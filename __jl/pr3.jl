
A = randn(100000)
unsorted_vector2 = randn(100000)
unsorted_vector3 = randn(100000)
unsorted_vector4 = randn(100000)

function shell_sort_var1!(vector::AbstractVector)
    n = length(vector) ÷ 2
    while (n > 0)
        insertion_sort!(@view vector[1:n:end])
        n = n ÷ 2
    end
    return vector
end

#function shell_sort_var2!(vector::AbstractVector)
#    n = length(vecotr) ÷ 2
    

function shell_sort_var3!(vector::AbstractVector;
    step_series = (length(vector) ÷ 2^i for i in 1:Int(floor(log2(length(vector)))))
    #step_series = filter( n -> (n < length(vector)), [1750, 701, 301, 132, 57, 23, 10, 4, 1] )
    )
    for step in step_series
        for i in firstindex(vector):lastindex(vector) - step
            j = i
            while j >= firstindex(vector) && ( vector[j] > vector[j + step] )
                vector[j], vector[j + step] = vector[j + step], vector[j]
                j -= step
            end
        end
    end
    return vector
end

function shell_sort_var4!(vector::AbstractVector;
    step_series = filter( n -> (n < length(vector)), [1750, 701, 301, 132, 57, 23, 10, 4, 1] )
    )
    for step in step_series
        for i in firstindex(vector):lastindex(vector) - step
            j = i
            while j >= firstindex(vector) && ( vector[j] > vector[j + step] )
                vector[j], vector[j + step] = vector[j + step], vector[j]
                j -= step
            end
        end
    end
    return vector
end

