from enum import *
from config import *
from readCSV import *
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
  
  #Note that after the prune class was made; there was a type error that was introduced that i used convertNumber() from the readCSV file to get around! 
  def matches(self, row):
    v=row[self.at]
    if   v=="?"   : return True
    elif self.first: return convertNumber(v) <= convertNumber(self.hi)
    elif self.last : return convertNumber(v) >= convertNumber(self.lo)
    else          : return convertNumber(self.lo) <= convertNumber(v) <= convertNumber(self.hi)
    
  def closeMatches(self, row, cols):
    if not self.name[0].isupper(): #not for sym
      return
    v=cols[self.at].norm(row[self.at])
    high = cols[self.at].norm(self.hi)
    low = cols[self.at].norm(self.lo)
    
    if   v=="?"   : return False
    elif self.first: return abs(high-v) <= Config.SpillPercent
    elif self.last : return abs(low-v) <= Config.SpillPercent
    else          : return (abs(high-v) <= Config.SpillPercent) or (abs(low-v) <= Config.SpillPercent)