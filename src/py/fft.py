from config import *
from discretization import *
from copy import deepcopy
from branch import *
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
  def __init__(self, remaining, sample, branch, stop = None, level=0):
    self.trees = []
    self.generateFFT(remaining, sample, branch, stop, level)
    
  '''
  Helper class
  '''
  def generateFFT(self, remaining, sample, branch, stop = None, level=0):
    if not stop:
      stop = stop or 2*(len(sample.rows)**Config.bins)   # stopping coding
    
    #use the discretize method to get all of our options
    discs = remaining.discretize()
    
    bestIdea = Fft.sortDiscs(discs, Discretization.DiscMethod.MAXIMIZE)[-1]
    worstIdea = Fft.sortDiscs(discs, Discretization.DiscMethod.MINIMIZE)[-1]
    for yes,no,idea in [(1,0,bestIdea), (0,1,worstIdea)]: # build 2 trees
      leaf,tree = sample.clone(), sample.clone()
      for row in remaining.rows:
        (leaf if idea.matches(row) else tree).add(row) # match the rows to leaf, tree
      branch1  = deepcopy(branch)
      branch1 += [Branch(typ = yes, level= level, mid = str(leaf), n = len(leaf.rows), disc = idea)]
      #if len(tree.rows) <= stop:
      if len(tree.rows) <= stop or level >= 3:
        branch1  += [Branch(typ = no, level= level, mid = str(leaf), n = len(leaf.rows))] # make a final leaf
        self.trees.append(branch1)
      else:
        self.generateFFT(tree, sample, branch1,stop=stop,level=level+1)
  
  def sortDiscs(discs, method):
    '''def best(d, s):
      count = 0
      for row in s.rows:
        if d.matches(row):
          count+=1
      return count
    def rest(d, s):
      return len(s.rows)-best(d, s)'''
      
    if method == Discretization.DiscMethod.MAXIMIZE:
      return sorted(discs, key=lambda d: d.best**Config.support / (d.best+d.rest))
    elif method == Discretization.DiscMethod.MINIMIZE:
      return sorted(discs, key=lambda d: d.rest**Config.support / (d.best+d.rest))
    else:
      return sorted(discs, key=lambda d: 1 / (d.best+d.rest))