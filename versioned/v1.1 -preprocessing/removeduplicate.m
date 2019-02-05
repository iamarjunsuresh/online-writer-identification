function result = removehook(Stroke)
%REMOVEHOOK1 Summary of this function goes here
%   Detailed explanation goes here

  %remove duplcates
  points(:,:)=Stroke(:,1:2);
  a1=[];
  ind=1;
  result=[];
      result(1,:)=points(1,:);
  cnt=size(Stroke);
  cnt=cnt(1);
  tdist=0;
  prev=points(1,:);
  for i=2:cnt
     t=points(i,:);
if(prev==t)
    
    
else
    result(ind,:)=points(i,:);
ind=ind+1;
end
prev=t;

  end
 
  
                
 
        
end
  
  
  
  
  
  


 

