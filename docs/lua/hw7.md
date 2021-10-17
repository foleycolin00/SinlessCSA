# Homework 7: Control the World

## 8: Report 

### 1. What were the run times of your optimizer as you increased r?
```
30:  1990.0  14.9    30.0    149 -- Time: 6.56468 seconds
60:  2085.0  21.7    40.0    5   -- Time: 19.597611 seconds
125: 2085.0  21.7    40.0    5   -- Time: 43.793017 seconds
250: 2085.0  21.7    40.0    7   -- Time: 93.028207 seconds
500: 2085.0  21.7    40.0    5   -- Time: 191.865732 seconds
1000: Killed
```
### 2. Does Hyperparameter optimization change a learner's behavior?

Yes, hyperparameter optimizaton changes the learner's behavior by choosing the best magic numbers to create the most accurate predicitons. 

### 3. Does Hyperparameter optimization improve a learner's behavior?
When compared to the best leaf previous to incorporating hyperparameter optimization, [ 2098.2 16.8 35.6 ], the hyperparameter optimzation improved the best leaf.

### 4. Does the Villabos hypothesis hold for car design? If not, how many random staggers do you suggest?

The Villalobos hypothesis does hold. After 60 runs, we recieve more or less the same best leaf. 