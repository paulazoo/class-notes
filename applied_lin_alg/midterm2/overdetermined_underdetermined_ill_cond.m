%% Overdetermined
clc
A =[8 3; -8 9; 2 -1; -9 3];
b =[7; 1; 3; -2];

%---------------------
ATA = A'*A

det_ATA = det(ATA)
[ATA(2,2) -(ATA(1,2)); -ATA(2,1) ATA(1,1)]
inv_ATA = (1/det_ATA) .* [ATA(2,2) -(ATA(1,2)); -ATA(2,1) ATA(1,1)]
AT_b = A' * b
x = inv_ATA * AT_b

%% Underdetermined
clc
A=[ 8 2 3
-8 -9 9 ];
b=[ -1
3 ];

%---------------------
disp('do svd:')
[U, sigma, V] = svd(A)

Spsuedo = (sigma.^(-1)).';
Spsuedo(Spsuedo == Inf) = 0;
V_Spsuedo = V * Spsuedo
Apsuedo = V_Spsuedo * U.'
x = Apsuedo * b


%% Ill-conditioned pt 1
clc
A=[ 8, 2, 3;
16, 4, 6];
b=[ 2;
3];

%---------------------
ATA = A.' * A

disp('do svd:')
[U, sigma, V] = svd(ATA)

%% Ill-conditioned pt 2
k = 1;

%---------------------
Spsuedo = 1./sigma;
Spsuedo(Spsuedo == Inf) = 0;
Spsuedo = Spsuedo.';
Spsuedo_ill = zeros(size(Spsuedo));
Spsuedo_ill(1:k,:) = Spsuedo(1:k,:)
V_ill = V(:, :)
U_ill = U(:, :)

V_Spsuedo = V_ill * Spsuedo_ill
ATApsuedo = V_Spsuedo * U_ill.'
ATApsuedo_AT = ATApsuedo * A.'
x = ATApsuedo_AT * b


