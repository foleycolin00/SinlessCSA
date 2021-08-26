def readCSV(file):
  with open('dog_breeds.txt', 'r') as reader:
    for line in reader.readlines():
      print(line, end='')

def testReadCSV():

readCSV("hw2.csv")
