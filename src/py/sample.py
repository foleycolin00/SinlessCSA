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
    self.data(lst) if len(self.names) > 0 else self.header(lst)
  
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
