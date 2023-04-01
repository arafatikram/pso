%    _________________________________________________________      %
%              PSO Algorithm source codes version 1.0               %
%                                                                   %
%       Developed in MATLAB R2021a(9.10.0.1602886)                  %
%       Programmer: Arafat Ibne Ikram                               %
%       e-Mail: arafatibne.ikram@gmail.com                          %
%       Homepage: https://github.com/arafatikram                    %
%       Reference Used: https://doi.org/10.1109/ICNN.1995.488968    %
%___________________________________________________________________%

function  results =pso_main(params)

noP=params.size;
iter=params.max_iter;
termination=params.termination;
total_run=params.total_run;


ub=params.ub;
lb=params.lb;
dim=params.dim;
fobj=params.fobj;

ub=ub*ones(1,dim);
lb=lb*ones(1,dim);

datavis=params.datavis;

% PSO paramters
Vmax = params.Vmax;
Vmin = params.Vmin; 
wMax = params.wMax; 
wMin = params.wMin;
c1 = params.c1; 
c2 = params.c2;

% Initializations
vel=zeros(noP,dim);
pBestScore=zeros(noP);
pBest=zeros(noP,dim);
gBest=zeros(1,dim);

for qq=1:total_run
    
    cg_curve=zeros(1,iter);
    
    % Random initialization for agents.
    pos=pso_initialization(noP,dim,ub,lb);
    
    for i=1:noP
        pBestScore(i)=inf;
    end
    
    % Initialize gBestScore for a minimization problem
    gBestScore=inf;
    
    
    for l=1:iter
        
        
        
        for i=1:size(pos,1)
            %Calculate objective function for each particle
            fitness=fobj(pos(i,:));
            
            %updating the individual best solutions
            if(pBestScore(i)>fitness)
                pBestScore(i)=fitness;
                pBest(i,:)=pos(i,:);
            end
            
            %updating the global best solutions
            if(gBestScore>fitness)
                gBestScore=fitness;
                gBest=pos(i,:);
            end
        end
        
        cg_curve(l)=gBestScore;
        
        %% Intertia Weight, Velocity, and Position Update
        %Update the W of PSO
        w=wMax-l*((wMax-wMin)/iter);
        %Update the Velocity and Position of particles
        for i=1:size(pos,1)
            for j=1:size(pos,2)
                %updating the velocity
                vel(i,j)=w*vel(i,j)+c1*rand()*(pBest(i,j)-pos(i,j))+c2*rand()*(gBest(j)-pos(i,j));
                
                % checking the boundary and returning back to the search space
                if(vel(i,j)>Vmax) || (vel(i,j)<-Vmax)
                    vel(i,j)=Vmin+rand*(Vmax-Vmin);
                else
                    vel(i,j)=vel(i,j);
                end
                
                %updating the positions
                pos(i,j)=pos(i,j)+vel(i,j);
                % checking the boundaries and returning to the search space
                if pos(i,j)<lb(j) || pos(i,j)>ub(j)
                    pos(i,j)=lb(j)+rand*(ub(j)-lb(j));
                else
                    pos(i,j)=pos(i,j);
                end
            end
        end
        %%
        disp(['Iter # ' , num2str(l),  ' Fitness # ', num2str(gBestScore)]);
        %% live Convergence curve
        if (datavis)
            figure(qq)
            plot(cg_curve(1:l), 'Color', '#A2142F', 'linewidth', 2 );
            grid on
            xlabel('generation');
            ylabel('best objective value');
            title(sprintf('RUN: %d, ITER: %d, EVAL: %d, OptimalValue: %0.4g',qq, l,l.*noP, cg_curve(l)));drawnow;
        end
        %%  Termination Criteria
        if l > 400     % +400 is taken to avoid early and unwanted mature
            if cg_curve(l)==cg_curve(l-1)
                termination=termination+1;
                if termination>2000
                    break;
                end
            else
                termination=0;
            end
        end
    end
    cg_all(qq,:)=cg_curve;              % storing the CG for each run
    GBest_Score_all(qq,:)=gBestScore;	% storing the Best score for each run
    GBest_Solution_all(qq,:)=gBest ;	% storing the Best solutions for each run
end
% Electing the Best fitness+solution from from multple run
[Best_obj, bb]=min(GBest_Score_all);        % filtering best score from multiple run
results.Best_obj=Best_obj;                  % filtering best objective outcome
results.Best_sol=GBest_Solution_all(bb,:);	% filtering best solutions from multiple run
results.cg_curve=cg_all(bb,:);              % filtering CG from multiple run

end