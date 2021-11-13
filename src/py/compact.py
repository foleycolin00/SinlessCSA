from branch import * 
from discretization import *
import numpy as np

'''
Class that handles compact printing 
'''

class Compact:

    #at each new typ it indents  
    def printCompact(trees):
        typHolder = -1
        first = True
        space = "  "
        for tree in trees:
            
            for branch in tree: 
                #get first typ
                if first: 
                    typHolder = branch.typ
                    first = False
                
                if branch.typ == typHolder: 
                    print(space + str(branch))
                else: 
                    space = space + "  "
                    print(space + str(branch))
                
                typHolder = branch.typ
            print()
            space = space.replace(" ", "")
            typHolder = -1
        
                
            
            
