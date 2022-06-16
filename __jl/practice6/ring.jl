struct Ring{Type, MOD}
    _value::Type

    # default constructor
    Ring{Type, MOD}(value) where {Type, MOD} = new(value % MOD) 
end

Base. +(a::Ring{Type, MOD}, b::Ring{Type, MOD}) where{Type, MOD} = ( (a._value + b._value) % MOD )
Base. *(a::Ring{Type, MOD}, b::Ring{Type, MOD}) where{Type, MOD} = ( (a._value * b._value) % MOD )


function Base. inv(a::Ring{Type, MOD})::Union{Nothing, Ring{Type, MOD}} where{Type, MOD}
    # для того, чтобы найти обратный по модулю элемент воспользуемся расширенным
    # алгоритмом Евклида
# --------------------------------------------------
    m,n = a._value, MOD

    xa, ya = 1, 0
    xb, yb = 0, 1

    while ( n != 0 )
        k = (m ÷ n)

        m, n = n, (m % n)

        x,y = xa, ya
        xa, ya = xb, yb
        xb, yb = x - xb*k, y - yb*k

    end

    (m != 1) && return nothing

    if (xa < 0)
        xa += MOD
    end


    return Ring{Type, MOD}(xa)
end


Base. /(a::Ring{Type, MOD}, b::Ring{Type, MOD}) where{Type, MOD} = a * inv(b)

# Унарный минус
Base. -(a::Ring{Type, MOD}) where{Type, MOD} = Ring{Type, MOD}(MOD - a._value)

# Реализация вычитание через унарный минус
Base. -(a::Ring{Type, MOD}, b::Ring{Type, MOD}) where{Type, MOD} = a + (-b)
