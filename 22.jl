open("22.txt") do f
    p1 = 0
    prune = 16777215
    seqs = Array{Array{Int}}([])
    for n ∈ parse.(Int, eachline(f))
        push!(seqs, [digits(n)[1]])
        for i ∈ 1:2000
            n = (n ⊻ n<<6) & prune
            n = (n ⊻ n>>5) & prune
            n = (n ⊻ n<<11) & prune
            push!(seqs[end], digits(n)[1])
        end
        p1 += n
    end
    println("Part 1: ", p1)

    bananas = zeros(Int, 80000)
    for seq ∈ seqs
        seen = falses(80000)
        for i ∈ 1:length(seq)-4
            delta = 40000 + sum((seq[i+1:i+4]-seq[i:i+3]) .* [4096, 256, 16, 1])
            if !seen[delta]
                seen[delta] = true
                bananas[delta] += seq[i+4]
            end
        end
    end
    println("Part 2: ", maximum(bananas))
end