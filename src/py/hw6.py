from sample import *
import os
import functools
from pprint import pprint
from fft import Fft

s = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
#s.fromFile(myPath + "/data/pom3a.csv")
s.fromFile(myPath + "/data/auto93.csv")

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
 
print("\n\n\n--------------BEST PATH------------")
print(fft.best)
print(fft.bestPath)
