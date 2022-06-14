# Merge Sort -- сортировка слиянием

# Идея: 
    # 1. дробление всего массива на непересекающиеся 
    #    множества 2-элементных(может остаться 1 одноэлементный) 
    # 2. сортировка каждого из двуэлементных массивов
    # 3. слияние массивов с длинной n или (n и n+1)
    #    в один с длинной (2*n) или (2*n) + 1

# Слияние двух массивов
function _merge(A::Vector{Type}, B::Vector{Type}) where Type
    
    result::Vector{Type} = []

    itA = firstindex(A)
    itB = firstindex(B)

    @inbounds while (itA <= lastindex(A) && itB <= lastindex(B))
        
        if (A[itA] < B[itB])
            push!(result, A[itA])
            itA +=1
        else
            push!(result, B[itB])
            itB += 1
        end
        
    end

    append!(result, A[ itA : lastindex(A) ])
    append!(result, B[ itB : lastindex(B) ])


    return result
end

# Основная функция
function _sort(vector::Vector)

    if (length(vector) <= 1 )
        return vector
    end

    partLeft = _sort(vector[begin : lastindex(vector) ÷ 2])
    partRight = _sort(vector[lastindex(vector) ÷ 2 + 1 : end])
    
    vector = _merge(partLeft, partRight)


    return vector
end

unsorted_vector = randn(10000)
println(issorted(unsorted_vector))

@time result = _sort(unsorted_vector)

println(issorted(result))