
 
function new = fun(A,istesting)


%A = dat{1,1}{1,1};

size_A = size(A,2);
s1=size_A;
list_A = 1:size_A;

new = [];
if(istesting==1)
    nooftimes=32;
else
    nooftimes=8;
end
for p = 1:nooftimes
   
    atom = [];
    q = 0;
    
    while q~=1
       
        sel_s = round(rand * (size_A - 1) + 1);
        
        
            stroke=A{1,list_A(sel_s)};
           stroke=removeduplicate(stroke);
          % stroke=removehook(stroke);
           stroke=cubicspline(stroke);
            if(size(stroke,1)>=60)
            data = stroke(1:60,1:2);
    
            me=mean(data);
             data=data-me;
            data = data(:);
                    
            atom = [atom data];
            
            q= q + 1;
         
        end
        size_A = size_A-1;
        list_A(sel_s) = [];
        
    end
    
    new = [new atom(:)];
    
end


%     figure
%     for i=1:8
%         B= new(:,i);
%         subplot(8,1,i);
%         plot(B(:,1));
%     end

end


