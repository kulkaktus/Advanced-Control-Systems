%% Ex. 1.1.2
stepSize = 1/10;
limit = 1500;

sum = 0;
for w = -limit:stepSize:limit
    sum = sum + 16*(w^2 + 1)/(w^4 + 13*w^2 + 36)*stepSize;
end
solution = sqrt(sum/(2*pi))