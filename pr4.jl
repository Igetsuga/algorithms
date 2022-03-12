unsorted_vector = randn(100000)

function partition!(vector::AbstractVector, left::Integer, right::Integer)
    pivot = vector[ (left + right ÷ 2) ] 
    while (left <= right)
        while (vector[left] < pivot)
            left = left + 1
        end 
        while (vector[right] > pivot)
            right = right - 1
        end 
        if (left >= right)
            break
        else
            vector[left + 1], vector[right - 1] = vector[right - 1], vector[left + 1]
        end
    end
    return right
end


function quicksort!(vector::AbstractVector, l, r)
    if (length(vector) == 1 || length(vector) == 0 )
        return vectror
    else 
        middle = partition(vector, l, r)
        quicksort!( @view vector[l : middle], l, middle )
        quicksort!( @view vectot[middle + 1 : r], middle + 1, r )
        return vector
    end 
end

issorted(unsorted_vector)














# function quicksort!(vector::AbstractVector; )
#     if (length(vector) == 0 || length(vector) == 1 )
#         return vector
#     else 
#         itt = (1 + length(vector)) ÷ 2

#         while 

