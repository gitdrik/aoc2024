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
    dirs = [(-1,0),(0,1),(1,0),(0,-1)]

    dir = 1
    pos = start
    seen = Set{Tuple{Int,Int}}()
    while all(pos .∈ (rows, cols))
        push!(seen, pos)
        npos = pos.+dirs[dir]
        if npos ∈ O
            dir = mod1(dir+1, 4)
        else
            pos = npos
        end
    end
    println("Part 1: ", length(seen))

    p2 = 0
    seen = delete!(seen, start)
    for item ∈ seen
        dir = 1
        pos = start
        seen2 = Set{Tuple{Tuple{Int,Int},Int}}()
        while all(pos .∈ (rows, cols))
            (pos, dir) ∈ seen2 && (p2+=1; break)
            push!(seen2, (pos, dir))
            npos = pos.+dirs[dir]
            if npos ∈ O || npos == item
                dir = mod1(dir+1, 4)
            else
                pos = pos .+ dirs[dir]
            end
        end
    end
    println("Part 2: ", p2)
end