from branch import * 
from discretization import *
import numpy as np

'''
Class that handles pruning
'''

  # a <= x
  # b <= y
  # where y > x

  # a >= x
  # b >= y
  # where y < x

  # x <= a <= w
  # y <= b <= z
  # where y < x
  # where z > w

  # we dont care about == because output is too specific to merge and requires more changes
  # the changes would be too distinct, the rules stand on their own so to speak

  # would a following item flip sign? probably dont care about y <= a <= x
  # a <= x
  # b >= y

  # a >= x
  # b <= y
  # x <= a <= y



  # x <= a <= y
  # a <= z
  
  # x <= a <= z
  
#tree is a list of branches 
class Prune:    
    def pruneBranches(trees):

        # [ a, b, c, d, e]
        for tree in trees:
            i = 0
            while(i != (len(tree) - 1)):
                j = i + 1
                branch1 = tree[i]
                branch2 = tree[j]
                if branch1.disc and branch2.disc: 
                    if branch1.typ == branch2.typ and branch1.disc.name == branch2.disc.name and (branch1.disc.first == branch2.disc.first or branch1.disc.last == branch2.disc.last):
                        if branch1.disc.lo != branch1.disc.hi and branch2.disc.lo != branch2.disc.hi:
                            print()
                            print(str(branch1))
                            print(str(branch2))
                    
                            for z in branch2.leaf.rows:
                                branch1.leaf.add(z)
                            
                            branch1.mid = str(branch1.leaf)
                            branch1.n = len(branch1.leaf.rows)

                            if branch1.disc.first:
                                branch1.disc.hi = branch2.disc.hi
                            else:
                                branch1.disc.lo = branch2.disc.lo

                            tree.pop(j)
                            #need to update the levels 
                            print(str(tree[i]))
                            print()
                i+=1            
        

                


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