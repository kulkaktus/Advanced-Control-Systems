T = 0.04;
CorD = 'z';
w_cross = 0;
par = [2, 30, w_cross];


phi = conphi ('PID', T, 'z');

per{1} = conper ('GPhC', par);
per{2} = conper ('GPhC', par);
per{3} = conper ('GPhC', par);

G = {G1, G2, G3};

K = condes(G, phi, per);

NyquistConstr(K, G, per)

S=feedback(1, G*K);
T=feedback(G*K, 1);
U=feedback(K, G);

step(T)
bode(U)
bode(S)