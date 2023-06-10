clc
clear

%Variáveis do modelo do aeropendulo
b = 0.006856; %Coeficiente de atrito viscoso rotacional
m = 0.3182; %Massa do conjunto propulsivo
g = 9.81; %Aceleração gravitacional
I = 0.0264; %Momento de inércia
kh = 2.12829e-5; %Coeficiente de empuxo
Lh = 0.32; %Distância do motor ao centro de rotação

%Variáveis do ponto de equilíbrio dado
theta_deg = 80;
theta_barra = theta_deg*pi/180;
omega_barra = sqrt(m*g*sin(theta_barra)/(kh));

%Variáveis da função transferência em malha aberta
c1 = Lh*kh/I;
c2 = Lh*m*g/I;
c3 = b/I;

s = tf('s');
G = 2*c1*omega_barra/(s^2 + c3*s + c2*cos(theta_barra));

%Variáveis a serem satisfeitas 
MS = 0.2;
ts = 5;

E = sqrt( (log(MS)^2) / (pi^2 + (log(MS)^2)) );
wn = 4/(E*ts);

%Variáveis para controlador PI+D
Kp = 50;
Ti = 0.7;
Td = 0.5;