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

'''
Test Num add
'''
def testNumInit():
  num = Num()
  num.add('123')
  num.add('?')
  num.add('abc')
  assert num.n == 2