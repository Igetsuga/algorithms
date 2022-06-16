# Лекция 8
- Представление множества упорядоченными двоичными деревьями
- Представление множества с помощью хеширования (встроенный тип данных Set)
- Хеш-таблицы (ассоциативные массивы, словари, встроенный тип данных Dict)
- Очередь с приоритетом
- Куча
- Пирамидальная сортировка
- Жадные алгоритмы
- Алгоритмы построения остова наименьшего веса для заданного взвешенного неориентированного графа
- Примеры задач, не решаемых жадными алгоритмами (задача коммивояжера, задача о рюкзаке)
- Динамическое программирование

## Множество, как структура данных

Операции:

- in
- push!
- pop!

- intersect
- union
- setdiff


### **Способы представления множества**

- на базе простого массива:
    - in - $O(N)$
    - push! - $O(N)$ (сначала требуется найти свободную позицию)
    - pop! - $O(N)$
- на базе отсортированного массива:
    - in - $O(\log N)$ (возможен быстрый поиск)
    - push! - $O(N)$ (приходится смещать элементы, для освобождения позиции)
    - pop! - $O(N)$  (приходится смещать элементы)
- в виде упорядоченного двоичного дерева:
    - in - $O(\log N)$ (возможен быстрый поиск)
    - push! - $O(\log N)$ (АВЛ - деревья, красно-черные деревья)
    - pop! - $O(\log N)$  (АВЛ - деревья, красно-черные деревья)
- с помощью "хеширования" 
    - in - $O(1)$
    - push! - $O(1)$ 
    - pop! - $O(1)$

### **Хеширование**
(https://habr.com/ru/company/otus/blog/495032/)

Ранее в СССР вместо слова "хеширование" (`hash`) использовался термин "расстановка".

Идея состоит в том, чтобы элементы множества хранить в виде простого массива, но чтобы, при этом, иметь возможность каким-либо образом индекс элемента этого массива **вычислять** по значению элемента массива. Причем сложность вычисления индекса не должна зависеть от размера массива, т.е. оцениваться как $O(N)$.

Тогда, если имеется возможность быстро вычислять индекс элемента по его значению, то сложность операции `in` будет оцениваться как $O(1)$. В самом деле, вычислив по заданному значению его индекс (за $O(1)$ элементарных операций), останется только проверить, что стоит, и стоит ли, что-нибудь в массиве на соответствующей позиции, на что потребуется еще $O(1)$ операций. 

Это, может быть, на первый взгляд выглядит фантастически, однако может быть реализовано с помощью так называемых хеш-функций.

**Хеш-функция** осуществляет преобразование массива входных данных произвольной длины в выходную битовую строку установленной длины по специальному алгоритму.

Само это преобразование, осушествляемое хеш-функцией, называется **хешированием**.

Хеш-функция получает исходные данные в виде входного массива, называемые также «ключом» или «сообщением». Возвращаемый ею двоичный код фиксированной длины (т.е. некоторое неотрицательное целое число) называется «хешем», «хеш-кодом».

При этом возможно, различным значениям ключа (различным входным данным) хеш-функция будет сопоставлять одно и то же число. Такая ситуация называется **коллизией** (ранее в CCCР это называли конфликтом). Важно, чтобы хеш-функция была устроена так, чтобы коллизии возникали редко. 

#### **Борьба с коллизиями**

Массив, представляющий множество, может хранить, например, не значения элементов, а ссылки на на начала связных списков, содержащих значения, имеющие один и тот же хеш-код.

Имеется и другой способ, называемый способом разрешения коллизий с открытой индексаций. Он состоит в том, что при вставке нового элемента, если в позиции, соответствующей его хеш-коду уже имеется другое значение, то ищется ближайшая пустая "ячейка" с большим индексом (при этом массив считается "закольцованным", т.е. "больший" индекс на самом деле не обязательно будет больше). При проверке же наличия в множестве некоторого значения, сначала это значение проверятся на "своей" позиции, и если оно не совпадает с имеющемся там элементом, то проверяются все позиции с "большими" индексами, пока не будет найдено искомое значение, или пока очередная ячейка массива не окажется пустой (последнее будет означать отсутствие такого элемента).

В результате **в среднем** сложность операций `in`, `push!`, `pop!` будет иметь оценку $O(1)$ (но для наихудшего случая будет - $O(N)$).

#### **Способы реализации хеш-функций**
(https://ru.wikipedia.org/wiki/Хеш-функция)

Существует много разных способов реализации хеш-функций. 

Общие требования к хеш-функции состоят в том, что бы 
 1) она вычислялась быстро, за $O(1)$ элементарныых операций;
 2) на случайных данных её значения "равномерно" распределялись по диапазону всех возможных значений; это будет способствовать уменьшению числа возникновения коллизий.

Следующие способы хеширования рассмотрены просто для примера.

1. Способ, основанный на делении целых чисел

```julia
hesh(key::Integer, m::Integer) = key % m
```
Здесь целое число `key` представляет входные данные (последовательность каких-либо битов), `m` - это число всех возможных хеш-кодов. При этом, чтобы коллизии случались относительно редко, требуется чтобы число `m` было простым.

2. Способ, основанный на умножении на число и сдвиге

```julia
#A,n - некоторые заданные целые положительные числа (параметры)
h(key::Integer) = (A*key) >> n
```

Можно подобрать такие значения параметров A и n, чтобы хеш-функция обладала требуемыми свойствами.

3. Хеш-функция Пирсона

```julia
using Random
const PERM_TABLE = randperm(256) .- 1 # - некоторая произвольная перестановка 0-255

"""
    hesh(bayt_vector::Vector{Int8})

Преобразует любую последовательность байтов в 8-битный числовой код 
(всего имеется ровно 2^8 = 256 различных 8-битных кодов)
"""
function hesh(bayt_vector::Vector{Int8})
    h = 0
    for bayt in bayt_vector
        h = PERM_TABLE[h ⊻ bayt] # операция ⊻ - это "исключающее или" (\xor <Tab>)
    end
    return h
end

"""
    hesh(bayt_vector::Vector{Int8}, dim::Integer)

Преобразует любую последовательность байтов в вектор длины dim 8-битных числовых кодов
(всего таких различных векторов имеется ровно 2^(8*dim))
"""
function hesh(bayt_vector::Vector{Int8}, dim::Integer)
    h_vector = Vector{Int8}(undef, len)
    for j in 1:dim 
        h = PERM_TABLE[(bayt_vector[1] + j-1) % 256]
        for bayt in @view(bayt_vector[2:end]) 
            h = PERM_TABLE[h ⊻ bayt]
        end
        h_vector[j] = h
    end
    return h_vector
end
```

**Замечание.** В языке Julia имеется встроенная функция Base.heap.

## Встроенные типы данных Set, Dict

Массивы типа Set основаны на использовании хеширования.

Словари (ассоциативные массивы) типа Dict представляют собой наборы пар ключ-значение, в которых ключи хешируются. Поэтому в словаре (как и в множестве типа Set) поиск значения по его ключу осуществляется за $O(1)$ элементарных операций. Такие структуры также называются хеш-таблицами.

## Очередь с приоритетом

Операции с приоритетной очередью:
- создать пустую проритетную очередь;
- проверить, является ли в приоритетная очередь пустой;

- добавить новый элемент в приоритетную очередь;
- извлечь элемент с наивысшим приоритетом;
- увеличить/уменьшить приоритет некоторого элемента очереди.


Способы реализации приоритетной очереди:

- на базе простого массива: время добавления - $O(1)$, время извлечения - $O(N)$;
- на базе отсортированного массива: время добавления - $O(N)$, время извлечения - $O(1)$;
- с помощью "кучи": время добавления - $O(log(N))$, время извлечения - $O(log(N))$.

## Тип данных "куча"

**Куча** представляет собой двоичную иерархическую структуру, в которой значение каждого из двух дочерних элементов меньше (больше) значения родительского элемента.

Если на вершине кучи находится максимальное значение, то она называется максимальной. 

В противном случае, есле на вершине кучи находится минимальное значение, то она называется минимальной.

### Реализация кучи на базе массива

Как правило кучу реализуют на базе обычного массива.

Массив `heap` имеет структуру **кучи** (**максимальной** кучи), если  для каждого его `i`-го элемента выполнены следующие два условия:
- `heap[i] < heap[2i]`
- `heap[i] < heap[2i+1]`

разумеется, индекс `i` здесь не должен превосходить `length(heap)÷2`. 

Преобразовать произвольный массива в максимальную кучу можно за $O(N)$ действий.

```julia
function heap!(array)
    N = length(array)
    for i in 1:N÷2
        if array[i] < array[2i]
            array[i], array[2i] = array[2i], array[i]
        end
        
        if 2i+1 <= N && array[i] < array[2i+1]
            array[i], array[2i+1] = array[2i+1], array[i]
        end
    end
    return array
end
```

Соответсвенно, если при всех возможных `i` выполняются условия
 - `heap[i] > heap[2i]`
 - `heap[i] > heap[2i+1]`
 
то массив `heap` имеет структуру **минимальной** кучи.

### Перемещение элемента на место, соответствующее его приоритету

Допустим, что имеется только один единственный элемент в куче, который стоит на позиции (`i-`ой), не соответствующей его приоритету. 

Такая ситуация может возникать, например, при добавлении/удалинии элемента в кучу. А также, если при решении какой-либо задачи, на каком-то шаге произошло изменение значения приоритета какого-то одного элемента кучи. 

Задача состоит в том, что бы переместить этот элемент на нужную позицию, восстановив требуемую структуру кучи.

Это можно делать с помощью одной из следующих двух функций, сложность каждой из которых оценивается как $O(log(N))$.

```julia
"""
    up!(heap::AbstractVector, index)

"Поднимает" элемент с индексом index к вершине куче, пока этот элемент не займет свое "правильное" место в куче, и возвращает наименьший из индексов всех перемещенных при этом элементов кучи.
"""
function up!(heap::AbstractVector, index)
    @assert i <= length(heap)
    is_ord = false
    while index > 1 && is_ord == false
        is_ord = true
        if heap[index] > heap[index÷2]
            heap[index], heap[index÷2] = heap[index÷2], heap[index]
            is_ord = false
        end

        if heap[index] > heap[(index-1)÷2]
            heap[index], heap[(index-1)÷2] = heap[(index-1)÷2], heap[index]
            is_ord = false
        end     
        
        current_index = index
        if isodd(i)
            index ÷= 2
        else
            index = (index-1)÷2
        end
    end
    return current_index
end

"""
    down!(heap::AbstractVector, index)::Nothing

"Опускает" элемент с индексом index ближе к концу кучи, пока этот элемент не займет свое "правильное" место в куче.
"""
function down!(heap::AbstractVector, index)::Nothing
    N = length(heap)
    while index < N÷2
        if heap[index] < heap[2index]
            heap[index], heap[2index] = heap[2index], heap[index]
        end
        if 2index+1 <= N && heap[index] < heap[2index+1]
            heap[index], heap[2index+1] = heap[2index+1], heap[index]
        end
        index *= 2
    end
end
```
### Добавление/извлечение элементов из кучи

Если масссив heap есть минимальная куча, то добавить в нее новый элемент (сохраняя структуру кучи) можно за `O((log N))` действий следующим образом.

```julia
"""
    push!(heap::AbstractVector, new_elem)::Nothing

Добавляет новый элемент в кучу, представленную массивом.
"""
function Base.push!(heap::AbstractVector, new_elem)::Nothing
    push!(heap, new_elem)
    up!(heap, lastindex(heap))
end

```

Соответственно, извлечь очередной (максимальный) элемент из кучи можно также за `O((log N))` действий следующим образом.

```julia
"""
    pop!(heap::AbstractVector, new_elem)

Извлекает из кучи, представленной массивом, и возвращает элемент с наивысшим приоритетом.
"""
function Base.pop!(heap::AbstractVector, new_elem)
    heap[begin], heap[end] = heap[end], heap[begin]    
    max_value = pop!(heap)
    down!(heap, firstindex(heap))
    return max_value
end

"""
dec_priority!(heap::AbstractVector{T}, index::Integer, new_value::T)::Nothing where T

Выполняет необходимое перестраивание максимальной кучи при замене heap[index] мЕньшим значением new_value.
"""
function dec_priority!(heap::AbstractVector{T}, index::Integer, new_value::T)::Nothing where T
    @assert new_value <= heap[index]
    prioity[index] = new_value
    down!(heap, index)
end

"""
inc_priority!(heap::AbstractVector{T}, index::Integer, new_value::T)::Nothing where T

Выполняет необходимое перестраивание максимальной кучи при замене heap[index] бОльшим значением new_value.
"""
function inc_priority!(heap::AbstractVector{T}, index::Integer, new_value::T)::Nothing where T
    @assert new_value >= heap[index]
    prioity[index] = new_value
    up!(heap, index)
end
```

Последние две функции, скорее всего, не будут полезными для практического использования, потому что для этого потребовалось бы уметь быстро определять номер позиции index, на которой в данный момент находтися значение приоритета, требуеющее быть замененном на другое. Но вот как именно это значение index может быть быстро определено - это пока остается под вопросом. 

В дальнейшем нами будет разработан специальный тип данных, с помощью которого эта проблема будет разрешена. 
Но не будем пока на этом состредотачиваться, сейчас важно лишь понять принципиальную возможность и механизм быстрой перестройки кучи при изменениисейчас приоритета одного из ее элементов. 

## Пирамидальная сортировка

Пусть $heap$ - произвольный вектор длины $N$.

Процедура сортировки состоит из следующих шагов.

1. Преобразуем исходный массив в кучу (с помощью функции heap!).

2. Поменяем местами первый элемент массива (после предыдущего шага он будет максималным) с последним (тем самым последний элемент массива окажется на "своем" окончательном месте), и переместим первый элемент массива на "правильное" место в куче. С использованием функции `down!` на это потребуется $O(\log N)$ элементарных операций.

4. Длину сортируемой части массива уменьшим на 1 и перейдем к пункту 2, и т.д. пока длина сортируемой части станет раной 3 (первые три элемента кучи всегда отсортированы).

Таким образом, сложность пирамидальной сортировки имеет оценку $O(N \log N)$. 

```julia
function heap_sort!(heap::AbstractVector)
    heap = heap!(heap) 
    # здесь heap! - это именно функция, преобразующая массивив в максимальную кучу, а не конструктор типа Heap!
    N = length(heap)  
    #ИНВАРИАНТ: heap[1:N] - это максимальная куча && heap[N+1:end] - это отсортированная часть массива
    while N > 3
        heap[1], heap[N] = heap[N], heap[1]
        N -= 1
        down!(@view(heap[1:N]), 1) 
        # - это вызов метода down!(::AbstractVector, Any), а не метода down!(::Heap!, ::Any)
    end
    return heap
end
```

## Пользовательский тип данных Heap!

Спроектированные нами функции `heap!`, `up!`, `down!`, `push!`,`pop!`, позволяют создать и работать с максимальной кучей, представленной обычным массивом. 

При этом, если вместо максимальной кучи потребуется минимальная куча, то будет достаточно перед началом просто в массиве поменять знаки всех элементов на противоположные. просто 

Однако есть задачи, при решении которых могут происходить изменения приоритетов отдельных элементов кучи. Тогда оказывается целесообразным в самой куче хранять не значения прироитетов, а лишь индексы массива с значениями приоритетов, а для записи самих приоритетов использовать отдельный массив, элементы которого никогда не будут перемещаться (но могут быть изменены). При этом будет необходимо установить соответствие между индексами массива приоритетов и индексами массива, представляющего собственно кучу. Для установления такого соответствия удобно будет использовать словарь типа `Dict{Int, Int}`, которая обеспечит желаемое здесь быстрое установление соответствий (за $O(1)$ элементарных операций), т.к. этот тип данных основан на хешировании. 

Т.е. пусть значение целого типа `index_priority` - это индекс какого-то элемента массива приоритетов, т.е. соответствующего ему приоритета есть `priority[index_priority]`, где `priority` - заданный массив приоритетов. 
Тогда позиция того же элемента в куче будет определена значением `index_heap[index_priority]`, где  `index_heap` - это объет словарь типа `Dict{Int, Int}`.  

Для реализации этого механизма, придется разработать специальный тип данных (структуру), который назовем `Heap!`.

```julia
"""
Heap!{:maх}(heap::AbstractVector, priority::Vector)

Приоритеты элементов массива heap определяются с помощью параметра priority.
"""
struct Heap!{T} # T = :min или Т = :max
    heap::Vector{Int}
    priority::Vector
    index_heap::Dict{Int,Int} 

    function Heap!{:maх}(priority::AbstractVector)
        @assert firstindex(priority) == 1
        heap = collect(1:length(priority))
        index_heap = Dict([i=>i for i in eachindex(priority)])   
        N=length(heap)
        for i in 1:N÷2
            if priority[heap[i]] < priority[heap[2i]] 
                heap[i], heap[2i] = heap[2i], heap[i]
                index_heap[heap[i]], index_heap[heap[2i]] = index_heap[heap[2i]], index_heap[heap[i]]
            end
        
            if 2i+1 <= N && priority[heap[i]] < priority[heap[2i+1]]
                heap[i], heap[2i+1] = heap[2i+1], heap[i]
                index_heap[heap[i]], index_heap[heap[2i+1]] = index_heap[heap[2i+1]], index_heap[heap[i]]
            end
        end
        new(heap, priority, index_heap)
    end

    function Heap!{:min}(priority::AbstractVector)
        @assert firstindex(priority) == 1
        heap = collect(1:length(priority))
        index_heap = Dict([i=>i for i in eachindex(priority)])   
        N=length(heap)
        for i in 1:N÷2
            if priority[heap[i]] > priority[heap[2i]] 
                heap[i], heap[2i] = heap[2i], heap[i]
                index_heap[heap[i]], index_heap[heap[2i]] = index_heap[heap[2i]], index_heap[heap[i]]
            end
        
            if 2i+1 <= N && priority[heap[i]] > priority[heap[2i+1]]
                heap[i], heap[2i+1] = heap[2i+1], heap[i]
                index_heap[heap[i]], index_heap[heap[2i+1]] = index_heap[heap[2i+1]], index_heap[heap[i]]
            end
        end
        new(heap, priority, index_heap)
    end
end

Base.isempty(heap::Heap!) = isempty(heap.heap)

"""
    up!(heap::Heap!, index)::Nothing

"Поднимает" элемент кучи с индексом index ближе к её вершине, пока он не займет свое "правильное" место.
"""
function up!(heap::Heap!{:max}, index)::Nothing
    priority = heap.priority
    index_heap = heap.index_heap
    heap = heap.heap
    while index > 1 
        if  priority[heap[index÷2]] < priority[heap[index]]
            heap[index], heap[index÷2] = heap[index÷2], heap[index]
            index_heap[index], index_heap[index÷2] = index_heap[index÷2], index_heap[index]
        end

        if priority[heap[(index-1)÷2]] < priority[heap[index]]
            heap[index], heap[(index-1)÷2] = heap[(index-1)÷2], heap[index]
            index_heap[index], index_heap[(index-1)÷2] = index_heap[(index-1)÷2], index_heap[index]
        end     
        
        if isodd(index)
            index ÷= 2
        else
            index = (index-1)÷2
        end
    end
end

function up!(heap::Heap!{:min}, index)::Nothing
    priority = heap.priority
    index_heap = heap.index_heap
    heap = heap.heap
    while index > 1 
        if  priority[heap[index÷2]] > priority[heap[index]]
            heap[index], heap[index÷2] = heap[index÷2], heap[index]
            index_heap[index], index_heap[index÷2] = index_heap[index÷2], index_heap[index]
        end

        if priority[heap[(index-1)÷2]] > priority[heap[index]]
            heap[index], heap[(index-1)÷2] = heap[(index-1)÷2], heap[index]
            index_heap[index], index_heap[(index-1)÷2] = index_heap[(index-1)÷2], index_heap[index]
        end     
        
        if isodd(index)
            index ÷= 2
        else
            index = (index-1)÷2
        end
    end
end

"""
    down!(heap::Heap!, index)::Nothing

"Опускает" элемент кучи с индексом index ближе к её концу, пока он не займет свое "правильное" место.
"""
function down!(heap::Heap!{:max}, index)::Nothing
    priority = heap.priority
    index_heap = heap.index_heap
    heap = heap.heap
    N = length(heap)
    while index < N÷2
        if priority[heap[index]] < priority[heap[2index]]
            heap[index], heap[2index] = heap[2index], heap[index]
            index_heap[index], index_heap[2index] = index_heap[2index], index_heap[index]
        end
        if 2index+1 <= N && priority[heap[index]] < priority[heap[2index+1]]
            heap[index], heap[2index+1] = heap[2index+1], heap[index]
            index_heap[index], index_heap[2index+1] = index_heap[2index+1], index_heap[index]
        end
        index *= 2
    end
end

function down!(heap::Heap!{:min}, index)::Nothing
    priority = heap.priority
    index_heap = heap.index_heap
    heap = heap.heap
    N = length(heap)
    while index < N÷2
        if priority[heap[index]] > priority[heap[2index]]
            heap[index], heap[2index] = heap[2index], heap[index]
            index_heap[index], index_heap[2index] = index_heap[2index], index_heap[index]
        end
        if 2index+1 <= N && priority[heap[index]] > priority[heap[2index+1]]
            heap[index], heap[2index+1] = heap[2index+1], heap[index]
            index_heap[index], index_heap[2index+1] = index_heap[2index+1], index_heap[index]
        end
        index *= 2
    end
end

"""
    push!(heap::Heap!, new_elem)::Nothing

Добавляет новый элемент в кучу.
"""
function Base.push!(heap::Heap!, new_elem)::Nothing
    heap = heap.heap
    push!(heap, new_elem)
    up!(heap, lastindex(heap))
end

"""
    pop!(heap::Heap!, new_elem)

Извлекает из кучи и возвращает элемент с наивысшим/наинизшем приоритетом.
"""
function Base.pop!(heap::Heap!, new_elem::Integer)
    heap[begin], heap[end] = heap[end], heap[begin]    
    max_value = pop!(heap.heap)
    down!(heap, firstindex(heap))
    return max_value
end

"""
    dec_priority!(heap::Heap!{:max}, index_priority::Integer, new_value)::Nothing

Выполняет необходимое перестраивание максимальной кучи при замене heap.priority[index_priority] на меньшее значение new_value.
"""
function dec_priority!(heap::Heap!{:max}, index_priority::Integer, new_value)::Nothing
    # @assert new_value <= heap.priority[index_priority]
    priority = heap.priority
    index_heap = heap.index_heap
    heap = heap.heap
    priority[index_priority] = new_value
    down!(heap, index_heap[index_priority])
end

"""
    inc_priority!(heap::Heap!{:max}, index::Integer, new_value::T)::Nothing where T

Выполняет необходимое перестраивание максимальной кучи при замене heap.priority[index_priority] на большее значение new_value.
"""
function inc_priority!(heap::Heap!{:max}, index_priority::Integer, new_value)::Nothing
    # @assert new_value >= heap.priority[index_priority]
    priority = heap.priority
    index_heap = heap.index_heap
    heap = heap.heap
    priority[index_priority] = new_value
    up!(heap, index_heap[index_priority])
end

"""
    dec_priority!(heap::Heap!{:min}, index_priority::Integer, new_value)::Nothing

Выполняет необходимое перестраивание минимальной кучи при замене heap.priority[index_priority] на меньшее значение new_value.
"""
function dec_priority!(heap::Heap!{:min}, index_priority::Integer, new_value)::Nothing
    # @assert new_value <>= heap.priority[index_priority]
    priority = heap.priority
    index_heap = heap.index_heap
    heap = heap.heap
    priority[index_priority] = new_value
    up!(heap, index_heap[index_priority])
end

"""
    inc_priority!(heap::Heap!{:min}, index_priority::Integer, new_value)::Nothing

Выполняет необходимое перестраивание минимальной кучи при замене heap.priority[index_priority] на большее значение new_value.
"""
function inc_priority!(heap::Heap!{:min}, index_priority::Integer, new_value)::Nothing
    # @assert new_value >= heap.priority[index_priority]
    priority = heap.priority
    index_heap = heap.index_heap
    heap = heap.heap
    priority[index_priority] = new_value
    down!(heap, index_heap[index_priority])
end

Base.iterate(heap::Heap!) = iterate(heap.heap)
Base.iterate(heap::Heap!, i::Integer) = iterate(heap.heap, i)
```

**Замечание.** Для языка Julia имеется пакет DataStructures.jl, в котором определены различные структуры данных, в том числе и куча.

## Задача построения остова наименьшего веса для заданного неориентированного взвешенного графа

https://ru.wikipedia.org/wiki/Минимальное_остовное_дерево

Это пример задачи, решаемой "жадным" алгоритмом.

### Алгоритм Прима

Шаги алгоритма.

1. Возьмем произвольную вершину, и из всех инцидентных ей ребер выберем имеющее наименьший вес. Это ребро войдет в искомый остов.

2. Проделаем аналогичную процедуру, в которой будут участывовать уже две вершины ребра, выбранного на предыдущем шаге. В результате найдем второе ребро остова, в котором будет уже 3 вершины, и т.д. пока все вершиеы графа не войдут в остов. При этом каждое вновь добавляемое в остов ребро не должно замыкать цикла (ребра, замыкающие циклы, должны пропускаться, какой бы малый вес они не имели). 

Этот алгорим может быть реализован с использованием приоритетной очереди - минимальной кучи.

Сначала в эту проритетную очередь помещают сразу **все** вершины, и одной из них (например, первой) приписывают нулевой приоритет, а всем остальным - бесконечно большое значение приоритета, так что именно она будет извлечена из минимальной кучи первой.

Далее, на каждом шаге алгоритма (после добавления к остову очередного ребра) приоритеты вершин персчитываются. Каждый раз они назначаются равными наименьшему весу какого-либо ребра, соединяющего данную вершину с уже построенной частью остова. После чего из кучи извлекается очередная вершина ("ближайшая" к построенной части остова), и соответсвующее инцидентное ей наиболее "легкое" ребро добавляется в остов. 

Алгоритм завершается, когда куча станет пустой.

## Примеры задач, не решаемых жадным алгоритмом

- Задача коммивояжера.

- Задача о рюкзаке (https://www.youtube.com/watch?v=HtrgxH3feME).

Перечисленные задачи относятся к так называемому классу `NP`-полных (говорят еще `NP`-трудных) задач. Этот класс характеризуется тем, что, во-первых, для задач этого класса пока неизвестны алгоритмы решения полиномиальной сложности (все известные алгоритмы имеют экспоненциальную или факториальную оценку сложности).
Во-вторых, если хотя бы для одной из задач этого класса будет найден алгоритм с полиномиальной оценкой сложности, то это будет означать также существование алгоритмов полиномиальной сложности для всех остальных задач этого класса. Однако обычно все специалисты соглашаются с (пока недоказанной и не опровергнутой) гипотезой о том, что класс алгоритмов полиномиальной сложности (класс P) и класс NP не совпадают (и, следовательно, не пересекаются). 