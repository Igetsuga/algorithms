mutable struct Polynomial{Type}
    coeff::Vector{Type}

    # constructor
    function Polynomial{Type}(other_coeff) where Type 
        zeros = 0
        for element in reverse(other_coeff)
            if ( element == 0 )
                zeros += 1
            else 
                break
            end
        end
        new( other_coeff[1 : end-zeros] )
    end

end

# Степень многочлена 
deg(pol::Polynomial) = length(pol.coeff) - 1

# --------------------------------
# вектор `coeff` представляет собой показатели при возрастающих степенях
# --------------------------------


function Base. +(p::Polynomial{Type}, q::Polynomial{Type})::Polynomial{Type} where Type
   
    p_size, q_size = length(p.coeff), length(q.coeff)

    # if  p_size >= q_size 
    #     result = similar(p.coeff)
    #     result[1 : q_size] .= ( @view( p.coeff[1 : q_size] ) .+ q.coeff ) 
    # else
    #     result = similar(q.coeff)
    #     result[1 : p_size] .= ( @view( q.coeff[1 : p_size] ) .+ p.coeff )
    # end
    if ( p_size >= q_size )
        result = copy(p.coeff)
        for it in 1 : q_size
            result[it] = result[it] + q.coeff[it]
        end
    else
        result = copy(q.coeff)
        for it in 1 : p_size
            result[it] = result[it] + p.coeff[it]
        end
    end
    # ------В отдельную фукцию----- #
    # При сложении некоторые старшие коэфициенты могли обратиться в 0 
    index, count_zeros = lastindex(result), 0
    @inbounds while ( index > 0 && result[index] == 0 )
        count_zeros += 1
        index -= 1
    end

    # count_zeros = число нулей в конце массива coeff,
    # соответсвующих старшим степеням  
    resize!(result, length(result) - count_zeros)
    # ------В отдельную фукцию----- #
    
    
    return Polynomial{Type}(result)
end


function Base. -(p::Polynomial{Type}, q::Polynomial{Type})::Polynomial{Type} where Type
    # 1. можно было бы создать новый многочлен q_negative с отрицательными 
    #    коэффициетами и перейти к сложению (p + q_negative), но это потребует 
    #    выделение дополнительной памяти, поэтому лучшим решением будет
    #    копипаст реализации сложения

   
    p_size, q_size = length(p.coeff), length(q.coeff)

    # if  p_size >= q_size 
    #     result = similar(p.coeff)
    #     result[1 : q_size] .= ( @view( p.coeff[1 : q_size] ) .- q.coeff ) 
    # else
    #     result = similar(q.coeff)
    #     result[1 : p_size] .= ( p.coeff .- @view( q.coeff[1 : p_size] ) )
    # end
    if ( p_size >= q_size )
        result = copy(p.coeff)
        for it in 1 : q_size
            result[it] = result[it] - q.coeff[it]
        end
    else
        result = copy(q.coeff)
        for it in 1 : p_size
            result[it] = p.coeff[it] - result[it] 
        end
    end

    # ------В отдельную фукцию----- #
    # При вычитания некоторые старшие коэфициенты могли обратиться в 0 
    index, count_zeros = lastindex(result), 0
    @inbounds while ( index > 0 && result[index] == 0 )
        count_zeros += 1
        index -= 1
    end

    # count_zeros = число нулей в конце массива coeff,
    # соответсвующих старшим степеням  
    resize!(result, length(result) - count_zeros)
    # ------В отдельную фукцию----- #
    
    return Polynomial{Type}(result)
end


function Base. *(p::Polynomial{Type}, q::Polynomial{Type})::Polynomial{Type} where Type
    
    result = zeros(Type, deg(p) + deg(q) + 1 )
    # println(length(result))
    # println(result)
    
    # for i in eachindex(p.coeff), j in eachindex(q.coeff)
    #     result[i+j - 1] = result[i+j - 1] + ( p.coeff[i] * q.coeff[j] )
    # end
    for i in 1 : length(p.coeff)
        for j in 1 : length(q.coeff)
            result[i+j - 1] = result[i+j - 1] + ( p.coeff[i] * q.coeff[j] )
        end
    end

    # ------В отдельную фукцию----- #
    # При умножении некоторые старшие коэфициенты могли обратиться в 0 
    index, count_zeros = lastindex(result), 0
    @inbounds while ( index > 0 && result[index] == 0 )
        count_zeros += 1
        index -= 1
    end

    # count_zeros = число нулей в конце массива coeff,
    # соответсвующих старшим степеням  
    resize!(result, length(result) - count_zeros)
    # ------В отдельную фукцию----- #

    return Polynomial{Type}(result)
end



# Base. +(p::Polynomial{Type}, num::Type) where Type = +(p, Polynomial{Type}([num]))
Base. +(p::Polynomial{Type}, num::Type) where Type = p.coeff[begin] += num
# Base. +(num::Type, p::Polynomial{Type}) where Type = +(Polynomial{Type}([num]), p)
Base. +(num::Type, p::Polynomial{Type}) where Type = p.coeff[begin] += num
# Base. -(p::Polynomial{Type}, num::Type) where Type = -(p, Polynomial{Type}([num]))
Base. -(p::Polynomial{Type}, num::Type) where Type = p.coeff[begin] -= num
# Base. -(num::Type, p::Polynomial{Type}) where Type = -(Polynomial{Type}([num]), p)
Base. -(num::Type, p::Polynomial{Type}) where Type = p.coeff[begin] -= num


Base. *(p::Polynomial{Type},) where Type = *(p, Polynomial{Type}([num]))
# function Base. *(p::Polynomial{Type}, num) where Type
#     result = copy(p.coeff)
#     for element in result
#         element = element * num
#     end


#     return Polynomial{Type}(result)
# end
Base. *(num, p::Polynomial{Type}) where Type = *(Polynomial{Type}([num]), p)
# function Base. *(num, p::Polynomial{Type}) where Type
#     result = copy(p.coeff)
#     for element in result
#         element = element * num
#     end

    
#     return Polynomial{Type}(result)
# end


# Вычисление значения многочлена в точке 
(p::Polynomial)(x) = polyval(reverse(p.coeff), x)



function Base.display(p::Polynomial)
    
    if isempty(p.coeff)
        return ""
    end
    
    str = "$(p.coeff[1])" # $(...) - означает "интерполяцию стоки", т.е. вставку в строку некоторого вычисляемого значения 
    
    for i in 2 : length(p.coeff) 
        
        if i > 2
            s = " + $(p.coeff[i])x^$(i-1)"
        else
            s = " + $(p.coeff[i])x"
        end
        
        str *= s
    end
    
    println(str)
end

function Base. copy(p::Polynomial{Type}, q::Polynomial{Type}) where Type 
    resize!(p.coeff, length(q.coeff))
    for it in 1 : length(q.coeff)
        p.coeff[it] = q.coeff[it]
    end

end

# -----------------------------
Base. div(p::Polynomial{Type}, q::Polynomial{Type})::Polynomial{Type} where Type = divrem(p,q)[1]
Base. rem(p::Polynomial{Type}, q::Polynomial{Type})::Polynomial{Type} where Type = divrem(p,q)[2]

function _divrem(p::Polynomial{Type}, q::Polynomial{Type}) where Type

    # copy(pc, p)
    pc = Polynomial{Type}(p.coeff)
    # copy(qc, q)
    qc = Polynomial{Type}(q.coeff)
    result::Vector{Type} = zeros(Type, deg(pc) - deg(qc) + 1 )

    while ( deg(pc) >= deg(qc) )

        k = pc.coeff[deg(pc) + 1] / qc.coeff[deg(qc) + 1]
        result[deg(pc) - deg(qc) + 1] = k
        
        pc = pc - (k*qc)
    end
    pol_result = Polynomial{Int64}(result)

    # Утверждение: p = pol_result * q + pc
    return (pol_result, pc)
end
