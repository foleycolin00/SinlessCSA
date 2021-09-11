from some import *
from readCSV import *

'''
 Num class
 '''
class Num:

  '''
  Returns whether the given string is a Weight (-1 if negative)
  We must already know it is a goal
  :param: s the string
  :return: 1 if +, -1 if -
  '''
  def getWeight(self):
    return -1 if '-' in self.name else 1

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
  def __init__(self, at = 0, name = ''):
    self.some = Some()
    self.n  = 0
    self.at = at
    self.name = name
    self.lo = 1e32
    self.hi = -1e32
    self.mu = self.m2 = self.sd = 0
    self.w = self.getWeight()

  '''
  Adds a value to the col
  :param x: the value to add
  '''
  def add(self, x):
    if x != '?':
      x = convertNumber(x)
      self.some.add(x)
      self.n +=1
      d = x - self.mu
      self.mu = self.mu + ( d/self.n)
      self.m2 = self.m2 + ( d* (x - self.mu) )
      self.sd = 0 if (self.m2<0 or self.n<2) else pow(self.m2/( self.n - 1 ), .5 )
      self.lo = min(x, self.lo)
      self.hi = max(x, self.hi)
  
  '''
  Normalizes the value x for the range lo .. hi
  :param x: the value to normalize
  :return: the value normalized
  '''
  def norm(self, x):
    if x == '?':
      return x
    else:
      return (x-self.lo) / (self.hi - self.lo + 1e-32)
  
  '''
  Distance function
  :param x: the first value
  :param y: the second value
  :return: the distance
  '''
  def dist(self, x,y):
    if x == '?':
      y = self.norm(y)
      if y>.5:
        x = 0
      else:
        x = 1
    elif y == '?':
      x = self.norm(x)
      if x>.5:
        y = 0
      else:
        y = 1
    else:
      x = self.norm(x)
      y = self.norm(y)
    return abs(x-y)

