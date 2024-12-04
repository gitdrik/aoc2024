open("02.txt") do f
    p1, p2 = 0, 0
    for l ∈ eachline(f)
        ns = parse.(Int, split(l))
        for i ∈ 0:length(ns)
            nns = [ns[1:i-1]; ns[i+1:end]]
            delta = nns[1:end-1]-nns[2:end]
            any(∉(1:3), abs.(delta)) && continue
            !allequal(sign.(delta)) && continue
            p1 += i==0
            p2 += 1
            break
        end
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end