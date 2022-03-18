unsorted_vector = randn(100000)


# отвечает за выбор опорного элемента `pivot`и за перемещение элементов в самом массиве
function partition!(vector::AbstractVector, left::Integer, right::Integer)

    # выбор опорного элемента - разделяющий массив элемент
    pivot = vector[ left + (right - left) ÷ 2 ] 


    # цикл прохода
    while (left <= right)

        # находим в левой части массива элемент, который больше опорного
        while (vector[left] < pivot)
            left = left + 1
        end 

        # находим в правой части массива элемент, который меньше опорного
        while (vector[right] > pivot)
            right = right - 1
        end 

        # это условие должно выпониться только тогда, когда после очередного прогона 
        # индексы left и right поменялись местами, тогда цикл должен быть закончен, а 
        # элементы не должны поменяться местами, т.к. уже находяться в правильных частях массива
        if (left >= right)
            break
        else
            # отправить элемент из левой части, который больше опорного, в правую часть
            # отправить элемент из правой части, который меньше опорного, в левую часть
            vector[left], vector[right] = vector[right], vector[left]
        end
    end
    # для последующих вызовов функции quick_sort! нужны индексы на конец левой части и начала правой части массива
    return right


end

# рекурсивный алгоритм Быстрой сортировки
function quick_sort!(vector::AbstractVector, index_l, index_r)

    # база рекурсии
    if (length(vector[index_l : index_r]) < 2)
        return vector

    else 
        index_current = partition!(vector, index_l, index_r)
        

        # новая левая часть массива
        quick_sort!( @view( vector[begin : index_current] ), firstindex(vector), index_current )
    
        # новая правая часть массива
        quick_sort!( @view( vector[index_current + 1 : end] ), index_current + 1, lastindex(vector) )


        return vector
    end 
end



# Point 1
issorted(unsorted_vector)

# print(firstindex(unsorted_vector), " : ", lastindex(unsorted_vector))

# Point 2. Запуск алгоритма quick_sort!
quick_sort!(unsorted_vector, firstindex(unsorted_vector), lastindex(unsorted_vector))


# Point 3. Проверка массива
issorted(unsorted_vector)



