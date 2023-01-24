v1 = [3; -0.6; 1.5];
v2 = [4; -4.8; 0.4];
v3 = [4; -7.8; -10.8];


y1_hat=v1 / norm(v1);

y2=v2 - ((v2.'*y1_hat).*y1_hat);

y2_hat = y2 / norm(y2);

y3=v3 - ((v3.'*y1_hat).*y1_hat) - ((v3.'*y2_hat).*y2_hat);

y3_hat = y3 / norm(y3);