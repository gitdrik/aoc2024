open("20.txt") do f
    M = readlines(f)
    rows, cols = eachindex(M), eachindex(M[1])
    sr, sc, er, ec, = 0, 0, 0, 0
    dp = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    for r∈rows, c∈cols
        if M[r][c]=='S'
            sr, sc = r, c
        elseif M[r][c]=='E'
            er, ec = r, c
        end
    end

    Q = [(0, er, ec)]
    trac = Dict{Tuple{Int, Int}, Int}()
    while !isempty(Q)
        steps, r, c = popfirst!(Q)
        (r, c) ∈ keys(trac) && continue
        trac[(r,c)] = steps
        for (dr, dc) ∈ dp
            nr, nc = r+dr, c+dc
            M[nr][nc] ≠ '#' && push!(Q, (steps+1, nr, nc))
        end
    end

    p1, p2 = 0, 0
    for (r, c) ∈ keys(trac)
        for dr ∈ -20:20, dc ∈ abs(dr)-20:20-abs(dr)
            nr, nc = r+dr, c+dc
            (nr, nc) ∉ keys(trac) && continue
            gain = trac[(r, c)] - trac[(nr, nc)] - abs(dr) - abs(dc)
            if gain ≥ 100
                p2 += 1
                p1 += abs(dr)+abs(dc) ≤ 2
            end
        end
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end