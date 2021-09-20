from sample import *
import os
import functools
from pprint import pprint

s = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
s.fromFile(myPath + "/data/auto93.csv")

print("------\nTask 1:")
print("(showing first 10 rows)")

for row in s.cols:
  print(row.name.ljust(20), end="")
print()

for i in range(10):
  print(f"\nRow {i+1}:")
  for data in s.rows[i]:
    print(str(data).ljust(20), end="")
  print("\nClosest Row:")
  a = s.neighbors(s.rows[i])
  print(f"Distance - {a[0][0]}")
  for data in a[0][1]:
    print(str(data).ljust(20), end="")
  print("\nFurthest Row:")
  print(f"Distance - {a[-1][0]}")
  for data in a[-1][1]:
    print(str(data).ljust(20), end="")
  print("\n\n")
 
print("\n\n\n\n\n\n\n------\nTask 3:")
 
leafs = s.divs()

for leaf in leafs:
  print(len(leaf.rows))