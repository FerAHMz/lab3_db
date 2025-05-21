from sqlalchemy import Column, Integer, String, Date, ForeignKey, Enum, DECIMAL
from sqlalchemy.orm import relationship
from app.database import Base
import enum

# --- Enums Python ---

class SexoEnum(enum.Enum):
    M = 'M'
    F = 'F'

class EstadoAnimalEnum(enum.Enum):
    Saludable = "Saludable"
    En_tratamiento = "En tratamiento"
    Fallecido = "Fallecido"
    Trasladado = "Trasladado"

class TipoAlimentoEnum(enum.Enum):
    Carnivoro = 'Carnívoro'
    Herbivoro = 'Herbívoro'
    Omnivoro = 'Omnívoro'
    Insectivoro = 'Insectívoro'

# --- Modelos SQLAlchemy ---

class Animal(Base):
    __tablename__ = "animal"

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, nullable=False)
    fecha_nacimiento = Column(Date)
    sexo = Column(Enum(SexoEnum, name="sexoenum", create_type=False), nullable=False)
    id_especie = Column(Integer, nullable=False)
    id_habitat = Column(Integer, nullable=False)
    fecha_ingreso = Column(Date, nullable=False)
    estado = Column(
        Enum(
            EstadoAnimalEnum,
            name="estadoanimalenum",
            create_type=False,
            native_enum=False,
            values_callable=lambda obj: [e.value for e in obj]
        ),
        nullable=False
    )

    dieta = relationship("Dieta", back_populates="animal")

class Alimento(Base):
    __tablename__ = "alimento"

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, unique=True, nullable=False)
    tipo = Column(Enum(TipoAlimentoEnum, name="tipo_alimento", create_type=False), nullable=False)
    unidad_medida = Column(String, nullable=False)
    cantidad_disponible = Column(DECIMAL(10, 2), nullable=False)

    dieta = relationship("Dieta", back_populates="alimento")

class Dieta(Base):
    __tablename__ = "dieta"

    id = Column(Integer, primary_key=True, index=True)
    id_animal = Column(Integer, ForeignKey("animal.id"), nullable=False)
    id_alimento = Column(Integer, ForeignKey("alimento.id"), nullable=False)
    cantidad_diaria = Column(DECIMAL(10, 2), nullable=False)
    frecuencia = Column(String, nullable=False)

    animal = relationship("Animal", back_populates="dieta")
    alimento = relationship("Alimento", back_populates="dieta")
