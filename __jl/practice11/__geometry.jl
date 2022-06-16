using LinearAlgebra

# ----------------------------------------
# Введение типов -------------------------
# ----------------------------------------
# Код Алексеева П.
"""Абстрактный тип многоугольника"""
abstract type AbstractPolygon{Type<:Real} end

"""
- обычный (неопределенный) многоугольник
"""
struct Polygon{Type} <: AbstractPolygon{Type} 
    # вектор точек, задающих многоугольник
    vertices::Vector{g_vector{Type}}
end

"""
- выпуклый многоугольник
"""
struct ConvexPolygon{Type} <: AbstractPolygon{Type}
    # вектор точек, задающих многоугольник
    vertices::Vector{g_vector{Type}}
end


"""
Дублирует в конце вектора его первый элемент, если изначально этого дублирования не было.
"""
function double_ended!(polygon::AbstractPolygon)::Bool
    if ( polygon[begin] != polygon[end] )
        push!(polygon, polygon[begin])
        
        
        return true
    end
    
    
    return false
end

"""
Удаляет из конца вектора элемент, дублирующий первый, если такой лемент был.
"""
function single_ended!(polygon::AbstractPolygon)::Bool
    if polygon[begin] == polygon[end]
        pop!(polygon)
        
        
        return true
    end
    
    
    return false
end
# ----------------------------------------
# ----------------------------------------
# ----------------------------------------




#######################################################################################################
# Именованный картеж, представляющий собой структуру точки на плоскости.
# Поскольку точку на плоскости можно трактовать как радиус-вектор, а при 
# вычислениях разницы между точкой и её радиус-вектором нет, то будем 
# представлять точки именно как соответствующие им радиус-вектора.
g_vector{Type <: Real} = NamedTuple{ (:x,:y) Tuple{Type, Type} }

# Введем опрации, которые будем использовать 
Base. +( A::g_vector{Type}, B::g_vector{Type} ) where Type = g_vector{Type}(Tuple(A) .+ Tuple(B))

Base. -( A::g_vector{Type}, B::g_vector{Type} ) where Type = g_vector{Type}(Tuple(A) .- Tuple(B))
    
Base. *( coeff::Type, A::g_vector{Type} ) where Type = g_vector{Type}(coeff .* Tuple(A))

# Норма вектора
LinearAlgebra.norm( A::g_vector{Type} ) where Type = norm(Tuple(A))

# Скалярное произведение
LinearAlgebra.dot( A::g_vector{Type}, B::g_vector{Type} ) where Type = dot(Tuple(A), Tuple(B))

# Косое произведение - xdot(a,b)=|a||b|sin(a,b)
xdot( A::g_vector{Type}, B::g_vector{Type} ) where Type = ( A.x * B.y - A.y * B.x )

# cos(ϕ), где ϕ - угол между двумя векторами
Base. cos( A::g_vector{Type}, B::g_vector{Type} ) where Type = ( dot(A,B) / (norm(A) * norm(B)) )

# sin(ϕ), где ϕ - угол между двумя векторами
Base. sin( A::g_vector{Type}, B::g_vector{Type} ) where Type = ( xdot(A,B) / (norm(A) * norm(B)) )

# Угол между прямыми по направ-им веторам
_angle( A::g_vector{Type}, B::g_vector{Type} ) where Type = atan(sin(A, B), cos(A, B))
   

# Знак синуса угла между веторами
Base. _sign( A::g_vector{Type}, B::g_vector{Type} ) where Type = sign(sin(A,B))


#######################################################################################################
#######################################################################################################
# Введем объект - отрезок. Этот объект будет задаваться своими концами - геометрическими точками
segment{Type <: Real} = NamedTuple{(:begin_, :end_), Tuple{g_vector{Type}, g_vector{Type}}}


# Введем объект - прямая. Этот объект будет задаваться точкой и своим направляющем вектором
line{Type <: Real} = NamedTuple{(:point_, :direction), Tuple{g_vector{Type}, g_vector{Type}}}





