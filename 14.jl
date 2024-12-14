open("14.txt") do f
    X, Y = 101, 103
    steps = 100
    R::Array{NTuple{4,Int}} = []
    Q = [0, 0, 0, 0]
    for l ∈ eachline(f)
        ss = split(l, r"=|,| ")
        x, y, dx, dy = parse.(Int, ss[[2,3,5,6]])
        x100 = mod(x+100dx, X)
        y100 = mod(y+100dy, Y)
        x100 ∈ 0:49 && y100 ∈ 0:50 && (Q[1] += 1)
        x100 ∈ 51:100 && y100 ∈ 0:50 && (Q[2] += 1)
        x100 ∈ 0:49 && y100 ∈ 52:102 && (Q[3] += 1)
        x100 ∈ 51:100 && y100 ∈ 52:102 && (Q[4] += 1)
        push!(R, (x, y, dx, dy))
    end
    println("Part 1: ", prod(Q))
    DY = sort([dy for (_,_,_,dy)∈R])
    println.(DY)
    exit()

    # 33 87 134 190 235  33:101:10000 87:103:10000
    # mod(t-33, 101)==0 && mod(t-87, 103)==0
    for t ∈ 7709 #Iterators.countfrom(0)
        M = Set()
        for (x, y, dx, dy) ∈ R
            push!(M, (mod(x+t*dx, X), mod(y+t*dy, Y)))
        end
        #   length(M) ≠ 500 && continue
        #   print("\u001B[3cle;1H")
        for y∈0:Y
            for x∈0:X
                print((x,y)∈M ? "██" : "  ")
            end
            println()
        end
        println("Part 2: ", t)
        # break
    end
end