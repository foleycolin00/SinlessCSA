'''
Class for holding discretizations created for decision trees
'''
class Discretization:
  
  '''
  Initilization for the Discretization class
  '''
  def __init__(self, at, name, lo, hi, best, rest):
    self.at = at
    self.name = name
    self.lo = lo
    self.hi = hi
    self.best = best
    self.rest = rest
  
  def __str__(self):
    return str(f"{{:at {self.at}, :name {self.name}, :lo {self.lo}, :hi {self.hi}, :best {self.best}, :rest {self.rest}}}")