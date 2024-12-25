open("25.txt") do f
    K = Array{BitArray}([])
    L = Array{BitArray}([])
    for map ∈ split(strip(read(f, String)), "\n\n")
        m = stack(split(map)) .== '#'
        m[1, 1] ? push!(L, m) : push!(K, m)
    end
    println("Part 1: ", sum(!any(k .& l) for k∈K for l∈L))
end