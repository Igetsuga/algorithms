# сортировка пузырьком
V = [43,12,23,28,22,17,67,36,17,42,9]
function bubblesort!(unsorted_vector)
    for it in firstindex(unsorted_vector):lastindex(unsorted_vector) - 1
        flag = false
        for j in firstindex(unsorted_vector):lastindex(unsorted_vector) - it
            if (unsorted_vector[it] > unsorted_vector[it + 1])
                unsorted_vector[it], unsorted_vector[it+1] = unsorted_vector[it+1], unsorted_vector[it]
                flag = true
            end 
        end 
        if flag == false
            break
        end
    end
    return unsorted_vector
end

print(bubblesort!(V), "\n")

function bubblesort2!(a)
    n = length(a)
    for k in 1:n-1
        istranspose = false
        for i in 1:n-k
            if a[i]>a[i+1]
                a[i], a[i+1] = a[i+1], a[i]
                istranspose = true
            end
        end
        if istranspose == false
            break
        end
    end
    return a
end

print(bubblesort2!(V))