vector_unsorted = rand(100000)


@inline function Base.merge!(vector_1::AbstractVector, vector_2::AbstractVector,
    vector_copy::AbstractVector)

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
    # элементы этого вектора точно больше другого
    if ( it1 > lenght(vector_1) )
        vector_copy[it : lastindex(vector_copy)] .= @view(vector_2[it2 : lastindex(vector_2)])
    else
        vector_copy[it : lastindex(vector_copy)] .= @view(vector_1[it1 : lastindex(vector_1)])
    end

    nothing
end





@inline function merge_sort!(vector::AbstractVector)

    vector_copy = similar(vector)

    if ( length(vector) > 2 )

        middle = firstindex(vector) + ( lastindex(vector) - firstindex(vector) ) ÷ 2

        vector_current_1 = merge_sort!( @view( vector[firstindex(vector) : middle] ) )
        vector_current_2 = merge_sort!( @view( vector[middle + 1 : lastindex(vector)] ) )

        Base.merge!(vector_current_1, vector_current_2, vector_copy)
        
        return ( vector_copy ) 
    else 

        if ( vector[firstindex(vector)] > vector[lastindex(vector)] )   
            vector[firstindex(vector)], vector[lastindex(vector)] = vector[lastindex(vector)], vector[firstindex(vector)]
        end

    end

end


issorted(vector_unsorted)

merge_sort!(vector_unsorted)

issorted(vector_unsorted)


@inline function merge_sort!(vector::AbstractVector)

    size = vector(length)
    itt = 1
    double = size ÷ 2
    while true

        step = 2
        num_double = size ÷ step

        for step in 1:num_double

            vector[itt : itt + 1]

        






end
