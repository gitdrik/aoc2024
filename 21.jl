open("21.txt") do f
    codes = readlines(f)
    numpad = Dict(
        '7'=>(1, 1), '8'=>(1, 2), '9'=>(1, 3),
        '4'=>(2, 1), '5'=>(2, 2), '6'=>(2, 3),
        '1'=>(3, 1), '2'=>(3, 2), '3'=>(3, 3),
        '#'=>(4, 1), '0'=>(4, 2), 'A'=>(4, 3)
    )
    dirpad = Dict(
        '#'=>(4, 1), '^'=>(4, 2), 'A'=>(4, 3),
        '<'=>(5, 1), 'v'=>(5, 2), '>'=>(5, 3)
    )

    MEM = Dict{Tuple{String, Int},Int}()
    function press(code, depth)
        depth==0 && return length(code)
        (code, depth) ∈ keys(MEM) && return MEM[(code, depth)]
        r, c = (4, 3)
        ans = 0
        for key ∈ code
            nr, nc = isdigit(key) ? numpad[key] : dirpad[key]
            dr, dc = nr-r, nc-c
            up = '^'^max(-dr, 0)
            down = 'v'^max(dr, 0)
            left = '<'^max(-dc, 0)
            right = '>'^max(dc, 0)
            alt1 = up * down * left * right * 'A'
            alt2 = left * right * up * down * 'A'
            if r==4 && nc==1
                ans += press(alt1, depth-1)
            elseif c==1 && nr==4
                ans += press(alt2, depth-1)
            else
                ans += min(press(alt1, depth-1), press(alt2, depth-1))
            end
            r, c = nr, nc
        end
        MEM[(code, depth)] = ans
        return ans
    end

    p1, p2 = 0, 0
    for code ∈ codes
        n = parse(Int, code[1:3])
        p1 += n * press(code, 3)
        p2 += n * press(code, 26)
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end