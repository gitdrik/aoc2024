open("10.txt") do f
    M = readlines(f)
    rows, cols = 1:length(M), 1:length(M[1])
    p1, p2 = 0, 0
    for r ∈ rows, c ∈ cols
        M[r][c] ≠ '0' && continue
        peaks::Set{Tuple{Int, Int}} = Set()
        Q = [(r, c)]
        while !isempty(Q)
            r, c = pop!(Q)
            if M[r][c] == '9'
                p2 += 1
                push!(peaks, (r, c))
                continue
            end
            for (dr, dc) ∈ [(-1,0), (0,1), (1,0), (0,-1)]
                nr, nc = r+dr, c+dc
                (nr ∉ rows || nc ∉ cols) && continue
                M[nr][nc] ≠ M[r][c] + 1 && continue
                push!(Q, (nr, nc))
            end
        end
        p1 += length(peaks)
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end