from branch import * 
from discretization import *
import numpy as np

'''
Class that handles pruning
'''
#tree is a list of branches 
class Prune:    
    def pruneBranches(tree):

        # [ a, b, c, d, e]

        for i in range(0, len(tree) - 1):
            j = i + 1
            branch1 = tree[i]
            branch2 = tree[j]

            if branch1.typ == branch2.typ and branch1.name == branch2.name:
                print(str(branch1))
                print(str(branch2))
            




        '''
        collecTyp = []
        collectDisc = []
        collectRelation = []
        collectNum = []

        for branch in tree:
            # collect type
            collecTyp.append(branch.typ)
            
            #collect col
            if branch.disc != None:
                collectDisc.append(branch.disc.name)
            
            #collect relational operator
            if '<=' in str(branch):
                collectRelation.append('<=')
            if '==' in str(branch):
                collectRelation.append('==')
            if '>=' in str(branch):
                collectRelation.append(">=")
            
            #collect number 
            if branch.disc != None: 
                collectNum.append(branch.disc.show())
            

                
            print(str(branch))
        zipped = list(zip(collecTyp, collectDisc, collectRelation, collectNum))
        print(zipped)

        '''


        #if the first element in zipped is a typ,col,relation match to any other element in zipped, then if should be considered
    
        '''
        for branch in zipped:
            print("first element ", zipped[0][:-1])
            print("compare ", branch[:-1])

            #if keyword is repeated
            if zipped[0][:-1] in branch[:-1]:
                print("match")
        '''