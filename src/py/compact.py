from branch import * 
from discretization import *
import numpy as np

'''
Class that handles compact printing 
'''

class Compact:
      
    def printCompact(trees):
        n = 0
        typHolder = 0
        first = True

        for tree in trees: 
            for branch in tree: 
                #get first typ
                if first: 
                    typHolder = branch.typ
                    first = False

                    
                if branch.typ == typHolder: 
                    print( " " + str(branch))
                else: 
                    print("  " + str(branch))
                n+=1

                
            print()
            n+=1  
