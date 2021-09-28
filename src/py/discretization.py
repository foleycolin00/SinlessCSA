from enum import *
from config import *
'''
Class for holding discretizations created for decision trees
'''
class Discretization:
  
  class DiscMethod(Enum):
    MAXIMIZE = 1
    MINIMIZE = 2
    NOVEL = 3
  
  '''
  Initilization for the Discretization class
  '''
  def __init__(self, at, name, lo, hi, best, rest, first, last):
    self.at = at
    self.name = name
    self.lo = lo
    self.hi = hi
    self.best = best
    self.rest = rest
    self.first = first
    self.last = last
  
  def __str__(self):
    return str(f"{{:at {self.at}, :name {self.name}, :lo {self.lo}, :hi {self.hi}, :best {self.best}, :rest {self.rest}, :first {self.first}, :last {self.last}}}")
  
  def show(self):
    if self.lo == self.hi: return f"{self.name} == {self.lo}"
    elif self.first: return f"{self.name} <= {self.hi}"
    elif self.last : return f"{self.name} >= {self.lo}"
    else: return f"{self.lo} <= {self.name} <= {self.hi}"
  
  def matches(self, row):
    v=row[self.at]
    if   v=="?"   : return True
    elif self.first: return v <= self.hi
    elif self.last : return v >= self.lo
    else          : return self.lo <= v <= self.hi