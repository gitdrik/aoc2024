open("04.txt") do f
    M = stack(readlines(f))
    rows, cols = size(M)
    MAS = Set(collect.(["MAS", "SAM"]))
    XMAS = Set(collect.(["XMAS", "SAMX"]))
    p1, p2 = 0, 0
    for r∈1:rows, c∈1:cols
        c+3≤cols && (p1 += M[r, c:c+3]∈XMAS)
        r+3≤rows && (p1 += M[r:r+3, c]∈XMAS)
        r+3≤rows && c+3≤cols && (p1 += [M[r+i,  c+i] for i∈0:3] ∈ XMAS)
        r+3≤rows && c+3≤cols && (p1 += [M[r+3-i,c+i] for i∈0:3] ∈ XMAS)
        r+2≤rows && c+2≤cols && (p2 += [M[r+i,  c+i] for i∈0:2] ∈ MAS && 
                                       [M[r+2-i,c+i] for i∈0:2] ∈ MAS)
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end