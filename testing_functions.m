%    _________________________________________________________      %
%              PSO Algorithm source codes version 1.0               %
%                                                                   %
%       Developed in MATLAB R2021a(9.10.0.1602886)                  %
%       Programmer: Arafat Ibne Ikram                               %
%       e-Mail: arafatibne.ikram@gmail.com                          %
%       Homepage: https://github.com/arafatikram                    %
%       Reference Used: https://doi.org/10.1109/ICNN.1995.488968    %
%___________________________________________________________________%


function [lb,ub,dim,fobj] = testing_functions(F)

switch F
    case 'F1'
        fobj = @F1;
        lb=-100;
        ub=100;
        dim=30;
        
    case 'F2'
        fobj = @F2;
        lb=-500;
        ub=500;
        dim=30;
        
    case 'F3'
        fobj = @F3;
        lb=-5.12;
        ub=5.12;
        dim=30;
        
    case 'F4'
        fobj = @F4;
        lb=-32;
        ub=32;
        dim=30;
end

end

% F1
function o = F1(x)
o=sum(x.^2);
end

% F2
function o = F2(x)
o=sum(-x.*sin(sqrt(abs(x))));
end

% F3
function o = F3(x)
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

% F4
function o = F4(x)
dim=size(x,2);
o=-20*exp(-.2*sqrt(sum(x.^2)/dim))-exp(sum(cos(2*pi.*x))/dim)+20+exp(1);
end

 