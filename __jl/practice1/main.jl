function _findall( container, func::Function )
    
    cartesian = CartesianIndices(container) # result vector of indecxes
    result::Vector = [] # result vector of indecxes

    for (index_linear, value) in enumerate(container)
        if (func(value) == true)
            push!(result, cartesian[index_linear])
        end
    end

    
    return result
end

# test 1
test = [1 2; 2 4; 2 6]
# _findall(test, !isodd)

#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#

function _issorted( container, func::Function )

    for index_linear in ( firstindex(container) + 1 ) : lastindex(container)
        if ( func( container[index_linear - 1] ) > func( container[index_linear] ) )
            return false
        end
    end


    return true
end

# test 1
test = [1, 2, 4, 5, 3]
_issorted(test, x-> x)

# test 2
test = [1, 2, 4, 5]
_issorted(test, x-> x)

#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#

function _slice(container::Matrix, row::Vector{Int}, col::Vector{Int})
    
    result = Matrix{eltype(container)}(undef, length(row), length(col))

    for i in row
        for j in col 
            result[i,j] = container[row[i], col[j]]
        end
    end


    return result
end

# test 1
test = [1 2; 2 4; 2 6]
# _slice( test, [1:2], [1,2] )
# _slice( test, [2], [1,2] ) не работает из-за того, что выделяется место
# lenght(row) = 1, а обращаемся ко 2-му элементу
#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
