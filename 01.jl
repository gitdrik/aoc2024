open("01.txt") do f
    A::Array{Int}, B::Array{Int} = [], []
    for l ∈ eachline(f)
        a, b = parse.(Int, split(l))
        push!(A, a)
        push!(B, b)
    end
    sort!(A)
    sort!(B)
    println("Part 1: ", sum(abs.(reduce.(-, zip(A, B)))))
    
    p2 = 0
    for a∈A, b∈B
        a==b && (p2 += a)
    end
    println("Part 2: ", p2)
end