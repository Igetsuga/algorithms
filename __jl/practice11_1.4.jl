using ("__geometry.jl")


# проверка, лежат ли две заданные точки плоскости по одну 
# сторону от заданной прямой
###############################################################################

# Решение 1. если две точки лежат плоскости лежат по одну сторону от прямой, то прямая 
# соединяющая эти две точки, не пересекается с заданной прямой.
# Решение 2. Прямая делит плоскость на две полуплоскости, в каждой из которых для 
# любой точки (x,y) выполнено: F(x,y) > 0 либо F(x,y) < 0. Если концы отрезка, соединяещего
# заданные точки лежат по одну сторону от прямой, произведение F(x_a,y_a) * F(x_b,y_b) 
# будет положительным, иначе отрицательным
function is_similar_side_line(F::Function, A::g_vector{Type}, B::g_vector{Type}) where Type
    return ( F(A) * F(B) > 0 ) 
 end