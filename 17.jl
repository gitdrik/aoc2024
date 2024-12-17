open("17.txt") do f
    A, B, C, ints... = parse.(Int, [m.match for m ∈ eachmatch(r"\d+", read(f, String))])
    A0 = A
    # Part 2: Want output  [2,4,1,5,7,5,1,6,0,3,4,2,5,5,3,0]
    # Combination of manual search and iterations gave:
    # just below the limit to get 3, 0 last: 105553116000000
    # just below the limit to get 2 on 5:th last: 105561706000001
    # just below the limit to get 2,5,5,3 onlast: 105965433000001
    # lost the 2 before getting 4,2,5,5,3, atemt to get a new 2?
    # just before loosing the 2:105974023000001
    # Just before getting 4, 2, 5, 5, 3, 0: 106085692000001
    # Just before getting 3, 4, 2, 5, 5, 3, 0: 106086363000001
    # The answer: 106086382266778
    for N ∈ [A0, 106086382266778]
        i = 1
        A, B, C = N, 0, 0
        N % 1000000 == 1 && println(N, (A, B, C), output)
        output = Array{Int}([])
        while i < length(ints)
            opcode = ints[i]
            n = ints[i+1]
            literal = n
            combo = n ∈ 0:3 ? n : [A, B, C][n-3] #n is never 7
            if opcode==0 #adv
                A = A>>combo
            elseif opcode==1 #bxl
                B = B ⊻ literal
            elseif opcode==2 #bst
                B = mod(combo, 8)
            elseif opcode==3 && A≠0 #jnz
                i = literal-1
            elseif opcode==4 #bxc
                B = B ⊻ C
            elseif opcode==5
                push!(output, mod(combo, 8))
            elseif opcode==6 #bdv
                B = A>>combo
            elseif opcode==7 #cdv
                C = A>>combo
            end
            i += 2
        end
        N==A0 && println("Part 1: ", join(string.(output), ','))
        output==ints && println("Part 2: ", N)
    end
end