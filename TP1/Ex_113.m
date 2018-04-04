%% Ex. 1.1.3
Ts = 1; %The 2-norm depends wholly on the sampling period, but we made no
        %assumptions on the sampling period when calculating the norm in
        %the frequency domain. I don't understand how we can compare the
        %two. 

% sys1 and sys2 represent the same system, but they are discretized a bit
% differently. None of them give the expected result.
sys1 = c2d(tf([4,4], [1,5,6]), Ts, 'zoh');
sys2 = tf([4,4], [1,5,6]);
[y1,t1] = impulse(sys1);
[y2,t2] = impulse(sys2, 0:Ts:max(t1));

sum1 = 0;
sum2 = 0;
for i = 1:length(y1)
    sum1 = sum1 + (y1(i))^2;
    sum2 = sum2 + (y2(i))^2;
end
solution1 = sqrt(sum1) % This is supposed to be 1.3663
solution2 = sqrt(sum2)