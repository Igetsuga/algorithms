"""
Вычисление экспоненты как сумму ряда Тейлора: O(n)
"""
# Соответсвующий ряд Тейлора
# exp = 1/1! + 1/2! + ... + sum_{i=1}^{n}{x^i \ i!}
function _exp(power = 1, acc = 20)

    exp::Float64 = 0.0
    numerator::Float64 = 1.0
    denominator::Float64 = 1.0

    for step in 1 : acc + 1
        exp += numerator * denominator
        
        numerator *= power
        denominator /= step
    end


    return exp
end


"""
Вычисление синуса через сходящийся степенной ряд
"""
# Функцию синуса в окрестности некоторой точки 
# можно представить в виде знакопеременного ряда
# Тейлора sin(x) = x/1! - x^3/3! + x^5/5! - ... + (-1)^(k-1) * x^(2k-1) / (2k-1)!

# Реккурентная функция для k+1 члена суммы:

# v_{k+1} = -v_{k} * x^2 / 2k*(2k+1)

function _sin(x; ϵ = 1e-8)
    
    xx = x * x
    result = eltype(x)(0)
    summand_current = x
    
    k = 2
    
    # while ( result + summand_current != resutl )
    while ( abs(summand_current) > ϵ )
        result += summand_current
        
        summand_current = -(summand_current) * xx / ( k *(k+1) )
        
        k += 2
    end

    #УТВ: |sin(x) - result| <= ϵ
    return result
end


"""
Вычисление косинуса через сходящийся степенной ряд
"""
# Функцию косинуса в окрестности некоторой точки 
# можно представить в виде знакопеременного ряда
# Тейлора sin(x) = 1 - x^2/2! + x^4/4! - ... + (-1)^(k) * x^(2k) / (2k)!

# Реккурентная функция для k+1 члена суммы:

# v_{k+1} = -v_{k} * x^2 / (2k+1)*(2k+2)

function _cos(x; ϵ = 1e-8)
    
    xx = x * x
    result = eltype(x)(0)
    summand_current = 1
    
    k = 0

    # while ( result + summand_current != resutl )
    while ( abs(summand_current) > ϵ )
        result += summand_current
        
        summand_current = -(summand_current) * xx / ( (k+1) * (k+2) )
        
        k += 2
    end

    #УТВ: |cos(x) - result| <= ϵ
    return result
end


"""
Вычисление гармонического ряда
"""
# result = lim_{n → ∞}{1 + 1/2 + 1/3 + ... + 1/n} = ∞
function _harmonic(ϵ = 1e-8)
    result::Float64 = 0.0
    k::Integer = 1
    summand_current::Float64 = 1.0

    # while ( result + summand_current != resutl )
    while ( abs(summand_current) > ϵ )
        summand_current = 1 / k
        result += summand_current 
        k += 1
    end
    
    
    return result
end


# Построение графиков
using Plots
xAxe = 0 : 0.1 : 10

plot = plot()

func = x -> cos(x) 
for n in 1 : 7
    plot!(plot, x, func(x)) 
end

display(plot) 


"""
Реккурентыне соотношения
"""
# 1.
# ln(x) = sum_{k = 1}^{∞}{(-1)^k * (x-1)^{k+1} / (k + 1)}
# v_{k+1} = -(v_k) * (x-1)  * ( (k+1)/(k+2) )

# 2.
# 1 / sqrt(1+x) = 1 + sum_{k=1}^{∞}{(-1)^k * (1*3*5*...*(2k-1)) / (2*4*6*...*2k) * x^k}
# v_{k+1} = -(v_k) * x * 2k/(2k+2)

# 3.
# x*sin(x) - exp(-x^2) + 1 = ... 
# v_{k+1} = -(v_k) * x^2 * (a + b) / ( a(k+1) + b(2k)(2k+1) )
# a = (2k+1)!
# b = (k+1)!

"""
Функция Бесселя
"""
function _bessel(x; order = 1) 
    
    order_fact = factorial(m)
    
    summand_current = 1 / (order_fact)
    k = 1
    result = 0
    
    while ( result + summand_current != result )
        
        result += summand_current
        # реккурентное соотношение
        summand_current = -summand_current * ( (x*x / 4) ) / ( (k+1) * (k+m+1) )
        
        k += 1
    end
    
    
    return ( (x / 2)^m ) * result
end

function plot_bessel(order_max)
    
    plot = Plot()

    for it in 0.0 : 0.01 : 1, order in 1 : order_max 
        plot!(plot, it, _bessel(it; order)) 
    end

    
    return plot
end

#plot(x,besselj_.(2,x))