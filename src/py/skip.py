'''
Skip class
Always does nothing on add
'''
class Skip:

  '''
  Initializes the variables
  n = counter of things seen so far
  :param at: column index
  :param name: column name
  '''
  def __init__(self, at = 0, name = ''):
    self.n  = 0
    self.at = at
    self.name = name

  '''
  Adds a value to the col
  :param x: the value to add
  '''
  def add(self, x):
    if x != '?':
      self.n += 1
  
  '''
  Gets the mid value of the col
  :return :
  '''
  def mid(self):
    return "?"