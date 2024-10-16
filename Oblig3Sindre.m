clc
clear
load Arbeidskrav3.mat
%Sindre bakke marthinussen Oblig3

%a)
%preprosseserer matrisen først
%Standardaviik 1, gjennomsnitt 0 og initaliserer variabler
a=2;
[n,m] = size(X1); %n = antall objekt
meanX=mean(X1); %Gjennomsnitt av hver kolonne
stdX=std(X1); %Standardavviket i hver kolonne
for j = 1:m 
    X1(:,j)=X1(:,j) - meanX(j); %Tegner gjennomsnitet av kolonne j fra kolonne j
    if stdX(j)~=0
        X1(:,j)= X1(:,j)/stdX(j); %Deviderer kolonne j med standard aviket til kolonne j
    end
end
Xnorm = X1; %Prossesert løkke

%b)
%Her arbeider vi med ulike typer data, som har ulike egenskaper. Defor
%preprosesserer en data slik at all dataen har like stor betytning.

%c
%Regner ut de to første prinsipalkomponentene

T = zeros(n,a);
P = zeros(m,a);

for i=1:a
    t_old = rand(n,1);
    p = Xnorm'*t_old;
    p = p/norm(p); %normalisering av p til len
    t = Xnorm*p;
    while (norm(t-t_old)>0.00001)
        p = Xnorm'*t;
        p = p/norm(p);
        t_old = t;
        t = Xnorm*p;
    end
    T(:,i) = t;
    P(:,i) = p;
    Xnorm = Xnorm - t*p';
end

%plotter scorematrisen av de to prinsipalkomponentene
figure
scatter(T(:,1), T(:,2))
text(T(:,1)+.1, T(:,2),objNames1)
hold on
plot(0,0, 'or') %tegner inn i origo for å ha et referansepunkt
grid on

%d)
%legger til tekst fra objNames1. Leser et av variasjonene mellom punkt 5a
%og 5b. Mindre enn +.5 på x-akse og midre enn 0.1 på y-akse.

%e)
%Finner forklert variasjon ad de to prinsipialkoffisientene = 98.36
trX = trace(X1'*X1); %Trace standardisert matrise X
trT = trace(T'*T); %Trace av scoremartisen
fprintf('Forklart variasjon med %d prinsipalkomonenter: %4.2f\n',a,trT/trX*100)

%f)
%plotter loading-martise
figure
scatter(P(:,1),P(:,2))
text(P(:,1)+.01, P(:,2),varNames1)
hold on
plot(0,0,'or') %tegner origo for referansepunkt
grid on

%g
%de nye målingene ligger gruppert høyere enn de gamle. Når det kommer til
%tekstur
%Prosesser først matrisen slik at hver kolonne får standardavik 1 og
%gjennomsnitt 0
a2=2;
[n2,m2]=size(X2); %n = antall objekt(forsøk/instillinger %m = antall variabler(målinger)
meanX2=mean(X2); % gjennomsnitt hver kolonne i matrise X
stdX2 = std(X2); %Standardaviket i hver kolonne i matrisen
for j2=1:m2
    X2(:,j2) = X2(:,j2)-meanX2(j2); %Trekker gjennomsnittet av kollone j fra kolonne j
    if stdX2(j2)~=0
        X2(:,j2)=X2(:,j2)/stdX2(j2); %pre-pros matrise
    end
end
Xnorm2=X2; %Preprossesert matrise
%Regner ut to første prinsipalkomponetene
T2 = zeros(n2,a2);
P2=zeros(m2,a2);


%Nipal
for i2=1:a2
    t_old2 = rand(n2,1);
    p2 = Xnorm2'*t_old2;
    p2 = p2/norm(p2); % Normalisering av p2 til lengde 1.
    t2 = Xnorm2*p2;
    while (norm(t2-t_old2)>0.00001)
        p2 = Xnorm2'*t2;
        p2 = p2/norm(p2);
        t_old2 = t2;
        t2 = Xnorm2*p2;
    end
    T2(:,i2) = t2; % Scores
    P2(:,i2) = p2; % Loading
    Xnorm2 = Xnorm2 - t2*p2';
end
%scormatrise plotting
figure
scatter(T2(:,1), T2(:,2))
text(T2(:,1)+.1, T2(:,2),objNames2)
hold on
plot(0,0, 'or')%tegner inn origo for referansepunkt
grid on

%finner den forklerte variasjonen av 2 prinsipialkoffisientene = 85.95
trX2 = trace(X2'*X2); %standarisert matrise x
trT2 = trace(T2'*T2); %scorematrisen
fprintf('Forklart variasjon med %d prinsipalkomponenter: %4.2f\n',a2,trT2/trX2*100)

% Plotting loadingmatrise
figure
scatter(P2(:,1), P2(:,2))
text(P2(:,1)+.01, P2(:,2), varNames2)
hold on
plot(0,0, 'or') %tegner inn origo
grid on
return
