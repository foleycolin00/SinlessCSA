from sample import *
import os
import functools
from pprint import pprint
from fft import Fft

s = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
s.fromFile(myPath + "/data/auto93.csv")

Config.loud = False
branch=[]
fft = Fft(s, s, branch)
Config.loud = True

n = 0
for f in fft.trees:
  for b in f:
    print(str(n)+ " " + str(b))
    n+=1
  print(n)
  n+=1