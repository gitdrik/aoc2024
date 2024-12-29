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

    bananadict = Dict{NTuple{4, Int}, Int}()
    for seq ∈ seqs
        seen = Set{NTuple{4, Int}}()
        for i ∈ 1:length(seq)-4
            delta = Tuple(b-a for (a,b) ∈ zip(seq[i:i+3], seq[i+1:i+4]))
            if delta ∉ seen
                push!(seen, delta)
                delta ∉ keys(bananadict) && (bananadict[delta] = 0)
                bananadict[delta] += seq[i+4]
            end
        end
    end
    println("Part 2: ", maximum(values(bananadict)))
end