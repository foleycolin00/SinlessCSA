from config import *
'''
Class for holding branches created for decision trees
'''
class Branch:
  
  '''
  Initilization for the Discretization class
  '''
  def __init__(self, typ, level, mid, n, at, disc = None):
    self.typ = typ
    self.level = level
    self.mid = mid
    self.n = n
    self.at = at
    
    self.disc = disc

    #added variables for pruning 
  
  def __str__(self):
    if self.disc and not Config.PRUNETREES:
      return str(f"{self.typ} {'if' if self.level == 0 else 'elseif' if self.disc else 'else'} {self.disc.show()} then {self.mid} ({self.n})")
    elif Config.PRUNETREES:
       return str("yeehaw")
    else:
      return str(f"{self.typ} {'if' if self.level == 0 else 'elseif' if self.disc else 'else'} {self.mid} ({self.n})")