function eyler(limit::Int)
    result = 0
    factorial = 1
    current_l = 1
    while (result + factorial != result)
        current_l += 1 
        result += factorial

        factorial /= current_l
    end
end

# дз: 