open("03.txt") do f
    s = read("03.txt", String)
    doit = true
    p1, p2 = 0, 0
    for m ∈ eachmatch(r"mul\((\d+),(\d+)\)|do\(\)|don't\(\)", s)
        if m.match=="do()"
            doit=true
        elseif m.match == "don't()"
            doit=false
        else
            a, b = parse.(Int, m)
            n = a*b
            p1 += n
            doit && (p2 += n)
        end
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end