mutable struct Polynomial
    coefficients::Vector{Int}
end
    
polynomial = Polynomial(senior_degree::Int = 1) 

    function deg(A::Polynomial)
        return length(A.coefficients)
    end 





function Base.divrem(A::Polynomial{T}, B::Polynomial{T}) where T
    
    A = copy(A)

    D = Vectro{T}(undef, deg(A) - deg(B) + 1)
    R = Vector{T}(undef, deg(B))
    
    while any( A .!= 0)
    for i in 1 : deg(A) - deg(B) - 1
        D[i] = -A[i] / B[i]
        A[i:end] .-= (D[i] .* B)
    end
    i = findfirst(D .!= 0)
    D = D[i:end]
    
    i = findfirst( A .! = 0)
    R = A[i:end]

    return R, D

end
