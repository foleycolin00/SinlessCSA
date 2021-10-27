import random
import numpy as np
import math
'''
Class for all of the configurations/hyperparameters
'''
class Config:
  #Time
  DISCLESS = False
  SHORTTREES = False
  ShortTreesNum = 5
  #Impermanence
  BASEBALLTREES = False
  BaseballStrikes = 3
  BaseballFFTLength = 15
  SPILLTREES = False
  SpillPercent = .01
  #Explainability
  BINARYCHOPS = False
  PRUNETREES = False

  bins =  .5            #Min bin size n**bins for discretize
  enough = .5           #Min size for divs creating creating leafs using gausian projections
  far = .9              #Where to look for far things
  FFTstop = .5          #Minimum size of the last leaf in FFT, calculated by n**FFTstop
  FFTLength = 5         #FFT Length
  iota = .3             #Minimum break span for discretization = sd * iota
  mergeVariance = .95   #Max variance needed to merge for discretization
  p = 2                 #Distance calculation exponent for rows
  samples = 128         #number of neighbors to explore
  support = 2           #support for discretization scoring a range for sort
  
  verbose = True        #Set verbose
  Round = 2
  
  #Min, Max(inclusive), Step
  bins_range = [0.1, .9, .1]
  enough_range = [0.1, .9, .1]
  far_range = [.5, .99, .05]
  FFTstop_range = [0, .9, .1]
  FFTLength_range = [2, 10, 1]
  iota_range = [.1, .9, .1]
  mergeVariance_range = [.5, .99, .05]
  p_range = [2, 10, 1]
  samples_range = [5, 10, 1] #2**x
  support_range = [2, 10, 1]
  
  def generate(v):
    #Get the range of the attr
    ranges = getattr(Config, v + '_range')
    
    #Create the range of choices
    choices = np.arange(ranges[0], ranges[1], ranges[2])
    choices = np.append(choices, ranges[1])
    
    #Round to near values
    if isinstance(ranges[2], int):
      choices = choices.astype(int)
    else:
      choices = np.around(choices, 2)
    
    if ranges[1] / ranges[2] == math.floor(ranges[1] / ranges[2]):
      choices = np.append(choices, ranges[1])
    
    #Set the attribute
    setattr(Config, v, random.choice(choices))
      
    if Config.verbose:
      print(f"{v}: {getattr(Config, v)}")
  
  def generateAll(variables = ['bins', 'enough', 'far', 'FFTstop', 'FFTLength', 'iota', 'mergeVariance', 'p', 'samples', 'support']):
    for v in variables:
      Config.generate(v)
  
  def getAsArray(variables = ['bins', 'enough', 'far', 'FFTstop', 'FFTLength', 'iota', 'mergeVariance', 'p', 'samples', 'support']):
    arr = []
    line = []
    for v in variables:
      line.append(getattr(Config, v))
    arr.append(variables)
    arr.append(line)
    return arr