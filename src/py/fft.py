from config import *
from discretization import *
from copy import deepcopy
from branch import *
from sample import *
'''
Class for Fast and Frugal Tree
'''
class Fft():

  '''
  Initilize the FFT tree
  :param remaining: the remaining values in the tree
  :param sample: the entire tree
  :param branch: the branch you are on
  :param branches: the list of all branches
  :param stop: the stop parameter
  :param level: the level of the tree
  '''
  def __init__(self, remaining, sample, branch, level=0):
    self.sample = sample
    self.tree = [] # the branches
    self.leaves =  [] # the leaves
    
    self.FFThelper(remaining, sample, branch)
    self.best = self.getBest()
    self.bestPath = self.getBestPath()
    
  '''
  Helper class
  '''
  def FFThelper(self, remaining, sample, tree, stop = None, level=0):
    if not stop:
      stop = len(sample.rows)**Config.FFTstop   # stopping coding
    
    #use the discretize method to get all of our options
    discs = remaining.discretize()
    
    yes = int(Config.FFTType[level])
    no = abs(yes-1)
    idea = None
    if yes == 1:
      idea = Fft.sortDiscs(discs, Discretization.DiscMethod.MAXIMIZE)[-1]
    else:
      idea = Fft.sortDiscs(discs, Discretization.DiscMethod.MINIMIZE)[-1]
    
    leaf,other = sample.clone(), sample.clone()
    for row in remaining.rows:
      (leaf if idea.matches(row) else other).add(row) # match the rows to leaf, tree
    #branch1  = deepcopy(branch)
    tree += [Branch(typ = yes, level= level, mid = str(leaf), n = len(leaf.rows), disc = idea)]
    self.leaves.append(leaf.mid()+[len(leaf.rows)])
    
    #Stop if we reach too far or past the tree level
    if len(other.rows) <= stop or level >= Config.FFTLength - 2: #end two before the end, not a magic number
      tree  += [Branch(typ = no, level= level, mid = str(leaf), n = len(leaf.rows))] # make a final leaf
      self.leaves.append(leaf.mid()+[len(leaf.rows)])
      self.tree = tree
    else:
      self.FFThelper(other, sample, tree,stop=stop,level=level+1)
  
  '''
  Helper sort method for discs created by discretization
  '''
  def sortDiscs(discs, method):
    if method == Discretization.DiscMethod.MAXIMIZE:
      return sorted(discs, key=lambda d: d.best**Config.support / (d.best+d.rest))
    elif method == Discretization.DiscMethod.MINIMIZE:
      return sorted(discs, key=lambda d: d.rest**Config.support / (d.best+d.rest))
    else:
      return sorted(discs, key=lambda d: 1 / (d.best+d.rest))
  
  '''
  Gets the best leaf from the FFT tree
  '''
  def getBest(self):
    #create the sample for sorting
    names = []
    for y in self.sample.y:
      names.append(y.name)
    s = Sample([names+["N+"]])
    
    for l in self.leaves:
      s.add(l)
    
    #sort the leaves
    s.rows.sort(key=functools.cmp_to_key(s.rowCompare))
    
    #return the best one
    return s.rows[0]
 
  '''
  Gets the string for the best path for the tree
  '''
  def getBestPath(self):
    bestString = f"{self.best}"
    #Get the best string with out the N+ row
    bestString = bestString[:bestString.rfind(',')]+"]"
    bestPath = ""
      
    i = 0
    while bestString not in bestPath:
      bestPath += str(self.tree[i])
      i+=1
    return bestPath