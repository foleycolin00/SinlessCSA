import sys, os
from readCSV import *

'''Test function convertNumber()'''
def testConvertNumber():
  assert convertNumber("123") == 123
  assert convertNumber("123.") == 123.0
  assert convertNumber("12.3") == 12.3
  assert convertNumber("-.123") == -.123
  assert convertNumber(".123") == .123
  assert convertNumber("-123") == -123
  assert convertNumber("-123.") == -123.0
  assert convertNumber("-12.3") == -12.3
  assert convertNumber("-0.123") == -0.123
  
  assert convertNumber(".-123") == ".-123"
  assert convertNumber("1.2.3") == "1.2.3"
  assert convertNumber("thisisnotanumber") == "thisisnotanumber"

'''Test function readCSV'''
def testReadCSV():
  expected = [['outlook','Temp','windy','Wins+','Play-'],
  ['sunny',85,'FALSE',10,20],
  ['sunny',80,'TRUE',12,40],
  ['overcast',83,'FALSE',40,40],
  ['rainy',70,'FALSE',40,50],
  ['rainy',68,'FALSE',50,30],
  ['rainy',65,'TRUE',4,10],
  ['overcast',64,'TRUE',30,60],
  ['sunny',72,'FALSE',7,20],
  ['sunny',69,'FALSE',70,70],
  ['rainy',75,'FALSE',80,40],
  ['sunny',75,'TRUE',30,50],
  ['overcast',72,'TRUE',60,50],
  ['overcast',81,'FALSE',30,60],
  ['rainy',71,'TRUE',50,40]]
  
  myPath = os.path.dirname(os.path.abspath(__file__))
  myPath = myPath[:myPath.rindex("/")]
  myPath = myPath[:myPath.rindex("/")]
  i = 0
  for line in readCSV(myPath + '/data/weather.csv'):
    assert line == expected[i]
    i+=1