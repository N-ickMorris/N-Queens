# ---- Model ----

reset;

param queens := 8;		# number of queens
set N := 1..queens;		# set of queens
var x{i in N, j in N} binary;		# a queen is/isn't positioned in i-j (ie. row-column) index

minimize obj: sum{i in N, j in N}(x[i, j]);		# redundant objective

s.t. Rows{i in N}: sum{j in N}(x[i, j]) = 1;		# all rows must have 1 queen
s.t. Cols{j in N}: sum{i in N}(x[i, j]) = 1;		# all columns must have 1 queen

s.t. ULUR{i in N, j in N: i <= j}: sum{k in 0..(i - 1)}(x[i - k, j - k]) <= 1;		# all up-left diagonals in the upper right triangle must have no more than one queen
s.t. ULLL{i in N, j in N: i >  j}: sum{k in 0..(j - 1)}(x[i - k, j - k]) <= 1;		# all up-left diagonals in the lower left triangle must have no more than one queen

s.t. DLUL{i in N, j in N: i <= (queens + 1 - j)}: sum{k in 0..(j - 1)}(x[i + k, j - k]) <= 1;		# all down-left diagonals in the upper left triangle must have no more than one queen
s.t. DLLR{i in N, j in N: i >  (queens + 1 - j)}: sum{k in 0..(queens - i)}(x[i + k, j - k]) <= 1;		# all down-left diagonals in the lower right triangle must have no more than one queen

# ---- Run ------

option solver cplex;
solve;
display x;

