function binarySearch(A::Vector, x::Number) # A is sorted, the result is rand simalar with x index of that value if it exist in vector  
    leftIndex = firstindex(A)
    #print(leftIndex, "\n")
    rightIndex = lastindex(A)
    #print(rightIndex, "\n")
    while leftIndex < rightIndex
        if A[leftIndex] == x
            return leftIndex
        elseif A[rightIndex] == x
            return rightIndex
        end
        middleIndex = leftIndex + (rightIndex - leftIndex) ÷ 2
        #print(middleIndex, "\n")
        if A[middleIndex] == x
            #print(A[middleIndex])
            return middleIndex
        elseif A[middleIndex] < x
            leftIndex = middleIndex  # we add 1 because of we already know that A[middleIndex] != x
            #print((leftIndex,A[leftIndex]),(middleIndex,A[middleIndex]), (rightIndex, A[rightIndex]), "\n")
        else 
            rightIndex = middleIndex 
            #print((leftIndex,A[leftIndex]),(middleIndex,A[middleIndex]), (rightIndex, A[rightIndex]), "\n")
        end
    end
    return false
end

function binarySearch_first(A::Vector, x)
    leftIndex = firstindex(A) - 1
    rightIndex = lastindex(A) -1 
    while leftIndex < rightIndex
        if A[leftIndex] == x
            return leftIndex
        end
        middleIndex = leftIndex + ((rightIndex - leftIndex) ÷ 2)
        if A[middleIndex] == x
            if middleIndex == leftIndex + 1
                return middleIndex
            end
            rightIndex = middleIndex + 1
        end
        if A[middleIndex] < x
            leftIndex = middleIndex + 1  # we add 1 because of we already know that A[middleIndex] != x
            print((leftIndex,A[leftIndex]),(middleIndex,A[middleIndex]), (rightIndex, A[rightIndex]), "\n")
        else 
            rightIndex = middleIndex 
            print((leftIndex,A[leftIndex]),(middleIndex,A[middleIndex]), (rightIndex, A[rightIndex]), "\n")
        end
    end
    return false 
end

function binarySearch_last(A::Vector, x)
    leftIndex = firstindex(A)
    rightIndex = lastindex(A)
    while leftIndex < rightIndex
        if A[rightIndex] == x
            return rightIndex
        end
        middleIndex = leftIndex + (rightIndex - leftIndex) ÷ 2
        if A[middleIndex] == x
            if middleIndex == rightIndex - 1
                return middleIndex
            end
            leftIndex = middleIndex + 1
        end
        if A[middleIndex] < x
            leftIndex = middleIndex + 1  # we add 1 because of we already know that A[middleIndex] != x
            print((leftIndex,A[leftIndex]),(middleIndex,A[middleIndex]), (rightIndex, A[rightIndex]), "\n")
        else 
            rightIndex = middleIndex 
            print((leftIndex,A[leftIndex]),(middleIndex,A[middleIndex]), (rightIndex, A[rightIndex]), "\n")
        end
    end
    return false 
end

function searchsorted_my2(vector::Vector, x::Number)
    leftIndex = 0
    rightIndex = length(vector)
    
    if (rightIndex == 0 || x < vector[1])
        return 0
    else
        while (leftIndex < rightIndex)
            middleIndex = leftIndex + (rightIndex - leftIndex) ÷ 2
            if (vector[middleIndex] <= x)
                if (middleIndex == length(vector) || x < vector[middleIndex + 1])
                    return middleIndex
                end
                leftIndex = middleIndex
            else
                rightIndex = middleIndex
            end
        end
    end
end

function searchsorted_my1(A::Vector, x::Number)
    return (binarySearch_first(A,x), ":", binarySearch_last(A,x), " --> ", searchsorted(A,x), "\n")
end