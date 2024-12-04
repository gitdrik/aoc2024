using LinearAlgebra
open("04.txt") do f
    M = stack(readlines(f))
    rows, cols = size(M)
    p1, p2 = 0, 0
    finder(l) = sum(length.([findall(s, String(l)) for s∈["XMAS","SAMX"]]))
    p1 += sum(finder.([M[:,c] for c∈1:cols]))
    p1 += sum(finder.([M[r,:] for r∈1:rows]))
    p1 += sum(finder.([diag(M, i) for i∈-rows-1:cols-1]))
    p1 += sum(finder.([diag(rotl90(M), i) for i∈-rows-1:cols-1]))
    println("Part 1: ", p1)
    for r∈2:rows-1, c∈2:cols-1
        M[r,c]≠'A' && continue
        Set([M[r-1,c-1], M[r+1,c+1]])≠Set(['M','S']) && continue
        Set([M[r-1,c+1], M[r+1,c-1]])≠Set(['M','S']) && continue
        p2 += 1
    end
    println("Part 2: ", p2)
end