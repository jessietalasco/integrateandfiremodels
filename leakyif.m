%% basic leaky if
y1=zeros(1,100);
y1(1)=-65;
yrest=-65;
R=1e6;
x=zeros(1,100);
x(10:70)=6e-5;
tau=.5e-3;
h=tau/10;
thresh=-20;
spikes=[];
for i=2:100
    y1(i)=y1(i-1)*(1-h/tau)+h/tau*(yrest+R*x(i-1));
    if y1(i)>=thresh
        y1(i)=yrest;
        spikes=[spikes i];

    end

    end

t=(1:100)*h*1000;
figure
subplot(2,1,1)
plot(t,x)
xlabel('time(ms)')
ylabel('I')
title('Input Current')

subplot(2,1,2)
plot(t,y1)
xlabel('time(ms)')
ylabel('Membrane Voltage (mV)')
title('Voltage Response')
hold on

plot(t(spikes),y1(spikes),'x')
%% Exponential IF
y1=zeros(1,100);
y1(1)=-65;
yrest=-65;
R=1e6;
x=zeros(1,100);
x(10:70)=6e-5; 
tau=.5e-3;
h=tau/10;
thresh=-20;
sharp=5;
rbv=-50;
spikes=[];
for i=2:100
    y1(i)=h/tau*(-(y1(i-1)-yrest)+sharp*exp((y1(i-1)-rbv)/sharp)+R*x(i-1))+y1(i-1);
    if y1(i)>=thresh
        y1(i)=yrest;
        spikes=[spikes i];

    end
end

t=(1:100)*h*1000;
figure
subplot(2,1,1)
plot(t,x)
xlabel('time(ms)')
ylabel('I')
title('Input Current')

subplot(2,1,2)
plot(t,y1)
xlabel('time(ms)')
ylabel('Membrane Voltage (mV)')
title('Voltage Response')
hold on

plot(t(spikes),y1(spikes),'x')
%% Quadratic IF
y1=zeros(1,100);
y1(1)=-65;
yrest=-65;
R=1e6;
x=zeros(1,100);
x(10:70)=6e-5; 
tau=.5e-3;
h=tau/10;
thresh=-20;
yc=-45;
a0=.5;
spikes=[];
for i=2:100
    y1(i)=h/tau*(a0*(y1(i-1)-yrest)*(y1(i-1)-yc)+R*x(i-1))+y1(i-1);
    if y1(i)>=thresh
        y1(i)=yrest;
        spikes=[spikes i];

    end
end

t=(1:100)*h*1000;
figure
subplot(2,1,1)
plot(t,x)
xlabel('time(ms)')
ylabel('I')
title('Input Current')

subplot(2,1,2)
plot(t,y1)
xlabel('time(ms)')
ylabel('Membrane Voltage (mV)')
title('Voltage Response')
hold on

 %% Adaptive Exponential IF
y1=zeros(1,100000);
y1(1)=-65;
wk=zeros(1,100000);
yrest=-65;
R=1e6;
x=zeros(1,100000);
x(10000:70000)=6e-5; 
tau=.5e-3;
h=tau/1000;
thresh=-20;
sharp=5;
rbv=-50;
spikes=[];
ak=-0.000002;
bk=12;
tauk=.05;
for i=2:100000
    y1(i)=h/tau*(-(y1(i-1)-yrest)+sharp*exp((y1(i-1)-rbv)/sharp)+R*x(i-1)-R*wk(i-1))+y1(i-1);
    if y1(i)>=thresh
        wk(i)=h/tauk*(-ak*(y1(i-1)-yrest)-wk(i-1)+bk*tauk)+wk(i-1);
        y1(i)=yrest;
        spikes=[spikes i];
    else
        wk(i)=h/tauk*(ak*(y1(i-1)-yrest)-wk(i-1))+wk(i-1);

    end
end

t=(1:100000)*h*1000;
figure
subplot(3,1,1)
plot(t,x)
xlabel('time(ms)')
ylabel('I')
title('Input Current')

subplot(3,1,2)
plot(t,y1)
xlabel('time(ms)')
ylabel('Membrane Voltage (mV)')
title('Voltage Response')
hold on

plot(t(spikes),y1(spikes),'x')

subplot(3,1,3)
plot(t,wk)
xlabel('time(ms)')
ylabel('wk')
title('Adaptive Variable')
hold on


