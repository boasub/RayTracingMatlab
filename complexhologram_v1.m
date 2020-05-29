clear all
close all
%%%%%%%%%%%%%%%
%  CONSTANTS  %
%%%%%%%%%%%%%%%

wavelength = 630e-9; % in meters
sampling=0.0015/300;  % in meters 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  INITIALIZE HOLOGRAM FILM  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dimensions = 1; 
range = dimensions*0.0005/2;
ipx = (-1*range):sampling:range;
ipy = (-1*range):sampling:range;
% 1in in length @ 600dpi
% 1in in length @ 600dpi
film = zeros(size(ipx,2),size(ipy,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%
%  DEFINE OBJECT POINTS  %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following sections utilize different methods and scripts to
% accomplish creating whatever virtual object design one desires

%...............
%SINGLE or MULTIPLE points
%...............
%objectpoints = [0 0 0.07];
%objectpoints = [-0.01 -0.01 0.005;0.01 0.01 0.005];
%objectpoints = [-0.2 0  2;0.2 0  2];
%objectpoints = [0 -0.002 0.5;0 0.002 0.5];


%...............
%IMAGE = simpleImage2objectpoints(img, width, height, depth)
%...............

img = imread('./img/p-300dpi-05cm.png','png');
width = 0.0015;  %gebnerated image width
height = 0.0015; %generated image height
depth=0.005;
objectpoints = simpleImage2objectpoints(img, width, height, depth);


%%%offset the x-axis by some amount
%offset = 0.05;
%objectpoints(:,1) = objectpoints(:,1)+offset;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  BEGIN HOLOGRAM COMPUTATION  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Computing...\n');
fprintf('Hologram resolution = %dx%d\n',size(ipx,2),size(ipy,2));
fprintf('Number of objectpoints = %d\n',size(objectpoints,1));

% Iterate through every object, and calculate the light field contribution
% at each sampling pixel on our film.
fprintf('calculating hologram for object point ');

n=size(objectpoints(:,1));
cost=2*pi/wavelength;
%dz=objectpoints(1,3);
%dz=0.005
dz=depth;

tic
for o=1:n
    %fprintf('%d,',o);
    for i=1:size(ipx,2)
        for j=1:size(ipy,2)
            dx = objectpoints(o,1) - ipx(i);
            dy = objectpoints(o,2) - ipy(j);
            distance=dz+(1./(2.*dz))*(dx^2+dy^2);
            %%%distance=sqrt(dx^2+dy^2+dz^2);
            complexwave = exp(2*pi*sqrt(-1)*distance/(wavelength));
            film(i,j) = film(i,j) + complexwave;
        end
    end
end
toc

pcolor(real(film));shading interp;


%%%reconstruction
propagZ=0.07;