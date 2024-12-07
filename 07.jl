function run()
open("07.txt") do f    
    p1, p2 = 0, 0
    for l ∈ eachline(f)
        ans, n, ns... = parse.(Int, split(l, r" |: "))
        function verify(ans, n, i, p2)
            n > ans && return false
            i > length(ns) && return ans==n
            return verify(ans, n+ns[i], i+1, p2) ||
                   verify(ans, n*ns[i], i+1, p2) ||
                   p2 && verify(ans, n * 10^ndigits(ns[i]) + ns[i], i+1, p2)
        end
        verify(ans, n, 1, false) && (p1 += ans)
        verify(ans, n, 1, true) && (p2 += ans)
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end
end