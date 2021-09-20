from some import *
from readCSV import *
from config import *
from discretization import *

def variance(i):
  i = [x[1] for x in i]
  arr = [i.count(0), i.count(1)]
  
  if arr[0] == 0 or arr[1] == 0:
    return 0
  
  e = 0
  for v in arr:
     p= v/len(i)      # probability of wanting it
     w= math.log(p,2) # how hard to find it (via binary chop)
     e= e - p*w
  return e

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
  Gets all of the values
  '''
  def _all(self):
    return self.some._all
    
  '''
  Returns the variance
  '''
  def var(self):
    return self.sd

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
  
  '''
  Median function
  :return: the mid value
  '''
  def mid(self):
    temp = self.some.getAll()
    middle = math.floor(len(temp)/2)
    if len(temp) % 2 == 1:
      return float(temp[middle])
    else:
      return (temp[middle] + temp[middle - 1]) / 2
  
  '''
  Discretize values
  :param i: 
  :param j: 
  '''
  def discretize(self, i, j):
    best, rest = 1,0
    # list of (number, class)
    xys=[(good,best) for good in i._all()] + [ (bad, rest) for bad  in j._all()]
    #
    # find a minimum break span (.3 * expected value of standard deivation)
    n1,n2 = len(i._all()), len(j._all())
    iota = Config.cohen * (i.var()*n1 + j.var()*n2) / (n1 + n2)
    #
    # all the real work is in unsuper and merge... which is your problem
    ranges = self.merge(self.unsuper(xys, len(xys)**Config.bins, iota))
    # 
    if len(ranges) > 1:  
      for r in ranges:
        rx = [t[0] for t in r]
        ry = [t[1] for t in r]
        yield Discretization(at=i.at, name=i.name, lo=sorted(rx)[0], hi=sorted(rx)[-1], 
                best= ry.count(1), rest=ry.count(0))
  
  '''
  Unsuper function
  :return: list of ranges in the values
  '''
  def unsuper(self, xys, binsize, iota):
    xys.sort(key=lambda s:s[0])
    split = []
    i, j = 0, 0
    while i < len(xys) - 1 and len(xys) - i > binsize:
      if (
        #It cannot break ranges uness the i-th+1 value is different to the i-th value
        ( j >= len(xys) - 1 or xys[j][0] != xys[j + 1][0]) and 
        #It cannot break unless the break contains more than iota items
        abs(i-j) > iota and
        #It cannot break unless there are enough items (sqrt(N)) after the break (so we can break some more, latter)
        len(xys) - 1 - j > binsize
      ):
        temp = []
        for k in range(i, j + 1):
          temp.append(xys[k])
        split.append(temp)  
        i = j + 1
        j = i + 1
      elif j < len(xys):
        j+=1
      else:
        i+=1
    #final left
    temp = []
    for k in range(i, len(xys)):
      temp.append(xys[k])
    split.append(temp)  
    
    return split
  
  '''
  Merge function
  :return: merge of ranges if possible
  '''
  def merge(self, ranges):
    i = 0
    while i < len(ranges)-1:
      a = ranges[i]
      b = ranges[i+1]
      c = a+b
      
      if variance(c)*.95 <= (variance(a)*len(a) + variance(b)*len(b))/(len(a) + len(b)):
        ranges[i+1] = ranges[i] + ranges[i+1]
        ranges.pop(i)
      else:
        i+=1
    return ranges