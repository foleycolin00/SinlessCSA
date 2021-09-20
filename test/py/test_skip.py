from skip import *

'''
Test class for Skip
'''

'''
Test Skip init
'''
def testSkipInit():
  skip = Skip()
  assert skip.at == 0
  assert skip.name == ''
  skip = Skip(1, '123')
  assert skip.at == 1
  assert skip.name == '123'

'''
Test Skip add
'''
def testSkipAdd():
  skip = Skip()
  assert skip.n == 0
  skip.add('123')
  skip.add('?')
  skip.add('abc')
  assert skip.n == 2

'''
Test Skip mid
'''
def testSkipMid():
  skip = Skip()
  assert skip.mid() == "?"
  skip.add('123')
  skip.add('?')
  skip.add('abc')
  assert skip.mid() == "?"