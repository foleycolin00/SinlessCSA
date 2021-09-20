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
leafs = s.divs()

print("------\nTask 2:")
for col in s.y:
  print(col.name.ljust(20), end="")
print("\n")
for leaf in leafs:
  strings = str(leaf).replace("[", "").replace("]", "").split(', ')
  for string in strings:
    print(string.ljust(20), end='')
  print()

print("------\nTask 3:")
Config.loud = False
disc = s.discretize()
for d in disc:
  print(d)
Config.loud = True

best, worst = leafs[0], leafs[-1]

for row in s.cols:
  print(row.name.ljust(20), end="")
print()

print("BEST LEAF:")
for i in range(5):
  for data in best.rows[i]:
    print(str(data).ljust(20), end="")
  print()

for row in s.cols:
  print(str("...").ljust(20), end="")
print()

print("WORST LEAF:")
for i in range(5):
  for data in worst.rows[i]:
    print(str(data).ljust(20), end="")
  print()

for row in s.cols:
  print(str("...").ljust(20), end="")
print()