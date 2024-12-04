open("04.txt") do f
    ls = readlines(f)
    rows, cols = eachindex(ls), 1:length(ls[1])
    M = fill(' ', rows.stop+3, cols.stop+3)
    for (i, l)∈enumerate(ls), (j, c)∈enumerate(l)
        M[i,j] = c
    end
    p1 = 0
    XMAS = Set(collect.(["XMAS", "SAMX"]))
    for r∈rows, c∈cols
        p1 += M[r, c:c+3] ∈ XMAS
        p1 += M[r:r+3, c] ∈ XMAS
        p1 += [M[r+i,c+i] for i∈0:3] ∈ XMAS
        p1 += [M[r+3-i,c+i] for i∈0:3] ∈ XMAS
    end
    println("Part 1: ", p1)
    MASX = Set(collect.(["MAS", "SAM"]))
    p2 = 0
    for r∈rows, c∈cols
        p2 += [M[r+i,c+i] for i∈0:2] ∈ MASX && [M[r+2-i,c+i] for i∈0:2] ∈ MASX
    end
    println("Part 2: ", p2)
end