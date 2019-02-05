function result = removehook(Stroke)
%REMOVEHOOK1 Summary of this function goes here
%   Detailed explanation goes here

  %remove duplcates
  points(:,:)=Stroke(:,1:2);
  a1=[];
 xnew=[];
 ynew=[];
  cnt=size(Stroke);
  cnt=cnt(1);
  tdist=0;
  for i=1:cnt-1
     t2=points(i,:);
      t1=points(i+1,:);
      dist=sqrt(sum((t2-t1).*(t2-t1)));
      tdist=tdist+dist;
      
  end
  tdist=tdist/cnt;   
  
  for i=1:cnt-1
        x1=Stroke(i,1);
        y1=Stroke(i,2);
        
        x2=Stroke(i+1,1);
        y2=Stroke(i+1,2);
          d=tdist/8;
          
        dist=sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
       
        if(dist<d)
            while(dist<d&&i<cnt-1)
                
                i=i+1;
                x2=Stroke(i+1,1);
                
                y2=Stroke(i+1,2);
                dist=dist+sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
                
            end
            
            d=dist-d;
            %i=i-1;
           
            
          
                
                
        end
        k=(y2-y1)/(x2-x1);
        spart=sqrt(d*d/(k*k+1));
        if(x1<x2)
            xnew=x1+spart;
        else
            
            if(x2>x1)
                xnew=x1-spart;
                
           else
            xnew=x1;
           end
        end
        
          
          
         if(y2>y1 && x1~=x2)
              
              ynew=y1+d;
          
          elseif(y2<y1 && x1~=x2)
              
                    ynew=y1-d;
                    
         elseif(x1~=x2)
            
               ynew=k*xnew+y1-k*x1;
         else 
             ynew=y1;
           
          end 
        %  disp("sd");
        % disp( size(a1));
         a1=[a1;[xnew ynew]];
    end
  
   result=a1;
        
end
  
  
  
  
  
  


 

