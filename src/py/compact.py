from branch import * 
from discretization import *
import numpy as np

'''
Class that handles compact printing 
'''

class Compact:
      
    def printCompact(trees):

        for tree in trees: 
            for branch in tree: 
                