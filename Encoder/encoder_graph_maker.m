load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Encoder\Encoder_B_X1.mat")
dataA=data.data; timeA=data.time;
load("C:\Users\Legion Pro5\Documents\FRA271-LAB1-A6-06-27\Encoder\Encoder_B_X1.mat")
dataB=data.data; timeB=data.time;

%AB_signal_watcher(timeA,dataA,timeB,dataB,[26100,26600])

posfinder(data.time,data.data,0,24)
%[r1,f1]=edge_counter(dataA,timeA,[2000,15000])
%[r2,f2]=edge_counter(dataA,timeA,[15000,27000])
%[r3,f3]=edge_counter(dataA,timeA,[27000,40000])

%[r4,f4]=edge_counter(dataB,timeB,[2000,15000])
%[r5,f5]=edge_counter(dataB,timeB,[15000,27000])
%[r6,f6]=edge_counter(dataB,timeB,[27000,40000])




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [newdata]=schmitt(data)
    newdata=[];
    
    for i=1:numel(data)
        if data(i)>=1.95
            newdata(end+1)=3.3;

        elseif data(i)<=1.35
            newdata(end+1)=0;
        else
            newdata(end+1)=newdata(end);

        end
    end
end

function V=adc2V(data)
V=[];
for i=1:numel(data)
    V(end+1)=double(data(i))*3.3/4095;
end
end

function [rise,fall]=edge_counter(data,time,interval)
    V=schmitt(adc2V(data));
    fall=0;
    rise=0;
    state=V(interval(1));

    for i=interval(1):interval(end)
        if state==0 && V(i)==3.3
            rise=rise+1;
            state=3.3;
        end
        if state==3.3&& V(i)==0
            fall=fall+1;
            state=0;
        end
    end
end
function []=AB_signal_watcher(timeA,dataA,timeB,dataB,period)
    Va=adc2V(dataA);
    Vb=adc2V(dataB);
    A=schmitt(Va);
    B=schmitt(Vb);
    

    plot(timeA(period(1):period(2)),A(period(1):period(2)),'LineWidth',6,'Color','r')
    hold on
    plot(timeA(period(1):period(2)),B(period(1):period(2)),'LineWidth',4,'Color','b')
    title('Encoder B Signal while Rotating Counter-Clockwise','FontSize',20)
    legend('A signal','B signal','FontSize',20)
    grid on 
    grid minor
end
function []=posfinder(time,data,count0,PPR)
    data=double(data);
    RelativePulse=data-count0;
    poslist=[];
    
    velolist=[];
    for i=1:numel(RelativePulse)
        poslist(end+1)=RelativePulse(i);
        if numel(poslist)>10000
            poslist=poslist(2:end);
           
        end
        velolist(end+1)=(poslist(end)-poslist(1))/9000;
    end
    rad=RelativePulse*2*pi/PPR;
    angularV=velolist*2*pi/PPR;
    %plot(time,rad)
    hold on
    plot(time,RelativePulse,'LineWidth',4)
    xlabel('Time (s)','FontSize',20)
    ylabel('Relative Pulses (Pulse)','FontSize',20)
    title('Encoder Relative Pulses','FontSize',20)
    grid on
    grid minor
end