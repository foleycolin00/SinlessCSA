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
  def __init__(self, sample, level=0):
    self.sample = sample
    self.trees = [] # the branches
    self.leaves =  [] # the leaves
    
    #Baseball trees should be three times as long
    if Config.BASEBALLTREES:
      Config.FFTLength = 6
    
    self.FFThelper(sample, sample, [], level)
    self.best = self.getBest()
    self.bestPath = self.getBestPath()
    
  '''
  Helper class
  '''
  def FFThelper(self, remaining, sample, branch, stop = None, level=0, yesStrikes = [], noStrikes = []):
    if Config.BASEBALLTREES and level == 0:
      yesStrikes = [0 for i in range(len(remaining.rows))]
      noStrikes = [0 for i in range(len(remaining.rows))]
      
    if not stop:
      stop = len(sample.rows)**Config.FFTstop   # stopping coding
    
    #use the discretize method to get all of our options
    if level == 0 or not Config.DISCLESS:
      self.discs = remaining.discretize()
    else:
      #Remove discs that do not sort anything
      for d in self.discs:
          if Fft.countMatches(d, remaining.rows) == 0:
            self.discs.remove(d)
    
    if len(self.discs) == 0:
      return
    
    #Sort the discs
    if Config.SHORTTREES:
      bestIdea = Fft.sortDiscsShort(self.discs, Discretization.DiscMethod.MAXIMIZE, remaining.rows)[-1]
      worstIdea = Fft.sortDiscsShort(self.discs, Discretization.DiscMethod.MINIMIZE, remaining.rows)[-1]
    else:
      bestIdea = Fft.sortDiscs(self.discs, Discretization.DiscMethod.MAXIMIZE)[-1]
      worstIdea = Fft.sortDiscs(self.discs, Discretization.DiscMethod.MINIMIZE)[-1]
    
    for yes,no,idea in [(1,0,bestIdea), (0,1,worstIdea)]: # build 2 trees
      yStrikes = yesStrikes[:]
      nStrikes = noStrikes[:]
      leaf,tree = sample.clone(), sample.clone()
      i = 0
      for row in remaining.rows:
        # print(i)
        # print(len(strikes))
        # print("\n")
        if Config.BASEBALLTREES:
          if idea.matches(row):
            if yes:
              yStrikes[i]+=1
            if no:
              nStrikes[i]+=1
            if (yes and yStrikes[i] == 3) or (no and nStrikes[i] == 3):
              yStrikes.pop(i)
              nStrikes.pop(i)
              leaf.add(row)
              i-=1
            else:
              tree.add(row)
          else:
            tree.add(row)
        else:
          (leaf if idea.matches(row) else tree).add(row) # match the rows to leaf, tree
        i+=1
      branch1  = deepcopy(branch)
      
      #Do not add if the split leaves either the tree or the leaf with 0 nodes, just stop
      if len(tree.rows) != 0 and (len(leaf.rows) != 0 or Config.BASEBALLTREES):
        branch1 += [Branch(typ = yes, level= level, mid = str(leaf), n = len(leaf.rows), disc = idea)]
      
      if len(tree.rows) == 0: # if this break just leaves nothing left
        branch1  += [Branch(typ = yes, level= level, mid = str(leaf), n = len(leaf.rows))] # make a final leaf
        self.trees.append(branch1)
      elif len(tree.rows) <= stop or level >= Config.FFTLength or (len(leaf.rows) == 0 and not Config.BASEBALLTREES): #if it hits stopping criteria
        branch1  += [Branch(typ = no, level= level, mid = str(tree), n = len(tree.rows))] # make a final leaf
        self.trees.append(branch1)
      else:
        self.FFThelper(tree, sample, branch1,stop,level+1, yStrikes, nStrikes)
  
  '''
  Helper to count number of matches for a disc
  '''
  def countMatches(d, rows):
    count = 0
    for r in rows:
      if d.matches(r):
        count+=1
    return count
    
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
  Helper sort method for discs created by discretization for SHORTTREES
  '''
  def sortDiscsShort(discs, method, rows):
    arr = None
    if method == Discretization.DiscMethod.MAXIMIZE:
      arr =  sorted(discs, key=lambda d: d.best**Config.support / (d.best+d.rest))[::-1]
    elif method == Discretization.DiscMethod.MINIMIZE:
      arr = sorted(discs, key=lambda d: d.best**Config.support / (d.best+d.rest))[::-1]
    else:
      arr = sorted(discs, key=lambda d: 1 / (d.best+d.rest))
    
    arr = arr[0:Config.ShortTreesNum]
    return sorted(discs, key=lambda d: Fft.countMatches(d, rows))
  
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
        if not Config.BASEBALLTREES or not '?' in b.mid: #baseball trees have a lot of blanks
          arr = b.mid.replace("]", "").replace("[", "").split(", ")
          for i in range(len(arr)):
            arr[i] = round(float(arr[i]), Config.Round)
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