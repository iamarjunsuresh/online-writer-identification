import os




#f=open('input.txt','r')

#data=f.read()

xs=[]
ys=[]
lines=[]
#lines=data.split('\n')
avx=0
avy=0
for l in lines:
    x,y=map(int,l.split(','))
    xs.append(x)
    ys.append(y)

con=len(xs);


def main():
   #plot points
             
