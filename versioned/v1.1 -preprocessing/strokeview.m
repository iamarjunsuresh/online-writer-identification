clc
clear
a=[];
load('stroke.mat')
for i=-10:2:10
   a=[a ;[i,i*i]]; 
end
str=a;
s=removeduplicate(str);

s=removehook(s)
s=cubicspline(s);
plot(str(:,1),str(:,2));
s(:,2)=s(:,2)+0;
hold on;
plot(s(:,1),s(:,2));
hold off;   