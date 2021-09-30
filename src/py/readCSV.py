import time
import os

'''Reads in a CSV file
Parses it
Prints errors for the bad lines
:param file: the file to read
:return: an array of arrays containing all of the valid rows'''
def readCSV(file):
  with open(file, 'r') as reader:
    lines = reader.readlines()
    i = 0
    headers = None
    
    while i < len(lines):
      line = lines[i]
    
      #clear the comments
      if '#' in line:
        line = line[:line.find('#')]# + "\n"
      
      #remove all whitespace
      line = line.replace(' ', '')
      line = line.replace('\n', '')
      line = line.replace('\t', '')
      
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
            
            yield result
          else:
            row = []
            
            #Check for errors
            errors = False
            
            #Incorrect number of cells
            if len(headers) != len(split):
              print(f'Error on line {i}: incorrect number of cells')
              errors = True
            else:  
              for j in range(len(headers)):
                #Remove any ignored columns
                if '?' not in headers[j]:
                  #Should be number
                  if headers[j][0].isupper():
                    split[j] = convertNumber(split[j])
                    if not isinstance(split[j], int) and not isinstance(split[j], float) and split[j] != '?':
                      errors = True
                      print(f'Error on line {i}: string where number should be')
                      print(headers[j])
                      print(split[j])
                  row.append(split[j])   
            if not errors:
              yield row
      i+=1

'''Convert the string to a number
:param num: the string
:return: the number or string as a result'''
def convertNumber(num):
  try:
    return int(num)
  except ValueError:
    try: 
      return float(num)
    except ValueError:
      return str(num)