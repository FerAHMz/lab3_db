import streamlit as st
import requests
from datetime import datetime

API_URL = "http://backend:8000"

st.set_page_config(page_title="Gestión de Animales", layout="wide")
st.title("🐾 Gestión de Animales - Zoológico")

# --------- Función para cargar la vista actual ---------
@st.cache_data(ttl=10)
def cargar_vista():
    try:
        res = requests.get(f"{API_URL}/vista")
        if res.status_code == 200:
            return res.json()
        else:
            st.error("Error al obtener la vista.")
            return []
    except Exception as e:
        st.error(f"Error de conexión con backend: {e}")
        return []

# --------- Función para obtener animales existentes ---------
def cargar_animales():
    try:
        res = requests.get(f"{API_URL}/animales/")
        return res.json() if res.status_code == 200 else []
    except Exception as e:
        st.error(f"No se pudo cargar la lista de animales: {e}")
        return []

# --------- Función para eliminar animal ---------
def eliminar_animal(animal_id):
    try:
        res = requests.delete(f"{API_URL}/animales/{animal_id}")
        return res.status_code == 204
    except:
        return False

# --------- Mostrar la tabla ---------
st.subheader("📊 Tabla de animales y su dieta")
vista = cargar_vista()
if vista:
    st.dataframe(vista)

# --------- Crear o actualizar ---------
st.subheader("📝 Registrar o actualizar animal y su dieta")

modo = st.radio("Modo", ["Crear nuevo", "Actualizar existente"])

animales = cargar_animales()
animal_seleccionado = None

if modo == "Actualizar existente" and animales:
    opciones = {f"{a['id']}: {a['nombre']}": a for a in animales}
    seleccion = st.selectbox("Selecciona un animal", list(opciones.keys()))
    animal_seleccionado = opciones.get(seleccion)

# --------- Formulario ---------
with st.form("form_animal"):
    nombre = st.text_input("Nombre del animal", animal_seleccionado["nombre"] if animal_seleccionado else "")
    fecha_nacimiento = st.date_input("Fecha de nacimiento",
                                     value=datetime.strptime(animal_seleccionado["fecha_nacimiento"], "%Y-%m-%d").date()
                                     if animal_seleccionado else datetime.today())
    sexo = st.selectbox("Sexo", ["M", "F"],
                        index=0 if not animal_seleccionado or animal_seleccionado["sexo"] == "M" else 1)
    especie_id = st.number_input("ID de especie", min_value=1,
                                 value=animal_seleccionado["id_especie"] if animal_seleccionado else 1)
    habitat_id = st.number_input("ID de hábitat", min_value=1,
                                 value=animal_seleccionado["id_habitat"] if animal_seleccionado else 1)
    fecha_ingreso = st.date_input("Fecha de ingreso",
                                  value=datetime.strptime(animal_seleccionado["fecha_ingreso"], "%Y-%m-%d").date()
                                  if animal_seleccionado else datetime.today())
    estado = st.selectbox("Estado", ["Saludable", "En tratamiento", "Fallecido", "Trasladado"],
                          index=(["Saludable", "En tratamiento", "Fallecido", "Trasladado"]
                                 .index(animal_seleccionado["estado"])) if animal_seleccionado else 0)

    st.markdown("### 🍽 Dieta del animal")

    num_dietas = st.number_input("¿Cuántos alimentos deseas registrar para la dieta?", min_value=1, max_value=10, value=1, step=1, key="num_dietas")

    dieta = []
    for i in range(num_dietas):
        st.markdown(f"**Alimento #{i+1}**")
        col1, col2, col3 = st.columns(3)

        with col1:
            id_alimento = st.number_input(f"ID alimento {i+1}", min_value=1, key=f"id_alim_{i}")
        with col2:
            cantidad_diaria = st.number_input(f"Cantidad diaria {i+1} (kg)", min_value=0.1, key=f"cant_{i}")
        with col3:
            frecuencia = st.text_input(f"Frecuencia {i+1}", key=f"freq_{i}")

        if id_alimento and cantidad_diaria and frecuencia:
            dieta.append({
                "id_alimento": id_alimento,
                "cantidad_diaria": cantidad_diaria,
                "frecuencia": frecuencia
            })

    enviado = st.form_submit_button("Guardar")

    if enviado:
        payload = {
            "nombre": nombre,
            "fecha_nacimiento": str(fecha_nacimiento),
            "sexo": sexo,
            "id_especie": int(especie_id),
            "id_habitat": int(habitat_id),
            "fecha_ingreso": str(fecha_ingreso),
            "estado": estado,
            "dieta": dieta
        }

        if modo == "Crear nuevo":
            res = requests.post(f"{API_URL}/animales/", json=payload)
            if res.status_code == 200:
                st.success("✅ Animal registrado")
                st.rerun()
            else:
                st.error("❌ No se pudo registrar")
        elif animal_seleccionado:
            animal_id = animal_seleccionado["id"]
            res = requests.put(f"{API_URL}/animales/{animal_id}", json=payload)
            if res.status_code == 200:
                st.success("✅ Animal actualizado")
                st.rerun()
            else:
                st.error("❌ No se pudo actualizar")

# --------- Eliminar animal ---------
st.subheader("❌ Eliminar un animal")
if animales:
    animal_id_eliminar = st.selectbox("Selecciona animal para eliminar",
                                      [f"{a['id']}: {a['nombre']}" for a in animales], key="delete_select")
    id_real = int(animal_id_eliminar.split(":")[0])

    if st.button("Eliminar"):
        if eliminar_animal(id_real):
            st.success("✅ Animal eliminado")
            st.rerun()
        else:
            st.error("❌ No se pudo eliminar el animal")
else:
    st.info("No hay animales disponibles para eliminar.")
