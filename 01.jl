using DelimitedFiles, Counters
open("01.txt") do f
    M = readdlm(f, Int)
    A, B = sort(M[:,1]), sort(M[:,2])
    println("Part 1: ", sum(abs.(A-B)))
    C = counter(B)
    println("Part 2: ", sum(a*C[a] for a∈A))
end