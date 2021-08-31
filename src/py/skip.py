'''
Skip class
Always does nothing on add
'''
class Skip:

  '''
  Initializes the variables
  n = counter of things seen so far
  at = column index
  name = column name
  '''
  def __init__(self):
    self.n  = 0
    self.at = 0
    self.name = ""

  '''
  Adds a value to the col
  :param x: the value to add
  '''
  def add(self, x):
    if x != '?':
      self.n += 1