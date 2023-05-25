include("structuri.jl")

function GreedyTir(buget::Float64, vec_tir::Vector{Tir}, vec_rez::Vector{Float64})
    # Avem un coeficient de profitabilitate calculat astfel: raportul dintre profitul produs de un tir pe un drum
    # si pretul acestuia
    lungime = length(vec_rez)
    for i in 1:lungime
        vec_rez[i] = vec_rez[i] / vec_tir[i].Pret
    end
    permutatie_desc = sortperm(vec_rez, rev=true)

    # Pentru alegerea optima a cumpararii tirurilor, folosim metoda Greedy pentru a calcula cate tiruri putem cumpara
    # incadrandu-ne in buget.
    for i = 1:lungime
        contor = 0
        while buget - vec_tir[permutatie_desc[i]].Pret >= 0
            buget -= vec_tir[permutatie_desc[i]].Pret
            contor = contor + 1
        end
        if contor > 0
            println("Camionul de tipul ", vec_tir[permutatie_desc[i]].Nume, " in numar de ", contor)
        end
    end
end