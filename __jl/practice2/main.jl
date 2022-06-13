function _reverse!(container::Vector{Type}) where Type

    value_perm = eltype(Type)(0)

    index_left = firstindex(container)
    index_right = lastindex(container) 
    
    while (index_left < index_right)
        
        value_perm = container[index_left]

        container[index_left] .= container[index_right]
        container[index_right] .= value_perm

        index_left += 1
        index_right -= 1
    end
end

#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#

function _shift!(container::Vector{Type}, shift::Int) where Type
 
    if ( shift >= length(container) )
        for index in firstindex(container) : lastindex(container) 
            container[index] = 0
        end
    end


    if (shift > 0)

        index = lastindex(container)
        
        while (index >= firstindex(container) + shift)
            container[index] .= container[index - shift]
            index -= 1
        end

        while (index >= firstindex(container))
            container[index] .= 0
            index -= 1
        end

    else 
        
        index = firstindex(container)
        
        while (index <= lastindex(container) + shift)
            container[index] .= container[index - shift]
            index += 1
        end

        while (index <= lastindex(container))
            container[index] .= 0
            index += 1
        end

    end
end

#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#

function _circshift!(container::Vector{Type}, shift::Int) where Type

    size = length(container)
    shift = shift % size
    if (shift < 0)
        shift = size + shift
    end    
    
    index = firstindex(container)
    value_prev = container[index]
    index_next = (index + shift) % size
    
    while (index_next != firstindex(container))
        value_next = container[index_next]
        container[index_next] = value_prev

        value_prev = value_next
        index = (index + shift) % size
        index_next = (index_next + shift) > size ? (index_next + shift) % size : (index_next + shift)
    end

    container[begin] = value_prev

end

#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#

# from Julia's bib
function _ispermutation(container::Vector{Int})
    
    size = length(container)  
    used = falses(size)

    for element in container
        (element in 1:n) && (used[i] ⊻ true) || return false
    end

    
    return true
end

#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
#-----------------------------------------------------------------------------#
