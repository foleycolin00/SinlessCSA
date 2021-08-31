'''
Test class for Skip
'''

'''
Test Skip init
'''
def testSkipInit():
  skip = sinless.Skip()
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