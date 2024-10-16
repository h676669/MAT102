% Dette scriptet finner dei a første prinsipalkomponentane til ei 
% datamatrise X. Frå scriptet får vi:
% T = scores matrisa (koordinatane til prinsipalkomponentane)
% P = loading matrisa (prinsipalkomponentane til X).
% Grafisk framstilling av prinsipalkomponentane.
% Forklart variasjon av prinsipalkomponentane.

% Laster inn datamatrisa.
% X - Datamatrisa
% names - namn på objekta
% varnames - namn på variablane
load Arbeidskrav3.mat

% Antall prinsipalkomponentar eg ønskjer å finne i matrisa X
a = 2;

% Først preprosesserer eg matrisa slik at kvar kolonne får gjennomsnitt 0
% og standardavvis 1.
[n,m] = size(X1);    % n = antall objekt (land)
                    % m = antall variablar (matvarer)
meanX1 = mean(X1);    % Gjennomsnittet av kvar kolonne i matrisa X
stdX1 = std(X1);      % Standardavviket i kvar kolonne i matrisa X.
for j = 1:m
    X1(:,j) = X1(:,j) - meanX1(j); % Trekker gjennomsnittet av kolonne j 
                                % frå kolonne j
    if stdX1(j)~=0
        X1(:,j)= X1(:,j)/stdX1(j); % Dividerer kolonne j med standardavviket 
                                % til kolonne j.
    end
end
X1norm = X1;                      % Preprosessert matrise.

% Bruker NIPALS-metoden for å finne dei a største eigenvektorane til 
% transponert(X)X (prinsipalkomponentane til X). 
% NIPALS-algoritma er beskrevet i kompendiet på s.331.

% Initialiserer scores/loadingmatrisa som 0-matriser.
T = zeros(n,a); 
P = zeros(m,a);

% NIPAL
for i=1:a
    t_old = rand(n,1);
    p = X1norm'*t_old;
    p = p/norm(p); % Normaliserer p til lengde 1.
    t = X1norm*p;
    while (norm(t-t_old)>0.00001)
        p = X1norm'*t;
        p = p/norm(p);
        t_old = t;
        t = X1norm*p;
    end
    T(:,i) = t;     % Scores
    P(:,i) = p;     % Loading
    X1norm = X1norm - t*p';
end

% Plotter scoresmatrisa (dei to første prinsipalkomponentane).
figure
scatter(T(:,1), T(:,2))
text(T(:,1)+.1, T(:,2),objNames1)
hold on
plot(0,0, 'or') %tegner inn i origo for å ha et referansepunkt
grid on


% Finner forklart variasjon av dei a prinsipalkoeffisientane.
trX1 = trace(X1'*X1);      % Trace av standardisert matrise X
trT = trace(T'*T);      % Trace av scoresmatrisa
fprintf('Forklart variasjon med %d prinsipalkomponenter er: %4.2f\n',a,trT/trX1*100)

%plotter loading-martise
figure
scatter(P(:,1),P(:,2))
text(P(:,1)+.01, P(:,2),varNames1)
hold on
plot(0,0,'or') %tegner origo for referansepunkt
grid on

avstand_5a_5b = norm(T(5,:) - T(6,:));
fprintf('Avstand mellom 5a og 5b: %f\n', avstand_5a_5b);  % Output the distance


a2 = 2;
[n2,m2] = size(X2);    % n = antall objekt (land)
                    % m = antall variablar (matvarer)
meanX2 = mean(X2);    % Gjennomsnittet av kvar kolonne i matrisa X
stdX2 = std(X2);      % Standardavviket i kvar kolonne i matrisa X.
for j = 1:m2
    X2(:,j) = X2(:,j) - meanX2(j); % Trekker gjennomsnittet av kolonne j 
                                % frå kolonne j
    if stdX2(j)~=0
        X2(:,j)= X2(:,j)/stdX2(j); % Dividerer kolonne j med standardavviket 
                                % til kolonne j.
    end
end
X2norm = X2;                      % Preprosessert matrise.

% Bruker NIPALS-metoden for å finne dei a største eigenvektorane til 
% transponert(X)X (prinsipalkomponentane til X). 
% NIPALS-algoritma er beskrevet i kompendiet på s.331.

% Initialiserer scores/loadingmatrisa som 0-matriser.
T2 = zeros(n2,a2); 
P2 = zeros(m2,a2);

% NIPAL
for i2=1:a2
    t_old2 = rand(n2,1);
    p2 = X2norm'*t_old2;
    p2 = p2/norm(p2); % Normaliserer p til lengde 1.
    t2 = X2norm*p2;
    while (norm(t2-t_old2)>0.00001)
        p2 = X2norm'*t2;
        p2 = p2/norm(p2);
        t_old2 = t2;
        t2 = X2norm*p2;
    end
    T2(:,i2) = t2;     % Scores
    P2(:,i2) = p2;     % Loading
    X2norm = X2norm - t2*p2';
end

% Plotter scoresmatrisa (dei to første prinsipalkomponentane).
figure
scatter(T2(:,1), T2(:,2))
text(T2(:,1)+.1, T2(:,2),objNames2)
hold on
plot(0,0, 'or') %tegner inn i origo for å ha et referansepunkt
grid on

% Finner forklart variasjon av dei a prinsipalkoeffisientane.
trX2 = trace(X2'*X2);      % Trace av standardisert matrise X
trT2 = trace(T2'*T2);      % Trace av scoresmatrisa
fprintf('Forklart variasjon med %d prinsipalkomponenter er: %4.2f\n',a,trT2/trX2*100)



