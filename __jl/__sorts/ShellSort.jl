# Мы выбираем некоторый шаг - gap. Начиная с первого элемента идем по вектору, если элемент 
# i больше элемента  (i + gap), мы меняем их местами, иначе идем дальше. Если перестановка
# случилась, то начиная с элемента (i + gap) мы идем по вектору назад, пока не упремся
# в первый элемент, либо пока перестановки все еще случаются. Потом снова возвращаемся к 
# элементу (i + 1) и повторяем тоже самое, пока шаг больше 0.
# Кароч, это почти тоже самое, что и бабл сорт, но с самого начала шаг равен не 1, а 
# половине длины вектора. Сначала мы сравниваем все элементы, которые находятся
# друг от друга на расстоянии равном шагу. Если в какой-то момент у нас случилось, что 
# элемент стоящий на позиции i больше, чем элемент стоящий на позиции (i + gap), то
# сначала мы меняем их местами, а дальше сравниваем элемент, который стоял на позиции 
# (i + gap) с теми элементами, с которыми при очередном проходе сравнивался элеметн i -
# это можно сравнть с повторным проходом в бабл сорт, либо с циклом while, когда мы 
# переставляем элемент назад, пока он меньше стоящего сзади. Так вот т.е. мы разбили 
# вектор на подвектор из элементов которые находятся на расстоянии gap друг от друга
# и запустили по этому подвектору тот же цикл while. Идея этого алгоритма заключается в
# том, что чем дальше, тем мешьше сравнений и перестановок придется сделать. 


# Эта сортировка очень похожа на BubbleSort, но во второй с 
# самого начала шаг = 1 и сравнивались только значения
# отстающие на 1 друг друга, когда здесь не совсем так.
# Выбираем шаг `gap`, сравниваем элементы отстающие друг от 
# друга на расстоянии `gap`, тем самым больший из этих элементов
# выносится в конец вектора. В тот момент, когда больший меняется
# с соседом, сосед отравляется искать себе место, среди тех, которые
# больший уже прошел. В самом конце шаг `gap` будет равен 1, тогда это 
# точная BubbleSort, но гораздо быстрее за счет того, что вектор уже 
# почти отсортирован

# Реализация 1
function ShellSort!(vector::Vector{Type}) where Type
    size::Integer = length(vector)

    # Выбираем начальное значение для `gap`
    gap::Integer = size ÷ 2;
    
    # Пока `gap` больше 0 
    while ( gap > 0 )
        
        for index_current::Integer in 1 : size - gap 
            # println(index_current, " : ", gap, " : ", vector[index_current], " <--> ", vector[index_current + gap] ) 
            if (vector[index_current] > vector[index_current + gap])
                
                vector[index_current], vector[index_current + gap] = 
                vector[index_current + gap], vector[index_current]

                index_compare::Integer = index_current
                permutation::Bool = true 

                while ( permutation && (index_compare - gap > 0) )
                    
                    if (vector[index_compare] < vector[index_compare - gap])

                        # println(gap, " :::: ", index_compare, " : ", vector[index_compare], " <--> ", vector[index_compare - gap] ) 
                        
                        vector[index_compare], vector[index_compare - gap] = 
                        vector[index_compare - gap], vector[index_compare]
                        permutation = true
                    else
                        permutation = false
                    end 

                    index_compare = index_compare - gap
                
                end
            end
        end

    gap = gap ÷ 2;
    end

end


unsorted_vector = randn(100000)
println(issorted(unsorted_vector))

@time ShellSort!(unsorted_vector)

println(issorted(unsorted_vector))


# Реализация 2
function ShellSort_Sedgewick!(vector::Vector{Type}) where Type
    vector_gap = filter( n -> (n < length(vector)), [1, 5, 19, 41, 109, 209, 505, 929, 2161, 3905,
     8929, 16001, 36289, 64769, 146305, 260609, 587521, 1045505, 2354689, 4188161, 9427969, 16764929,
      37730305, 67084289, 150958081, 268386305, 603906049, 1073643521, 2415771649, 4294770689,
       9663381505, 17179475969] )

    for gap in vector_gap

        for index_current::Integer in 1 : length(vector) - gap 
            # println(index_current, " : ", gap, " : ", vector[index_current], " <--> ", vector[index_current + gap] ) 
            if (vector[index_current] > vector[index_current + gap])
                
                vector[index_current], vector[index_current + gap] = 
                vector[index_current + gap], vector[index_current]

                index_compare::Integer = index_current
                permutation::Bool = true 

                while ( permutation && (index_compare - gap > 0) )
                    
                    if (vector[index_compare] < vector[index_compare - gap])

                        # println(gap, " :::: ", index_compare, " : ", vector[index_compare], " <--> ", vector[index_compare - gap] ) 
                        
                        vector[index_compare], vector[index_compare - gap] = 
                        vector[index_compare - gap], vector[index_compare]
                        permutation = true
                    else
                        permutation = false
                    end 

                    index_compare = index_compare - gap
                
                end
            end
        end
    end
end

unsorted_vector = randn(100000)
println(issorted(unsorted_vector))

@time ShellSort_Sedgewick!(unsorted_vector)

println(issorted(unsorted_vector))