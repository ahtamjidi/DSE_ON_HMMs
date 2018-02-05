function [KL] = kullback(q,p, basis)
% KULLBACK Kullback-Leibler Divergence between discrete
% pdf's
%
% [KL] = KULLBACK(Q, P, <BASIS>)
%
% Inputs :
% Q, P : Target and Model distributions
% BASIS : Basis for log(.), <Default : e>
%
% Outputs :
% KL(Q||P)
%
% Usage Example : KL = kullback([0.1 0.9],[0.5 0.5]);
%
%
% Note :
% See also

% Uses :

% Change History :
% Date Time Prog Note
% 28-Apr-1999 3:34 PM ATC Created under MATLAB 5.2.0.3084

% ATC = Ali Taylan Cemgil,
% SNN - University of Nijmegen, Department of Medical Physics and
% Biophysics
% e-mail : cemgil@mbfys.kun.nl

if nargin<3,
  C = 1;
else
  C = 1/log(basis);
end;

q = q(:);
p = p(:);

zq = find(q>0);
zp = find(p>0);

if ~isempty(setdiff(zq,zp)),
  KL = Inf;
else
  KL = q(zq)'*log(q(zq)) - q(zp)'*log(p(zp));
end;

KL = C*KL;
