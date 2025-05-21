from pydantic import BaseModel
from typing import List, Optional
from datetime import date
from enum import Enum

class SexoEnum(str, Enum):
    M = 'M'
    F = 'F'

class EstadoAnimalEnum(str, Enum):
    Saludable = 'Saludable'
    EnTratamiento = 'En tratamiento'
    Fallecido = 'Fallecido'
    Trasladado = 'Trasladado'

class TipoAlimentoEnum(str, Enum):
    Carnivoro = 'Carnívoro'
    Herbivoro = 'Herbívoro'
    Omnivoro = 'Omnívoro'
    Insectivoro = 'Insectívoro'

class DietaCreate(BaseModel):
    id_alimento: int
    cantidad_diaria: float
    frecuencia: str

class AnimalBase(BaseModel):
    nombre: str
    fecha_nacimiento: Optional[date]
    sexo: SexoEnum
    id_especie: int
    id_habitat: int
    fecha_ingreso: date
    estado: EstadoAnimalEnum
    dieta: List[DietaCreate]

class AnimalResponse(BaseModel):
    id: int
    nombre: str
    fecha_nacimiento: date
    sexo: str
    id_especie: int
    id_habitat: int
    fecha_ingreso: date
    estado: str
    class Config:
        from_attributes = True
