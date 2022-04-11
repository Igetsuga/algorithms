function BubbleSort!(vector::AbstractVector)

    for itt = 1:(lastindex(vector) - 1)
        for jtt = 1:(lastindex(vector) - itt)
            if (vector[jtt] > vector[jtt + 1])
                vector[jtt], vector[jtt + 1] = vector[jtt + 1], vector[jtt]
            end
        end
    end 

end

unsorted_vector = randn(100)
A = copy(unsorted_vector)
println(issorted(unsorted_vector))


BubbleSort!(unsorted_vector)
# println(A .== unsorted_vector)
println(issorted(unsorted_vector))