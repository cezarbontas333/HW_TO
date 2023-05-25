using JuMP
using HiGHS

include("structuri.jl")

function CalcTir(Vec_Jucarii::Vector{Jucarie}, Vec_Tiruri::Vector{Tir})::Vector{Float64}
    # Prima parte a problemei consta in calcularea unui model optim pentru incarcarea in fiecare tir din
    # catalog. Astfel putem compara fiecare maxim pentru partea a doua a problemei.
    Nr_Jucarii = length(Vec_Jucarii)
    Nr_Tiruri = length(Vec_Tiruri)

    Rezultate_Maxime = []

    for index_tir in 1:Nr_Tiruri
        # Declararea modelului
        IC = Model(HiGHS.Optimizer)

        # Variabilele functiei de optimizat, adica numarul de jucarii transportate
        @variable(IC, Cantitate[index_jucarie=1:Nr_Jucarii] ≥ 0, Int)

        # Functia obiectiv; optimizarea profitului maxim pentru toate tipurile de jucarii
        @objective(IC, Max, sum(Vec_Jucarii[index_jucarie].Profit * Cantitate[index_jucarie] for index_jucarie = 1:Nr_Jucarii))

        # Contrangerile: de greutate, respectiv de volum, cat si canticatea minima ce trebuie vanduta
        @constraint(IC, sum(Vec_Jucarii[index_jucarie].Greutate * Cantitate[index_jucarie] for index_jucarie = 1:Nr_Jucarii) ≤ Vec_Tiruri[index_tir].Greutate)
        @constraint(IC, sum(Vec_Jucarii[index_jucarie].Volum * Cantitate[index_jucarie] for index_jucarie = 1:Nr_Jucarii) ≤ Vec_Tiruri[index_tir].Volum)
        @constraint(IC, [index_jucarie = 1:Nr_Jucarii], Cantitate[index_jucarie] ≥ Vec_Jucarii[index_jucarie].Cantitate_Min)

        # Optimizarea si afisarea rezultatelor
        optimize!(IC)
        if termination_status(IC) == MOI.OPTIMAL
            push!(Rezultate_Maxime, objective_value(IC))
        end
    end
    return Rezultate_Maxime
end