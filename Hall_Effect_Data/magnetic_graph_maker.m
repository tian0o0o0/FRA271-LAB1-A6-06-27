N_noShield=1;
N_Shield=1;
S_noShield=0;
S_Shield=0;
if N_noShield==true
load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\N-NOshield-1.mat")
[b1,v1,d1]=magnetmethod(data.time,data.data,[4,17,32,44,57,72,90]);
[time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\N-NOshield-2.mat");
[b2,v2,d2]=magnetmethod(time,data,[7,27,55,79,107,126,142]);
[time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\N-NOshield-3.mat");
[b3,v3,d3]=magnetmethod(time,data,[7,27,53,80,105,126,137]);

end
if N_Shield==true
[time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\N-shield-1.mat");
[b4,v4,d4]=magnetmethod(time,data,[10,44,65,87,113,134,155]);
load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\N-shield-2.mat")
[b5,v5,d5]=magnetmethod(data.time,data.data,[7,47,63,93,117,138,163]);
load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\N-shield-3.mat")
[b6,v6,d6]=magnetmethod(data.time,data.data,[8,44,67,87,112,132,152]);
end
if S_noShield==true
    [time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\S-NOshield-1.mat");
    [b7,v7,d7]=magnetmethod(time,data,[4,20,40,69,77,92,106]);
    [time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\S-NOshield-2.mat");
    [b8,v8,d8]=magnetmethod(time,data,[5,28,47,68,82,97,112]);
    [time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\S-NOshield-3.mat");
    [b9,v9,d9]=magnetmethod(time,data,[7,22,42,59,80,94,112]);
end
if S_Shield==true
    [time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\S-shield-1.mat");
    [b10,v10,d10]=magnetmethod(time,data,[3,17,30,47,61,77,92]);
    [time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\S-shield-2.mat");
    [b11,v11,d11]=magnetmethod(time,data,[4,22,37,58,78,95,118]);
    [time,data]=filextractor("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Hall_Effect_Data\S-shield-3.mat");
    [b12,v12,d12]=magnetmethod(time,data,[4,22,37,58,78,92,107]);
end

bdplotter(b1,b2,b3,d1,d2,d3);
hold on;
bdplotter(b4,b5,b6,d4,d5,d6)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%FUNCTIONS



function V=adc2V(data)
V=[];
for i=1:numel(data)
    V(end+1)=double(data(i))*3.3/4095;
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


function [B,v,d]=magnetmethod(time,data,startT)
distance=[4,3.5,3,2.5,2,1.5,1];
adc=dataselecter(time,data,startT,1000);

v=adc2V(adc);
v=1000*v;
B=(v-1650)/30;
d=distance_multiplier(distance,1000);
end





function [time_vec,data_vec]=filextractor(path)

load(path);

sig = data.get(1); 
time_vec = sig.Values.Time;
data_vec = sig.Values.Data;
end

function []=bvplotter(b1,b2,b3,v1,v2,v3)
    b=[b1,b2,b3]
    v=[v1,v2,v3]
    
    plot(b,v,'LineWidth',5)
    
    title('Relationship between Magnetic Flux Density and Hall Volatage mean of N=3','FontSize',25)
    xlabel('Magnetic field B (mT)','FontSize',25);
    ylabel('Hall voltage V (mV)','FontSize',25);
    
    grid on;
    grid minor;
end
function []=bdplotter(b1,b2,b3,d1,d2,d3)
b=[];
for i=1:numel(b1)
    b(end+1)=(b1(i)+b2(i)+b3(i))/3;
end

plot(d1,b,'LineWidth',5);
title('Relationship between Distance and Magnetic Flux Density mean of N=3','FontSize',25)
xlabel('Distance (cm)','FontSize',25);
ylabel('Magnetic Flux Density B(mt)','FontSize',25);
legend('South Pole without Shield','South Pole with Shield','FontSize',20)



grid on;
grid minor;
end