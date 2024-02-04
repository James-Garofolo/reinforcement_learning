% Define the function use epsilon-greedy strategy

function [episode_return] = epsilon_greedy(T,p_a,N,r,epsilon)
Q_a = zeros(1,N);
N_a = zeros(1,N);
reward_matrix = zeros(N,T); 
episode_return = 0;

for k=1:T
    p_exploration = rand;
    if p_exploration <= epsilon % conduct exploration at this trial
        a_k = randi([1,4]);     % randomly selected action following uniform distribution
        p_action_success = rand;
        N_a(a_k) = N_a(a_k) + 1;
        if p_action_success < p_a(a_k)  % trial successful
            if k == 1
                Q_a(a_k) = (1/N_a(a_k))*r;
                reward_matrix(a_k,k) = r;
                episode_return = episode_return + r;
            else
                reward_tmp = 0;
                for tau = 1:k-1
                    reward_tmp = reward_tmp + reward_matrix(a_k,tau);
                end
                Q_a(a_k) = (1/N_a(a_k))*(r+reward_tmp);
                reward_matrix(a_k,k) = r;
                episode_return = episode_return + r;
            end
        else                %trial failed
            if k == 1
                Q_a(a_k) = 0;
            else
                reward_tmp = 0;
                for tau = 1:k-1
                    reward_tmp = reward_tmp + reward_matrix(a_k,tau);
                end
                Q_a(a_k) = (1/N_a(a_k))*(reward_tmp);
            end
        end
    else        % select the action with the maximum action value at this trial
        maxValue = max(Q_a);
        maxIndices = find(Q_a == maxValue);
        a_k = maxIndices(randi(length(maxIndices)));
        p_action_success = rand;
        N_a(a_k) = N_a(a_k) + 1;
        if p_action_success < p_a(a_k)  % trial successful
            if k == 1
                Q_a(a_k) = (1/N_a(a_k))*r;
                reward_matrix(a_k,k) = r;
                episode_return = episode_return + r;
            else
                reward_tmp = 0;
                for tau = 1:k-1
                    reward_tmp = reward_tmp + reward_matrix(a_k,tau);
                end
                Q_a(a_k) = (1/N_a(a_k))*(r+reward_tmp);
                reward_matrix(a_k,k) = r;
                episode_return = episode_return + r;
            end
        else                %trial failed
            if k == 1
                Q_a(a_k) = 0;
            else
                reward_tmp = 0;
                for tau = 1:k-1
                    reward_tmp = reward_tmp + reward_matrix(a_k,tau);
                end
                Q_a(a_k) = (1/N_a(a_k))*(reward_tmp);
            end
        end
    end
end