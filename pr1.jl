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
end





