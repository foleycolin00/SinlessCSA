from sample import *

'''Test function isKlass'''
def testIsKlass():
  assert isKlass('!')
  assert isKlass('abc!')
  assert isKlass('!abc')
  
  assert not isKlass('123')
  assert not isKlass('')
  
'''Test function isGoal'''
def testIsGoal():
  assert isGoal('+')
  assert isGoal('abc+')
  assert isGoal('+abc')
  assert isGoal('-')
  assert isGoal('abc-')
  assert isGoal('-abc')
  assert isGoal('-123')
  assert isGoal('!')
  assert isGoal('abc!')
  assert isGoal('!abc')
  
  assert not isGoal("123")
  assert not isGoal("")
  
'''Test function isNum'''
def testIsNum():
  assert isNum("123")
  assert isNum("123.")
  assert isNum("12.3")
  assert isNum("-.123")
  assert isNum(".123")
  assert isNum("-123")
  assert isNum("-123.")
  assert isNum("-12.3")
  assert isNum("-0.123")
  
  assert not isNum(".-123")
  assert not isNum("1.2.3")
  assert not isNum("thisisnotanumber")
  
'''Test function isWeight'''
def testIsWeight():
  assert isWeight("+") == 1
  assert isWeight("") == 1
  assert isWeight("+abc") == 1
  assert isWeight("abc+") == 1
  
  assert isWeight("-") == -1
  assert isWeight("-abc") == -1
  assert isWeight("abc-") == -1
  
'''Test function isSkip'''
def testIsSkip():
  assert isSkip('?')
  assert isSkip('abc?')
  assert isSkip('?abc')
  
  assert not isSkip('123')
  assert not isSkip('')
