# les_architectes_cosmiques

A new Flutter project.

## Getting Started

## Mermaid Schema

classDiagram

class User {
Int id
String name
}

class Technologies {
Int id
String name
Bool unlocked
Double costMetal
Double costCrystal
Int? prerequisiteTechId
}

class Resources {
Int id
Int planetId
String type
Double quantity
}

class Planets {
Int id
Int userId
String name
String? politicalRegime
}

class Diplomacy {
Int id
Int planetId
String relationType
Int targetPlanetId
}

class Buildings {
Int id
Int planetId
String type
Int level
}

class BonusMissions {
Int id
String type
Bool isActive
DateTime? expiry
}

%% Relations (déduites des *_id)
User "1" --> "0..*" Planets : userId
Resources "0..*" --> "1" Planets : planetId
Buildings "0..*" --> "1" Planets : planetId
Diplomacy "0..*" --> "1" Planets : planetId
Diplomacy "0..*" --> "1" Planets : targetPlanetId
Technologies "0..*" --> "0..1" Technologies : prerequisiteTechId
