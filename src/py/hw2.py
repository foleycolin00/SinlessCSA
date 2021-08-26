'''Reads in a CSV file
Parses it
Prints errors for the bad lines
:param file the file to read
:return an array of arrays containing all of the valid rows'''
def readCSV(file):
  array = []
  with open(file, 'r') as reader:
  
    lines = reader.readlines()
    i = 0
    headers = None
    
    while i < len(lines):
      line = lines[i]
    
      #clear the comments
      line = line[:line.find('#')] + "\n"
      
      #remove all whitespace
      line = line.replace(' ', '')
      line = line.replace('\n', '')
      
      #dont print empty lines
      if len(line) > 0:
      
        #break each line on comma, continue onto next line
        if line[-1] == ',':
          lines[i+1] = line + lines[i+1]
        else:
          
          #Parse the commas
          split = line.split(',')
          
          #Create the Header template
          if (headers == None):
            headers = split
            
            #Remove any ignored columns
            result = []
            for col in split:
              if '?' not in col:
                result.append(col)
            array.append(result)
            
          else:
            row = []
            
            #Check for errors
            errors = False
            
            #Incorrect number of cells
            if len(headers) != len(split):
              print(f'Error on line {i}: incorrect number of cells')
              
            for j in range(len(headers)):
            
              #Should be number
              if headers[j][0].isupper():
                if not isNumber(split[j]):
                  errors = True
                  print(f'Error on line {i}: string where number should be')
              
              #Remove any ignored columns
              if '?' not in headers[j]:
                row.append(split[j])
                
            
            if not errors:
              array.append(split)
      
      i+=1
  return array

'''Returns if the string is a number (int/float)
:param num: the string
:return: if the string is a number'''
def isNumber(num):
  try:
    return True
  except ValueError:
    try: 
      return True
    except ValueError:
      return False

array = readCSV("hw2.csv")
for line in array:
  for value in line:
    print(value, end = ",")
  print()
