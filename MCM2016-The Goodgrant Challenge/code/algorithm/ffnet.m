%��ȡѵ������
[f1,f2,f3,f4,class] = textscan('trainData.txt' , '%f%f%f%f%f',150);

%����ֵ��һ��
[input,minI,maxI] = premnmx( [f1 , f2 , f3 , f4 ]') ;

%�����������
s = length( class) ;
output = zeros( s , 3 ) ;
for i = 1 : s 
 output( i , class( i ) ) = 1 ;
end

%����������
net = newff( minmax(input) , [10 3] , { 'logsig' 'purelin' } , 'traingdx' ) ; 

%����ѵ������
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;

%��ʼѵ��
net = train( net, input , output' ) ;

%��ȡ��������
[t1 t2 t3 t4 c] = textread('testData.txt' , '%f%f%f%f%f',150);

%�������ݹ�һ��
testInput = tramnmx ( [t1,t2,t3,t4]' , minI, maxI ) ;

%����
Y = sim( net , testInput ) 

%ͳ��ʶ����ȷ��
[s1 , s2] = size( Y ) ;
hitNum = 0 ;
for i = 1 : s2
 [m , Index] = max( Y( : , i ) ) ;
 if( Index == c(i) ) 
 hitNum = hitNum + 1 ; 
 end
end
sprintf('ʶ������ %3.3f%%',100 * hitNum / s2 )