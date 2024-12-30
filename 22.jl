open("22.txt") do f
    p1 = 0
    prune = 16777215
    seqs = Array{Array{Int}}([])
    deltas = Array{Array{Int}}([])
    for n ∈ parse.(Int, eachline(f))
        push!(seqs, [mod(n, 10)])
        push!(deltas, [0])
        old = mod(n, 10)
        for i ∈ 1:2000
            n = (n ⊻ n<<6) & prune
            n = (n ⊻ n>>5) & prune
            n = (n ⊻ n<<11) & prune
            new = mod(n, 10)
            push!(seqs[end], new)
            push!(deltas[end], new-old)
            old = new
        end
        p1 += n
    end
    println("Part 1: ", p1)
    bananas = zeros(Int, 80000)
    for (j, delta) ∈ enumerate(deltas)
        seen = falses(80000)
        d = delta[2]<<8 + delta[3]<<4 + delta[4]
        for i ∈ 1:length(delta)-4
            d = (d - delta[i]<<12)<<4 + delta[i+4]
            if !seen[d + 40000]
                seen[d + 40000] = true
                bananas[d + 40000] += seqs[j][i+4]
            end
        end
    end
    println("Part 2: ", maximum(bananas))
end