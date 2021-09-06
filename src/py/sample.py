from readCSV import *
from skip import *
from sym import *
from some import *
from num import *
import random
import math

'''
Returns whether the given string is a Klass (contains !)
:param: s the string
:return: boolean
'''
def isKlass(s):
  return '!' in s

'''
Returns whether the given string is a Goal (contains +/-/Klass)
:param: s the string
:return: boolean
'''
def isGoal(s):
  return '+' in s or '-' in s or isKlass(s)

'''
Returns whether the given string is a Number
:param: s the string
:return: boolean
'''
def isNum(s):
  return s[0].isupper()

'''
Returns whether the given string is a Klass (contains !)
:param: s the string
:return: boolean
'''
def isSkip(s):
  return '?' in s

'''
Class for a sample
'''
class Sample:
  
  '''
  Initialize the sample
  rows = rows as dict
  keep = ?
  cols = columns as dict
  name = the names of the columns
  x = list of x vars
  y = list of y vars
  klass = klass value
  '''
  def __init__(self, inits = []):
    self.rows = []
    self.keep = True
    self.cols = []
    self.names = []
    self.x = []
    self.y = []
    self.klass = None
    
    #initialize the values
    for value in inits:
      self.add(value)
  
  '''
  Adds a new row
  :param lst: the row to add
  '''
  def add(self, lst):
    self.header(lst) if len(self.names) <= 0 else self.data(lst)
  
  '''
  Adds the header
  :param lst: the row to add
  '''
  def header(self, lst):
    #save the names for cloning
    self.names = lst
    
    at = 0
    for name in lst:
      new = None
      #find the right type
      if isSkip(name):
        new = Skip(at, name)
      elif isNum(name):
        new = Num(at, name)
      else:
        new = Sym(at, name)
      
      #add to the cols
      self.cols.append(new)
      
      if not isSkip(name):
        if isGoal(name):
          self.y.append(new)
        else:
          self.x.append(new)
      at+=1
  
  '''
  Adds the data
  :param lst: the row to add
  '''
  def data(self, lst):
    #add to each of the cols
    for c in self.cols:
      c.add(lst[c.at])
    
    if self.keep:
      self.rows.append(lst)
  
  '''
  Reads in from a csv file
  Uses readCSV from HW2
  :param f: the file to read
  '''
  def read(self, f):
    for row in readCSV(f):
      self.add(row)
      
  '''
  Query to get the better row using Zitler's continuous domination indicator
  "row1 is better than row2"
  :param row1: the first row
  :param row2: the second row
  :return: the comparison
  '''
  def better(self, row1, row2):
    s1 = 0
    s2 = 0
    n = len(self.y)
    e = 2.71828
    
    for col in self.y:
      w = col.w
      x = col.norm(row1[col.at])
      y = col.norm(row2[col.at])
      s1 = s1 - math.pow(e, w * (x-y)/n)
      s2 = s2 - math.pow(e, w * (y-x)/n)
    #"row1 is better than row2"
    return s1/n < s2/n
  
  '''
  Compare function using better
  "row1 is better than row2"
  :param row1: the first row
  :param row2: the second row
  :return: the comparison
  '''
  def betterCompare(self, row1, row2):
    #if row1 is better than row2, then no switch is needed
    if self.better(row1, row2):
      return -1
    else:
      return 1