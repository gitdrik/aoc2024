open("07.txt") do f
    p1, p2 = 0, 0
    for l ∈ eachline(f)
        ans, n, ns... = parse.(Int, split(l, r" |: "))
        function verify(n, i, p2)
            n > ans && return false
            i > length(ns) && return ans==n
            return verify(n+ns[i], i+1, p2) ||
                   verify(n*ns[i], i+1, p2) ||
                   p2 && verify(n * 10^ndigits(ns[i]) + ns[i], i+1, p2)
        end
        verify(n, 1, false) && (p1 += ans)
        verify(n, 1, true) && (p2 += ans)
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end