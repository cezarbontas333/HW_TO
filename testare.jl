include("CalcTir.jl")
include("GreedyTir.jl")

# Aici avem un set de date generate aleator, se poate implementa separat citire dintr-un fisier cvs/json
jucarie_data = [
    Jucarie("Jucarie1", 10.0, 5, 0.5, 0.2),
    Jucarie("Jucarie2", 15.0, 3, 0.8, 0.3),
    Jucarie("Jucarie3", 8.0, 6, 0.6, 0.5),
    Jucarie("Jucarie4", 12.0, 4, 0.9, 0.4),
    Jucarie("Jucarie5", 20.0, 2, 0.7, 0.6),
    Jucarie("Jucarie6", 18.0, 5, 1.2, 0.8),
    Jucarie("Jucarie7", 16.0, 3, 0.4, 0.7),
    Jucarie("Jucarie8", 9.0, 6, 0.3, 0.3),
    Jucarie("Jucarie9", 14.0, 4, 0.5, 0.4),
    Jucarie("Jucarie10", 7.0, 2, 0.8, 0.5)
]


tir_data = [
    Tir("Tir1", 50.0, 30.0, 1000.0),
    Tir("Tir2", 60.0, 40.0, 1500.0),
    Tir("Tir3", 70.0, 35.0, 2000.0),
    Tir("Tir4", 80.0, 45.0, 1800.0),
    Tir("Tir5", 90.0, 55.0, 1600.0),
    Tir("Tir6", 100.0, 50.0, 2500.0),
    Tir("Tir7", 110.0, 60.0, 2200.0),
    Tir("Tir8", 120.0, 52.0, 1900.0),
    Tir("Tir9", 130.0, 48.0, 1700.0),
    Tir("Tir10", 140.0, 43.0, 1300.0)
]

buget = 25700.0

# Calculam si ne extragem doar profiturile generate de o cursa de tir.
Rezultate_Maxime = CalcTir(jucarie_data, tir_data)
# Dupa va trebui sa calculam care tiruri sunt cele mai bune investitii si care se incadreaza in buget.
GreedyTir(buget, tir_data, Rezultate_Maxime)