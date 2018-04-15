load('TorMod.mat')
Te = 0.04;
Gmm = stack(1,G1,G2,G3);
[Gu,info]=ucover(Gmm,G3);
s = tf('s');
z = tf('z',Te);
w_c = 2;
W{1} = w_c/s; % We choose W1 as an integrator because this will force S to be small at low frequencies.
W{2} = info.W1opt;% ikke sikkert vi trenger tfest
W{3} = tf(0.1);

L_d = w_c/s;
phi = conphi('Laguerre',[Te , 0 ,7],'z',z/(z+1));
hinfper = conper('Hinf',W,L_d);
%w = 0.1:0.5:pi/Te;
w=logspace(-1,4,500);
opt = condesopt('gamma',[0.01 2 0.01],'lambda',[1 1 0 0],'w',w);
%opt.nq=[];
%opt.yalmip='on';
K = condes(G3,phi,hinfper,opt)
%%
T3=feedback(G3*K, 1); 
U3=feedback(K, G3); 

stepinfo(T3)
figure(1) 
step(T3); 
figure(2) 
bode(U3)
figure(3)
step(U3)
NyquistConstr(K, G3 , hinfper);
