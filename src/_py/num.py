from some import *

'''
 Num class
 '''
class Num:
  '''
  Initializes the variables
  some = resevoir
  n = counter of things seen so far
  lo = lowest value
  hi = highest value
  mu = greek letter mu
  m2 = ?
  sd = standard deviation
  w = weight
  :param at: column index
  :param name: column name
  '''
  def __init__(self, at=0, name=''):
    self.some = Some()
    self.n  = 0
    self.at = at
    self.name = name
    self.lo = 1e32
    self.hi = -1e32
    self.mu = self.m2 = self.sd = 0
    self.w = isWeight(name)

  '''
  Adds a value to the col
  :param x: the value to add
  '''
  def add(self, x):
    if x != '?':
      self.some.add(x)
      self.n +=1
      d = x - self.mu
      self.mu = self.mu + ( d/self.n)
      self.m2 = self.m2 + ( d* (x - self.mu) )
      self.sd = 0 if (self.m2<0 or self.n<2) else ( (self.m2/( self.n - 1 )) ^.5 )
      self.lo = min(x, self.lo)
      self.hi = max(x, self.hi)
