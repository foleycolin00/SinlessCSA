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
    self.trees = [] # the branches
    self.leaves =  [] # the leaves
    
    self.FFThelper(remaining, sample, branch, level)
    self.best = self.getBest()
    self.bestPath = self.getBestPath()
    
  '''
  Helper class
  '''
  def FFThelper(self, remaining, sample, branch, stop = None, level=0):
    if not stop:
      stop = len(sample.rows)**Config.FFTstop   # stopping coding
    
    #use the discretize method to get all of our options
    discs = remaining.discretize()
    
    if len(discs) == 0:
      print("ERROR: Issue with Discretization")
      return
    
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
        self.FFThelper(tree, sample, branch1,stop=stop,level=level+1)
  
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
    
    for f in self.trees:
      for b in f:
        arr = b.mid.replace("]", "").replace("[", "").split(", ")
        for i in range(len(arr)):
          arr[i] = round(float(arr[i]), 2)
        s.add(arr + [b.n])
    
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
    print(bestString)
    bestPath = ""
      
    i = 0
    for tree in self.trees: 
      for branch in tree:
        bestPath += str(branch) + "\n"
        if bestString in bestPath:
          return bestPath
      bestPath = ""
    return None