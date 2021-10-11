from sample import *
import os
import functools
from pprint import pprint
from fft import Fft

s = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
s.fromFile(myPath + "/data/pom3a.csv")

Config.verbose = False
branch=[]
fft = Fft(s, s, branch)
Config.verbose = True

for b in fft.tree:
  print(str(b))
  
print(fft.best)