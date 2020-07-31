%% CapSA (Capuchin Swarm Algorithm)
% Citation details:
% Braik, Malik, Alaa Sheta, and Heba Al-Hiary. "A novel meta-heuristic search algorithm for solving 
% optimization problems: capuchin search algorithm.
% " Neural Computing and Applications (2020): 1-33

% Programmed by Malik Braik & Prof. Alaa Sheta
% Al-Balqa Applied University (BAU) %
% Date of programming: 2020 %
% -------------------------------------------------
% This demo only implements a standard version of CapSA for a minimization problem 
% of a standard test function on MATLAB (R2018).
% -------------------------------------------------	
% Note:
% Due to the stochastic nature of meta-heuristc algorithms, 
% different runs may produce slightly different results.
function [fFitness,CapuchinPositions,cg_curve]=CapSA(noP,maxite,LB,UB,dim,fobj)
 
warning off;

format longe;

if size(UB,1)==1
    UB=ones(dim,1)*UB;
    LB=ones(dim,1)*LB;
end
 
% CSA main program
 
f1 =  figure (1);
set(gcf,'color','w');
hold on
xlabel('Iteration','interpreter','latex','FontName','Times','fontsize',10)
ylabel('fitness value','interpreter','latex','FontName','Times','fontsize',10); 
grid;
 
cg_curve=zeros(1,maxite);

%% % CSA initialization

%Initialize the positions of Capuchins

CapuchinInitPositions=initialization(noP,dim,UB,LB);


CapuchinPositions=CapuchinInitPositions;% initial population
 
v=0.1*CapuchinInitPositions;% initial velocity
 
v0=1.0*v;

% Calculate the fitness of initialCapuchins
% 
for i=1:noP
     CapuchinFitness(i,1)=fobj(CapuchinInitPositions(i,:));
end
%  

[arranged_Capuchins_fitness,arranged_indexes]=sort(CapuchinFitness);

for newindex=1:noP
    arranged_Capuchins(newindex,:)=CapuchinPositions(arranged_indexes(newindex),:);
end

gFoodPosition=arranged_Capuchins(1,:);
fFitness=arranged_Capuchins_fitness(1);

CapuchinBestPosition=CapuchinInitPositions;% initial CapuchinBestPosition

%% % CSA Parameters
 
bf=0.70;%Balance factor
cr=9;  %Modulus of elasticity
prob=0.5;
g=9.81;

% CSA velocity updates
a1=1.0; a2=1.0;   
%  cf=0.70;

beta=[2 21 2];
wmax=0.9;
wmin=0.1;
%% % CSA Main loop

t=1; % Start from the first iteration

while t<=maxite

% Life time convergence
tau = beta(1) * exp(-beta(2) * ((t)/maxite)^beta(3));

 w=wmax-(wmax-wmin)*(t/maxite)^2; 
% CSA velocity update
for i=1:noP   
      v(i,:)=  w* v(i,:) +tau*a1*(CapuchinPositions(i,:)-CapuchinBestPosition(i,:))*rand + ...
                                                       tau*a2*(gFoodPosition-CapuchinPositions(i,:))*rand;
end

% CSA position update

for i=1:noP
   if i<noP/2
   for j=1:dim
        r=rand();
        if  (r>=0.1)
          if  (r<=prob)  % Global search
             if (r<=0.2)
                 CapuchinPositions(i,j) =  gFoodPosition(j)+   1*bf*((v(i,j).^2)*sin(2*rand()*1.5))/g;  % Jumping (Projection)       
             elseif (r>0.2 && r<=0.30)
                  CapuchinPositions(i,j) =  gFoodPosition(j)+   1*cr*bf*((v(i,j).^2)*sin(2*rand()*1.5))/g;  % Jumping (Land)  
             else    
                  CapuchinPositions(i,j) =    CapuchinPositions(i,j) + 1*v(i,j); % Movement on the ground
             end               
           elseif (r<=0.75 && r>prob)
                 CapuchinPositions(i,j) =      gFoodPosition(j) +  tau*bf*1*sin(rand()*1.5);   % Swing % Local search  
          elseif (r>0.75 )
                CapuchinPositions(i,j) =       gFoodPosition(j) +  tau*bf*(v(i,j)-v0(i,j));    % Climbing   % Local search
          end
        else
                CapuchinPositions(i,j)=   1.0*tau*((UB(j)-LB(j))*rand+1*LB(j));  % Random allocation
                 
     end   
   end  

% Let the followers follow the leaders (update their positions)
elseif i>=noP/2 && i<=noP 
        alphaPos=CapuchinPositions(i-1,:);
        followerPos=CapuchinPositions(i,:);
        CapuchinPositions(i,:)=(alphaPos+followerPos)/2; 
   end
 end

v0 = v;

% check the boundaries
for i=1:noP
    for j=1:dim
        if CapuchinPositions(i,j)<LB(j)
            CapuchinPositions(i,j)=LB(j);
        elseif CapuchinPositions(i,j)>UB(j)
                CapuchinPositions(i,j)=UB(j);
        end
    end
end    
 
for i=1:noP

        CapuchinFitness(i,1)=fobj(CapuchinPositions(i,:));
            
          if CapuchinFitness(i,1)<fFitness
               CapuchinBestPosition(i,:)=CapuchinPositions(i,:);
               fFitness=CapuchinFitness(i,1); 

               % finding out the best capuchin
                [~,index]=min((CapuchinFitness));
                gFoodPosition=CapuchinPositions(index,:);
               end
end
   
   % Display the iterative results

     outmsg = ['Iteration# ', num2str(t) , '  Fitness= ' , num2str(fFitness)];
        disp(outmsg);
   
    % Obtain the convergence curve
     cg_curve(t)=fFitness;
    
 if t>2
     set(0, 'CurrentFigure', f1)

        line([t-1 t], [cg_curve(t-1) cg_curve(t)],'Color','b'); 
        xlabel('Iteration');
        ylabel('Best score obtained so far');
        drawnow 
 end
  
    t=t+1;
    
end
fFitness ;
end