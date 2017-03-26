function [att,class]=sampleMultiClass(n)
x=rand(n,1);
y=rand(n,1);

r=[x,y];
c1=r(r(:,1) > .5 & r(:,2)>.5,:);
c2=r(r(:,1) < .5 & r(:,2)>.5,:);
c3=r(r(:,1) < .5 & r(:,2)<.5,:);
c4=r(r(:,1) > .5 & r(:,2)<.5,:);

figure; hold on;
plot(c1(:,1),c1(:,2),'*','color','m')
plot(c2(:,1),c2(:,2),'*','color','r')
plot(c3(:,1),c3(:,2),'*','color','b')
plot(c4(:,1),c4(:,2),'*','color','c')
hold off;

att=[c1;c2;c3;c4];
cc1=repmat([1,0,0,0],length(c1),1);
cc2=repmat([0,1,0,0],length(c2),1);
cc3=repmat([0,0,1,0],length(c3),1);
cc4=repmat([0,0,0,1],length(c4),1);
class=[cc1;cc2;cc3;cc4];

end