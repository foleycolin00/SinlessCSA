from readCSV import *
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
  return isinstance(convertNumber(s), int) or isinstance(convertNumber(s), float)

'''
Returns whether the given string is a Weight (-1 if negative)
We must already know it is a goal
:param: s the string
:return: 1 if +, -1 if -
'''
def isWeight(s):
  return -1 if '-' in s else 1

'''
Returns whether the given string is a Klass (contains !)
:param: s the string
:return: boolean
'''
def isSkip(s):
  return '?' in s
