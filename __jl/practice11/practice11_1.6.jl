using ("__geometry.jl")
using ("practice11_1.2.jl")

# проверка, лежит ли точка внутри многоугольника
###############################################################################
# пусть вектор figure содержит все угловые точки фигуры, в 
# порядке обхода против часовой стрелки
function isInside(node::g_vector{Type}, polygon::Polygon{Type}) where Type
    # Описание алгоритма:
    # http://e-maxx.ru/bookz/files/andreeva.pdf
    
    flag = double_ended!(polygon)
    sum_angles = 0.0

    for it in firstindex(polygon.vertices) : lastindex(polygon.vertices) - 1
        sum_angles += angle(polygon.vertices[it+1] - node, polygon.vertices[it] - node)
    end

    if flag == true
        single_ended!(polygon)
    end

    if sum_angles < pi # угол равен 0
        
        
        return true 
    else # угол равен 2pi
        
        
        return false 
    end

end

"""
isinner(node::Vector2D{T}, polygon::ConvexPolygon{T})

Проверка принадлежности точки внутренности ВЫПУКЛОГО многоугольника.
"""
function isInside(node::g_vector{Type}, polygon::Polygon{Type})::Bool where Type
    flag = double_ended!(polygon)
    
    sign_prev = sign(polygon.vertices[begin+1] - node,
     polygon.vertices[begin] - node)
    
     for it in firstindex(polygon.vertices) + 1 : lastindex(polygon.vertices) - 1
        sign_cur += sign(polygon[it+1] - node, polygon[it] - node)
        
        if ( sign_prev * sign_cur < 0 )
            
            
            return false
        end 
    end

    flag && single_ended!(polygon)


    return true
end
