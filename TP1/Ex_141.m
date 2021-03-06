%% Ex. 1.4.1
load('TorMod.mat')
Te = 0.04; 

n = 8; 
MM = 0.6;
z = tf('z',Te); 
w_c = 2; 
 
phi = conphi('Laguerre',[Te , 0 , n],'z',z/(z-1));  
Ld = w_c/z; 
per = conper('LS',[MM,8,50],Ld); 
K = condes(G3,phi,per); 
K = minreal(K,10^-3)
T3=feedback(G3*K, 1); 
U3=feedback(K, G3); 
RtoU = feedback(K,G3); %Play with parameters (n, w_c, modulus margin) until pole zero cancellation disappears. have fun

figure(1) 
step(T3)
figure(2) 
bode(U3)
figure(3)
step(U3)


NyquistConstr(K, G3, per);

%%
%% Ex. 1.4.1
load('TorMod.mat')
Te = 0.04; 

n = 7; 
MM = 0.6;
z = tf('z',Te); 
s = tf('s'); 
w_c = 2; 
 
phi = conphi('Laguerre',[Te , 0 , n],'z',z/(z-1));  
Ld = w_c/s; 
per = conper('LS',[MM,8,50],Ld); 
w=0.1:0.5:pi/Te;
opt=condesopt('w',w);
K = condes(G3,phi,per, opt); 
 
T3=feedback(G3*K, 1); 
U3=feedback(K, G3); 
RtoU = feedback(K,G3); %Play with parameters (n, w_c, modulus margin) until pole zero cancellation disappears. have fun
stepinfo(T3)
figure(1) 
step(T3); 
figure(2) 
bode(U3)
figure(3)
step(U3)

K
 
NyquistConstr(K, G3, per);