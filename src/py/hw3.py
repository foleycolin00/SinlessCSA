from sample import *

s = Sample()
s.read('../../data/auto93.csv')

for row in s.cols:
  print(row.name.ljust(20), end="")
print()

for row in s.rows:
  for data in row:
    print(str(data).ljust(20), end="")
  print()