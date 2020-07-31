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
function [ t ] = Objfun (y)
    t = sum ( abs(y) ) + prod( abs(y) );
end