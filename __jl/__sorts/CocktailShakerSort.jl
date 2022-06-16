function CocktailShakerSort!(vector::Vector)
    isSwapped = true
    
    index_left = firstindex(vector)
    index_right = lastindex(vector) - 1

    while (isSwapped)

        for index in index_left : index_right 
            if (vector[index] > vector[index + 1])
                vector[index], vector[index + 1] =
                vector[index + 1], vector[index]

                isSwapped = true
            end
        end

        if (!isSwapped)
            return nothing
        end

        isSwapped = false
        index_right -= 1

        for index in index_right : -1 : index_left 
            if (vector[index] > vector[index + 1])
                vector[index], vector[index + 1] =
                vector[index + 1], vector[index]

                isSwapped = true
            end
        end

        index_left += 1
    end

end

unsorted_vector = randn(100)
println(issorted(unsorted_vector))

@time CocktailShakerSort!(unsorted_vector)

println(issorted(unsorted_vector))