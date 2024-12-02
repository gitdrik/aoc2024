open("02.txt") do f
    function unsafe(ns)
        delta = ns[1:end-1]-ns[2:end]
        any(∉(1:3), abs.(delta)) || 
            any(≠(sign(delta[end])), sign.(delta))
    end
    p1, p2 = 0, 0
    for l in eachline(f)
        ns = parse.(Int, split(l))
        for i ∈ 0:length(ns)
            nns = [ns[1:i-1]; ns[i+1:end]]
            unsafe(nns) && continue
            p1 += i==0
            p2 += 1
            break
        end
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end