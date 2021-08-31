'''
Class for resevoir sampling
'''
class Some:
  '''
  Initializes the variables
  n = counter of things seen so far
  at = column index
  name = column name
  _all = current sample
  :param most: the most values in the sample
  '''
  def __init__(self, most = 256):
    self.most = most
    self.n = 0
    self.at = 0
    self.name = ''
    self._all = []
    self._sorted = True
  
  '''
  Adds a value to the col
  :param x: the value to add
  '''
  def add(self, x):
    if x != '?':
      self.n += 1
      #if the length is less than the max length, add to the end
      if len(self._all) < self.most:
        self._sorted = False
        self._all[len(self._all) + 1] = x
      #else, randomly replace a value, less likely the more values we have
      elif random.random() < len(self._all)/self.n:
        self._sorted = False
        self._all[math.floor(random.random()*len(self._all)+1)]