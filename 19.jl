open("19.txt") do f
    T = split.(readline(f), ", ")
    @assert readline(f)==""
    
    p1, p2 = 0, 0
    for l ∈ eachline(f)

        MEM = Dict{Int, Int}()
        function solve(i)
            i ∈ keys(MEM) && return MEM[i]
            i==length(l)+1 && return 1
            ans = 0
            for t ∈ T
                if startswith(l[i:end], t)
                    ans += solve(i+length(t))
                end
            end
            MEM[i] = ans
            return ans
        end

        ans = solve(1)
        p1 += ans > 0
        p2 += ans
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end