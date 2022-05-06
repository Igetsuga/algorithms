

function bin_pow(x::Integer, pow::Integer, mod::Integer)
    
    result = 1
    
    while ( pow > 0 ) 

        if (pow % 2 == 1)
            result = ( result * x ) % mod
        end

        x = ( x * x ) % mod

        pow = ( pow ÷ 2 )

    end

    return result
end

print( bin_pow(2, 130, 1000*1000*1000 + 7) )