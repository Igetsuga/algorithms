function CombSort!(vector::Vector)

    start = firstindex(vector)
    size = length(vector)

     # gap = eltype(Int64)(length(vector))
     gap::Integer = size
     factor = eltype(Float64)(1.2473309)

    while (gap > 0)
        

        for index in start + 1 : size - gap 
            if (vector[index] > vector[index + gap])
                vector[index], vector[index + gap] = vector[index + gap], vector[index]
            end 
        end 
        # index = firstindex(vector)
        # while (index + gap < lastindex(vector))
            
        #     if (vector[index] > vector[index + gap])
        #         vector[index], vector[index + gap] = vector[index + gap], vector[index]
        #     end  
        #     # ( vector[index] > vector[index + gap] ) ||
        #     # vector[index], vector[index + gap] = vector[index + gap], vector[index]
        #     index += 1
        # end

        gap = gap ÷ factor
    end

end

unsorted_vector = randn(100000)
println(issorted(unsorted_vector))

@time CombSort!(unsorted_vector)

println(issorted(unsorted_vector))

