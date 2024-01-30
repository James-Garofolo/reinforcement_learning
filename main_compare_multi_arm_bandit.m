clear all

% This code is used to compare different strategies

M = 1000;   % Total number of episodes
T = [50,100,200,300,400,500,1000,10000];    % Total number of trials for a single episode
p_a = [0.3,0.5,0.2,0.8];  % the winning probability of each machine
N = length(p_a);      % Number of machines.
r = 1;      % Reward of a success trial.
epsilon = [0.01,0.1,0.2,1];  % define the parameter of epsilon for epsilon-greedy algorithm

for ii=1:length(T)
    Optimal_return = 0.8*T(ii);

    Final_return_exploration_only = 0;
    Final_return_exploitation_only = 0;
    Final_return_epsilon_greedy_1 = 0;
    Final_return_epsilon_greedy_2 = 0;
    Final_return_epsilon_greedy_3 = 0;
    Final_return_epsilon_greedy_4 = 0;
    Final_return_UCB1 = 0;
    for jj=1:M
        Final_return_exploration_only = Final_return_exploration_only + exploration_only(T(ii),p_a,r);
        Final_return_exploitation_only = Final_return_exploitation_only + exploitation_only(T(ii),p_a,N,r);
        Final_return_epsilon_greedy_1 = Final_return_epsilon_greedy_1 + epsilon_greedy(T(ii),p_a,N,r,epsilon(1));
        Final_return_epsilon_greedy_2 = Final_return_epsilon_greedy_2 + epsilon_greedy(T(ii),p_a,N,r,epsilon(2));
        Final_return_epsilon_greedy_3 = Final_return_epsilon_greedy_3 + epsilon_greedy(T(ii),p_a,N,r,epsilon(3));
        Final_return_epsilon_greedy_4 = Final_return_epsilon_greedy_4 + epsilon_greedy(T(ii),p_a,N,r,epsilon(4));
        Final_return_UCB1 = Final_return_UCB1 + UCB1(T(ii),p_a,N,r);
    end
    Average_return_exploration_only = Final_return_exploration_only/M;
    Average_return_exploitation_only = Final_return_exploitation_only/M;
    Average_return_epsilon_greedy_1 = Final_return_epsilon_greedy_1/M;
    Average_return_epsilon_greedy_2 = Final_return_epsilon_greedy_2/M;
    Average_return_epsilon_greedy_3 = Final_return_epsilon_greedy_3/M;
    Average_return_epsilon_greedy_4 = Final_return_epsilon_greedy_4/M;
    Average_return_UCB1 = Final_return_UCB1/M;

    Ratio_exploration_only(ii) = Average_return_exploration_only/Optimal_return;
    Ratio_exploitation_only(ii) = Average_return_exploitation_only/Optimal_return;
    Ratio_epsilon_greedy_1(ii) = Average_return_epsilon_greedy_1/Optimal_return;
    Ratio_epsilon_greedy_2(ii) = Average_return_epsilon_greedy_2/Optimal_return;
    Ratio_epsilon_greedy_3(ii) = Average_return_epsilon_greedy_3/Optimal_return;
    Ratio_epsilon_greedy_4(ii) = Average_return_epsilon_greedy_4/Optimal_return;
    Ratio_UCB1(ii) = Average_return_UCB1/Optimal_return;
end

plot(T,Ratio_exploration_only,'--m*',T,Ratio_exploitation_only,'-.k^',T,Ratio_epsilon_greedy_1,'-.bp',T,Ratio_epsilon_greedy_2,'-g+',...
    T,Ratio_epsilon_greedy_3,':r>',T,Ratio_epsilon_greedy_4,'-.b>',T,Ratio_UCB1,'-r<');
xlabel('Number of trials');
ylabel('Ratio to the optimal strategy');
grid on;
lgd = legend('exploration only','exploitation only','epsilon-greedy with 0.01','epsilon-greedy with 0.1','epsilon-greedy with 0.2','epsilon-greedy with 1','UCB1');
%fontsize(lgd,14,'points')
axis([50 10000 0.5 1]);
        

