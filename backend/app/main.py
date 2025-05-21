from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from sqlalchemy import text
from typing import List
from app import models, schemas
from app.database import SessionLocal, engine, Base

# Crear las tablas si no existen
Base.metadata.create_all(bind=engine)

# Inicializar la app
app = FastAPI()

# CORS middleware para permitir comunicación con el frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Dependencia para la sesión de base de datos
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Crear un nuevo animal y asociar dieta
@app.post("/animales/", response_model=schemas.AnimalResponse)
def crear_animal(animal: schemas.AnimalBase, db: Session = Depends(get_db)):
    nuevo_animal = models.Animal(
        nombre=animal.nombre,
        fecha_nacimiento=animal.fecha_nacimiento,
        sexo=animal.sexo,
        id_especie=animal.id_especie,
        id_habitat=animal.id_habitat,
        fecha_ingreso=animal.fecha_ingreso,
        estado=animal.estado
    )
    db.add(nuevo_animal)
    db.commit()
    db.refresh(nuevo_animal)

    # Asociar dieta (alimentos)
    for dieta in animal.dieta:
        nueva_dieta = models.Dieta(
            id_animal=nuevo_animal.id,
            id_alimento=dieta.id_alimento,
            cantidad_diaria=dieta.cantidad_diaria,
            frecuencia=dieta.frecuencia
        )
        db.add(nueva_dieta)
    db.commit()

    return nuevo_animal

# Obtener todos los animales (básico)
@app.get("/animales/", response_model=List[schemas.AnimalResponse])
def listar_animales(db: Session = Depends(get_db)):
    return db.query(models.Animal).all()

# Obtener los datos combinados desde la vista SQL
@app.get("/vista")
def vista_animales_dieta(db: Session = Depends(get_db)):
    try:
        result = db.execute(text("SELECT * FROM vista_animales_dieta"))
        return [dict(row._mapping) for row in result]
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@app.put("/animales/{animal_id}", response_model=schemas.AnimalResponse)
def actualizar_animal(animal_id: int, animal: schemas.AnimalBase, db: Session = Depends(get_db)):
    db_animal = db.query(models.Animal).filter(models.Animal.id == animal_id).first()
    if not db_animal:
        raise HTTPException(status_code=404, detail="Animal no encontrado")

    # Actualizar campos principales
    db_animal.nombre = animal.nombre
    db_animal.fecha_nacimiento = animal.fecha_nacimiento
    db_animal.sexo = animal.sexo
    db_animal.id_especie = animal.id_especie
    db_animal.id_habitat = animal.id_habitat
    db_animal.fecha_ingreso = animal.fecha_ingreso
    db_animal.estado = animal.estado
    db.commit()

    # Eliminar dieta previa
    db.query(models.Dieta).filter(models.Dieta.id_animal == animal_id).delete()

    # Agregar nueva dieta
    for dieta in animal.dieta:
        nueva = models.Dieta(
            id_animal=animal_id,
            id_alimento=dieta.id_alimento,
            cantidad_diaria=dieta.cantidad_diaria,
            frecuencia=dieta.frecuencia
        )
        db.add(nueva)

    db.commit()
    db.refresh(db_animal)
    return db_animal

@app.delete("/animales/{animal_id}", status_code=204)
def eliminar_animal(animal_id: int, db: Session = Depends(get_db)):
    db_animal = db.query(models.Animal).filter(models.Animal.id == animal_id).first()
    if not db_animal:
        raise HTTPException(status_code=404, detail="Animal no encontrado")

    try:
        db.query(models.Dieta).filter(models.Dieta.id_animal == animal_id).delete()
        db.execute(text("DELETE FROM cuidado WHERE id_animal = :id"), {"id": animal_id})
        db.execute(text("DELETE FROM horarios_alimentacion WHERE id_animal = :id"), {"id": animal_id})
        db.execute(text("DELETE FROM registro_salud WHERE id_animal = :id"), {"id": animal_id})

        db.delete(db_animal)
        db.commit()

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"No se pudo eliminar el animal: {str(e)}")

    return
