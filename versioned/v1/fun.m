
 
function new = fun(A)


%A = dat{1,1}{1,1};

size_A = size(A,2);

list_A = 1:size_A;

new = [];
for p = 1:8
   
    atom = [];
    q = 0;
    
    while q~=3
       
        sel_s = round(rand * (size_A - 1) + 1);
        if(size(A{1,list_A(sel_s)},1)>=20)
        
            data = A{1,list_A(sel_s)}(1:20,1:2);
          % me=[99999,999999];
            
            
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


