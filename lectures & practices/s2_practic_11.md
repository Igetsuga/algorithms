# Практика 11

При выполнении следующих заданий удобно будет использовать блокноты Jupyter (см. лекцию 6).

При этом рекомендуется программный код по-прежнему размещать в jl-файлах, а в ячейки блокнота вставлять содержащиеся в них определения функций с помощью include. После чего вызывать функции на исполнение можно будет уже из ячеек блокнота. 

1. Написать функции, осуществляющие следующие действия.

- поиск точки пересечения (если она есть) двух заданных отрезков на плоскости;

- вычисление угола между двумя плоскими прямыми;

- проверку, лежат ли две заданные точки плоскости по одну сторону от заданной (с помощью неявной функции) границы области;

- проверку, лежат ли две заданные точки плоскости по одну сторону от заданной прямой;

- проверку, является ли заданный плоский многоугольник выпуклым;

- проверку, лежит ли заданная точка плоскости внутри заданного многоугольника (не обязательно выпуклого).

**Указание.** Для решения всех перечисленных выше задач, кроме последней (решение которой обсуждалось в лекции 6), воспользоваться материалом лекции 5.

2. Написать функцию, реализующую алгоритм Джарвиса построения выпуклой оболочки заданных точек плоскости (см. лекцию 6).
   
3. Написать функцию, реализующую алгоритм Грехома построения выпуклой оболочки заданных точек плоскости (см. лекцию 6).

4. Написать функцию, возвращающую значение ориентированной площади заданного плоского многоугольника, воспользовавшись методом прямогольников (см. лекцию 6).

5. Написать функцию, возвращающую значение ориентированной площади заданного плоского многоугольника, воспользовавшись методом треугольников (см. лекцию 6).

6. Написать функцию, которая будет, как и две предыдущие, возвращать площадь заданного многоугольника, но использовать какой-то один из двух методов, в зависимости от заданного значения специально введенного для этого именованного параметра (например: method = :tarpz, здесь :trapz - это значение типа Symbol).

7*. Написать функцию, строющую выпуклую оболчку заданного многоугольника и одновременно вычисляющая её площадь (функция должна возвращать кортеж из вектора с координатами вершин выпуклой оболочки и из значения его площади).

**Указание.** Алгоритм вычисления этой функции должен быть однопроходным, т.е. построение выпуклой оболочки (и вычисления её площади) надо свести к вычислению соответствующей индуктивной функции, заданной на произвольной последовательности точек (выпуклую оболочку которых требуется построить).

Идея такого алгоритма может состоять в следующем. На вход алгоритма поступает последовательность точек. При получении каждой новой точки, выпуклая оболочка для ранее построенных точек, корректируется так, чтобы она включала и новую точку. 

Алгоритм можно начать с первых 3- точек, котрые будут вершинами треугольника и, соответственно, являться вершинами их выпуклой оболочки.

Далее, при получении новой точки надо определить является ли она внутренней или внешней точкой по отношению к ранее построенной выпуклой оболочке. Если она оказалась внутренней, то выпуклая оболочка остается прежней. Если же точка оказалась внешней, то надо определить две "крайние" вершины прежней выпуклой оболочки, через каждую из которых можно провести из новой точки луч, таким образом, чтобы он не проходил через её внутренние точки. После этого останется только заменить соответствующую часть вершин ранее построенной выпуклой оболочки на одну новую вершину, и таким образом получить выпуклую оболочку, включающую её.

Одновременно с этим очевидным образом можно скорректировать вычисляемое значение площади выпуклой оболочки, воспользовавшись методом треугольников.