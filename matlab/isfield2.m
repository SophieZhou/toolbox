% More comprehensive version of isfield.
%
% A more comprehensive test of what fields are present [and optionally
% initialized] in a stuct S.  fs is either a single field name or a cell
% array of field name.  The presence of all fields in fs are tested for in
% S, tf is true iif all fs are present. Additionally, if isinit==1, then tf
% is true iff every field fs of every element of S is nonempty (test done
% using isempty).
%
% USAGE
%  tf = isfield2( S, fs, [isinit] )
%
% INPUTS
%  S        - struct array
%  fs       - cell of string name or string
%  isinit   - [0] if true additionally test if all fields are initialized
%
% OUTPUTS
%  tf      - true or false, depending on results of above tests
%
% EXAMPLE
%  isfield2( struct('a',1,'b',2), {'a','b'}, 1 )
%
% See also ISFIELD

% Piotr's Image&Video Toolbox      Version 1.03   PPD
% Written and maintained by Piotr Dollar    pdollar-at-cs.ucsd.edu
% Please email me if you find bugs, or have suggestions or questions!

function tf = isfield2( S, fs, isinit )

if( nargin<3 ); isinit=0;  end

if ~isa(S,'struct')
  tf = false; return;
end

% check if fs is a cell array, if not make it so
if( iscell(fs) )
  nfs = length(fs);
else
  nfs=1; fs={fs};
end;

% see if every one of fs is a fieldname
Sfs = fieldnames(S);
tf = true;
for i=1:nfs
  tf = tf & any(strcmp(Sfs,fs{i}));
  if( ~tf ); return; end
end;

% now optionally check if fields are isinitialized
if( ~isinit || ~tf ); return; end
nS = numel(S);
for i=1:nfs
  for j=1:nS
    tf = tf & ~isempty( S(j).(fs{i}) );
    if( ~tf ); return; end
  end
end
