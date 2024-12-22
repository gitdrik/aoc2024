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

    combos = Set{NTuple{4, Int}}()
    bananadicts = Array{Dict{NTuple{4, Int}, Int}}([])
    for seq ∈ seqs
        push!(bananadicts, Dict())
        for i ∈ 1:length(seq)-4
            delta = Tuple(b-a for (a,b) ∈ zip(seq[i:i+3], seq[i+1:i+4]))
            if delta ∉ keys(bananadicts[end])
                push!(combos, delta)
                bananadicts[end][delta] = seq[i+4]
            end
        end
    end

    p2 = 0
    for c ∈ combos
        bananas = 0
        for (i, bananadict) ∈ enumerate(bananadicts)
            if c ∈ keys(bananadict)
                bananas += bananadict[c]
            end
        end
        p2 = max(p2, bananas)
    end
    println("Part 2: ", p2)
end