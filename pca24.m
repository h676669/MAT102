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
load('pcaeksempel.mat')

% Antall prinsipalkomponentar eg ønskjer å finne i matrisa X
a = 3;

% Først preprosesserer eg matrisa slik at kvar kolonne får gjennomsnitt 0
% og standardavvis 1.
[n,m] = size(X);    % n = antall objekt (land)
                    % m = antall variablar (matvarer)
meanX = mean(X);    % Gjennomsnittet av kvar kolonne i matrisa X
stdX = std(X);      % Standardavviket i kvar kolonne i matrisa X.
for j = 1:m
    X(:,j) = X(:,j) - meanX(j); % Trekker gjennomsnittet av kolonne j 
                                % frå kolonne j
    if stdX(j)~=0
        X(:,j)= X(:,j)/stdX(j); % Dividerer kolonne j med standardavviket 
                                % til kolonne j.
    end
end
Xnorm = X;                      % Preprosessert matrise.

% Bruker NIPALS-metoden for å finne dei a største eigenvektorane til 
% transponert(X)X (prinsipalkomponentane til X). 
% NIPALS-algoritma er beskrevet i kompendiet på s.331.

% Initialiserer scores/loadingmatrisa som 0-matriser.
T = zeros(n,a); 
P = zeros(m,a);

% NIPAL
for i=1:a
    t_old = rand(n,1);
    p = Xnorm'*t_old;
    p = p/norm(p); % Normaliserer p til lengde 1.
    t = Xnorm*p;
    while (norm(t-t_old)>0.00001)
        p = Xnorm'*t;
        p = p/norm(p);
        t_old = t;
        t = Xnorm*p;
    end
    T(:,i) = t;     % Scores
    P(:,i) = p;     % Loading
    Xnorm = Xnorm - t*p';
end

% Finner forklart variasjon av dei a prinsipalkoeffisientane.
trX = trace(X'*X);      % Trace av standardisert matrise X
trT = trace(T'*T);      % Trace av scoresmatrisa
fprintf('Forklart variasjon med %d prinsipalkomponenter er: %4.2f\n',a,trT/trX*100)

% Plotter scoresmatrisa (dei to første prinsipalkomponentane).
figure
scatter(T(:,1), T(:,2))
text(T(:,1)+.1, T(:,2),names)
hold on
plot(0,0,'or')  % Teiknar inn origo (som referanse)
grid on
%Plotter loadingmatrisa.
figure
scatter(P(:,1), P(:,2))
text(P(:,1)+.01, P(:,2),varnames)
hold on
plot(0,0,'or')  % Teiknar inn origo (som referanse)
grid on

return 
% Viss ein finner dei 3 første prinsipalkomponentane:

% Plotter dei 3 første prinsipalkomtonentane i eit 3d koordinatsystem
figure
scatter3(T(:,1), T(:,2),T(:,3))
text(T(:,1)+0.1, T(:,2), T(:,3),names)
hold on
plot3(0,0,0,'or')  % Teiknar inn origo (som referanse)
grid on
figure
scatter3(P(:,1), P(:,2),P(:,3))
text(P(:,1)+0.01, P(:,2), P(:,3),varnames)
hold on
plot3(0,0,0,'or')  % Teiknar inn origo (som referanse)
grid on
return

% % Plotter 1. og 3. prinsipalkomponent
% figure
% scatter(T(:,1), T(:,3))
% text(T(:,1)+.1, T(:,3),names)
% hold on
% plot(0,0,'or')  % Teiknar inn origo (som referanse)
% grid on
% % Plotter loadingmatrisa.
% figure
% scatter(P(:,1), P(:,3))
% text(P(:,1)+.01, P(:,3),varnames)
% hold on
% plot(0,0,'or')  % Teiknar inn origo (som referanse)
% grid on

% % Plotter 2. og 3. prinsipalkomponent
% figure
% scatter(T(:,2), T(:,3))
% text(T(:,2)+.1, T(:,3),names)
% hold on
% plot(0,0,'or')  % Teiknar inn origo (som referanse)
% grid on
% % Plotter loadingmatrisa.
% figure
% scatter(P(:,2), P(:,3))
% text(P(:,2)+.01, P(:,3),varnames)
% hold on
% plot(0,0,'or')  % Teiknar inn origo (som referanse)
% grid on



