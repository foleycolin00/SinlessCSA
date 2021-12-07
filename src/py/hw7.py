from sample import *
import os
import functools
from pprint import pprint
from fft import Fft
import csv

s = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
s.fromFile(myPath + "/data/auto93.csv")

NEWHYPER = True
HyperNum = 30

if (NEWHYPER):
  with open(myPath + "/data/hyperOutput.csv",'w') as f:
      writer = csv.writer(f)
      row = Config.getAsArray()[0]
      names = [x.name for x in s.y]
      writer.writerow(row+names+["N+"])

  for i in range(HyperNum):
    print(f"{i+1}:  ", end = "")
    Config.verbose = False
    
    #generate all new values
    Config.generateAll()

    #get the FFT trees
    #Config.verbose = False
    branch=[]
    try:
      fft = Fft(s)
    except:
      print("ERROR")
      continue
    Config.verbose = True

    #The final value
    print(fft.best)
    
    with open(myPath + "/data/hyperOutput.csv",'a') as f:
      writer = csv.writer(f)
      row = Config.getAsArray()[1]
      values = fft.best
      writer.writerow(row+values)

s2 = Sample()
myPath = os.path.dirname(os.path.abspath(__file__))
myPath = myPath[:myPath.rindex("/")]
myPath = myPath[:myPath.rindex("/")]
s2.fromFile(myPath + "/data/hyperOutput.csv")

print(s2.names)

Config.verbose = False
branch=[]
fft = Fft(s2)
Config.verbose = True

#The final, final value
print(fft.best)
print(fft.bestPath)
