using DataStructures

open("16.txt") do f
    M = readlines(f)
    sr, sc = length(M)-1, 2
    goal = (2, length(M[1])-1)
    dp = [(-1,0),(0,1),(1,0),(0,-1)]
    @assert M[sr][sc]=='S'
    @assert M[goal[1]][goal[2]]=='E'

    dir = 0
    points = 0
    lowpoints = DefaultDict{Tuple{Int,Int}, Int}(typemax(Int))
    Q = SortedSet([(points, 2, sr, sc)])
    seen = Set{NTuple{3,Int}}()
    while true
        points, dir, r, c = pop!(Q)
        (r, c) == goal && break
        (dir, r, c) ∈ seen && continue
        push!(seen, (dir, r, c))
        lowpoints[(r, c)] = min(points, lowpoints[(r,c)])
        for ndir ∈ mod1.([dir-1, dir, dir+1], 4)
            nr, nc = (r, c) .+ dp[ndir]
            if M[nr][nc] ≠ '#'
                npoints = points + 1000*(ndir≠dir) + 1
                push!(Q, (npoints, ndir, nr, nc))
            end
        end
    end
    println("Part 1: ", points)

    Q = [(points, mod1(dir+2,4), goal[1], goal[2])]
    good = Set{Tuple{Int, Int}}()
    while !isempty(Q)
        points, dir, r, c = pop!(Q)
        (r, c) ∈ good && continue
        push!(good, (r, c))
        for ndir ∈ mod1.([dir-1, dir, dir+1], 4)
            nr, nc = (r, c) .+ dp[ndir]
            if M[nr][nc] ≠ '#'
                npoints = points - 1000*(ndir≠dir) - 1
                if (nr, nc)∈keys(lowpoints) && npoints ≥ lowpoints[(nr, nc)]
                    push!(Q, (npoints, ndir, nr, nc))
                end
            end
        end
    end
    println("Part 2: ", length(good))
end