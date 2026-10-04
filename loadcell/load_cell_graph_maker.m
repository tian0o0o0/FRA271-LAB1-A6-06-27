load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\loadcell\lab1.4.2 185.8 ohm.mat")
mass=[0,0.307,1.287,2.305,3.298,4.229,5.144,6.141,7.167,8.167];
startT=[4,35,55,75,90,105,125,145,165,180];
[masses1,v1]=loadcellmethod(data.time,data.data,mass,startT);


load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\loadcell\lab1.4.2 (2).mat")
%plot(data.time,data.data)
mass=[0,0.307,1.318,2.317,3.307,4.29,5.294,6.185,7.045,8.041];
startT=[5,25,60,100,130,155,190,220,325,360];
[masses2,v2]=loadcellmethod(data.time,data.data,mass,startT);


V=[v1,v2];
M=[masses1,masses2];
%plot(V,M,'.')
ylabel('Mass (kg)','FontSize',20)
xlabel('Output Voltage','FontSize',20)
title('Relationship between Output Voltage and Mass','FontSize',20)
grid on
grid minor
hold off
load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\loadcell\lab1.4.2 validation.mat")

dat=movingAVG(data.time,data.data);
masslist=[0,0.5,0.984,1.5,1.992,2.467,2.966,3.462,3.981];
plot(data.time,dat,'LineWidth',4)
hold on
for i=1:numel(masslist)
    plot([1,235],[masslist(i),masslist(i)],'LineWidth',4,'Color','r')
    hold on
end
grid on
grid minor
title('Comparison betwen Load Cell Measurement and Digital Scale','FontSize',20)
ylabel('Mass (kg)','FontSize',20)
xlabel('Time (s)','FontSize',20)
legend('Load Cell Measurement','Digital Scale Measurement','FontSize',20)
function V=adc2V(data)
V=[];
for i=1:numel(data)
    V(end+1)=double(data(i))*3.3/4095;
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
function BIGdistance=distance_multiplier(distance,count)
BIGdistance=[];
for i=1:numel(distance)
    for j=1:count
        BIGdistance(end+1)=distance(i);
    end
end
end
function [masses,V]=loadcellmethod(time,data,mass,startT)
    
    adc=dataselecter(time,data,startT,1000);
    V = adc2V(adc);
    masses=distance_multiplier(mass,1000);
end
function newdata=movingAVG(time,data)
    newdata=[];
    avg=[];
    for i=1:numel(time)
        avg(end+1)=data(i);
        if numel(avg)>1000
            avg=avg(2:end);
        end
        newdata(end+1)=sum(avg)/numel(avg);
    end
end