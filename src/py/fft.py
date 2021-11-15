from config import *
from discretization import *
from copy import deepcopy
from branch import *
from sample import *
from prune import *
from compact import *

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
  def __init__(self, sample, level=0, prune = False):
    self.sample = sample
    self.trees = [] # the branches
    self.leaves =  [] # the leaves
    
    #Baseball trees should be three times as long
    if Config.BASEBALLTREES:
      Config.FFTLength = Config.BaseballFFTLength
    
    self.FFThelper(sample, sample, [], level)

    #prune here as an option
    if Config.PRUNETREES:
      Prune.pruneBranches(self.trees)

    if Config.COMPACTPRINT:
      Compact.printCompact(self.trees) 

    self.best = self.getBest()
    self.bestPath = self.getBestPath()
    
  '''
  Helper class
  '''
  def FFThelper(self, remaining, sample, branch, stop = None, level=0, goodStrikes = [], badStrikes = []):
    if Config.BASEBALLTREES and level == 0:
      goodStrikes = [0 for i in range(len(remaining.rows))]
      badStrikes = [0 for i in range(len(remaining.rows))]
      
    if not stop:
      stop = len(sample.rows)**Config.FFTstop   # stopping coding
    
    #use the discretize method to get all of our options
    if level == 0 or not Config.DISCLESS:
      if Config.BINARYCHOPS:
        self.discs = remaining.binaryChops()
      else:
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
      gStrikes = goodStrikes[:]
      bStrikes = badStrikes[:]
      leaf,tree = sample.clone(), sample.clone()
      i = 0
      for row in remaining.rows:
        if Config.BASEBALLTREES:
          if not idea.matches(row) or (Config.SPILLTREES and idea.closeMatches(row, sample.cols)):
            tree.add(row)
          
          if Config.SPILLTREES and idea.closeMatches(row, sample.cols):
            gStrikes.append(gStrikes[i])
            bStrikes.append(bStrikes[i])
        
          if idea.matches(row) or (Config.SPILLTREES and idea.closeMatches(row, sample.cols)):
            if yes:
              gStrikes[i]+=1
            if no:
              bStrikes[i]+=1
            if (yes and gStrikes[i] == Config.BaseballStrikes) or (no and bStrikes[i] == Config.BaseballStrikes):
              if not Config.SPILLTREES and idea.closeMatches(row, sample.cols):
                gStrikes.pop(i)
                bStrikes.pop(i)
              leaf.add(row)
              i-=1
            else:
              tree.add(row)         
        else:
          if idea.matches(row):
            leaf.add(row)
            if Config.SPILLTREES:
              tree.add(row)
          else:
            tree.add(row)
            if Config.SPILLTREES:
              leaf.add(row)
        i+=1
      branch1  = deepcopy(branch)
      
      #Do not add if the split leaves either the tree or the leaf with 0 nodes, just stop
      if len(tree.rows) != 0 and (len(leaf.rows) != 0 or Config.BASEBALLTREES):
        branch1 += [Branch(typ = yes, level= level, leaf = deepcopy(leaf), at=idea.at, disc = idea)]
        
        #different branches for prune trees
        #if Config.PRUNETREES:
          #branch1 += [Branch(typ = yes, level= level, leafList = leaf, at=idea.at, disc = idea)]

      
      if len(tree.rows) == 0: # if this break just leaves nothing left
        branch1  += [Branch(typ = yes, level= level, leaf = deepcopy(leaf), at=idea.at)] # make a final leaf
        
        #different branches for prune trees
        #if Config.PRUNETREES:
         # branch1 += [Branch(typ = yes, level= level, leafList = leaf, at=idea.at, disc = idea)]

        self.trees.append(branch1)
      elif len(tree.rows) <= stop or level >= Config.FFTLength or (len(leaf.rows) == 0 and not Config.BASEBALLTREES): #if it hits stopping criteria
        branch1  += [Branch(typ = no, level= level, leaf = deepcopy(tree), at=idea.at)] # make a final leaf
       
        #different branches for prune trees
        #if Config.PRUNETREES:
         # branch1 += [Branch(typ = yes, level= level, leafList = leaf, at=idea.at, disc = idea)]

        self.trees.append(branch1)
      else:
        self.FFThelper(tree, sample, branch1,stop,level+1, gStrikes, bStrikes)
  
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
      arr =  sorted(discs, key=lambda d: Fft.countMatches(d, rows) ** (d.best**Config.support / (d.best+d.rest)))[::-1]
    elif method == Discretization.DiscMethod.MINIMIZE:
      arr = sorted(discs, key=lambda d: Fft.countMatches(d, rows) ** (d.best**Config.support / (d.best+d.rest)))[::-1]
    else:
      arr = sorted(discs, key=lambda d: 1 / (d.best+d.rest))
    return arr
  
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
    bestPath = ""
      
    i = 0
    for tree in self.trees: 
      for branch in tree:
        bestPath += str(branch) + "\n"
        if bestString in bestPath:
          return bestPath
      bestPath = ""
    return None