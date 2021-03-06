# Практика 13

1. Научиться программировать все алгоритмы, разбиравшиеся в лекции 7.

2. Решить следующие задачи.

**Задача 1.** Составить цикл, генерирующий и печатающий последовательность всех размещений **без повторений** (можно обернуть его в соответствующую функцию).

**Указание.** Воспользоваться пользоательскими типами KSubset{M,K} и Permute{K} (см. лекцию 7).

**Задача 2.** Решить так называемую задачу **коммивояжера**, т.е. написать функцию, получающую на вход весовую матрицу некоторого ориентированного, вообще говоря, графа, и возвращающую двухэлементный кортеж, содержащий:
 1) последовательность вершин этого графа, определяющую цикл наименьшей "стоимости", включающий все вершины графа ровно по одному разу;
 2) "стоимость" этого цикла.
 
В этой задаче граф считается **простым**, т.е. не содержащем петель и кратных ребер.

Элементы весовой матрицы должны представлять собой произвольные вещественные числа с плавающей точкой (не обязательно положительные, вообще говоря).

**Замечание.** Цикл, содержащий все вершины графа ровно по одному разу, называется **гамильтоновом цикл**. Не в кажом графе существует гамильтонов цикл. Граф, содержащий гамильтонов цикл, называется **гамильтоновым графом**.

Каждый полный граф, очевидно, является гамильтоновым. 

Условие задачи предполагает, что рассматриваемый граф является гамильтоновым.

Если весовая матрица не содержит бескоечностей, то она определяет некоторый полный граф. Однако, если мы хотим рассматривать не только полные графы, то можно допустить, чтобы некоторые  элементы матриы были бы равными плюс бесконечности (`Inf=Inf64, Inf32, Inf16`), что фактически будет означать отсутствие соответствующих ребр. 

При этом, если окажется, что найденная минимальная стоимость равна плюс бесконечности, то это будет означать, что данный граф не является гамильтоновым.

**Указание.** Свести решение задачи коммивояжера к генерации  перестановок индексов вершин графа.

**Вопрос:** каково наименьшее необходимое число таких перестановок.
Из следующих вариантов ответа выберите правильный:

- $n!$
- $(n-1)!$
- $(n-1)!/2$

где n - число всех вершин.

Обоснуйте, почему в случае ориентированного графа правильным будет второй вариант, а в случае неориентированного графа - третий.

**Подсказка.**

Первый вариант приводит к тому, что каждый цикл будет повторяться ровно n раз, из за того, что в качестве "стартовой" вершины "старовых" будет рассмативаться каждая вершина по отдельности, но для цикла нет понятия "стартовая вершина".

**Второй вариант** фиксирует какую-то одну вершину в качестве стартовой, но допускает, рассмотрение каждого цикла вместе со своим противоположным циклом. Если граф неориентированный, то стоимости взаимно противоположных циклов будут одинаковые, а если граф ориентированый, то, вообще говоря, - нет.


**Замечание.** Задача коммивояжера относится к так называемому классу NP-трудных задач. Этот класс задач характеризуется тем, что для содержащихся в нем задач не известны алгоритмы полиномиальной сложности и, как предполагается специалистами (но на сегодняшний день это не доказано), не могут быть решены за $O(n^d)$ операций, где $n$ - размер задачи, $d$ - некоторое натуральное число.

Можно считать, что оценка сложности таких задач в зависимости от их размера растет или экспоненциально или как факториал.

Поэтому решить задачу комивояжера для сколько-нибудь больших значений n оказывается практически невозможным (на практике n придется ограничить всего несколькими десятками).  Однако существуют различные методы приближенного решения этой задачи, которые уже могут быть практически реализованы, но которые мы сейчас не рассмативаем.


