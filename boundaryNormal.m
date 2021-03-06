% Christopher J. Mirfin 
% Sir Peter Mansfield Imaging Centre, University of Nottingham
% christopher.mirfin@dtc.ox.ac.uk
% 23/07/2016

function [boundary,normals] = boundaryNormal(img,Delta)
%function BOUNDARYNORMAL takes an image, finds boundaries and computes normal to these
%boundaries.
if nargin < 2
    Delta = 2;
else
    Delta = ceil(Delta)+1;
end

%find boundary points
[boundaryImg] = edge(img,'sobel');


newBoundaryImg = zeros(size(img));
newBoundaryImg(Delta:end-Delta,Delta:end-Delta) = boundaryImg(Delta:end-Delta,Delta:end-Delta);
[X,Y] = find(newBoundaryImg == 1);
boundary = [X(:),Y(:)];

[dx,dy] = gradient(img);

% normalise vectors
l=sqrt(dx.^2+dy.^2);
dx = dx./l; 
dy = dy./l;

nx = zeros(1,length(X));
ny = zeros(1,length(Y));

for i = 1:length(X)
    
    nx(i) = dx(X(i),Y(i));
    ny(i) = dy(X(i),Y(i));
end
%normals = abs([nx;ny])';
normals = ([nx;ny])';

%plot vectors
% Nx = zeros(size(img));
% Ny = zeros(size(img));
% 
% for i = 1:length(X)
% 
% Nx(X(i),Y(i)) = nx(i);
% Ny(X(i),Y(i)) = ny(i);
% end
% 
% quiver(Nx,Ny);
end

