
%peakfinder(data.time,data.data,startT);
load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\sliding\slid_a1.mat")
startT=[1,15,24,41,53,70,85,100,112,123,132,142,151];



load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\sliding\slid_a2.mat")
startT=[1,2,18,28,40,58,72,88,100,112,122,138,152];



load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\sliding\slid_a3.mat")
startT=[1,15,22,34,45,56,66,76,87,98,110,120,130];



load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\sliding\slid_b1.mat")
startT=[2,11,18,28,38,46,54,64,70,76,85,92,100];
%[x1,y1]=slidingmethod(data.time,data.data,startT);

load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\sliding\slid_b2.mat")
startT=[1,15,20,28,36,43,50,58,65,72,79,86,94];
%[x2,y2]=slidingmethod(data.time,data.data,startT);

load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\sliding\slid_b3.mat")
startT=[1,7,14,21,28,35,41,47,54,60,67,73,80];
%[x3,y3]=slidingmethod(data.time,data.data,startT);

%slidingmethod(data.time,data.data,startT);

load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_a1.mat");
startT=[1,10,17,24,30,36,42,48,53,58,62,67,72,77,81,86,92,97,101,104,109];


load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_a2.mat");
startT=[1,10,15,20,25,30,33,36,39,42,46,50,53,57,59.5,62,65,68,72,74,76];


load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_a3.mat");
startT=[1,9,12,15,20,25,29,33,36,40,43,47,50,53,57,61,64,67.5,70,73,75];


load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_b1.mat");
startT=[1,7,12,16,21,26,30,35,40,44,49,54,58,62,66,70,74,79,83,87,91];



load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_b2.mat");
startT=[1,7,10,15,20,25,30,34,38,42,46,52,56,61,65,69,74,78,84,88,92];


load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_b3.mat");
startT=[2,6,10,15,20,23,28,32,37,41,44,48,52,56,60,63,67,72,77,81,86];


load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_c1.mat");
startT=[1,8,13,17,23,27,32,38,42,46,51,56,59,64,68,74,78,82,86,90,92];
[x1,y1]=rotamethod(data.time,data.data,startT);


load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_c2.mat");
startT=[1,5,10,16,20,24,29,33,37,41,45,49,53,56,60,64,68,71,76,80,84];
[x2,y2]=rotamethod(data.time,data.data,startT);

load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\poten\rotational\rot_c3.mat");
startT=[1,5,8,13,18,22,27,32,36,41,45,51,55,60,65,69,73,77,82,86,90];
[x3,y3]=rotamethod(data.time,data.data,startT);
graphplotter(x1,y1,y2,y3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%FUNCTIONS


function percent=adc2percent(data)
percent=[];
for i=1:numel(data)
    percent(end+1)=double(data(i))*100/4095;
end
end
function V=adc2V(data)
V=[];
for i=1:numel(data)
    V(end+1)=double(data(i))*3.3/4095;
end
end
function percent=distance2percent(data,max)
percent=[];
for i=1:numel(data)
    percent(end+1)=double(data(i))*100/max;
end
end

function BIGdistance=distance_multiplier(distance,count)
BIGdistance=[];
for i=1:numel(distance)
    for j=1:count
        BIGdistance(end+1)=distance(i);
    end
end
end
function selected_data=dataselecter(time,data,startT,amount)%[a,b,c,d],[1,2,3,4],[1,3],2-->[a,b,c,d]
selected_data=[];
selected_time=[];
for i=1:numel(startT)
    count=0;
    for j=1:numel(time)
        if time(j)>=startT(i) && count<amount
            selected_data(end+1)=data(j);
            selected_time(end+1)=time(j);
            count=count+1;
        end
    end
end
end
function []=graphplotter(x,y1,y2,y3)
y=[];

for i=1:numel(y2)
    y(end+1)=(y1(i)+y2(i)+y3(i))/3;
end


plot(x,y,'Marker','o','LineWidth',4)
hold on
title('Rotary Potentiometer "C" Characteristics (mean of N=3)','FontSize',20)
xlabel("Rotational Travel (%) ",'FontWeight','Bold','FontSize',20);
ylabel({'V_{1-2} / V_{1-3} \times 100  (%)'},'FontSize',20,'FontWeight','Bold');
text(0,-5,"Terminal 1",'FontSize',15);
text(92,-5,"Terminal 3",'FontSize',15);
grid on 
grid minor


end
function [bigdistance,v]=slidingmethod(time,data,startT)
distance=[0,0.2,0.7,1.2,1.7,2.2,2.7,3.2,3.7,4.2,4.7,5.2,5.7];
adc=dataselecter(time,data,startT,1000);

v=adc2percent(adc);

x=distance2percent(distance,5.7);
bigdistance=distance_multiplier(x,1000);

%graphplotter(bigdistance,v);


end
function[bigdeg,v]=rotamethod(time,data,startT)
    degpercent=0:5:100;
    
    adc=dataselecter(time,data,startT,1000);
    v=adc2percent(adc);
    bigdeg=distance_multiplier(degpercent,1000); 
    
    
    
end
function peak=peakfinder(time,data,startT)

adc=dataselecter(time,data,startT,1000);
v=adc2V(adc);

max=0;
min=1000;
peak=[];
for i=1:numel(v)
    if v(i)>max
        max=v(i);
    end
    if v(i)<min
        min=v(i);
    end
    if mod(i,1000)==0
        
        peak(end+1)=max-min;
        max=0;
        min=1000;
        
        end
    end
plot([1:numel(peak)],peak);
end


