%    _________________________________________________________      %
%              PSO Algorithm source codes version 1.0               %
%                                                                   %
%       Developed in MATLAB R2021a(9.10.0.1602886)                  %
%       Programmer: Arafat Ibne Ikram                               %
%       e-Mail: arafatibne.ikram@gmail.com                          %
%       Homepage: https://github.com/arafatikram                    %
%       Reference Used: https://doi.org/10.1109/ICNN.1995.488968    %
%___________________________________________________________________%

function func_plot_rcga(func_name) % This function draw the benchmark functions

[lb,ub,dim,fobj] = testing_functions(func_name);

switch func_name 
    case 'F1' 
        x=-100:2:100; y=x; %[-100,100]        
    case 'F2' 
        x=-500:10:500;y=x; %[-500,500]
    case 'F3' 
        x=-5:0.1:5;   y=x; %[-5,5]    
    case 'F4' 
        x=-20:0.5:20; y=x;%[-500,500]
end    

L=length(x);
f=[];
for i=1:L
    for j=1:L
        if strcmp(func_name,'F15')==0 && strcmp(func_name,'F19')==0 && strcmp(func_name,'F20')==0 && strcmp(func_name,'F21')==0 && strcmp(func_name,'F22')==0 && strcmp(func_name,'F23')==0
            f(i,j)=fobj([x(i),y(j)]);
        end
        if strcmp(func_name,'F15')==1
            f(i,j)=fobj([x(i),y(j),0,0]);
        end
        if strcmp(func_name,'F19')==1
            f(i,j)=fobj([x(i),y(j),0]);
        end
        if strcmp(func_name,'F20')==1
            f(i,j)=fobj([x(i),y(j),0,0,0,0]);
        end       
        if strcmp(func_name,'F21')==1 || strcmp(func_name,'F22')==1 ||strcmp(func_name,'F23')==1
            f(i,j)=fobj([x(i),y(j),0,0]);
        end          
    end
end

surfc(x,y,f,'LineStyle','none');

end

