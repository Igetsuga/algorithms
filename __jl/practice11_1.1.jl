using ("__geometry.jl")

# поиск точки пересечения заданных отрезков
###############################################################################

# проверка, лежит ли точка внутри заданного отрезка
function islie(point::g_vector{Type}, segment::segment{Type}) where Type end

# поиск точки пересечения двух отрезков
function intersection(s1::segment{Type}, s2::segment{Type}) where Type
    
    # если точка пересечения существует, то столбец её координат является 
    # решением уравнения A*X = b
    A = [ s1.end_.y - s1.begin_.y  s1.begin_.x - s1.end_.x
          s2.end_.y - s2.begin_.y  s2.begin_.x - s2.end_.x ]

    b = [ s1.begin_.y * (s1.begin_.x - s1.end_.x) + s1.begin_.x * (s1.end_.y - s1.begin_.y) 
          s2.begin_.y * (s2.begin_.x - s2.end_.x) + s2.begin_.x * (s2.end_.y - s2.begin_.y) ]

    x,y = A\b

    # проверка, найденная точка лежит внутри заданных отрезков, это необходимо, т.к. мы
    # искали точку пересечения прямых, содержащих заданные отрезки
    if ( islie((;x, y), s1) == false  || islie((;x,y), s2) == false )
        return nothing
    end

    return (;x, y)

end

function islie(point::g_vector{Type}, segment::segment{Type}) where Type
    
    return ( (segment.begin_.x <= point.x <= segment.end_.x || segment.begin_.x >= point.x >= segment.end_.x) &&
    (segment.begin_.y <= point.y <= segment.end_.y || segment.begin_.y >= point.y >= segment.end_.y) )

end
