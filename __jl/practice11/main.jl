import ("__geometry.jl")
import  ("practice11_1.1.jl")
import ("practice11_1.2.jl")
import  ("practice11_1.3.jl")
import  ("practice11_1.4.jl")
import  ("practice11_1.5.jl")
import  ("practice11_1.6.jl")
# ----------------------------------------
# ----------------------------------------

# Идея: 
#     1. выбираем точку k, выбираем к ней некоторое базовое 
#        направление l_{k}, например это направление l_{k-1 → k}.
#        Если k = 1, то можно выбрать горизантальное направление влево
#        или вправо
#     2. точка k+1 будет выбрана следующим образом. направление
#        l_{k → k+1} образует наименьший угол с направлением l_{k} 
"""
Алгоритм Джарвиса построения выпуклой оболочки заданных точек плоскости
- points - набор точек
"""
function Jarvis(set::Vector{g_vector{Type}})::ConvexPolygon{Type} where Type<:Real
    @assert length(points) > 1 # иначе операция в строке 9 будет не возможна
    
    yyy = (set[i][2] for i in 1:length(set))
    i_start = findmin(yyy) # индекс самой нижней точки
    convex_shell = [i_start]
    ort_base = g_vector{Int}((1,0)) # - этот вектор задает начальное базовое направление (горизонтално вправо)
    
    while next!(convex_shell, points, ort_base) != i_start
        ort_base = convex_shell[end] - convex_shell[end-1]  # - не нулевой вектор, задающий очередное базовое направление
    end
    

    return convex_shell # В конце и в начале массива convex_shell дважды содержится значение i_start 
end




# Идея: НЕ ПОНИМАЮ
#     1. выбираем начальную точку - самая низкая точка их набора ~ алг. Джарвиса
#     2. выбираем базовое направление для первой точке
#     3. сортируем все точки в порядке возрастания угла между направлением
#        в след. точку и текущим базовым направление. Первые две точки 
#        обязательно войдут в оболочку, потому что ...
#     4. все отсортированные точки помещаются в стек 
#     5. при переходе к следующей точке
"""
Ищет следующую точку по удаленности
- convex_shell - нумерация точек (оболочка)
- points - набор точек
- ort_base - вектор, от которого мы "отталкиваемся"
"""
function next!(convex_shell::Vector{Int64}, points::Vector{g_vector{Type}}, ort_base::g_vector{Type}) where Type<:Real
    cos_max = typemin(Type)
    i_base = convex_shell[end]
    resize!(convex_shell, length(convex_shell)+1)
    
    for i in eachindex(points)
        if ( points[i] == points[i_base] )
            continue
        end
    
        ort_i = points[i] - points[i_base] # - не нулевой вектор, задающий направление на очередную точку
        cos_i = cos_angle(ort_base, ort_i)
    
        if ( cos_i > cos_max )
            cos_max = cos_i
            convex_shell[end] = i 
        elseif ( cos_i == cos_max && quad_len(ort_i) > quad_len(ort_base) ) # на луче, содержащем сторону выпуклого многоугольника, может оказаться более двух точек заданного множества (надо выбрать самую дальнюю из них) 
            convex_shell[end] = i
        end
    end
    
    return convex_shell[end]
end


#-------------------------------------
"""Квадрат модуля вектора (скалярное произведение на самого себя)"""
quad_len(vec) = dot(vec, vec)
#-------------------------------------

"""
Алгоритм Грехома построения выпуклой оболочки заданных точек плоскости
- points - набор точек плоскости
"""
function Grekhom!(points::Vector{g_vector{Type}})::ConvexPolygon{Type} where Type<:Real
        
    ydata = (points[i][2] for i in 1:length(points))
    
    i_start = findmin(ydata) # индекс самой нижней точки
    
    points[begin], points[i_start] = points[i_start], points[begin]

    sort!( @view(points[begin+1 : end]), by = (point -> _angle( point, g_vector{Type}((1,0)) ) ) )
    push!(points, points[begin]) # теперь points[end] == points[begin] 
    convex_polygon = [firstindex(points), firstindex(points)+1, firstindex(points)+2] # - в стек помещены первые 3 точки
    
    for i in firstindex(points)+3 : lastindex(points)
        while ( _sign(points[i] - points[convex_polygon[end]], points[convex_polygon[end-1]] - points[convex_polygon[end]]) < 0 )
            pop!(convex_polygon)
        end
        push!(convex_polygon, i)
    end

    return ConvexPolygon{Type}(points[convex_polygon])  # convex_polygon[begin] == convex_polygon[end]
end
    

#-------------------------------------




"""
Считает значение ориентированной площади заданного плоского многоугольника, воспользовавшись методом трапеций
- polygon - многоугольник
"""
function square_tr(polygon::AbstractPolygon)
    S = 0
    for k in firstindex(polygon.vertices):(lastindex(polygon.vertices)-1)
        S += (polygon.vertices[k][2] + polygon.vertices[k+1][2])*(polygon.vertices[k+1][1] - polygon.vertices[k][1]) / 2
    end

    return S
end

"""
Считает значение ориентированной площади заданного плоского многоугольника, воспользовавшись методом треугольников
- polygon - многоугольник
"""
function square_tr(polygon::AbstractPolygon)
    square = 0
    p0 = polygon.vertices[1]
    for k in (firstindex(polygon.vertices)+1):(lastindex(polygon.vertices)-1)
        square += xdot(polygon.vertices[k] - p0, polygon.vertices[k+1] - p0) / 2
    end


    return square
end


# """
# Достраивает данный выпуклый многоугольник, добавляя в его оболочку данную точку и убирая лишние
# - polygon - выпуклый многоугольник
# - A - точка, которую нужно пристроить
# """
# function increase!(polygon::ConvexPolygon{Type}, A::g_vector{Type}) where Type<:Real
#     imi = -1
#     ima = -1
#     mi = 10000
#     ma = -10000

#     for i in firstindex(polygon.vertices):lastindex(polygon.vertices)
#         ang = _angle(polygon.vertices[i] - A, g_vector{Type}((0,1)))
#         if ang < mi
#             mi = ang
#             imi = i
#         end
#         if ang > ma
#             ma = ang
#             ima = i
#         end 
#     end

#     if imi > ima
#         imi, ima = ima, imi
#     end
#     for i in (imi+1):(ima-1)
#         deleteat!(polygon.vertices, i)
#     end
#     insert!(polygon.vertices, i2, A)

#     return polygon
# end


# """
# Алгоритм построения МВО с помощью добавления точек по одной
# - Points - набор точек, на которых будет строится МВО
# """
# function third_algo(points::Vector{g_vector{Type}})::ConvexPolygon{Type} where Type<:Real
#     ps = points[1:2]
    
#     k = 3
#     while _angle(ps[2]-ps[1], points[k]-ps[1]) == 0
#         k += 1
#     end
#     push!(ps, points[k])
#     polygon = ConvexPolygon{Type}(ps)

#     for i in @view(points[k+1:end])
#         if !isinner(i, polygon)
#             increase!(ps, i)
#         end
#     end

#     return polygon
# end


# """
# Достраивает данный выпуклый многоугольник, добавляя в его оболочку данную точку и убирая лишние
# - polygon - выпуклый многоугольник
# - A - точка, которую нужно пристроить
# - S - изначальная площадь многоугольника
# """
# function increase_wth_S!(polygon::ConvexPolygon{Type}, A::g_vector{Type}, S::Real) where Type<:Real
#     imi = -1
#     ima = -1
#     mi = 10000
#     ma = -10000

#     for i in firstindex(polygon.vertices):lastindex(polygon.vertices)
#         ang = _angle(polygon.vertices[i] - A, g_vector{Type}((0,1)))
#         if ang < mi
#             mi = ang
#             imi = i
#         end
#         if ang > ma
#             ma = ang
#             ima = i
#         end 
#     end

#     if imi > ima
#         imi, ima = ima, imi
#     end

#     if ima - imi > 1
#         S -= abs(oriented_S_2(Polygon(@view(polygon.vertices[imi:ima]))))
        
#         for i in (imi+1):(ima-1)
#             deleteat!(polygon.vertices, i)
#         end
#     end

#     S += xdot(polygon.vertices[imi]-A, polygon.vertices[ima]-A)
#     insert!(polygon.vertices, i2, A)

#     return polygon, S
# end

# #-------------------
