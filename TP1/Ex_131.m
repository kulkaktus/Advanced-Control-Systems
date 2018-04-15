load('TorMod.mat')
Ts = 0.04;
%w_cross = 0;
par = [2, 30];


phi = conphi ('PID', Ts, 'z');

per = conper ('GPhC', par);

G = {G1, G2, G3};

K = condes(G, phi, per);

NyquistConstr(K, G1, per)
NyquistConstr(K, G2, per)
NyquistConstr(K, G3, per)

S1=feedback(1, G1*K);
S2=feedback(1, G2*K);
S3=feedback(1, G3*K);

T1=feedback(G1*K, 1);
T2=feedback(G2*K, 1);
T3=feedback(G3*K, 1);
U1=feedback(K, G1);
U2=feedback(K, G2);
U3=feedback(K, G3);
figure(4)
step(T1,T2,T3)
figure(5)
bode(U1,U2,U3)
figure(6)
bode(S1,S2,S3)