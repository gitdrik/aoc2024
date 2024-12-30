open("22.txt") do f
    ls = readlines(f)
    nums = length(ls)
    prune = 16777215
    seqs = [Array{Int}(undef, 2001) for _ ∈ 1:nums]
    deltas = [Array{Int}(undef, 2001) for _ ∈ 1:nums]
    n = parse.(Int, ls)
    new, old = zeros(Int, nums), zeros(Int, nums)
    Threads.@threads for i ∈ eachindex(ls)
        old[i] = mod(n[i], 10)
        seqs[i][1] = old[i]
        deltas[i][1] = 0
        for j ∈ 1:2000
            n[i] = (n[i] ⊻ n[i]<<6) & prune
            n[i] = (n[i] ⊻ n[i]>>5)
            n[i] = (n[i] ⊻ n[i]<<11) & prune
            new[i] = mod(n[i], 10)
            seqs[i][j+1] = new[i]
            deltas[i][j+1] = new[i] - old[i]
            old[i] = new[i]
        end
    end
    println("Part 1: ", sum(n))

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