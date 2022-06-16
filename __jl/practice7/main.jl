# Решение нелинейного уравнения методом Ньютона

# Метод Ньютона заключается в следующем.
#     1. Пусть дано уравнение f(x) = 0, и  xs - его решение,
#        которое мы хотим получить.
#     2. Пусть у нам есть некоторое значение xc, которое с
#        какой-то точность приближено к xs, т.е. f(xc) ~ 0
#     3. Пусть функция f(x) дважды дифференцируема в некоторой 
#        окрестности xs.
# Тогда определим h := xs - xc. Из дифференциального исчисления
# нам известно, что f(xc+h) - f(xc) = f'(xc)*h + o(h), но тогда,
# забыв про o(h), получим: f(xc+h)[= f(xs) = 0] = f(xc) + f'(xc)*h = 0
# Откуда получим xs = xc - f(xc)/f'(xc)

"""
Решение нелинейного уравнения методом Ньютона
"""
function _newton(func_t::Function, xc; epsilon = 1e-8, max_iter_num = 20)
    
    iter_num = 0
    
    fx_current = func_t(xc)

    while ( iter_num < max_iter_num && abs(fx_current) > epsilon )
        
        xc += fx_current
        fx_current = func_t(xc)
        
        iter_num += 1
    end


    abs(fx_current) <= epsilon && return xc
    
    
    return NaN
end

"""
Решение нелинейного уравнения методом Ньютона без передачи производной функции
"""
function _newtonD(func::Function, xc; epsilon = 1e-8, max_iter_num = 20)
    h = 1e-8
    
    iter_num = 0
    fx_current = func(xc) 

    while ( iter_num < max_iter_num && abs(fx_current) > epsilon )
        
        xc += fx_current
        
        # --- Вычисление производной функции в точке
        # f'(xc) = ( f(xc+h) - f(xc) ) / h, h = 1e-8
        # ---
        func_deriv = ( func(xc + h) - func(xc) ) / (h)
        
        fx_current = func(xc) / func_deriv
        
        iter_num += 1
    end


    abs(fx_current) <= epsilon && return xc
    
    
    return NaN
end

