using Counters
open("01.txt") do f
    L = readlines(f) .|> split .|> ss->parse.(Int, ss)
    A, B = sort(first.(L)), sort(last.(L))
    println("Part 1: ", sum(abs.(A.-B)))

    BC = counter(B)
    println("Part 2: ", sum(a*BC[a] for a∈A))
end