% Dette scriptet finner dei a første prinsipalkomponentane til ei 
% datamatrise X1. Frå scriptet får vi:
% T = scores matrisa (koordinatane til prinsipalkomponentane)
% P = loading matrisa (prinsipalkomponentane til X).
% Grafisk framstilling av prinsipalkomponentane.
% Forklart variasjon av prinsipalkomponentane.

% Laster inn datamatrisa.
load Arbeidskrav3.mat

% Antall prinsipalkomponentar eg ønskjer å finne i matrisa X
a = 2;  % Set to 2 since task 2 asks for the first two components

% Først preprosesserer eg matrisa slik at kvar kolonne får gjennomsnitt 0
% og standardavvik 1.
[n,m] = size(X1);    % n = antall objekt, m = antall variablar
meanX1 = mean(X1);   % Gjennomsnittet av kvar kolonne i matrisa X
stdX1 = std(X1);     % Standardavviket i kvar kolonne i matrisa X.

for j = 1:m
    X1(:,j) = X1(:,j) - meanX1(j); % Trekker gjennomsnittet av kolonne j 
    if stdX1(j) ~= 0
        X1(:,j) = X1(:,j) / stdX1(j); % Dividerer kolonne j med standardavviket 
    end
end
X1norm = X1;  % Preprosessert matrise.
%   0.0737   -0.0278   -0.0485    0.0149   -0.0417    0.0918    0.2085    0.0526    0.3268   -0.0112
%   0.1064   -0.0309   -0.0788   -0.0219    0.0432   -0.0976   -0.0333    0.1285    0.0099   -0.0410
%   0.0131    0.0141   -0.0308    0.0314    0.0724   -0.0542    0.1018   -0.0787    0.1134    0.0878
%  -0.1056    0.0747    0.0277    0.0405    0.1804   -0.1686   -0.1651   -0.1509   -0.3022    0.1008
%  -0.1295    0.0126    0.1274   -0.0246   -0.1947    0.1237   -0.0400   -0.1352   -0.1300   -0.0347
%  -0.0586   -0.0313    0.1004   -0.0828   -0.1234    0.0848   -0.2905    0.1118   -0.3734   -0.1091
%  -0.0950    0.0548    0.0362    0.0694    0.0329    0.1501    0.0800   -0.0302    0.1133   -0.0266
%   0.1956   -0.0662   -0.1336   -0.0269    0.0310   -0.1300    0.1385    0.1021    0.2422    0.0340

% Bruker NIPALS-metoden for å finne dei a største eigenvektorane til 
% transponert(X)X (prinsipalkomponentane til X). 
% NIPALS-algoritma er beskrevet i kompendiet på s.331.

% Initialiserer scores/loadingmatrisa som 0-matriser.
T = zeros(n,a); 
P = zeros(m,a);

% NIPAL Algorithm
for i = 1:a
    t_old = rand(n,1);  % Start with random initialization
    p = X1norm' * t_old;  % Calculate loading
    p = p / norm(p);      % Normalize loading to length 1
    t = X1norm * p;       % Calculate scores (projection onto p)
    
    % Iteratively update until convergence
    while norm(t - t_old) > 0.00001
        p = X1norm' * t;
        p = p / norm(p);  % Normalize p
        t_old = t;
        t = X1norm * p;   % Update t
    end
    
    % Store the calculated scores and loadings
    T(:,i) = t;     % Scores
    P(:,i) = p;     % Loadings
    
    % Deflate the data (remove explained variance)
    X1norm = X1norm - t * p';
end

% Finner forklart variasjon av dei a prinsipalkoeffisientane.
trX1 = trace(X1' * X1);    % Trace av standardisert matrise X
trT = trace(T' * T);       % Trace av scoresmatrisa (explained variance)
fprintf('Forklart variasjon med %d prinsipalkomponenter er: %4.2f%%\n', a, trT / trX1 * 100);
% 98.36%

% Task 2c: Plot the score plot of the first two principal components
figure;
scatter(T(:,1), T(:,2));
text(T(:,1) + 0.1, T(:,2), objNames1);  % Annotate with object names
xlabel('First Principal Component');
ylabel('Second Principal Component');
title('Score Plot (PC1 vs PC2)');
hold on;
plot(0,0,'or');  % Origo (as reference)
grid on;

% Task 2d: Check if the taste panel is consistent (compare 5a and 5b)
distance_5a_5b = norm(T(5,:) - T(6,:));  % Distance between the two trials (5a, 5b)
fprintf('Avstand mellom 5a og 5b: %f\n', distance_5a_5b);  % Output the distance

% Task 2f: Plot the loadings for the first two principal components
figure;
scatter(P(:,1), P(:,2));
text(P(:,1) + 0.01, P(:,2), varNames1);  % Annotate with variable names
xlabel('First Principal Component');
ylabel('Second Principal Component');
title('Loadings Plot (PC1 vs PC2)');
hold on;
plot(0,0,'or');  % Origo (as reference)
grid on;

% Additional task 2g: PCA for X2 with the extra substance
% Preprocess X2 in the same way as X1
[n2,m2] = size(X2);
meanX2 = mean(X2);
stdX2 = std(X2);

for j = 1:m2
    X2(:,j) = X2(:,j) - meanX2(j);  % Subtract mean
    if stdX2(j) ~= 0
        X2(:,j) = X2(:,j) / stdX2(j);  % Divide by standard deviation
    end
end

X2norm = X2;  % Preprocessed X2

% NIPALS for X2
T2 = zeros(n2, a);
P2 = zeros(m2, a);

for i = 1:a
    t_old = rand(n2,1);
    p = X2norm' * t_old;
    p = p / norm(p);
    t = X2norm * p;
    
    while norm(t - t_old) > 0.00001
        p = X2norm' * t;
        p = p / norm(p);
        t_old = t;
        t = X2norm * p;
    end
    
    T2(:,i) = t;
    P2(:,i) = p;
    X2norm = X2norm - t * p';
end

% Explained variance for X2
trX2 = trace(X2' * X2);
trT2 = trace(T2' * T2);
fprintf('Forklart variasjon med %d prinsipalkomponenter for X2 er: %4.2f%%\n', a, trT2 / trX2 * 100);

% Plot the score plot for X2
figure;
scatter(T2(:,1), T2(:,2));
text(T2(:,1) + 0.1, T2(:,2), objNames2);
xlabel('First Principal Component');
ylabel('Second Principal Component');
title('Score Plot for X2 (PC1 vs PC2)');
hold on;
plot(0,0,'or');  % Origo (as reference)
grid on;

% Plot the loadings for X2
figure;
scatter(P2(:,1), P2(:,2));
text(P2(:,1) + 0.01, P2(:,2), varNames2);
xlabel('First Principal Component');
ylabel('Second Principal Component');
title('Loadings Plot for X2 (PC1 vs PC2)');
hold on;
plot(0,0,'or');  % Origo (as reference)
grid on;
