% Evaluate features of X given a set of radial basis functions.
%
% See rbfComputeBasis for discussion of rbfs and general usage.
%
% USAGE
%  Xrbf = rbfComputeFeatures( X, rbfBasis )
%
% INPUTS
%  X         - [N x d] N points of d dimensions each
%  rbfBasis  - rbfBasis struct (see rbfComputeBasis)
%
% OUTPUTS
%  Xrbf      - [N x k] computed feature vectors
%
% EXAMPLE
%
% See also RBFDEMO, RBFCOMPUTEBASIS

% Piotr's Image&Video Toolbox      Version 1.03   PPD
% Written and maintained by Piotr Dollar    pdollar-at-cs.ucsd.edu
% Please email me if you find bugs, or have suggestions or questions!

function Xrbf = rbfComputeFeatures( X, rbfBasis )

N = size(X,1);
k = rbfBasis.k;
mu = rbfBasis.mu';
var = rbfBasis.var;

% for each point, compute values of all basis functions
% mu=[k x d]; onesVec=[k x 1]; Xi=[1 x d];
Xrbf = zeros( N, k );
onesVec = ones(k,1);
for i=1:N
  eucdist = sum( ((onesVec*X(i,:) - mu)).^2, 2 );
  Xrbf(i,:) = eucdist' / 2 ./ var;
end;
Xrbf = exp( -Xrbf );

% normalize rbfs to sum to 1
if( 0 ); Xrbf = Xrbf ./ repmat( sum(Xrbf,2), [1 k] ); end

% add constant vector of ones as last feature
if( 0 ); Xrbf = [Xrbf ones(N,1)]; end

% add original features as features
if( 0 );  Xrbf = [X Xrbf];  end
