function binarySearch(A::Vector, x::Number) # A is sorted
    currentIndexValue = length(A) ÷ 2
    flag = true
    while flag
        if A[currentIndexValue] == x
            flag = false
            return currentIndexValue
        elseif A[currentIndexValue] > x
            tempVector = copy(A[firstindex(A):currentIndexValue])
            return binarySearch(tempVector, x)
        else
            tempVector = copy(A[currentIndexValue:lastindex(A)])
            return binarySearch(tempVector, x)
        end
    end
end



