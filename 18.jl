open("18.txt") do f
    xr, yr = 1:71, 1:71
    M = falses(xr.stop, yr.stop)
    dp =[(-1, 0), (0, 1), (1, 0), (0, -1)]    
    for (i, byte) ∈ enumerate(eachline(f))
        x, y = parse.(Int, split(byte, ','))
        M[x+1, y+1] = true
        i < 1024 && continue
        steps = 0
        Q = [(steps, xr.start, yr.start)]
        seen = Set{Tuple{Int, Int}}()
        while !isempty(Q)
            steps, x, y = i > 1024 ? pop!(Q) : popfirst!(Q)
            (x, y)==(xr.stop, yr.stop) && break 
            (x, y) ∈ seen && continue
            push!(seen, (x, y))
            for (dx, dy) ∈ dp
                nx, ny = x+dx, y+dy
                nx∈xr && ny∈yr && !M[nx, ny] && push!(Q, (steps+1, nx, ny))
            end
        end
        i==1024 && println("Part 1: ", steps)
        if (x, y) ≠ (xr.stop, yr.stop)
            println("Part 2: ", byte)
            break
        end
    end
end