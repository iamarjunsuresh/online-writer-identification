function s = cubicspline(stroke)
%CUBICSPLINE Summary of this function goes here

x = stroke(:,1);
y = stroke(:,2);
if(numel(x)<3)
    s=stroke;return;
end
t=1:numel(x);
ti=1:0.25:numel(x);
  xs = interp1(t,x, ti,'pchip');
  ys = interp1(t,y, ti,'pchip');

  s(:,1)=xs(:);
  
  s(:,2)=ys(:);
  
end

