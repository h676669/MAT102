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
% Oppgave A
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
%{  
    0.0737   -0.0278   -0.0485    0.0149   -0.0417    0.0918    0.2085    0.0526    0.3268   -0.0112
    0.1064   -0.0309   -0.0788   -0.0219    0.0432   -0.0976   -0.0333    0.1285    0.0099   -0.0410
    0.0131    0.0141   -0.0308    0.0314    0.0724   -0.0542    0.1018   -0.0787    0.1133    0.0878
   -0.1056    0.0747    0.0277    0.0405    0.1804   -0.1686   -0.1651   -0.1509   -0.3022    0.1008
   -0.1295    0.0126    0.1274   -0.0246   -0.1947    0.1237   -0.0400   -0.1352   -0.1300   -0.0347
   -0.0586   -0.0313    0.1004   -0.0828   -0.1234    0.0848   -0.2905    0.1118   -0.3734   -0.1091
   -0.0950    0.0548    0.0362    0.0694    0.0329    0.1501    0.0800   -0.0302    0.1133   -0.0266
    0.1956   -0.0662   -0.1336   -0.0269    0.0310   -0.1300    0.1385    0.1021    0.2422    0.0340
%}

%Oppgave B
%{
Grunnen for at det er viktig å preprosessere matrisen er fordi at verdiene i
X1 ikkje er på samme verdiskala og dermed kan gjøre at nokon variabler
ikkje får den innflytelsen som den skal ha eller får ei mye støre
innflytelse på PCA-en en den skal ha. 
%}

%Oppgave C
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

%Oppgave D
%{
Ved å se på scorematrisen så ser vi at 5a og 5b er veldig nærme (har liten
forskjell mellom 5a og 5b) kvarandre og kan dermed konkludere med at
smakspanelet er konsistent
%}

%Oppgave E
% Finner forklart variasjon av dei a prinsipalkoeffisientane.
trX1 = trace(X1'*X1);      % Trace av standardisert matrise X
trT = trace(T'*T);      % Trace av scoresmatrisa
fprintf('Forklart variasjon med %d prinsipalkomponenter er: %4.2f\n',a,trT/trX1*100);
%Forklart variasjon med 2 prinsipalkomponenter er: 98.36

%Oppgave F
%{
En observasjon vi kan gjøre med å se på ploten er at 
%}
%plotter loading-martise
figure
scatter(P(:,1),P(:,2))
text(P(:,1)+.01, P(:,2),varNames1)
hold on
plot(0,0,'or') %tegner origo for referansepunkt
grid on

avstand = norm(T(5,:) - T(6,:));
fprintf('Avstand mellom 5a og 5b: %f\n', avstand);
%Avstand mellom 5a og 5b: 0.197531

%Oppgave G, Svar på oppgaven er nederst i scriptet

a2 = 2;
[n2,m2] = size(X2);   % n = antall objekt (land)
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
%{
    0.4327   -1.3401    0.9075   -0.2181    0.3313    0.2082    0.0786    0.2515    0.7915    0.0399    0.0288   -0.0900   -0.1732    0.1378    0.4464   -0.6784
    0.0457    0.6377   -0.6834    0.0556   -0.2723   -0.1738    0.0003   -0.1263   -0.0489   -0.1798    0.0472    0.1758    0.1873    0.0407   -0.0502    0.3452
   -0.2155    1.6625   -1.4470   -0.0831   -0.5624   -0.2606    0.1696    0.0325   -0.3542   -0.1300   -0.2485    0.1245    0.0376   -0.1313   -0.0790    0.9638
    0.0792   -0.9052    0.8260   -0.2410    0.3575    0.1130   -0.2533   -0.1515   -0.0027    0.1990   -0.0045   -0.2536   -0.1260    0.0588   -0.2284   -0.3875
   -0.1988    0.1203    0.0786    0.0176   -0.0280    0.0176    0.1052   -0.0596   -0.2138   -0.0280   -0.0410   -0.0481    0.0146   -0.0796   -0.1334    0.0412
   -0.1307    0.0929    0.0378    0.1103   -0.0803   -0.0564    0.0427   -0.3463   -0.2964    0.2502   -0.1779    0.1252   -0.0036   -0.1734   -0.3846   -0.0232
   -0.2492    0.4550   -0.2059    0.1765    0.0011   -0.0239    0.1204    0.0975   -0.1259   -0.2332    0.2533    0.0471    0.0151    0.0764    0.0762    0.1592
    0.1674   -0.3030    0.1356    0.1665    0.0844    0.0550   -0.1889    0.2360    0.1501    0.0338    0.0783    0.0306    0.0752    0.0575    0.2307   -0.1581
    0.3267   -1.4079    1.0812    0.1462    0.4629    0.2816   -0.3825   -0.0961    0.2813    0.1462    0.3393   -0.3546    0.1341    0.2084    0.1714   -0.6432
   -0.1490    0.6139   -0.4649    0.1100   -0.1748   -0.0376   -0.0527    0.3109   -0.1906    0.0399   -0.0703    0.0146    0.0133   -0.2879    0.1980    0.0405
   -0.3560    1.6250   -1.2690    0.0516   -0.3701   -0.0588    0.2879    0.0047   -0.4592   -0.1867   -0.1721    0.1657   -0.1021   -0.1753   -0.0165    0.7190
   -0.0112   -0.9958    1.0070    0.1382    0.2353   -0.1677   -0.0293   -0.1628    0.1183   -0.0050    0.2980    0.2960    0.0127    0.1634   -0.4068   -0.3691
   -0.2772    0.0316    0.2455    0.0430    0.1099   -0.0474    0.1053    0.0734   -0.2083   -0.0019   -0.1746    0.1340   -0.0542    0.2325   -0.2716    0.1624
   -0.0165    0.2661   -0.2496   -0.2193   -0.0030    0.0502    0.0402    0.1035   -0.0124   -0.0721   -0.0656   -0.2960    0.0227   -0.0672    0.1951    0.0590
    0.5524   -0.5530    0.0006   -0.2541   -0.0914    0.1006   -0.0435   -0.1672    0.5713    0.1277   -0.0903   -0.0711   -0.0535   -0.0607    0.2527   -0.2307
%}

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

%plotter loading-martise
figure
scatter(P2(:,1),P2(:,2))
text(P2(:,1)+.01, P2(:,2),varNames2)
hold on
plot(0,0,'or') %tegner origo for referansepunkt

% Finner forklart variasjon av dei a prinsipalkoeffisientane.
trX2 = trace(X2'*X2);      % Trace av standardisert matrise X
trT2 = trace(T2'*T2);      % Trace av scoresmatrisa
fprintf('Forklart variasjon med %d prinsipalkomponenter er: %4.2f\n',a,trT2/trX2*100);
%Forklart variasjon med 2 prinsipalkomponenter er: 85.95

%G
%{
    med å se på grafen for forrige og den nye målingene se vi at et det er
    klare grupperinger mellom måligene, med de gamle måligene på den eine
    siden og de ny på den andre. Dette tyder da at å tilsette
    tilsetjingsstoff skapte ein stastisk signifikant forksjell i variansen
    som blir tatt opp av de 2 første prinsipalkomponentene. Dette blir også
    sett med at X1 med de 2 første prinsipalkomponenter tar opp 98.36% av
    all varians og X2 tar opp 85.85%, en 12.51 forksjell
%}