using ("__geometry.jl")


# проверка, является ли заданный плоский многоугольник выпуклым
###############################################################################
# пусть вектор figure содержит все угловые точки фигуры, в 
# порядке обхода против часовой стрелки
function is_convex(figure::Vector{g_vector{Type}}) where Type 
    # будем считать углы многоугольника. у выпуклого многоугольника
    # все углы мешьше 180 градусов, в то время как, у невыпуклого 
    # хотя бы один из углов больше 180 градусов; если угол больше
    # 180 градусов, его синус отрицательный 
    for itt in 1:lastindex(figure) - 2
        
        node_i = figure[itt]         # (x_i,y_i)
        node_j = figure[itt + 1]     # (x_j,y_j)
        node_k = figure[itt + 2]     # (x_k,y_k)

        segment_ij .= node_j .- node_i
        segment_jk .= node_k .- node_j

        if ( Base.sin(segment_ij, segment_jk) < 0 ) 
            return false
        end

    end


    return true
end