# На каждом шаге мы ищем минимальный элемент в неотсортированном срезе массива и меняем
# с элементом, который стоит на первом месте в рассматриваемом срезе. Для всех элементов
# до начала среза это уже было сделано, поэтому часть массива до рассматриваемого среза
# отсортирована
function SelectionSort!(vector::Vector{Type}) where Type
    # Выбираем индекс элемента с которого будем начинать сортировку
    index_current::Integer = firstindex(vector)

    while ( index_current < lastindex(vector) )
        # На данном этапе мы задаём переменной `index_min` начальное значение равное
        # текущему индексу
        index_min::Integer = index_current

        # этим циклом мы ищем минимальный элемент в массиве, который расположен после 
        # текущего элемента
        for index in (index_current + 1) : lastindex(vector)
           index_min = ( vector[index_min] > vector[index] ) ? index : index_min 
        end
        
        # меняем местами текущий элемент и минимальный, который был найден в цикле выше
        vector[index_current], vector[index_min] =  vector[index_min], vector[index_current]

        index_current = index_current + 1
    end

end

unsorted_vector = randn(100000)
println(issorted(unsorted_vector))

@time SelectionSort!(unsorted_vector)

println(issorted(unsorted_vector))