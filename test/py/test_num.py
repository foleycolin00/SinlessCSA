from num import *

'''
Test class for Num
'''

'''
Test Num init
'''
def testNumInit():
  num = Num()
  assert num.at == 0
  assert num.name == ''
  
  num = Num(1, '123')
  assert num.at == 1
  assert num.name == '123'
  assert num.lo == 1e32
  assert num.hi == -1e32
  assert num.mu == 0
  assert num.m2 == 0
  assert num.sd == 0
  assert num.w == 1
  
  num = Num(1, '-123')
  assert num.w == -1

'''Test function getWeight'''
def testGetWeight():
  assert Num(1, '+').getWeight() == 1
  assert Num(1, "").getWeight() == 1
  assert Num(1, "+abc").getWeight() == 1
  assert Num(1, "abc+").getWeight() == 1
  
  assert Num(1, "-").getWeight() == -1
  assert Num(1, "-abc").getWeight() == -1
  assert Num(1, "abc-").getWeight() == -1


'''
Test Num add
'''
def testNumAdd():
  num = Num()
  num.add(123)
  num.add('?')
  num.add(456)
  assert num.n == 2

'''Test function norm'''
def testNorm():
  num = Num()
  num.add(0)
  num.add('?')
  num.add(1)

  assert num.norm('?') == '?'
  assert num.norm(1) == 1
  assert num.norm(0) == 0
  assert num.norm(.5) == .5