open("23.txt") do f
    D = Dict{String, Set{String}}(Set())
    for (a, b) ∈ split.(eachline(f), '-')
        a ∉ keys(D) && (D[a] = Set())
        push!(D[a], b)
        b ∉ keys(D) && (D[b] = Set())
        push!(D[b], a)
    end

    p1 = Set{Set{String}}(Set())
    for c ∈ keys(D)
        !startswith(c, 't') && continue
        cc = collect(D[c])
        for i ∈ 1:length(cc)-1, j ∈ i+1:length(cc)
            if cc[i] ∈ D[cc[j]]
                push!(p1, Set([c, cc[i], cc[j]]))
            end
        end
    end
    println(length(p1))

    p2 = Array{String}([])
    for c ∈ keys(D)
        connected = Array{String}([])
        for cn ∈ collect(D[c])
            good = true
            for cc ∈ connected
                if cn ∉ D[cc]
                    good = false
                    break
                end
            end
            good && push!(connected, cn)
        end
        push!(connected, c)
        if length(connected) > length(p2)
            p2 = connected
        end
    end
    println(join(sort(p2),','))
end