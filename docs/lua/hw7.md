# Homework 7: Control the World

## 1: Hyperparameters 

### Binary Interger Converter
```
We use the lua tonumber() method. ex. tonumber(11101) will give us 29.
```
### Other Hyperparameters
```
    local o = { name = 'default',
                p = 12,--2,
                far = 0.8,--0.9,
                samples = 600,--128,
                enough = 0.58,--0.5,
                cohen = 0.53,--0.3,
                bins = 0.54,--0.5,
                support = 3.4}--2}
```
## 2: Control your hyperparameter
```
    if fileName then
      for hyper_param in tools:csv(fileName) do
        local split_param = tools:stringToTable(hyper_param[1], '=')
        o[split_param[1]] = tonumber(split_param[2]) or split_param[2]
      end
    end
    
    return o
```

## 3: Mutator of Hyperparameters 
```
function settings:random()
  -- random is range + base, use // 1 to truncate to integer, add 1 to range when doing so
  local setting = self:new()
  setting.p = tools:randi(1, 20)--tools:randi(2, 2)--tools:randi(1, 10) -- 1-6 inclusive
  setting.far = tools:rand(0.6, 0.99)--tools:rand(0.9, 0.9)--tools:rand(0.2, 1) -- 0.1-0.9 inclusive
  setting.samples = tools:randi(64, 1024)--tools:randi(256, 256)--tools:randi(64, 512) -- 64-512
  setting.enough = tools:rand(0.5, 0.9)--tools:rand(0.5, 0.5)--tools:rand(0.5, 1) -- 0.1-0.9
  setting.cohen = tools:rand(0.1, 3)--tools:rand(0.3, 0.3)--tools:rand(0.1, 2) -- 0.1-0.9
  setting.bins = tools:rand(0.5, 0.9)--tools:rand(0.5, 0.5)--tools:rand(0.5, 0.9) -- dies at less than 0.5
  setting.support = tools:rand(1, 5)--tools:rand(2, 2)--tools:rand(0.1, 10) -- 0.5-5
  return setting
end
```

## 4: Make your code crash reliant
```
```

## 5: Adjust the FFT code 

## 6: Random Stagger 

## 7: Learn a good policy 

## 8: Report 

### 1. What were the run times of your optimizer as you increased r?

### 2. Does Hyperparameter optimization change a learner's behavior?

### 3. Does Hyperparameter optimization improve a learner's behavior?

### 4. Does the Villabos hypothesis hold for car design? If not, how many random staggers do you suggest?