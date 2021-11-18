from sample import *
import time
import os
import functools
from pprint import pprint
from fft import Fft
from prune import * 
import math
import multiprocessing
import sys
import statistics
import numpy
import csv

def runParallelTest(params):
  header = params[0]
  data = params[1]
  test = params[2]
  
  #Start Time
  startTime = time.time()

  Config.verbose = False
  s = Sample()
  s.add(header)
  for row in data:
    s.add(row)
  fft = Fft(s)
  
  #Test sample
  t = s.clone()
  for row in test:
    t.add(row)
  
  treesSort = []
  for f in fft.trees:
    #Get accuracy for each tree
    TP = 0
    TN = 0
    FP = 0
    FN = 0
    firstRow = True
    for row in t.rows:
      if firstRow:
        firstRow = False
      else:
        result = row[t.y[0].at]
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
  TP = chosenTree[1]
  TN = chosenTree[2]
  FP = chosenTree[3]
  FN = chosenTree[4]
  
  try:
    accuracy = (TP+TN) / (TP+TN+FP+FN)
    precision = TP / (TP+FP)
    falseAlarm = FP / (FP+TN)
    recall = TP/(TP+FN)
    return [accuracy, precision, falseAlarm, recall]
  except BaseException:
    accuracy = (TP+TN) / (TP+TN+FP+FN)
    calculatedTime = time.time() - startTime
    return [accuracy, 0, 0, 0]

#Set the arguments
if len(sys.argv) > 1:
  try:
    chosenDataset = int(sys.argv[1])
    Config.dataSet = Config.dataSets[chosenDataset]
    print(Config.dataSet)
  except BaseException:
    print("error")

csvOutputHeader = ["Dataset " + sys.argv[1], "Mean", "Median", "StDev", "25th", "75th", "Min", "Max", "T Test"]
csvOutputTime = [["Time"]]
csvOutputAccuracy = [["Accuracy"]]
csvOutputPrecision = [["Precision"]]
csvOutputFalseAlarm = [["FalseAlarm"]]
csvOutputRecall = [["Recall"]]

for chosenImprovements in ["000000", "100000", "010000", "001000", "000100", "000010", "000001"] :
  Config.DISCLESS = False if chosenImprovements[0] == '0' else True
  Config.SHORTTREES = False if chosenImprovements[1] == '0' else True
  Config.BASEBALLTREES = False if chosenImprovements[2] == '0' else True
  Config.SPILLTREES = False if chosenImprovements[3] == '0' else True
  Config.BINARYCHOPS = False if chosenImprovements[4] == '0' else True
  Config.PRUNETREES = False if chosenImprovements[5] == '0' else True

  startTime = time.time()

  myPath = os.path.dirname(os.path.abspath(__file__))
  myPath = myPath[:myPath.rindex("/")]
  myPath = myPath[:myPath.rindex("/")]

  # Get the data and headers
  totalRows = 0
  headers = None
  data = []
  for i, row in enumerate(readCSV(myPath + Config.dataSet)):
    if i == 0 :
      headers = row
    else:
      totalRows+=1
      data.append(row)

  #Split the data
  fiveSplitData = []
  for i in range(0, 5):
    tempData = []
    for j in range(math.floor(len(data)/5 * i), math.floor(len(data)/5 * (i+1))):
      tempData.append(data[j])
    fiveSplitData.append(tempData)

  pool = multiprocessing.Pool()
  pool = multiprocessing.Pool(processes=25)
  inputs = []
  for i in range(0, 5):
    #Repeat 5 times
    for j in range(0, 5):
      seperateData = []
      seperateTest = []
      seperateTest.extend(fiveSplitData[j])
      for k in range(0, 5):
        if not k == j:
          seperateData.extend(fiveSplitData[k])
      params = [headers, seperateData, seperateTest]
      inputs.append(params)
  outputs = pool.map(runParallelTest, inputs)

  print("\n\n\n\n", chosenImprovements, "\n\n")
  print("\n--------------Time------------")
  timeAvg = (time.time() - startTime)/25
  csvOutputTime.append([chosenImprovements, timeAvg])
  print(timeAvg)

  print("\n--------------ACCURACY------------")
  arr = list(map(lambda x: x[0], outputs))
  resultMean = sum(arr)/25
  resultMedian = statistics.median(arr)
  resultStDev = statistics.stdev(arr)
  result25 = numpy.percentile(arr, 25)
  result75 = numpy.percentile(arr, 75)
  resultMin = min(arr)
  resultMax = max(arr)
  csvOutputAccuracy.append([chosenImprovements, resultMean, resultMedian, resultStDev, result25, result75, resultMin, resultMax])
  print(resultMean)

  print("\n--------------PRECISION------------")
  arr = list(map(lambda x: x[1], outputs))
  resultMean = sum(arr)/25
  resultMedian = statistics.median(arr)
  resultStDev = statistics.stdev(arr)
  result25 = numpy.percentile(arr, 25)
  result75 = numpy.percentile(arr, 75)
  resultMin = min(arr)
  resultMax = max(arr)
  csvOutputPrecision.append([chosenImprovements, resultMean, resultMedian, resultStDev, result25, result75, resultMin, resultMax])
  print(resultMean)

  print("\n--------------FALSE ALARM------------")
  arr = list(map(lambda x: x[2], outputs))
  resultMean = sum(arr)/25
  resultMedian = statistics.median(arr)
  resultStDev = statistics.stdev(arr)
  result25 = numpy.percentile(arr, 25)
  result75 = numpy.percentile(arr, 75)
  resultMin = min(arr)
  resultMax = max(arr)
  csvOutputFalseAlarm.append([chosenImprovements, resultMean, resultMedian, resultStDev, result25, result75, resultMin, resultMax])
  print(resultMean)

  print("\n--------------RECALL------------")
  arr = list(map(lambda x: x[3], outputs))
  resultMean = sum(arr)/25
  resultMedian = statistics.median(arr)
  resultStDev = statistics.stdev(arr)
  result25 = numpy.percentile(arr, 25)
  result75 = numpy.percentile(arr, 75)
  resultMin = min(arr)
  resultMax = max(arr)
  csvOutputRecall.append([chosenImprovements, resultMean, resultMedian, resultStDev, result25, result75, resultMin, resultMax])
  print(resultMean)

#Print to CSV
with open(myPath + "/testOutput/Dataset" + sys.argv[1] + ".csv", 'w+') as csvfile: 
  # creating a csv writer object 
  csvwriter = csv.writer(csvfile) 
      
  # writing the fields 
  csvwriter.writerow(csvOutputHeader) 
      
  # writing the data rows 
  csvwriter.writerows(csvOutputTime)
  csvwriter.writerows(csvOutputAccuracy)
  csvwriter.writerows(csvOutputPrecision)
  csvwriter.writerows(csvOutputFalseAlarm)
  csvwriter.writerows(csvOutputRecall)

print("\n\n\n\n--------------CODE FINISHED--------------")