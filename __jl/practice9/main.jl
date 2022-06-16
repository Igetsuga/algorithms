using LinearAlgebra

"""
Приведение матрицы(хорошо обусловленной, невырожденной) к ступенчатому виду
"""
function LU_decomposition(matrix::AbstractMatrix; U_decomposition = true)
    
    @assert size(matrix,1) == size(matrix,2) "Matrix is not square" 
    
    # L_matrix, U_matrix = randn(matrix)
    L_matrix, U_matrix = lu(matrix)
    

    U_decomposition && return U_matrix
    U_decomposition || return L_matrix 
end


"""
Приведение матрицы хорошо обусловленной и невырожденной к ступенчатому виду
"""
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
    else 
        LU_decomposition(matrix; false)
    end
end

matrix = randn(5,5) 
println(matrix)

GaussianElimination!(matrix; U_decomposition = true)
println(matrix)

"""
Обратынй ход Гаусса
"""
function ReverseGaussianElimination!(A::AbstractMatrix, b::AbstractVector)
    result = similar(b)
    
    rows = size(A, 1)
    for row in 0 : rows - 1
        result[rows - row] =
         ( b[rows-row] - sum( @view( A[rows-row, rows-row + 1 : rows] ) .* @view( result[rows-row + 1 : N] ) ) ) / A[rows-row, rows-row]
    end


    return result
end 


"""
Метод Гаусса для транспонированной расширенной матрицы
"""
function ReverseGaussianElimination!(Ab::AbstractMatrix)
    
    cols = size(A, 2) # = rows(Ab^T)
    
    result = Vector{typeof(Ab)}(undef, cols)
   
    for col in 0 : cols-1
        result[cols-col] =
         (Ab[cols-col, cols] - dot( @view(Ab[cols-col+1 : cols, cols-col]), @view( result[cols-col+1 : cols] ) )) / Ab[cols-col, cols-col]
        # dot() - скалярное произведение 
    end
    
    
    return result
end  
        

"""
Произвольная треугольная матрица
"""
function GetTriangle(size::Integer; up = true)
    matrix = randn(size)
    upper,lower = lu(matrix)
    
    
    up && return upper
    up || return lower
end



# -----------------------------------------------
# -----------------------------------------------
# Написано не мной
# -----------------------------------------------
# -----------------------------------------------

function reverse_gauss_1(A::AbstractMatrix{T}, b::AbstractVector{T}) where T
    x = similar(b)
    N = size(A, 1)
    for k in 0:N-1
        x[N-k] = (b[N-k] - sum(A[N-k,N-k+1:end] .* x[N-k+1:end])) / A[N-k,N-k]
    end
    return x
end 

function reverse_gauss_2(A::AbstractMatrix{T}, b::AbstractVector{T}) where T
    x = similar(b)
    N = size(A, 1)
    for k in 0:N-1
        x[N-k] = (b[N-k] - sum(@view(A[N-k,N-k+1:end]) .* @view(x[N-k+1:end]))) / A[N-k,N-k]
    end
    return x
end

function reverse_gauss_3(A::AbstractMatrix{T}, b::AbstractVector{T}) where T
    x = similar(b)
    N = size(A, 1)
    for k in 0:N-1
        x[N-k] = (b[N-k] - dot(@view(A[N-k,N-k+1:end]), @view(x[N-k+1:end]))) / A[N-k,N-k]
    end
    return x
end

function reverse_gauss_4(A,b)
    #A - транспонированная матрица 
    N = size(A, 2)
    x = Vector{eltype(Ab)}(undef,N)
        
    for k in 0:N-1
        x[N-k] = (b[N-k] - dot(@view(A[N-k+1:N, N-k]), @view(x[N-k+1:N]))) / A[N-k,N-k]
    end
    return x
end

function reverse_gauss_5(Ab)
    #Ab - транспонированная расширенная матрица 
    N = size(A, 2)
    x = Vector{eltype(Ab)}(undef,N)
           
    for k in 0:N-1
        x[N-k] = (Ab[N-k, N] - dot(@view(Ab[N-k+1:N, N-k]), @view(x[N-k+1:N])))/Ab[N-k,N-k]
    end
    return x
end 

# Тестирование -------------------------------------------------
N = 1000
A = GetTriangle(N)
b = ones(N)
At = A'
Abt = [A b]'

println("1.1:")
@time reverse_gauss_1(A,b);
println("1.2:")
@time reverse_gauss_1(A,b);

println("2.1:")
@time reverse_gauss_2(A,b);
println("2.2:")
@time reverse_gauss_2(A,b);

println("3.1:")
@time reverse_gauss_3(A,b);
println("3.2:")
@time reverse_gauss_3(A,b);

println("4.1:")
@time reverse_gauss_3(At,b); 
println("4.2:")
@time reverse_gauss_3(At,b); #лучшая

println("5.1:")
@time reverse_gauss_5(Abt);
println("5.2:")
@time reverse_gauss_5(Abt);