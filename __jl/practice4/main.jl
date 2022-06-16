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
function partition_Hoare!(vector::Vector{Type}, pivot::Type) where Type
    
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

            vector[index], vector[leftBorer] =
             vector[leftBorer], vector[index]
        end
    end


    return index, rightBorder + 1 
end

# разбиение на 2 части
function _partition_Hoare!(vector::Vector{Type}, pivot) where Type

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

function order_statistics!(vector::Vector{Type}, order::Integer) where Type
    
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

function _myfunc(vector::Vector{Type}, k::Integer) where Type
    
    result::Vector{Type} = sort( @view vector[1 : k])
    
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