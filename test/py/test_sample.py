from sample import *
from num import *
from skip import *
from sym import *
import functools

'''Test function isKlass'''
def testIsKlass():
  assert isKlass('!')
  assert isKlass('abc!')
  assert isKlass('!abc')
  
  assert not isKlass('123')
  assert not isKlass('')
  
'''Test function isGoal'''
def testIsGoal():
  assert isGoal('+')
  assert isGoal('abc+')
  assert isGoal('+abc')
  assert isGoal('-')
  assert isGoal('abc-')
  assert isGoal('-abc')
  assert isGoal('-123')
  assert isGoal('!')
  assert isGoal('abc!')
  assert isGoal('!abc')
  
  assert not isGoal("123")
  assert not isGoal("")
  
'''Test function isNum'''
def testIsNum():
  assert isNum("Number")
  
  assert not isNum("notanumber")
  
'''Test function isSkip'''
def testIsSkip():
  assert isSkip('?')
  assert isSkip('abc?')
  assert isSkip('?abc')
  
  assert not isSkip('123')
  assert not isSkip('')

'''Test function Sample.init'''
def testSampleInit():
  s = Sample()
  assert s.rows == []
  assert s.keep == True
  assert s.cols == []
  assert s.names == []
  assert s.x == []
  assert s.y == []
  assert s.klass == None

'''Test function Sample.add'''
def testSampleAdd():
  s = Sample()
  names = ['1', "a?", "B-"]
  s.add(names)
  
  assert len(s.cols) == 3
  assert len(s.rows) == 0
  assert len(s.x) == 1
  assert len(s.y) == 1
  assert s.names == names
  
  s1 = Sample([names])
  assert len(s1.cols) == 3
  assert len(s1.rows) == 0
  assert len(s1.x) == 1
  assert len(s1.y) == 1
  assert s1.names == names
  
  s.add(['b', 'c', 4])
  assert len(s.cols) == 3
  assert len(s.rows) == 1
  assert len(s.x) == 1
  assert len(s.y) == 1
  assert s.names == names

'''Test function better'''
def testSampleBetter():
    s = Sample([["abc", "A+", "def"]])
    s.add(["a", 1, "a"])
    s.add(["b", 2, "b"])
    assert s.better(s.rows[1], s.rows[0])
    assert not s.better(s.rows[0], s.rows[1])
    
    s = Sample([["abc", "A-", "def"]])
    s.add(["a", 1, "a"])
    s.add(["b", 2, "b"])
    assert not s.better(s.rows[1], s.rows[0])
    assert s.better(s.rows[0], s.rows[1])
    
    s = Sample([["abc", "A+", "def"]])
    s.add(["a", 1, "a"])
    s.add(["b", 2, "b"])
    s.rows.sort(key=functools.cmp_to_key(s.rowCompare))
    assert s.rows[0][0] == "b"
    assert s.rows[1][0] == "a"

'''Test function dist'''
def testSampleDist():
  s = Sample([["abc", "A+", "def"]])
  s.add(["a", 0, "a"])
  s.add(["b", 1, "b"])
  
  assert s.dist(["a", 0, "a"], ["a", 0, "a"]) == 0
  assert s.dist(["a", 0, "a"], ["b", 1, "b"]) == 1
  assert s.dist(["b", 1, "b"], ["a", 0, "a"]) == 1
  assert s.dist(["a", 1, "a"], ["a", 0, "a"]) == pow(1/3, 1/2)

'''Test function neighbors'''
def testSampleNeighbors():
  s = Sample([["abc", "A+", "def"]])
  s.add(["a", 0, "a"])
  s.add(["b", 1, "b"])
  
  a = s.neighbors(["a", 0, "a"])
  assert a[0][1] == ["b", 1, "b"]
  
  a = s.neighbors(["a", 0, "a"], [["b", 1, "b"]])
  assert len(a) == 1
  assert a[0][1] == ["b", 1, "b"]
  
'''Test function faraway'''
def testSampleFaraway():
  s = Sample()
  myPath = os.path.dirname(os.path.abspath(__file__))
  myPath = myPath[:myPath.rindex("/")]
  myPath = myPath[:myPath.rindex("/")]
  s.fromFile(myPath + "/data/auto93.csv")
  
  random.seed(0)
  
  f = s.faraway(s.rows[0])
  assert round(s.rows.index(f)/len(s.rows), 1) == .9

'''Test function divs'''
def testSampleDivs():
  s = Sample()
  myPath = os.path.dirname(os.path.abspath(__file__))
  myPath = myPath[:myPath.rindex("/")]
  myPath = myPath[:myPath.rindex("/")]
  s.fromFile(myPath + "/data/auto93.csv")
  
  random.seed(0)
  
  leafs = s.divs()
  
  for leaf in leafs:
    assert len(leaf.rows) == 12 or len(leaf.rows) == 13