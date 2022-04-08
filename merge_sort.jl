vector_unsorted = rand(100000)

# слияние двух уже отсортированных массивов в один отсортированный
@inline function Base.merge!(vector_1::AbstractVector, vector_2::AbstractVector)

    
    index_max = min( lenght(vector_1), lenght(vector_2) )
    it, it1, it2 = 1, 1, 1

    @inbounds while ( it1 <= index_max && it2 <= index_max )

        if ( vector_1[it1] < vector_2[it2] )
            vector_copy[it] = vector_1[it1]
            it1 += 1
        else
            vector_copy[it] = vector_2[it2]
            it2 += 1    
        end

        it += 1

    end
    
    # у одного из массивов(vector_1 или vector_2) мог остаться кусок, который не переписали в vector_copy, 
    # первый элемент из этого куска точно не меньше, чем маскимальный элемент из второго массива
    if ( it1 > lenght(vector_1) )
        vector_copy[it : lastindex(vector_copy)] .= @view(vector_2[it2 : lastindex(vector_2)])
    else
        vector_copy[it : lastindex(vector_copy)] .= @view(vector_1[it1 : lastindex(vector_1)])
    end

    # return vector_copy
    return nothing
end





# @inline function merge_sort_rec!(vector::AbstractVector)

#     vector_copy = similar(vector)

#     if ( length(vector) > 1 )

#         middle = firstindex(vector) + ( lastindex(vector) - firstindex(vector) ) ÷ 2

#         vector_current_1 = merge_sort!( @view( vector[firstindex(vector) : middle] ) )
#         vector_current_2 = merge_sort!( @view( vector[middle + 1 : lastindex(vector)] ) )

#         Base.merge!(vector_current_1, vector_current_2, vector_copy)
        
#         return ( vector_copy ) 
#     # else 

#     #     if ( vector[firstindex(vector)] > vector[lastindex(vector)] )   
#     #         vector[firstindex(vector)], vector[lastindex(vector)] = vector[lastindex(vector)], vector[firstindex(vector)]
#     #     end

#     end
#     return vector

# end


@inline function merge_sort_it!(vector::AbstractVector)

    vector_copy = similar(vector)
    vector_length = lenght(vector)
    # длинна блоков, которые мы будем слиять 
    n = 1
    while n < N
        itt = div(N,2n)
        for it in 0:K-1
            merge!(@view(a[(1:n).+k*2n]), @view(a[(n+1:2n).+k*2n]), @view(b[(1:2n).+k*2n]))
        end
        if N - K*2n > n # - осталось еще смержить блок длины n и более короткий остаток
            merge!(@view(a[(1:n).+K*2n]), @view(a[K*2n+n+1:end]), @view(b[K*2n+1:end]))
        elseif 0 < N - K*2n <= n # - оставшуюся короткую часть мержить не с чем
            b[K*2n+1:end] .= @view(a[K*2n+1:end])
        end
        a, b = b, a
        n *= 2
    end
    if isodd(log2(n)) # - если цикл был выполнен нечетное число раз
        b .= a  # b = copy(a) - это было бы не то же самое, т.к. тут получилась бы ссылка на новый массив, который создаст функция copy
        a = b
    end
    return a # - ссылка на исходный массив (проверить, что это так, можно с помощью ===)

end



issorted(vector_unsorted)

merge_sort_it!(vector_unsorted)

issorted(vector_unsorted)


# @inline function merge_sort!(vector::AbstractVector)

#     size = vector(length)
#     itt = 1
#     double = size ÷ 2
#     while true

#         step = 2
#         num_double = size ÷ step

#         for step in 1:num_double

#             vector[itt : itt + 1]

        






# end
