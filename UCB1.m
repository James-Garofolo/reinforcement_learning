% Define the function use UCB1 strategy

function [episode_return] = UCB1(T,p_a,N,r)
Q_a = zeros(1,N);          % initialize the action-value for each machine
N_a = zeros(1,N);          % initialize the selection number for each machine
U_a = zeros(1,N);          % initialize the upper confidence bound value for each machine
reward_matrix = zeros(N,T); 
episode_return = 0;

for k=1:T
    if k == 1    % consider the first trial, randomly select one the machines
        a_k = randi([1,4]);     % randomly selected action following uniform distribution
        p_action_success = rand;
        N_a(a_k) = N_a(a_k) + 1;
        if p_action_success < p_a(a_k)  % trial successful
            Q_a(a_k) = (1/N_a(a_k))*r;   % update the action-value
            reward_matrix(a_k,1) = r;
            episode_return = episode_return + r;
        end
    else
        UCB_a = Q_a + U_a;    % add the Q-value and U-value together
        maxValue = max(UCB_a);   
        maxIndices = find(UCB_a == maxValue);
        a_k = maxIndices(randi(length(maxIndices)));
        p_action_success = rand;
        N_a(a_k) = N_a(a_k) + 1;
        if p_action_success < p_a(a_k)  % trial successful
            reward_tmp = 0;
            for tau = 1:k-1
                reward_tmp = reward_tmp + reward_matrix(a_k,tau);
            end
            Q_a(a_k) = (1/N_a(a_k))*(r+reward_tmp);
            for j=1:N
                U_a(j) = sqrt((2*log(k))/N_a(j));
            end
            reward_matrix(a_k,k) = r;
            episode_return = episode_return + r;
        else    % trial failed
            reward_tmp = 0;
            for tau = 1:k-1
                reward_tmp = reward_tmp + reward_matrix(a_k,tau);
            end
            Q_a(a_k) = (1/N_a(a_k))*(reward_tmp);
            for j=1:N
                U_a(j) = sqrt((2*log(k))/N_a(j));
            end
        end
    end
end







