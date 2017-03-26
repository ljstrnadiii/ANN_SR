function [att,class]=sampleFun(n)

x=rand(n,1);
y=rand(n,1);

% plot boundary
lx=linspace(0,1,n);
ly=poly(lx);

% partition by condition
r=[x,y];
c1=r(r(:,2)>poly(r(:,1)),:);
c2=r(r(:,2)<=poly(r(:,1)),:);
    
figure; hold on;
plot(lx,ly)
% plot points and color according to class
plot(c1(:,1),c1(:,2),'*','color','m')
plot(c2(:,1),c2(:,2),'*','color','b')
hold off;
att=[x,y];
class=[y>poly(x)];
end

