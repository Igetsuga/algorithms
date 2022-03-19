
function gcd(x::Integer, y::Integer)

    while (x > 0 && y > 0)

        if (x > y)
            x = x % y
        else 
            y = y % x
        end

    end

    return (x + y)
end

print( gcd(54236, 3251134) )