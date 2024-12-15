open("15.txt") do f
    map, inst = split(read(f, String), "\n\n")
    M = collect.(split(map, "\n"))
    sr, sc = 0, 0
    for r ∈ eachindex(M), c ∈ eachindex(M[r])
        if M[r][c]=='@'
            sr, sc = r, c
            M[r][c] = '.'
        end
    end
    m = Dict('^'=>(-1,0), '>'=>(0,1), 'v'=>(1,0), '<'=>(0,-1))
    I = [m[c] for c ∈ replace(inst, "\n"=>"")]

    M2::Array{Array{Char}} = []
    for r ∈ eachindex(M)
        push!(M2, [])
        for c ∈ eachindex(M[r])
            if M[r][c]=='O'
                push!(M2[r], '[')
                push!(M2[r], ']')
            else
                push!(M2[r], M[r][c])
                push!(M2[r], M[r][c])
            end
        end
    end

    function isstuck(M, r, c, dr, dc)
        M[r][c] == '.' && return false
        M[r][c] == '#' && return true
        nr, nc = r+dr, c+dc
        if dr==0 || M[r][c]=='O'
            return isstuck(M, nr, nc, dr, dc)
        end
        if M[r][c] == '['
            nr2, nc2 = nr, nc+1
        else
            @assert M[r][c] == ']'
            nr2, nc2 = nr, nc-1
        end
        return isstuck(M, nr, nc, dr, dc) || isstuck(M, nr2, nc2, dr, dc)
    end

    function move!(M, r, c, dr, dc)
        if M[r][c] ≠ '.'
            nr, nc = r+dr, c+dc
            if dr == 0 || M[r][c] == 'O'
                move!(M, nr, nc, dr, dc)
                M[nr][nc], M[r][c] = M[r][c], M[nr][nc]
            elseif M[r][c]=='['
                move!(M, nr, nc, dr, dc)
                move!(M, nr, nc+1, dr, dc)
                M[nr][nc], M[r][c] = M[r][c], M[nr][nc]
                M[nr][nc+1], M[r][c+1] = M[r][c+1], M[nr][nc+1]
            elseif M[r][c]==']'
                move!(M, nr, nc, dr, dc)
                move!(M, nr, nc-1, dr, dc)
                M[nr][nc], M[r][c] = M[r][c], M[nr][nc]
                M[nr][nc-1], M[r][c-1] = M[r][c-1], M[nr][nc-1]
            end
        end
    end

    r, c = sr, sc
    r2, c2 = sr, 2*(sc-1)+1
    for (dr, dc) ∈ I
        nr, nc = r+dr, c+dc
        if !isstuck(M, nr, nc, dr, dc)
            move!(M, nr, nc, dr, dc)
            r, c = nr, nc
        end
        nr, nc = r2+dr, c2+dc
        if !isstuck(M2, nr, nc, dr, dc)
            move!(M2, nr, nc, dr, dc)
            r2, c2 = nr, nc
        end
    end

    function score(M)
        ans = 0
        for (r, row)∈enumerate(M), (c, ch)∈enumerate(row)
            ch ∈ "O[" && (ans += 100*(r-1) + (c-1))
        end
        return ans
    end

    println("Part 1: ", score(M))
    println("Part 2: ", score(M2))
end