# function InsertionSort!(vector::AbstractVector)
#     @inbounds for itt in 2 : lastindex(vector)
#         while ( itt > 1 && vector[itt] < vector[itt - 1] )
#             vector[itt], vector[itt - 1] = vector[itt - 1], vector[itt]
#             itt -= 1
#         end
#     end
# end



function InsertionSort!(vector::AbstractVector)
    for itt in 2 : lastindex(vector)
        utt = itt - 1
        current_value = vector[itt]
        while ( utt > 1 && vector[itt] < vector[utt] )
            utt -= 1
        end
        shift!(@view vector[utt + 1 : itt])
        # vector[utt + 1 : itt] = vector[utt : itt - 1] 
        vector[utt + 1] = current_value
    end
end

function shift!(vector::AbstractVector)
    if (length(vector) > 2)
        for itt in lastindex(vector) : firstindex(vector) + 1 
            vector[itt] = vector[itt - 1]
        end
    end
end





unsorted_vector = randn(100)
println(issorted(unsorted_vector))

@time InsertionSort!(unsorted_vector)

println(issorted(unsorted_vector))