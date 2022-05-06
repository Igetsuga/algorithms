function BubbleSort!(vector::AbstractVector)

    @inbounds for itt = 1:(lastindex(vector) - 1)
        flag = false
        @inbounds for jtt = 1:(lastindex(vector) - itt)
            if (vector[jtt] > vector[jtt + 1])
                vector[jtt], vector[jtt + 1] = vector[jtt + 1], vector[jtt]
                flag = true
            end
        end
        if (!flag)
            break 
        end 
    end 

end

unsorted_vector = randn(100)
A = copy(unsorted_vector)
println(issorted(unsorted_vector))


BubbleSort!(unsorted_vector)
# println(A .== unsorted_vector)
println(issorted(unsorted_vector))