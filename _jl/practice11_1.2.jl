using ("__geometry.jl")

# вычисление угла между прямыми
###############################################################################

# cos(ϕ), где ϕ - угол между двумя векторами
Base. cos( A::g_vector{Type}, B::g_vector{Type} ) where Type = ( dot(A,B) / (norm(A) * norm(B)) )

# sin(ϕ), где ϕ - угол между двумя векторами
Base. sin( A::g_vector{Type}, B::g_vector{Type} ) where Type = ( xdot(A,B) / (norm(A) * norm(B)) )


    
end