open("08.txt") do f
    M = readlines(f)
    rows, cols = 1:length(M), 1:length(M[1])
    A = Dict{Char, Array{Tuple{Int,Int}}}()
    for r∈rows, c∈cols
        M[r][c] == '.' && continue
        M[r][c] ∉ keys(A) && (A[M[r][c]]=[])
        push!(A[M[r][c]], (r,c))
    end

    N1, N2 = Set{Tuple{Int,Int}}(), Set{Tuple{Int,Int}}()
    for a∈values(A), i∈1:length(a)-1, j∈i+1:length(a)
        for k∈Iterators.countfrom(0)
            n = (1 + k) .* a[i] .- k .* a[j]
            any(n .∉ (rows, cols)) && break
            push!(N2, n)
            k==1 && push!(N1, n)
        end
        for k∈Iterators.countfrom(0)
            n = (1 + k) .* a[j] .- k .* a[i]
            any(n .∉ (rows, cols)) && break
            push!(N2, n)
            k==1 && push!(N1, n)
        end
    end
    println("Part 1: ", length(N1))
    println("Part 2: ", length(N2))
end