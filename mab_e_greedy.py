import numpy as np
from tqdm import tqdm

# This code is used to determine the average return from epison-greedy strategy
#significance_multiplier = 200
#T = 100*significance_multiplier # Total number of trials.
T = 100
runs = 1000
N = 4 # Number of machines.
r = 1 # Reward of a success trial.
epsilon = 1 # define the parameter of epsilon for epsilon-greedy algorithm
p_a = [0.3,0.5,0.2,0.8]
total_returns = []

for _ in tqdm(range(runs)):
    Q_a = np.zeros((N))
    N_a = np.zeros((N))
    reward_matrix = np.zeros((N,T))
    total_return = 0
    for k in range(T):
        p_exploration = np.random.rand()
        if p_exploration <= epsilon: # conduct exploration at this trial
            a_k = np.random.randint(0,4) # randomly selected action following uniform distribution
            p_action_success = np.random.rand()
            N_a[a_k] += 1
            if p_action_success < p_a[a_k]: # trial successful
                if k == 1:
                    Q_a[a_k] = (1/N_a[a_k])*r
                    reward_matrix[a_k,k] = r
                    total_return = total_return + r
                else:
                    reward_tmp = 0
                    for tau in range(1,k-1):
                        reward_tmp = reward_tmp + reward_matrix[a_k,tau]
                    
                    Q_a[a_k] = (1/N_a[a_k])*(r+reward_tmp)
                    reward_matrix[a_k,k] = r
                    total_return = total_return + r
                
            else: #trial failed
                if k == 1:
                    Q_a[a_k] = 0
                else:
                    reward_tmp = 0
                    for tau in range(1,k-1):
                        reward_tmp = reward_tmp + reward_matrix[a_k,tau]
                    
                    Q_a[a_k] = (1/N_a[a_k])*(reward_tmp)
                
            
        else: # select the action with the maximum action value at this trial
            maxValue = np.max(Q_a)
            maxIndices = np.argwhere(Q_a == maxValue)
            a_k = maxIndices[np.random.randint(0,len(maxIndices))][0]
            p_action_success = np.random.rand()
            N_a[a_k] += 1
            if p_action_success < p_a[a_k]: # trial successful
                if k == 1:
                    Q_a[a_k] = (1/N_a[a_k])*r
                    reward_matrix[a_k,k] = r
                    total_return = total_return + r
                else:
                    reward_tmp = 0
                    for tau in range(1,k-1):
                        reward_tmp = reward_tmp + reward_matrix[a_k,tau]
                    
                    Q_a[a_k] = (1/N_a[a_k])*(r+reward_tmp)
                    reward_matrix[a_k,k] = r
                    total_return = total_return + r
                
            else: #trial failed
                if k == 1:
                    Q_a[a_k] = 0
                else:
                    reward_tmp = 0
                    for tau in range(1,k-1):
                        reward_tmp = reward_tmp + reward_matrix[a_k,tau]
                    
                    Q_a[a_k] = (1/N_a[a_k])*(reward_tmp)
    

    total_returns.append(total_return)

total_return = np.mean(np.array(total_returns))
print(total_return, 80-total_return)