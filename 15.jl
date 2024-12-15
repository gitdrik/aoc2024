open("15.txt") do f
    p = (0, 0)
    M::Array{Array{Char}} = []
    for (r, l) ∈ enumerate(eachline(f))
        isempty(l) && break
        c = findfirst('@', l)
        l = collect(l)
        if c ≠ nothing
            p = (r, c)
            l[c] = '.'
        end
        push!(M, l)
    end
    m = Dict('^'=>(-1,0), '>'=>(0,1), 'v'=>(1,0), '<'=>(0,-1))
    I = [m[c] for c ∈ join(readlines(f))]

    p2 = (p[1], 2*(p[2]-1) + 1)
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

    function isstuck(M, p, dp)
        r, c = p
        M[r][c] == '.' && return false
        M[r][c] == '#' && return true
        nr, nc = p .+ dp
        if dp[1]==0 || M[r][c]=='O'
            return isstuck(M, (nr, nc), dp)
        end
        if M[r][c] == '['
            nr2, nc2 = (nr, nc+1)
        else
            @assert M[r][c] == ']'
            nr2, nc2 = (nr, nc-1)
        end
        return isstuck(M, (nr, nc), dp) || isstuck(M, (nr2, nc2), dp)
    end

    function move!(M, p, dp)
        r, c = p
        if M[r][c] ≠ '.'
            nr, nc = p .+ dp
            if dp[1] == 0 || M[r][c] == 'O'
                move!(M, (nr, nc), dp)
                M[nr][nc], M[r][c] = M[r][c], M[nr][nc]
            elseif M[r][c]=='['
                move!(M, (nr, nc), dp)
                move!(M, (nr, nc+1), dp)
                M[nr][nc], M[r][c] = M[r][c], M[nr][nc]
                M[nr][nc+1], M[r][c+1] = M[r][c+1], M[nr][nc+1]
            elseif M[r][c]==']'
                move!(M, (nr, nc), dp)
                move!(M, (nr, nc-1), dp)
                M[nr][nc], M[r][c] = M[r][c], M[nr][nc]
                M[nr][nc-1], M[r][c-1] = M[r][c-1], M[nr][nc-1]
            end
        end
    end

    for dp ∈ I
        np = p .+ dp
        if !isstuck(M, np, dp)
            move!(M, np, dp)
            p = np
        end
        np = p2 .+ dp
        if !isstuck(M2, np, dp)
            move!(M2, np, dp)
            p2 = np
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