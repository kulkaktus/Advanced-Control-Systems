load('TP1/TorMod.mat')

T = 0.04;
CorD = 'z';
w_cross = 1;
par = [2, 30];

phi = conphi ('PID', T, 'z');

per{1} = conper ('GPhC', par);
per{2} = conper ('GPhC', par);
per{3} = conper ('GPhC', par);

G = {G1, G2, G3};

K = condes(G, phi, per);

NyquistConstr(K, G(1), conper ('GPhC', par));
NyquistConstr(K, G(2), conper ('GPhC', par));
NyquistConstr(K, G(3), conper ('GPhC', par));

S1=feedback(1,G1*K);
S2=feedback(1,G2*K);
S3=feedback(1,G3*K);
T1=feedback(G1*K, 1);
T2=feedback(G2*K, 1);
T3=feedback(G3*K, 1);
U1=feedback(K, G1);
U2=feedback(K, G2);
U3=feedback(K, G3);
figure(4)
hold on
step(T1);step(T2);step(T3)
hold off
figure(5)
hold on
bode(U1);bode(U2);bode(U3)
hold off
figure(6)
hold on
bode(S1);bode(S2);bode(S3)
hold off