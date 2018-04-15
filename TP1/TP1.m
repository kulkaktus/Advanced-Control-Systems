clear all;
close all,

clc;

%%
% % I.1 Norm of signals and systems
% s = tf('s');
% G = 4*(s+1)/(s*s+5*s+6);
% 
% fun = @(w) 4^2*(w.^2+1)./((6-w.^2).^2+(5*w).^2);%function G?
% norm2_freq = sqrt((1/(2*pi))*integral(fun,-Inf,inf))
% 
% 
% dt = 1e-5;
% t = 0:dt:10;
% g = impulse(G,t);
% 
% norm2_impl = sqrt(sum(g.^2)*dt)%= sqrt(g'*g*dt) %idem same computation
% norm_2_valid = norm(G,2) %v?rification
% 
% w = 0 : 0.1 : 1000;
% [mag,phase] = bode(G,w);
% norm_inf = max(mag)
% 
% norm_Inf_valid = norm(G,Inf)
% 

%%
% % %I.2Uncertainty modeling


load data1
Ts=0.04;
Z=iddata(y,u,Ts);
Zd=detrend(Z);
G1 = oe(Zd,[4 6 2]);%first model
G1f=spa(Zd,200);%second model

P = nyquistoptions;
P.ConfidenceRegionDisplaySpacing=1;
P.ShowFullContour='off';
P.Xlim=[-1 1];
P.Ylim=[-0.3 1.6];
figure(1);h=nyquistplot(G1f,P);
hold on
axis equal ; showConfidence(h,2);

figure(1);h=nyquistplot(G1,P);
axis equal ; showConfidence(h,2);





%data2
load TorMod.mat
Ts=0.04;
Z=iddata(y,u,Ts);
Zd=detrend(Z);
G2 = oe(Zd,[4 6 2]);%first model
G2f=spa(Zd,200);%second model

P = nyquistoptions;
P.ConfidenceRegionDisplaySpacing=1;
P.ShowFullContour='off';
P.Xlim=[-1 1];
P.Ylim=[-0.3 1.6];
figure(2);h=nyquistplot(G2f,P);
hold on
axis equal ;hold on showConfidence(h,2);

figure(2);h=nyquistplot(G2,P);
axis equal ; showConfidence(h,2);



%data3
load data3
Ts=0.04;
Z=iddata(y,u,Ts);
Zd=detrend(Z);
G3 = oe(Zd,[4 6 2]);%first model
G3f=spa(Zd,200);%second model

P = nyquistoptions;
P.ConfidenceRegionDisplaySpacing=1;
P.ShowFullContour='off';
P.Xlim=[-1 1];
P.Ylim=[-0.3 1.6];
figure(3);h=nyquistplot(G3f,P);
hold on
axis equal ; showConfidence(h,2);

figure(3);h=nyquistplot(G3,P);
axis equal ; showConfidence(h,2);



Gmm=stack(1,G1,G2,G3);
Gnom1 = G1;
Gnom2 = G2;
Gnom3 = G3;
[Gu,info]=ucover(Gmm,Gnom1);
W2_1=info.W1opt %choosing the nom model with the smalest w2
[Gu,info]=ucover(Gmm,Gnom2);
W2_2=info.W1opt
[Gu,info]=ucover(Gmm,Gnom3);
W2_3=info.W1opt

figure(4);h=bodeplot (W2_1);
hold on
figure(4);h=bodeplot (W2_2);
hold on
figure(4);h=bodeplot (W2_3);
legend('G1','G2','G3');%G3 is the best choice for the nominal model (the smalest w2)


%% Robust PID controller
%TorMod
load TorMod
Ts=0.04;

G{1}=G1;
G{2}=G2;
G{3}=G3;

% Gain margin, Phase margin, wc, Ku, wh(Ku)
par = [2, 30];
phi=conphi('PID',Ts,'z');          %controller configuration : PID PI ... in s or z... here continuous-time PID controller
per=conper('GPhC',par);     %control performance
K=condes(G,phi,per)        %to design controller

NyquistConstr(K,G,per)
% NyquistConstr(K,G1,per)
% NyquistConstr(K,G2,per)
% NyquistConstr(K,G3,per)


S{1} = feedback(1, G1*K);
T{1} = feedback(G{1}*K, 1);
U{1} = feedback(K, G{1});

S{2} = feedback(1, G{2}*K);
T{2} = feedback(G{2}*K, 1);
U{2} = feedback(K, G{2});

S{3} = feedback(1, G{3}*K);
T{3} = feedback(G{3}*K, 1);
U{3} = feedback(K, G{3});

figure(4)
step(T{1})
hold on
step(T{2})
hold on
step(T{3})

figure(5)
step(S{1})
hold on
step(S{2})
hold on
step(S{3})

figure(6)
step(U{1})
hold on
step(U{2})
hold on
step(U{3})


figure(7)
bode(U{1})
bode(U{2})
bode(U{3})
%%
%Loop Shaping Controller

par = [0.6];% param gain margin 0.6

z = tf('z',Ts);
s = tf('s');

F=z/(z-1);
a=0;%fixe
n=6;%n_th order (number of variables) (choose n<10)


phi=conphi('Laguerre',[Ts,a,n],'z',F);          %controller configuration : PID PI ... in s or z... here continuous-time PID controller
wc=5%2*pi/3;% w=2*pi*f=2*pi/T  larger wc faster response
Ld=wc/s;
per=conper('LS',par,Ld);                   %control performance
K=condes(G{3},phi,per)                    %to design controller


NyquistConstr(K,G{3},per)

figure(2)
margin(G{3})


% S{3} = feedback(1, G{3}*K);
% T{3} = feedback(G{3}*K, 1);
% U{3} = feedback(K, G{3});
% step(T{3})

%% Robust H_inf Controller


