open("05.txt") do f
    afters::Dict{Int,Set{Int}} = Dict()
    for l∈eachline(f)
        l=="" && break
        a, b = parse.(Int, split(l,'|'))
        a∉keys(afters) && (afters[a]=Set())
        push!(afters[a], b)
    end
    updates = [parse.(Int, split(l,',')) for l∈eachline(f)]
    
    p1, p2 = 0, 0
    for u ∈ updates
        good = [u[1]]
        for i ∈ 2:length(u)
            pos = length(good)+1
            for j ∈ 1:length(good)
                if u[i]∈keys(afters) && good[j]∈afters[u[i]]
                    pos = j
                    break
                end
            end
            insert!(good, pos, u[i])
        end
        u==good ? p1 += good[end÷2+1] : p2 += good[end÷2+1]
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end