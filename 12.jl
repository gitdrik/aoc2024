open("12.txt") do f
    M = readlines(f)
    rows, cols = 1:length(M), 1:length(M[1])
    seen::Set{Tuple{Int, Int}} = Set()
    p1, p2 = 0, 0
    for r∈rows, c∈cols
        (r, c) ∈ seen && continue
        type = M[r][c]
        area = 0
        perimeter::Set{NTuple{4, Int}} = Set()
        Q = [(r, c)]
        while !isempty(Q)
            r, c = popfirst!(Q)
            (r, c) ∈ seen && continue
            area += 1
            push!(seen, (r, c))
            for (dr, dc) ∈ [(-1,0),(0,1),(1,0),(0,-1)]
                nr, nc = r+dr, c+dc
                if (nr ∉ rows || nc ∉ cols || M[nr][nc] ≠ type)
                    push!(perimeter, (dr, dc, nr, nc))
                    continue
                end
                push!(Q, (nr, nc))
            end
        end
        p1 += area * length(perimeter)
        sides = 0
        while !isempty(perimeter)
            sides += 1
            dr, dc, r, c = pop!(perimeter)
            nr, nc = r, c
            while (dr, dc, nr-dc, nc-dr) ∈ perimeter
                nr, nc = nr-dc, nc-dr
                delete!(perimeter, (dr, dc, nr, nc))
            end
            nr, nc = r, c
            while (dr, dc, nr+dc, nc+dr) ∈ perimeter
                nr, nc = nr+dc, nc+dr
                delete!(perimeter, (dr, dc, nr, nc))
            end
        end
        p2 += area * sides
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end