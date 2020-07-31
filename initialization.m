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
%__________________________________________
function pos=initialization(noP,dim,ub_,lb_)

% number of boundaries
BoundNo= size(ub_,1); 

% If the boundaries of all variables are equal and user enters one  number for both ub_ and lb_

if BoundNo==1
    pos=rand(noP,dim).*(ub_-lb_)+lb_;
end

% If each variable has different ub_ and lb_

if BoundNo>1
    for i=1:dim
        ubi=ub_(i);
        lbi=lb_(i);
        pos(:,i)=rand(noP,1).*(ubi-lbi)+lbi;
    end
end