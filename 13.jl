open("13.txt") do f
    machines = split(read(f, String), "\n\n")
    p1, p2, n = 0, 0, 10000000000000
    for m ∈ machines
        ss = split(m, r"\+|,|=|\n")
        x1, y1, x2, y2, x, y = parse.(Int, ss[2:2:end])
        ab1, ab2 = [x1 x2; y1 y2] \ [x, y], [x1 x2; y1 y2] \ [x+n, y+n]
        abr1, abr2 = round.(Int, ab1), round.(Int, ab2)
        sum(abs.(ab1 .- abr1)) < 0.01 && (p1 += 3*abr1[1] + abr1[2])
        sum(abs.(ab2 .- abr2)) < 0.01 && (p2 += 3*abr2[1] + abr2[2])        
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end