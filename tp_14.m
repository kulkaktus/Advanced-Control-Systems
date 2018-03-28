Te = 0.04;
n=6;
z = tf('z',Te);
s = tf('s');
w_c = 5;

phi = conphi('Laguerre',[Te , 0 , n],'z',z/(z-1)); 
Ld = w_c/s;
per = conper('LS',[0.6, 1, 10],Ld);
K = condes(G3,phi,per);

T3=feedback(G3*K, 1);
U3=feedback(K, G3);

figure(1)
step(T3);
figure(2)
bode(U3)

figure(3)
NyquistConstr(K, G(3), per);