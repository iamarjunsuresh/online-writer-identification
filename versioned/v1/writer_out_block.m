
clc 
clear all

accarr=[]
 load('writerdata.mat');

for running=1:5


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Training Part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
numbers=1:8;
n=20;                                        % No of person
numbertopick=4;                            % No of Training images
pickednums=[];
arrsize=size(numbers);
arrsize=arrsize(2);
finalt=[];

for i=1:numbertopick 
   num=round(ceil(rand([1,1])*arrsize)); 
   pickednums=[pickednums numbers(num)];
   numbers(num)=[];
   arrsize=arrsize-1;
end 


for t=1:n
m=1;
for j=1:numbertopick
    new=fun(dat{1,t}{1,pickednums(j)});
    for k=1:8
        trainA(t,m,:)=new(:,k);
        m=m+1;
    end
end
m=1;
for j=1:4
    new=fun(dat{1,t}{1,numbers(j)});
      for k=1:8
        testA(t,m,:)=new(:,k);
        m=m+1;
    end
end
end



 

fc=1;
for j=1:n
    
for k=1:32
    Tmp_Data(:)=trainA(j,k,:);   
    Tmp_Data_Down_Sampled = Tmp_Data / norm(Tmp_Data,2);
   
    Data_Matrix(:,fc) = Tmp_Data_Down_Sampled;
fc=fc+1;
end
    % 55 random 5x32
    
   % randadd=50+5*rand([5,32]);
   % Data_Matrix((j-1)*5+1:(j-1)*5+5,(j-1)*32+1:(j-1)*32+32)=Data_Matrix((j-1)*5+1:(j-1)*5+5,(j-1)*32+1:(j-1)*32+32)+randadd; 
end
X = Data_Matrix;

%X = normc(X);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Testing Part %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%











acc=0;
acc1=0;
cnt=0;
% cvx_solver Mosek;

    
no_of_test = 20;
dd=[];
ddd=[];
for k = 1:no_of_test
       

for p = 1:4
      Tmp_Data(:)=testA(k,p,:);
      Tmp_Data_Down_Sampled = Tmp_Data / norm(Tmp_Data,2);
        y= Tmp_Data_Down_Sampled;
      %   randadd=50+5*rand([5,1]);
    %Data_Matrix((j-1)*5+1:(j-1)*5+5,(j-1)*32+1:(j-1)*32+32)=Data_Matrix((j-1)*5+1:(j-1)*5+5,(j-1)*32+1:(j-1)*32+32)+randadd; 

        y=y(:);
%        y((k-1)*5+1:(k-1)*5+5)=y((k-1)*5+1:(k-1)*5+5)+randadd;
        train_num=32;   
        sz=n;
        cnt=cnt+1;
        sub=k;
        q=2;
        thr=.05;
        
        Tn = train_num * ones(1,n);
        
        cvx_begin
        variable x_l1(train_num*n)
        minimize( norm( x_l1, 1 ) )
        subject to
        norm( X*x_l1 - y,2) <= .05;
        cvx_end;
         
        
        mind=999999990;
        minindex=1;
       
        for i=1:sz
            s=zeros(sz*train_num,1);
            s((i-1)*train_num+1:i*train_num)=x_l1((i-1)*train_num+1:i*train_num);
            d=X*s;
            d=norm(d-y,2);
            
            if(d<mind)
                mind=d;
                minindex=i;
            end
      
          end
        ddd=[ddd minindex];
        
        if minindex==k
            dd=[dd k];
            acc=acc+1;
        end

        
       
    end
   disp(acc);  
end

acc1=acc/cnt*100;new

acc1
accarr=[accarr acc1]


end

accarr
