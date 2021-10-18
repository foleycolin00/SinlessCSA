# Homework 7: Control the World
 
## 7: Learn a Good Policy
```
r = 30:
p = 12, far = 0.541, samples = 383, enough =  0.417, cohen = 0.344, bins =  0.654, support = 3.039, weight = 2050.0, acceleration = 17.3, mpg =  40.0, N+ = 29

r = 60:
p = 20, far = 0.741, samples = 144, enough = 0.425, cohen = 0.337, bins = 0.237, support = 4.509, weight = 2085.0, acceleration = 21.7, mpg = 40.0, N+ = 5

r = 125:
p = 20, far =  0.651, samples = 807, enough = 0.248, cohen = 0.826, bins = 0.228, support = 2.933, weight = 2085.0, accleration =  21.7, mpg = 40.0, N+ = 5

r = 250:
p = 25, far =  0.967, samples = 378, enough = 0.28, cohen = 0.714, bins = 0.252, support = 2.821, weight = 2085.0, accleration = 21.7, mpg = 40.0, N+ = 7

r = 500:
p = 9, far = 0.711, samples = 244, enough = 0.292, cohen = 0.717, bins = 0.296, support = 1.886, weight = 2085.0, acceleration = 21.7, mpg = 40.0, N+ = 5

r = 1000: 
p = 25, far = 0.632, samples = 791, enough = 0.651, cohen = 0.504, bins = 0.319, support = 2.091, weight = 2085.0, acceleration = 21.7, mpg = 40.0, N+ = 7
```

## 8: Report 

### 1. What were the run times of your optimizer as you increased r?
Full Run:
```
30:  1990.0  14.9    30.0    149 -- Time: 6.56468 seconds
60:  2085.0  21.7    40.0    5   -- Time: 19.597611 seconds
125: 2085.0  21.7    40.0    5   -- Time: 43.793017 seconds
250: 2085.0  21.7    40.0    7   -- Time: 93.028207 seconds
500:  2085.0  21.7    40.0    5  -- Time: 191.865732 seconds
1000: 2085.0  21.7    40.0    7  -- Time: 213.375214 seconds
```

Exclusive Optimized Tree Run: 
```
30:  1990.0  14.9    30.0    149 -- Time: 0.0070180000000004 seconds 
60:  2085.0  21.7    40.0    5   -- Time: 0.038853 seconds
125: 2085.0  21.7    40.0    5   -- Time: 0.145539 seconds
250: 2085.0  21.7    40.0    7   -- Time: 0.64523299999999 seconds
500: 2085.0  21.7    40.0    5   -- Time: 1.766591 seconds
1000: 2085.0  21.7    40.0    5  -- Time: 2.17581 seconds
```
### 2. Does Hyperparameter optimization change a learner's behavior?

Yes, hyperparameter optimizaton changes the learner's behavior by searching for the hyperparameters that create the best output for some desired metric. Changing the learner's output is changing the behavior of the learner.

### 3. Does Hyperparameter optimization improve a learner's behavior?
When compared to the best leaf previous to incorporating hyperparameter optimization, [ 2098.2 16.8 35.6 ], the hyperparameter optimization improved the best leaf.

It should improve the learner's behavior, at least for the dataset the hyperparameter optimization was done for.

### 4. Does the Villalobos hypothesis hold for car design? If not, how many random staggers do you suggest?

The Villalobos hypothesis does hold. After 60 runs, we receive more or less the same best leaf. More runs may report different leafs that zitler more or less deems identical, but for the most part it settles on [2085.0 21.7 40] starting from 60 or 125 runs and onward.

Although, it could be that we favor one set of values over another. For example, when run twice and looking at the 60 run, we get the following 2 outputs. But we would argue that the first is better than the second. It has lower dimensions for the distance calculation (4 vs 26), a higher value for far (0.923 vs 0.54), etc. On almost all values, due to domain knowledge of the hyperparameters, the first set looks much more reasonable. So we would recommend do multiple runs at the 60 and then choose the most reasonable.

![first_screenshot](https://user-images.githubusercontent.com/89092830/137640903-6c3fdaef-a003-4d4e-8998-65ddcb599d6d.png)

![second screenshot](https://user-images.githubusercontent.com/89092830/137644570-35e2b297-b925-44c4-a026-e73bfde784b7.png)
