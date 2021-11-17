from sample import *
import time
import os
import functools
from pprint import pprint
from fft import Fft
from prune import * 

#Start Time
startTime = time.time()

s = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
s.fromFile(myPath + Config.dataSet)

prevVerbose = Config.verbose

Config.verbose = False
fft = Fft(s)
Config.verbose = prevVerbose

if Config.verbose:
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

treesSort = []
for f in fft.trees:
  #Get accuracy for each tree
  TP = 0
  TN = 0
  FP = 0
  FN = 0
  firstRow = True
  for row in readCSV(myPath + Config.dataSet):
    if firstRow:
      firstRow = False
    else:
      result = row[s.y[0].at]
      for b in f:
        if not b.disc or b.disc.matches(row):
          #True
          if b.typ == result:
            if result == 1:
              TP+=1
            if result == 0:
              TN+=1
          #False
          else:
            if result == 1:
              FN+=1
            if result == 0:
              FP+=1
          break;
          break;
  treesSort.append([f, TP, TN, FP, FN])
#Sort by accuracy
#Accuracy = TP+TN / TP+TN+FP+FN
treesSort.sort(key=lambda x: (x[1]+x[2])/(x[1]+x[2]+x[3]+x[4]))

chosenTree = treesSort[-1]

if Config.verbose:
  for b in f:
    print(str(b))
print("\n\n\n--------------ACCURACY------------")
#Accuracy = TP+TN / TP+TN+FP+FN
print((chosenTree[1]+chosenTree[2])/(chosenTree[1]+chosenTree[2]+chosenTree[3]+chosenTree[4]))

print("\n--------------PRECISION------------")
#Precision = TP / TP+FP
print((chosenTree[1])/(chosenTree[1]+chosenTree[3]))

print("\n--------------FALSE ALARM------------")
#False Alarm = FP / FP+TN
print((chosenTree[3])/(chosenTree[3]+chosenTree[2]))

print("\n--------------RECALL------------")
#Recall = TP/(TP+FN)
print((chosenTree[1])/(chosenTree[1]+chosenTree[4]))

print("\n--------------Time------------")
endTime = time.time()
print(endTime - startTime)