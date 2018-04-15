%% TP1

load ('data1.mat')
Ts=0.04;
Z=iddata(y,u,Ts);
Zd=detrend(Z);
G1 = oe(Zd,[4 6 2]);
G1f=spa(Zd,200);


P = nyquistoptions;
P.ConfidenceRegionDisplaySpacing=1;
P.ShowFullContour='off';
P.Xlim=[-1 1];
P.Ylim=[-0.7 1.6]; 
figure(1);h=nyquistplot(G1f,P); % Show true noise and clunky nyquist plot since few data points.
axis equal ; 
showConfidence(h,2);

figure(2); h=nyquistplot(G1,P); % Estimated transfer func and therefore 
                                % smooth, small parameter uncertainty which does not neceserly represent true noise
axis equal ; 
showConfidence(h,2);
%% data2
load Data/data2;

Z=iddata(y,u,Ts);
Zd=detrend(Z);
G2 = oe(Zd,[4 6 2]);
G2f=spa(Zd,200);

figure(3);h=nyquistplot(G2f,P); 
axis equal ; 
showConfidence(h,2);
figure(4);h=nyquistplot(G2,P);
axis equal ; 
showConfidence(h,2);

%% Data3
load Data/data3;

Z=iddata(y,u,Ts);
Zd=detrend(Z);
G3 = oe(Zd,[4 6 2]);
G3f=spa(Zd,200);

figure(5);h=nyquistplot(G3f,P); 
axis equal ; 
showConfidence(h,2);
figure(6);h=nyquistplot(G3,P);
axis equal ; 
showConfidence(h,2);
load Data/data3;
%% Multimodel uncertainty, G3 is the best nomial model

Gmm = stack(1,G1,G2,G3);
Gnom1 = G1;
Gnom2 = G2;
Gnom3 = G3;
[Gu,info1] = ucover(Gmm,Gnom1);
[Gu,info2] = ucover(Gmm,Gnom2);
[Gu,info3] = ucover(Gmm,Gnom3);
W2_1 = info1.W1opt;
W2_2 = info2.W1opt;
W2_3 = info3.W1opt;
plot(W2_1,'r')
hold on
plot(W2_2,'g')
plot(W2_3)
hold off