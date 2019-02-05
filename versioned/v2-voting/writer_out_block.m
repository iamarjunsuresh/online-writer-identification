

clc
clear all
accc=0;
repetation=1;
acc_mat=[];



for repeat=1:repetation
 
    
    train_num=32;
    n = 32;                             % No of people for testing
    dat = select_writer(n);             % Randomly finding n people
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Training Part %%%%%%%%%%%%%%%%%%%%%%%
    numbers=1:8;

    numbertopick=4;                            % No of Training images
    pickednums=[];
    arrsize=size(numbers);
    arrsize=arrsize(2);
    finalt=[];
    
    
    %%%%%%%%%%%%%%%%%%%%%% Choosing Random numbers for training and testing
    
    for i=1:numbertopick
        num=round(ceil(rand([1,1])*arrsize));
        pickednums=[pickednums numbers(num)];
        numbers(num)=[];
        arrsize=arrsize-1;
    end
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Training set generation
    
    for t=1:n
        m=1;
        for j=1:numbertopick
            
            
            new=fun(dat{1,t}{1,pickednums(j)});
            for k=1:8
                trainA(t,m,:)=new(:,k);
                m=m+1;
            end
        end
        
        
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Testing set generation
        
        m=1;
        for j=1:4
            new=fun(dat{1,t}{1,pickednums(j)});
            for k=1:8
                testA(t,m,:)=new(:,k);
                m=m+1;
            end
        end
    end
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Normalizing
    
    
    fc=1;
    for j=1:n
        for k=1:32
            Tmp_Data(:)=trainA(j,k,:);
            Tmp_Data_Down_Sampled = Tmp_Data / norm(Tmp_Data,2);
            Data_Matrix(:,fc) = Tmp_Data_Down_Sampled;
            fc=fc+1;
        end
        
    end
    X = Data_Matrix;
    
    %X = normc(X);
    
    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Testing Part %%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    
    
    
    
    
    
    acc=0;
    acc1=0;
    cnt=0;
    cvx_solver Mosek;
    
    
    
    no_of_test = n;
    
   % sss=[];
    group = 4;      %%%%%%%%%%%%%%%%%%%  group check for one persion
    
    for k = 1:no_of_test
        
        test_item = 1;
        for p = 1:train_num/group            
            
            op = [];
            
            for m = 1:group
                
                Tmp_Data(:)=testA(k,test_item,:);
                test_item = test_item+1;
                Tmp_Data_Down_Sampled = Tmp_Data / norm(Tmp_Data,2);
                y= Tmp_Data_Down_Sampled;
                y=y(:);
                
                
                
                train_num=32;
                sz=n;
       
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
                op=[op minindex];
                %sss = [sss minindex];
                
            end
            
            if mode(op) == sub
                
                acc = acc+1;
            
            end
            
            cnt=cnt+1;
            
            
            
        end
        
    end
    
    acc=acc/cnt*100;
    
    acc_mat=[acc_mat acc];
   
    
end





















