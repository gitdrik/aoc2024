open("13.txt") do f
    machines = split(read(f, String), "\n\n")
    p1, p2, n = 0, 0, 10000000000000
    for m ∈ machines
        ss = split(m, r"\+|,|=|\n")
        ax, ay, bx, by, x, y = parse.(Int, ss[2:2:end])
        A = (y*bx - by*x) // (ay*bx - by*ax)
        B = (x - ax*A) // bx
        1==denominator(A)==denominator(B) && (p1 += Int(3*A+B))
        x, y = x+n, y+n
        A = (y*bx - by*x) // (ay*bx - by*ax)
        B = (x - ax*A) // bx
        1==denominator(A)==denominator(B) && (p2 += Int(3*A+B))
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end