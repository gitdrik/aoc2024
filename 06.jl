open("06.txt") do f
    M = readlines(f)
    rows = 1:length(M)
    cols = 1:length(M[1])
    O = Set{Tuple{Int,Int}}()
    start = (0, 0)
    for r∈rows, c∈cols
        M[r][c]=='#' && push!(O, (r, c))
        M[r][c]=='^' && (start = (r, c))
    end
    
    p2 = 0
    dir = 1
    pos = start
    I = Set{Tuple{Int,Int}}()
    seen = Set{Tuple{Int,Int}}()
    dp = [(-1,0),(0,1),(1,0),(0,-1)]
    while all(pos .∈ (rows, cols))
        push!(seen, pos)
        npos = pos .+ dp[dir]
        if npos ∈ O
            dir = mod1(dir+1, 4)
        else
            npos ∈ I && (pos = npos; continue)
            push!(I, npos)
            dir2 = dir
            pos2 = pos
            seen2 = Set{Tuple{Tuple{Int,Int},Int}}()
            while all(pos2 .∈ (rows, cols))
                (pos2, dir2) ∈ seen2 && (p2 += 1; break)
                push!(seen2, (pos2, dir2))
                npos2 = pos2 .+ dp[dir2]
                if npos2 ∈ O || npos2 == npos
                    dir2 = mod1(dir2 + 1, 4)
                else
                    pos2 = pos2 .+ dp[dir2]
                end
            end
            pos = npos
        end
    end
    println("Part 1: ", length(seen))
    println("Part 2: ", p2)
end