# Мы выбираем некоторый шаг - gap. Начиная с первого элемента идем по вектору, если элемент 
# i больше элемента  (i + gap), мы меняем их местами, иначе идем дальше. Если перестановка
# случилась, то начиная с элемента (i + gap) мы идем по вектору назад, пока не упремся
# в первый элемент, либо пока перестановки все еще случаются. Потом снова возвращаемся к 
# элементу (i + 1) и повторяем тоже самое, пока шаг больше 0.
# Кароч, это почти тоже самое, что и бабл сорт, но с самого начала шаг равен не 1, а 
# половине длины вектора. Сначала мы сравниваем все элементы, которые на ходятся на 
# друг от друга на расстоянии равном шагу. Если в какой-то момент у нас случилось, что 
# элемент стоящий на позиции i больше, чем элемент стоящий на позиции (i + gap), то
# сначала мы меняем их местами, а дальше сравниваем элемент, который стоял на позиции 
# (i + gap) с теми элементами, с которыми при очередном проходе сравнивался элеметн i -
# это можно сравнть с повторным проходом в бабл сорт, либо с циклом while, когда мы 
# переставляем элемент назад, пока он меньше стоящего сзади. Так вот т.е. мы разбили 
# вектор на подвектор из элементов которые находятся на расстоянии gap друг от друга
# и запустили по этому подвектору тот же цикл while. Идея этого алгоритма заключается в
# том, что чем дальше, тем мешьше сравнений и перестановок придется сделать. 


function ShellSort!(vector::AbstractVector{Type}) where Type
    vector_lenght::Integer = length(vector)

    # Выбираем первоначальный gap
    gap::Integer = vector_lenght ÷ 2;
    
    # Пока gap больше 0 
    while ( gap > 0 )
        
        for index_start::Integer in 1 : vector_lenght - gap 
            println(index_start, " : ", gap, " : ", vector[index_start], " <--> ", vector[index_start + gap] ) 
            if (vector[index_start] > vector[index_start + gap])
                
                vector[index_start], vector[index_start + gap] = 
                vector[index_start + gap], vector[index_start]

                index_compare::Integer = index_start 
                permutation::Bool = false 

                while ( !permutation && index_compare - gap > 0 )
                    
                    if (vector[index_compare] < vector[index_compare - gap])

                        println(gap, " :::: ", index_compare, " : ", vector[index_compare], " <--> ", vector[index_compare - gap] ) 
                        
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


unsorted_vector =  [0.5398815214815024, 0.904427251181875, 0.14359239927671053, 0.6685221789412202, 0.15012254794734026, 0.8437516189156684, 0.46475922802394254, 0.7488612583560331, 0.5523845879853817, 0.13950319933022115, 0.4469631610720366, 0.11836921581435778, 0.29527324420398426, 0.31216161654101426, 0.09060008015256626, 0.8077955037136461, 0.8078944181866511, 0.65086967824949, 0.09613702108924282, 0.7773035011490173]
println(unsorted_vector)
println(issorted(unsorted_vector))
A = copy(unsorted_vector)
ShellSort!(unsorted_vector)
A = sort(A)
println(A .== unsorted_vector)
println(unsorted_vector)
# println(A)
println(issorted(unsorted_vector))
