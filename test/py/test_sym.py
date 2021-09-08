from sym import *

'''
Test class for Sym
'''

'''
Test Sym init
'''
def testSymInit():
  sym = Sym()
  assert sym.at == 0
  assert sym.name == ''
  sym = Sym(1, '123')
  assert sym.at == 1
  assert sym.name == '123'

'''
Test Sym add
'''
def testSymAdd():
  sym = Sym()
  assert sym.n == 0
  sym.add('123')
  sym.add('?')
  sym.add('abc')
  sym.add('123')
  assert sym.n == 3
  assert sym.has['abc'] == 1
  assert sym.has['123'] == 2
  assert sym.mode == '123'
  assert sym._most == 2