from sample import *
import os
import functools
from pprint import pprint
from fft import Fft

s = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
s.fromFile(myPath + Config.dataSet)

Config.verbose = False
fft = Fft(s)
Config.verbose = True

n = 0
for f in fft.trees:
  for b in f:
    print(str(n)+ " " + str(b))
    n+=1
  print(n)
  n+=1
 
'''print("\n\n\n--------------BEST PATH------------")
print(fft.best)
print(fft.bestPath)'''

print("\n\n\n--------------ACCURACY------------")
treesSort = []
for f in fft.trees:
  #Get accuracy for each tree
  treeCorrect = 0;
  treeIncorrect = 0;
  firstRow = True
  for row in readCSV(myPath + Config.dataSet):
    if firstRow:
      firstRow = False
    else:
      result = row[s.y[0].at]
      for b in f:
        if b.disc:
          if b.disc.matches(row):
            #correct match
            if b.typ == result:
              treeCorrect+=1
            else:
              treeIncorrect+=1
            break;
        #last row
        else:
          if b.typ == result:
            treeCorrect+=1
          else:
            treeIncorrect+=1
  treesSort.append([f, treeCorrect/(treeCorrect+treeIncorrect)])
treesSort.sort(key=lambda x: x[1])

for b in f:
  print(str(b))
print(treesSort[-1][1])