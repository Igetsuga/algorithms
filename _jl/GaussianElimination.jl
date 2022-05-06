using LinearAlgebra

# function reverse_gauss(Ab)
#     N = size(A,2)
#     x = vector(eltype(Ab)){undef, N}

#     for k in 0 : N - 1
#         x[N - k] = (Ab[N - k, N]) - dot(@view(Ab[N - k + 1 : N, N - k]), @view(x[N - k + 1: N])) / Ab[N - k, N -k]
#     end
#     return x
# end



# Приведение матрицы(хорошо обусловленной, невырожденной) к ступенчатому виду
function LU_decomposition(matrix::AbstractMatrix; U_decomposition = true)
    
    @assert size(matrix,1) == size(matrix,2) "Matrix is not square" 
    
    # L_matrix, U_matrix = randn(matrix)
    L_matrix, U_matrix = lu(matrix)
    
    if (U_decomposition) return U_matrix end
    
    return L_matrix 
    
end


# Приведение матрицы(хорошо обусловленной, невырожденной) к ступенчатому виду
function GaussianElimination!(matrix::AbstractMatrix; U_decomposition = true)
    
    if (U_decomposition) # если нужна верхнетреугольная матрица

        rows = size(matrix,1)

        for row in 1 : rows - 1

            # псевдокод:
            # 1. Найти строку с масимальным абслютным значением элемента на позиции (i,i) - пусть эта строка имеет номер j
            # 2. Поменять строки i , j местами
            # 3. Применить ход Гаусса 
        
            # Ход Гаусса: пусть он запущен на строке с номером j 
            #    - пройтись по каждой строке с номером k (j < k <= N) и занулить элемент на позиции (k,j) в каждой строке
            
            # Занулить элемент на позиции (k,j) в каждой строке: 
            #    - домножить сроку j на коэффициент t
            #    - сложить строку j со строкой k
        
            # for row_ in row : rows - 1 
            #     index_current = findmax(abs, @view( matrix[row_ : end, row_] ) )
            #     index_max[2] = (index_max[1] > index_current[1]) ? index_max : index_current 
            # end

            # Поиск максимального элемента по модулю в столбце 
            index_current = findmax(abs, @view( matrix[row : end, row] ) )
        
            # После того, как масимальный элемент в столбце найден: index_current = [value_max, row_number]
            # Необходимо поменять местами текущую строку и строку с максимальным элементом на позиции (i,i)
            matrix[row, 1:end], matrix[index_current[2], 1:end]  = matrix[index_current[2], 1:end], matrix[row, 1:end]
        
            # После того, как строка с нужным элементом оказалась на своём месте, применяем метод Гаусса
            
            row_copy = copy( @view matrix[row, 1:end] )

            for row_ in row + 1 : rows 
                
                t = ( matrix[row_, row_] / row_copy[row] )


                # matrix[row_, 1:end] .= @view(matrix[row_, 1 : end]) - t .* @view(matrix[row, row])
                @. @views matrix[row_, 1:end] = ( matrix[row_, 1:end]) - t .* ( row_copy )
                # @. matrix[] = @view(matrix[]) - t .* @view(matrix[])
                
            end
        end    
    end
end

matrix = randn(5,5)
println(matrix)

GaussianElimination(matrix; U_decomposition = true)
println(matrix)

# LU_decomposition(matrix; U_decomposition = true)



# function transform_to_steps!(A::AbstractMatrix; epsilon = 1e-8, exception_throw = true)
#     @inbounds for k in 1 : size(A : 1)
#         absval, Δk = findmax(abs, @view(A[k : end, k]))
#         Δk -= 1
#         exception_throw && absval <= epsilon && throw("Matrix is Invertible")
#         if (Δk != 0)
            
#         end
#     end
# end
        
        
        