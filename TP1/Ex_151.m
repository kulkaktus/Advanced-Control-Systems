load('TorMod.mat')
Te = 0.04;
Gmm = stack(1,G1,G2,G3);
[Gu,info]=ucover(Gmm,G3);
W{2} = info.W1opt;
z = tf('z',Te);
s = tf('s');
w_c = 6;
W{1} = w_c/s; % We choose W1 as an integrator because this will force S to be small at low frequencies.
L_d = w_c/s;
phi=conphi('PID',Te);
hinfper=conper('Hinf',W,L_d);
w = logspace(-1,4,500);
opt = condesopt('gamma',[0.01 2 0.001],'lambda',[1 1 0 0],'w',w);
K = condes(G3,phi,hinfper)