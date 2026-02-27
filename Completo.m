%% Com esse arq será possível rodar todas as simulações referentes aos controles desenvolvidos para o PMSG Wind Turbine
%% NÃO RODE INTEIRO
% Variaveis Conversor
Vi = 110;
Vo = 400;
Vref = 5;
Vds_pk=5; 
Lb = 0.9513*10^-3;
Ci = 2878*10^-6;
R = 1;
kv = Vref/Vi; % ganho do sensor de tensão 
kpwm = 1/Vds_pk; % ganho do modulador PWM
ke = 1;
kde = 0.1;
% ke = 8;
% kde = 10;
%% Entrada de vento real
dados = readtable('velocidade-vento.txt');
dados.Properties.VariableNames{1} = 'Time';
dados.Properties.VariableNames{2} = 'Vvento';
time = dados.Time;n
vwind = dados.Vvento;
%% Modelagem Boost
s = tf('s');
Gv_s = Vo/(Lb*Ci*s^2 +R*Ci*s+ 1);
H_s = tf(kv);
PWM_s = tf(kpwm);
FTLA  =Gv_s*H_s*PWM_s;
%figure(1); clf(); bode(Gv_s*H_s*PWM_s)
%figure(1); clf(); bode(Gv_s)
% figure(2); clf(); pzmap(Gv_s)
% figure(3); clf(); step(Gv_s)
% figure(4); clf(); rlocus(Gv_s)
%% Projeto PI Analítico Resposta em Frequencia - clássico
wcg = 60.4;
MF = (135*pi)/180;
rp = freqresp(Gv_s*PWM_s*H_s, wcg);
mp = abs(rp); thetap = angle(rp);
mk = 1/mp; thetak = MF - thetap - pi;
ki = -mk*sin(thetak)*wcg;
kp = mk*cos(thetak);
numk = [kp ki];
denk = [1 0];
Ks_PI = tf(numk, denk);
%figure(6); bode(Gv_s*PWM_s*Ks_PI)
%figure(7); bode(Gv_s*PWM_s*H_s*Ks_PI)
%% Rodando a simulação do PMSG_wind_turbine com o controlador PI
tic
sim('pmsg_wind_turbine_PI.slx')
toc
%% Carregando o arquivo fuzzy
mpptdois;
%% Rodando simulação do PMSG_wind_turbine com o controlador Fuzzy
tic
sim('pmsg_wind_turbine.slx')
toc
%% Simplificação do circuito (só conversor e controle) fonte de corrente
load('saidasPItensao.mat');
current=out.Iind;
y = out.tempo;
%% Tempo de simulaçao PI simplicado
tic
sim('pmsg_wind_turbine_simpCURRENT')
toc
%% Tempo de simulacao Fuzzy simplificado 
tic
sim('pmsg_wind_turbine_simpfuzzyCURRENT')
toc
%% Otimizado
 fis = newFis([39.610366 15.854974 0.215169 0.862472 9.013812 10.407375]);
 ke = 39.610366;
 kde = 15.854979;
 