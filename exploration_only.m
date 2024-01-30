% Define the function use exploration strategy

function [episode_return] = exploration_only(T,p_a,r)
episode_return = 0;
for k = 1:T
    a_k = randi([1,4]);     % randomly selected action following uniform distribution
    p_action_success = rand;
    if p_action_success < p_a(a_k)  % trial successful
        episode_return = episode_return + r;
    end
end