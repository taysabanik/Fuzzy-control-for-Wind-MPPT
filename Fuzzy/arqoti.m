function fis = newFis(x)
%Universo de discurso fixos em -1 e 1
ud_E = [-1 1]; ud_dE = [-1 1];%universo de discurso ganho 8 e 100
ud_kp = [x(3) x(4)]; ud_ki = [x(5) x(6)];

fis = mamfis;

% Parâmetros de entrada E - [-1 ..1]
% Para Erro
fis = addInputs(fis, ud_E, "Name", "E");
fis = addMF(fis,'E','trimf',[-10.5/8 -8/8 -4/8],'Name','NP');
fis = addMF(fis,'E','trimf',[-8/8 -4/8 0],'Name','NE');
fis = addMF(fis,'E','trimf',[-4/8 0 4/8],'Name','ZO');
fis = addMF(fis,'E','trimf',[0 4/8 8/8],'Name','PO');
fis = addMF(fis,'E','trimf',[4/8 8/8 10.5/8],'Name','PP');


% Parâmetros entrada dE -  - [-1 .. 1]
fis = addInput(fis, ud_dE, "Name", "dE");
fis = addMF(fis,'dE','trimf',[-200/100 -100/100 -50/100],'Name','NP');
fis = addMF(fis,'dE','trimf',[-100/100 -50/100 0],'Name','NE');
fis = addMF(fis,'dE','trimf',[-50/100 0 50/100],'Name','ZO');
fis = addMF(fis,'dE','trimf',[0 50/100 100/100],'Name','PO');
fis = addMF(fis,'dE','trimf',[50/100 100/100 200/100],'Name','PP');


% Parâmetros entrada kp - [0.1 0.5]
fis = addOutput(fis, ud_kp, "Name", "kp");
fis = addMF(fis,'Kp','trimf',[x(3) x(3) x(3)*2],'Name','Z');
fis = addMF(fis,'Kp','trimf',[x(3) x(3)*2 x(3)*3],'Name','S');
fis = addMF(fis,'Kp','trimf',[x(4)*0.4 x(4)*0.7 x(4)*0.9],'Name','M');
fis = addMF(fis,'Kp','trimf',[x(4)*0.6 x(4) x(4)],'Name','B');


% Parâmetros entrada ki - [1 12]
fis = addOutput(fis, ud_ki, "Name", "ki");
fis = addMF(fis,'Ki','trimf',[x(5) x(5) x(5)*4],'Name','Z');
fis = addMF(fis,'Ki','trimf',[x(5) x(5)*4 x(5)*7],'Name','S');
fis = addMF(fis,'Ki','trimf',[x(6)/3 x(6)/1.7 x(6)/1.2],'Name','M');
fis = addMF(fis,'Ki','trimf',[x(6)/1.7 x(6)/1.2 x(6)],'Name','B');



%_____________________________Conjunto de Regras___________________________
fis = addRule(fis,"E==NP &  dE==NP => Kp==B");
fis = addRule(fis,"E==NP &  dE==NE => Kp==B");
fis = addRule(fis,"E==NP &  dE==ZO => Kp==B");
fis = addRule(fis,"E==NP &  dE==PO => Kp==B");
fis = addRule(fis,"E==NP &  dE==PP => Kp==M");

fis = addRule(fis,"E==NE &  dE==NP => Kp==M");
fis = addRule(fis,"E==NE &  dE==NE => Kp==B");
fis = addRule(fis,"E==NE &  dE==ZO => Kp==S");
fis = addRule(fis,"E==NE &  dE==PO => Kp==S");
fis = addRule(fis,"E==NE &  dE==PP => Kp==S");

fis = addRule(fis,"E==ZO &  dE==NP => Kp==M");
fis = addRule(fis,"E==ZO &  dE==NE => Kp==B");
fis = addRule(fis,"E==ZO &  dE==ZO => Kp==Z");
fis = addRule(fis,"E==ZO &  dE==PO => Kp==S");
fis = addRule(fis,"E==ZO &  dE==PP => Kp==B");

fis = addRule(fis,"E==PO &  dE==NP => Kp==S");
fis = addRule(fis,"E==PO &  dE==NE => Kp==S");
fis = addRule(fis,"E==PO &  dE==ZO => Kp==S");
fis = addRule(fis,"E==PO &  dE==PO => Kp==S");
fis = addRule(fis,"E==PO &  dE==PP => Kp==S");

fis = addRule(fis,"E==PP &  dE==NP => Kp==M");
fis = addRule(fis,"E==PP &  dE==NE => Kp==B");
fis = addRule(fis,"E==PP &  dE==ZO => Kp==B");
fis = addRule(fis,"E==PP &  dE==PO => Kp==M");
fis = addRule(fis,"E==PP &  dE==PP => Kp==B");

fis = addRule(fis,"E==NP &  dE==NP => Ki==Z");
fis = addRule(fis,"E==NP &  dE==NE => Ki==Z");
fis = addRule(fis,"E==NP &  dE==ZO => Ki==Z");
fis = addRule(fis,"E==NP &  dE==PO => Ki==Z");
fis = addRule(fis,"E==NP &  dE==PP => Ki==Z");

fis = addRule(fis,"E==NE &  dE==NP => Ki==M");
fis = addRule(fis,"E==NE &  dE==NE => Ki==M");
fis = addRule(fis,"E==NE &  dE==ZO => Ki==M");
fis = addRule(fis,"E==NE &  dE==PO => Ki==M");
fis = addRule(fis,"E==NE &  dE==PP => Ki==M");

fis = addRule(fis,"E==ZO &  dE==NP => Ki==B");
fis = addRule(fis,"E==ZO &  dE==NE => Ki==B");
fis = addRule(fis,"E==ZO &  dE==ZO => Ki==Z");
fis = addRule(fis,"E==ZO &  dE==PO => Ki==B");
fis = addRule(fis,"E==ZO &  dE==PP => Ki==B");

fis = addRule(fis,"E==PO &  dE==NP => Ki==S");
fis = addRule(fis,"E==PO &  dE==NE => Ki==M");
fis = addRule(fis,"E==PO &  dE==ZO => Ki==M");
fis = addRule(fis,"E==PO &  dE==PO => Ki==M");
fis = addRule(fis,"E==PO &  dE==PP => Ki==M");

fis = addRule(fis,"E==PP &  dE==NP => Ki==Z");
fis = addRule(fis,"E==PP &  dE==NE => Ki==S");
fis = addRule(fis,"E==PP &  dE==ZO => Ki==B");
fis = addRule(fis,"E==PP &  dE==PO => Ki==B");
fis = addRule(fis,"E==PP &  dE==PP => Ki==B");

x(38:135) = int32(x(38:135));


fis = addRule(fis, ruleList);

end