from config import *
'''
Class for holding branches created for decision trees
'''
class Branch:
  
  '''
  Initilization for the Discretization class
  '''
  def __init__(self, typ, level, leaf, at, disc = None):
    self.typ = typ
    self.level = level
    self.at = at
    self.leaf = leaf
    self.mid = str(self.leaf)
    self.n = len(self.leaf.rows)
    self.disc = disc

  
  def __str__(self):
    if self.disc:
      return str(f"{self.typ} {'if' if self.level == 0 else 'elseif' if self.disc else 'else'} {self.disc.show()} then {self.mid} ({self.n})")
    else:
      return str(f"{self.typ} {'if' if self.level == 0 else 'elseif' if self.disc else 'else'} {self.mid} ({self.n})")