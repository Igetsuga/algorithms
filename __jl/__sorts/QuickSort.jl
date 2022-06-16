function TripleSort!(vector::Vector{Type}) where Type
    max_::Type, min_::Type = maximum(vector), minimum(vector)
    mean_::Type = 0
    
    for itt in 1 : lastindex(vector)
        mean_ = mean_ + vector[itt]
    end
    
    mean_ = mean_ - max_ - min_

    vector[1], vector[2], vector[3] = min_, max_, mean_
end



# выбор опорного элемента -- `pivot` и разделение массива на
# две части. Левая часть содержит только те элементы, которые
# меньше чем `pivot`, правая соответственно больше

# Разбиение Ломуто
function partition_Lomuto!(vector::AbstractVector)

    left = firstindex(vector)
    right = lastindex(vector)
    
    # index_mid = left + ( (right - left) ÷ 2 )
    # пусть `pivot` -- середина среза
    
    
    # Отправляем `pivot` в конец
    # vector[index_mid], vector[end] =
    # vector[end], vector[index_mid]

    pivot = vector[end]

    index_smaller = 0
    for compare_counter in 1 : lastindex(vector) - 1
        if (vector[compare_counter] < pivot)
            index_smaller += 1
            vector[compare_counter], vector[index_smaller] = 
            vector[index_smaller], vector[compare_counter]
        end
    end

    # vector[ left + ( (right - left) ÷ 2 ) ], vector[index_smaller + 1] =
    # vector[index_smaller + 1], vector[ left + ( (right - left) ÷ 2 ) ]
    vector[index_smaller + 1], vector[end] = 
    vector[end], vector[index_smaller + 1] 


    return index_smaller, index_smaller + 1
end


# Разбиение Хоара
function partition_Hoare!(vector::AbstractVector{Type}) where Type

    left = firstindex(vector)
    right = lastindex(vector)

    # Выбираем `pivot` как медиану массива
    mid::Integer = left + (right - left) ÷ 2
    subvector::Vector{Type} = [vector[begin], vector[end], vector[mid]]
    # `pivot` окажется в конце массива
    TripleSort!(subvector)
    pivot::Type = vector[end]
    # разделение массива на две части
    right = right - 1 
    while ( true )

        while (vector[left] < pivot)
            left = left + 1
        end 
        while (vector[right] > pivot)
            right = right - 1
        end 

        if (right > left)
            vector[left], vector[right] = vector[right], vector[left]
        else
            vector[left], vector[end] = vector[end], vector[left]
            break
        end

    end
    

    return right, left + 1
end

function QuickSort!(vector::AbstractVector) 

    if (length(vector) > 1)

        (leftPart_lastIndex, rightPart_firstIndex) = partition_Hoare!(vector)

        QuickSort!( @view vector[begin : leftPart_lastIndex] )

        QuickSort!( @view vector[rightPart_firstIndex : end] )

    else
        
        
        return vector
    end
end

unsorted_vector = randn(100000)
println(issorted(unsorted_vector))

@time QuickSort!(unsorted_vector)
a = sort(unsorted_vector)

println(issorted(unsorted_vector))
# 
# b  = (a .== unsorted_vector)
# println(b)

function partition!(vector::AbstractVector)
    
    left = firstindex(vector)
    right = lastindex(vector)

    pivot = vector[end]
    index_smaller = 0

    for it in 1 : lastindex(vector) - 1
        if (vector[it] < pivot)
            index_smaller += 1
            vector[it], vector[index_smaller] =
            vector[index_smaller], vector[it]
        end
    end

    vector[index_smaller + 1], vector[end] = 
    vector[end], vector[index_smaller + 1] 



    return index_smaller, index_smaller + 1
end


function _quicksort!(vector::AbstractVector)
    

    if ( length(vector) > 1 )

        (leftPart_lastIndex, rightPart_firstIndex) = partition!(vector)
        _quicksort!( @view vector[begin : leftPart_lastIndex] )
        _quicksort!( @view vector[rightPart_firstIndex : end] )
    else 
        return vector
    end

end

unsorted_vector = randn(100000)
println(issorted(unsorted_vector))

@time _quicksort!(unsorted_vector)
println(issorted(unsorted_vector))
