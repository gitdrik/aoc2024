open("11.txt") do f
    line = parse.(Int, split(readline(f)))

    MEM::Dict{Tuple{Int, Int}, Int} = Dict()
    function process(n, times)
        times == 0 && return 1
        (n, times) ∈ keys(MEM) && return MEM[(n, times)]
        if n==0
            ans = process(1, times-1)
        elseif isodd(ndigits(n))
            ans = process(n*2024, times-1)
        else
            digs = digits(n)
            nl = length(digs)÷2
            n1 = sum(digs[k]*10^(k-nl-1) for k ∈ nl+1:2*nl)
            n2 = sum(digs[k]*10^(k-1) for k ∈ 1:nl)
            ans = process(n1, times-1)+process(n2, times-1)
        end
        MEM[(n, times)] = ans
        return ans
    end

    println("Part 1: ", sum(process.(line, 25)))
    println("Part 2: ", sum(process.(line, 75)))
end