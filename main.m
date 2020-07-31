%_________________________________________________________________________________
%  %% CapSA (Capuchin Swarm Algorithm) source codes version 1.0
%
%  Developed in MATLAB R2019a
%
%  Author and programmer: Malik Braik
%
%         e-Mail: m_fjo@yahoo.com
%                 mbraik@bau.edu.jo 
%
%       Homepage: https://www.researchgate.net/profile/Malik_Braik
%
%   Main paper:
%       Braik, Malik & Sheta, Alaa & Al-Hiary, Heba. (2020).
%       " A novel meta-heuristic search algorithm for solving optimization problems: 
%       capuchin search algorithm," Neural Computing and Applications, July 2020.
%%        
%         @article{Braik_2020,
%         doi = {10.1007/s00521-020-05145-6},
%         url = {https://doi.org/10.1007%2Fs00521-020-05145-6},
%         year = 2020,
%         month = {jul},
%         publisher = {Springer Science and Business Media {LLC}},
%         author = {Malik Braik and Alaa Sheta and Heba Al-Hiary},
%         title = {A novel meta-heuristic search algorithm for solving optimization problems: capuchin search algorithm},
%         journal = {Neural Computing and Applications}
%         }
% You can simply define your cost in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% nVar number of Variables to optimize
% noP number of indvidual
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers
% To run CapSA: [bestFitness, bestPosition, CSAConvCurve] = CapSA(noP,maxIter,lb,ub,nVar,fobj); 
%
%__________________________________________
 
clc
clear 
close all
set(0,'defaultTextInterpreter','latex');             % drawing default
extraInputs = {'interpreter','latex','fontsize',14}; % latex interpreter
%% % Prepare the problem
nVar = 2;
ub   =  50 * ones(1, 2);
lb   = -50 * ones(1, 2);
fobj = @Objfun;

%% % CSA parameters 
noP     = 30;
maxIter = 1000;

%% % call CSA
[bestFitness, bestPosition, CSAConvCurve] = CapSA(noP,maxIter,lb,ub,nVar,fobj); % Standard CSA

%-----------------------------------------------------
%% % Draw the objective space
%-----------------------------------------------------
figure (1);  set(gcf,'color','w');
plot(CSAConvCurve,'LineWidth',2,'Color','b'); grid;
title({'Objective space','(Convergence characteristic)'},extraInputs{:});
xlabel('Iteration',extraInputs{:})
ylabel('Best score obtained so far',extraInputs{:}); 

axis tight; grid on; box on 
     
h1 = legend('CapSA','location','northeast');
set(h1,'interpreter','Latex','FontName','Times','FontSize',10) 
ah = axes('position',get(gca,'position'),...
            'visible','off');
%-----------------------------------------------------
%% The convergence values of the best parameters
% are stored in the bestPosition to draw if necessary
%-----------------------------------------------------

figure (2);
subplot(211); plot(bestPosition(:,1),'LineWidth',2,'Color','b'); grid;
title({'Convergence of $a_1$'},extraInputs{:});
xlabel('Iteration',extraInputs{:})
subplot(212); plot(bestPosition(:,1),'LineWidth',2,'Color','b'); grid;
title({'Convergence of $a_2$'},extraInputs{:});
xlabel('Iteration',extraInputs{:})

%-----------------------------------------------------
%% Display the optimal values
%-----------------------------------------------------

disp(['The best solution obtained is ', num2str(bestPosition(end,:))]);
disp(['The best objective funciton is ', num2str(bestFitness)]);





