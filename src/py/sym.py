from discretization import *

'''
 Sym class
 '''
class Sym:

  '''
  Initializes the variables
  n = counter of things seen so far
  has = dictionary of values
  mode = most common symbol
  _most = frequency of most seen symbol
  :param at: column index
  :param name: column name
  '''
  def __init__(self, at=0, name = ''):
    self.at = at
    self.name = name
    self.n = 0
    self.has = {}
    self.mode = ''
    self._most = 0
    
  '''
  Adds a symbol to this col
  :param x: the symbol to add
  '''
  def add(self, x):
    if x != '?':
      self.n += 1
      if x in self.has.keys():
        self.has[x] = self.has[x] + 1
      else:
        self.has[x] = 1
      if self.has[x] > self._most:
        self._most, self.mode = self.has[x], x
  
  '''
  Distance function between two symbols
  :param x: the first symbol
  :param y: the second symbol
  :return: 0 if equal and 1 if not
  '''
  def dist(self, x,y):
    if x == y:
      return 0
    else:
      return 1
  
  '''
  Median function
  :return: the mid value
  '''
  def mid(self):
    return self.mode
  
  '''
  Discretize values
  :param i: 
  :param j: 
  '''
  def discretize(self, i, j):
    ittr = i.has
    ittr.update(j.has)
    for x in ittr:
      yield Discretization(i.at, i.name, x, x, i.has.get(x,0), j.has.get(x,0), False, False)