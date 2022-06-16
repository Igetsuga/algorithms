# - [] i-aя порядковая статистика -- значение элемента, который
#      находится на i-ой позиции в отсортированном массиве.

# Нахождение i-ой порядковой статистики, используя метод
# разбиения Хоора.

# Для начала опишем метод разбиение Хоора. Массив делится на 3
# части (или на 2 части) относительно выбранного элемента, который 
# мы называет `pivot`. В первой части расположены элементы, 
# значении которых строго меньше, чем pivot. В средней части 
# - раные ему. В последней части - сторого большие, чем pivot.
# Это выполняется для каждого выбранного pivot, поэтому это 
# можно считать инвариантом для разбиения 

# разбиение на 3 части
function partition_Hoare!(vector::AbstractVector{Type}, pivot::Type) where Type
    
    index = firstindex(vector)
    leftBorer = firstindex(vector)
    rightBorder = lastindex(vector) 

    @inbounds while ( index < rightBorder )
        if vector[index] == pivot
            leftBorer += 1
        elseif ( vector[index] > pivot )
            
            vector[index], vector[rightBorder] =
             vector[rightBorder], vector[index]
            
             rightBorder -= 1
        else 
            
            leftBorer += 1
            index += 1

            vector[index], vector[leftBorder] =
             vector[leftBorder], vector[index]
        end
    end


    return index, rightBorder + 1 
end

# разбиение на 2 части
function _partition_Hoare!(vector::AbstractVector{Type}, pivot) where Type

    left = firstindex(vector)
    right = lastindex(vector)

    # right = right - 1 
    while ( true )

        @inbounds while ( vector[left] < pivot )
            left = left + 1
        end 
        @inbounds while ( vector[right] > pivot )
            right = right - 1
        end 

        if ( right > left )
            vector[left], vector[right] =
             vector[right], vector[left]
        else
            vector[left], vector[end] =
             vector[end], vector[left]
            break
        end

    end
    

    return right, left + 1
end

# Вычисление порядковой статистики
# Для того, чтобы вычислить i-ую порядковую статистику, нам 
# нужно определить отсортировать диапазон индексов, в котором
# содержится индекс i. На самом деле нам нужно отсортировать его 
# относительно некоторого выбранного элемента, т.е. нам нужно 
# выполнить разбиение массива на 3(или 2) части. 

# Почему так происходит. Дело в том, что после очередной 
# сортировки  ~ разбиения, в левой части новый пивот точно 
# не больше старого, поэтому элементы, которые были максимально
# приближены к старому pivot будут больше, чем новый pivot, 
# они никуда не сдвинуться, то же самое и в правой части, но
# только там самые маленькие не будут никуда двигаться,
# что после очередного разбиения в некоторой окресности pivot
# элементы уже отсортированы. И, конечно, после каждого
# разбиения pivot становится на свое место. Поэтому можно
# заключить, порядковая статистика соответствующих
# индексов совпадет с ними.

function order_statistics!(vector::AbstractVector{Type}, order::Integer) where Type
    
    size = length(vector)
    
    leftPart_lastIndex, rightPart_firstIndex = _partition_Hoare!(vector,
     vector[ rand( firstindex(vector) : lastindex(vector) ) ]) 
    
     if ( leftPart_lastIndex < order < rightPart_firstIndex )
        
        
        return vector[order]
    elseif ( order <= leftPart_lastIndex )
        
        
        return order_statistics!( @view(vector[firstindex(vector) : leftPart_lastIndex]), order ) 
    else 
        
        
        return order_statistics!( @view(vector[rightPart_firstIndex : lastindex(vector)]), order )
    end
end


# Вычисление медианы массива

# [НЕПОНЯТНО] -- оказывается, что это по опрделению
                # https://en.wikipedia.org/wiki/Median
# ------------------------
# Медиана массива - это порядковая статистика с индексом $N/2+1$,
# если длина массива $N$ - нечетная, или - среднее арифметическое
# порядковых статистик с индексами $N/2$ и $N/2+1$,
# если $N$ - четное. 
# ------------------------

# Если медиана массива это его порядковая статистика, то можно 
# воспользоваться функцией order_statistics!. 



# Поиск первых k наименьших элементов массива

# Первые k наименьшие элемента массива удовлетворяют неравенству 
# vector[i] <= OS[k] для i = 1:k-1, где OS[k] - порядковая
# статистика

# Алгоритм 1: O(n) 
    # 1. вычисление порядковой статистики = O(n)
    # 2. проход по массиву и сбор элементов = O(n)

        # O(n) + O(n) = O(n) 

# Алгоритм 2: O(n) 
#     1. берем подмассив начального массива, сортируем его = O(n).
#        Т.к. ( k = const )
#     2. ИНВАРИАНТ: в выбранном подмассиве всегда будут находиться
#        наименьшие из среза vector[1:i]
#     3. Цикл по всему массиву, если найдем элемент vector[i],
#        который меньше, чем наибольший из выбранного массива,
#        добавляем его в выбранный массив. = O(n) * O(1)
#     4. Сортируем массив, чтобы на его конце был максимальный 
#        элемент = O(k) = const < O(n)

            # O(n) + O(n) * O(1) = O(n) 


function _invBubbleSort!(vector::Vector)
# Поскольку нам нужно протолькнуть на свое место только последний
# элемент, то начинать нужно с конца, а поскольку до него все
# элементы уже отсортированы, то нужен всего 1 проход
    index = lastindex(vector)
    @inbounds while ( index - 1 >= firstindex(vector) )
        if ( vector[index] < index[index - 1] )
            vector[index], index[index - 1] =
            vector[index - 1], index[index] 
        end

        index -= 1 
    end

end

function _myfunc(vector::AbstractVector{Type}, k::Integer) where Type
    
    result::AbstractVector{Type} = sort( @view vector[1 : k])
    
    index = k + 1
    @inbounds while (index < lastindex(vector))
        
        if (vector[k] < result[end])
            result[end] = vector[k]

            _invBubbleSort!(result)
        end

        index += 1
    end
    

    return result
end



"""Сортировка Хоара"""
function quick_sort!(A)
    length(A) <= 1 &&  return A
    N = length(A)
    left, right = part_sort!(A, A[rand(1:N)])
    quick_sort!(left)
    quick_sort!(right)
    return A
end

"""Вспомогательная сортировка"""
function part_sort!(A, b)
    N = length(A)
    K, L, M = 0, 0, N
    # Инвариант: A[1:K] <b && A[K+1:L] == b && A[M+1:N] > b
    @inbounds while L < M
        if A[L+1] == b
            L += 1
        elseif A[L+1] > b
            A[L+1], A[M] = A[M], A[L+1]
            M -= 1
        else
            L += 1; K += 1
            A[L], A[K] = A[K], A[L]
        end
    end
    return @view(A[1:K]), @view(A[M+1:N])
end

"""Вычисление k-ой порядковой статистики методом Хоара"""
function order_statistics!(A::AbstractVector{T}, i::Integer)::T where T
    function find(index_range)
        left_range, right_range = part_sort!(A, index_range, A[rand(index_range)])
        if i in left_range
            return find(left_range) 
        elseif i in right_range
            return find(right_range)
        else
            return A[i]
        end
    end
    find(firstindex(A):lastindex(A))
end

@inline function part_sort!(A, index_range::AbstractUnitRange, b)
    K, L, M = index_range[1]-1, index_range[begin]-1, index_range[end]
    @inbounds while L < M 
        if A[L+1] == b
            L += 1
        elseif A[L+1] > b
            A[L+1], A[M] = A[M], A[L+1]
            M -= 1
        else
            L += 1; K += 1
            A[L], A[K] = A[K], A[L]
        end
    end    
    return index_range[begin]:K, M+1:index_range[end]
end

"""Вычисление медианы массива"""
function median(A::AbstractVector{T}) where T
    if length(A) % 2 != 0
        return order_statistics!(A, length(A) ÷ 2 + 1)
    else
        return (order_statistics!(A, Int(length(A)/2)) + order_statistics!(A, Int(length(A)/2) + 1))/2
    end
end

"""Поиск первых k наименьших элементов массива"""
function minimums(array, k)
    N = length(array)
    k_minimums = sort(array[1:k])
    i = k
    while i < length(array)
        i += 1
        if array[i] < k_minimums[end]
            k_minimums[end] = array[i]
            insert_end!(k_minimums)
        end
    end
    return k_minimums
end            

function insert_end!(array)::Nothing
    j = length(array)
    while j>1 && array[j-1] > array[j]
        array[j-1], array[j] = array[j], array[j-1]
        j -= 1
    end
end

"""Алгоритм вычисления среднего квадратического отклонения от среднего значения массива"""
function standard_deviation(A)
    Sx = 0
    Sx2 = 0
    for i in firstindex(A):lastindex(A)
        Sx += a[i]
        Sx2 += a[i]*a[i]
    end
    return sqrt(Sx2 / length(A) - Sx * Sx / length(A)/ length(A))
end