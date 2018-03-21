T = 0.04;
CorD = 'z';
w_cross = 0;
par = [2, 30, w_cross, 1];

phi = conphi ('PID', T, 'z', 1);
per = conper ('GPhC', par);

condes = 