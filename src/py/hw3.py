from sample import *
import os
import functools

s = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
s.read(myPath + "/data/auto93.csv")

s.rows.sort(key=functools.cmp_to_key(s.betterCompare))

for row in s.cols:
  print(row.name.ljust(20), end="")
print()

for i in range(0,5):
  for data in s.rows[i]:
    print(str(data).ljust(20), end="")
  print()

for row in s.cols:
  print(str("...").ljust(20), end="")
print()

for i in range(len(s.rows) - 5, len(s.rows)):
  for data in s.rows[i]:
    print(str(data).ljust(20), end="")
  print()