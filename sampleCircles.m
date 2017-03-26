function [att,class]=sampleCircles(n)
radius = rand;
xc = randn;
yc = randn;
% Engine
theta = rand(1,n/2)*(2*pi);
r1 = sqrt(rand(1,n/2))*radius;
r2 = sqrt(rand(1,n/2)+ones(1,n/2))*(radius)+.1;

x1 = xc + r1.*cos(theta);
y1 = yc + r1.*sin(theta);

x2 = xc + r2.*cos(theta);
y2 = yc + r2.*sin(theta);

att=[x1,x2;y1,y2]';
class=[ones(1,length(x1)),zeros(1,length(x1))]';
% Check
figure; hold on;
plot(x1,y1,'*','color','r')
plot(x2,y2,'*','color','b')
hold off;
%att=[
%class=[ones(length(x1),1);zeros(length(x2),1)];
end