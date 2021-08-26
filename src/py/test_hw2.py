from hw2 import readCSV, isNumber

'''Test function isNumber()'''
def testIsNumber():
  assert isNumber("123") == True
  assert isNumber("123.") == True
  assert isNumber("12.3") == True
  assert isNumber("=.123") == True
  assert isNumber(".123") == True
  assert isNumber("-123") == True
  assert isNumber("-123.") == True
  assert isNumber("-12.3") == True
  assert isNumber("-0.123") == True
  
  assert isNumber(".-123") == False
  assert isNumber("1.2.3") == False
  assert isNumber("thisisnotanumber") == False

'''Test function readCSV'''
def testReadCSV():
  expected = [['Outlook','Temp','?Humidity','Windy','Wins+','Play-'],
  ['sunny',85,85,10,20],
  ['sunny',80,90,12,40],
  ['overcast',83,86,40,40],
  ['rainy',70,96,40,50],
  ['rainy',68,80,50,30],
  ['rainy',65,70,4,10],
  ['overcast',64,65,30,60],
  ['sunny',72,95,7,20],
  ['sunny',69,70,70,70],
  ['rainy',75,80,80,40],
  ['sunny',75,70,30,50],
  ['overcast',72,90,60,50],
  ['overcast',81,75,30,60],
  ['rainy',71,91,50,40]]
  assert readCSV("/src/py/hw2.csv") == expected