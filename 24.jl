open("24.txt") do f
    G = Dict{String, Array{String}}()
    for l ∈ eachline(f)
        l == "" && continue
        if ':' ∈ l
            lbl, value = split(l, ": ")
            G[lbl] = [value]
        else
            a, op, b, _, lbl = split(l)
            G[lbl] = [a, b, op]
        end
    end

    MEM = Dict{String, Bool}()
    function process(lbl, d)
        length(G[lbl])==1 && return G[lbl]==["1"]
        lbl ∈ keys(MEM) && return MEM[lbl]
        a, b, op = G[lbl]
        #Uncomment for part 2(!): println("  "^d, "$lbl = $a $op $b")
        ans = false
        op=="AND" && (ans = process(a, d+1) & process(b, d+1))
        op=="XOR" && (ans = process(a, d+1) ⊻ process(b, d+1))
        op=="OR"  && (ans = process(a, d+1) | process(b, d+1))
        MEM[lbl] = ans
        return ans
    end

    output = BitArray([])
    for z ∈ sort([lbl for lbl in keys(G) if startswith(lbl, 'z')])
        push!(output, process(z, 0))
    end
    println("Part 1: ", sum(b*2^(i-1) for (i, b)∈enumerate(output)))

    # Analyzing print in process() reveals the folowing swaps:
    badpairs = ["z11","vkq","z24","mmk","pvb","qdq","z38","hqh"]
    println("Part 2: ", join(sort(badpairs), ','))
end