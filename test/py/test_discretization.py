from discretization import *

'''test function for init'''
def testInit():
  d = Discretization(1, "abc", 0.0, 100.0, 2, 3)
  assert str(d) == "{:at 1, :name abc, :lo 0.0, :hi 100.0, :best 2, :rest 3}"