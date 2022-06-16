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
function partition_Lomuto!(vector::Vector{Type}) where Type

    left = firstindex(vector)
    right = lastindex(vector)

    # пусть `pivot` -- середина среза
    pivot::Type = vector[ left + ( (right - left) ÷ 2 ) ]
    # Отправляем `pivot` в конец
    vector[ left + ( (right - left) ÷ 2 ) ], vector[end] =
    vector[end], vector[ left + ( (right - left) ÷ 2 ) ]

    index_smaller = 0
    for counter_compare in 1 : lastindex(vector) - 1
        if (vector[counter_compare] < pivot)
            index_smaller = index_smaller + 1
            vector[counter_compare], vector[index_smaller] = 
            vector[index_smaller], vector[counter_compare]
        end
    end

    vector[ left + ( (right - left) ÷ 2 ) ], vector[index_smaller + 1] =
    vector[index_smaller + 1], vector[ left + ( (right - left) ÷ 2 ) ]


    return index_smaller, index_smaller + 2
end


# Разбиение Хоара
function partition_Hoare!(vector::Vector{Type}) where Type

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

function QuickSort!(vector::Vector{Type}) where Type

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

println(issorted(unsorted_vector))
