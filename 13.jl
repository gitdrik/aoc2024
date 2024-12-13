open("13.txt") do f
    machines = split(read(f, String), "\n\n")
    p1, p2 = 0, 0
    n = 10000000000000
    for m ∈ machines
        ss = split(m, r"\+|,|=|\n")
        x1, y1, x2, y2, x, y = parse.(Int, ss[2:2:end])
        try
            A::Int = (y*x2 - y2*x) / (y1*x2 - y2*x1)
            B::Int = (x - x1*A) / x2
            p1 += 3*A + B
        catch
            nothing
        end
        x, y = x+n, y+n
        try
            A::Int = (y*x2 - y2*x) / (y1*x2 - y2*x1)
            B::Int = (x - x1*A) / x2
            p2 += 3*A + B
        catch
            nothing
        end
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end