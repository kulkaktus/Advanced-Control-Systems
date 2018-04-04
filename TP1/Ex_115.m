%% Ex. 1.1.5
sys = tf([4,4], [1,5,6]);
twoNorm = norm(sys, 2);
infNorm = norm(sys, inf);