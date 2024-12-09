open("09.txt") do f
    diskmap = readline(f)
    files = parse.(Int, collect(diskmap[1:2:end]))
    space = parse.(Int, collect(diskmap[2:2:end]))

    p1 = 0
    spaceid = 1
    forward = true
    left, right = 1, length(files)
    for pos ∈ 0:sum(files)-1
        if forward && files[left] == 0
            forward = false
            left += 1
        end
        if !forward && space[spaceid] == 0
            forward = true
            spaceid += 1
        elseif !forward && files[right] == 0
            right -= 1
        end
        if forward
            p1 += pos * (left-1)
            files[left] -=1
        else
            p1 += pos * (right-1)
            files[right] -=1
            space[spaceid] -=1
        end
    end 
    println("Part 1: ", p1)

    files = collect(enumerate(parse.(Int, collect(diskmap[1:2:end]))))
    space = [parse.(Int, collect(diskmap[2:2:end])); [0]]
    for fileid ∈ reverse(eachindex(files))
        i = findfirst(a->a[1]==fileid, files)
        for j ∈ 1:i-1
            if files[i][2] ≤ space[j]
                id, n = popat!(files, i)
                insert!(files, j+1, (id, n))
                space[j] -= n
                insert!(space, j, 0)
                space[i] += n + space[i+1]
                deleteat!(space, i+1)
                break
            end
        end
    end

    p2 = 0
    pos = 0
    for (i, (id, n)) ∈ enumerate(files)
        for _ ∈ 1:n
            p2 += pos * (id-1)
            pos += 1
        end
        pos += space[i]
    end
    println("Part 2: ", p2)
end