 controladormppt = mamfis;
%__________________Entradas e Saídas________________
% Adiciona variável entrada Erro e derivada do Erro ao fuzzy
controladormppt = addvar(controladormppt, 'input', 'E',[-8 8]);
controladormppt = addvar(controladormppt, 'input', 'dE',[-100 100]);

% Adiciona variável saída Ki e Kp - constante de integração e derivação ao fuzzy
% controladormppt = addvar(controladormppt, 'output','Ki',[0 14]);
% controladormppt = addvar(controladormppt, 'output','Kp',[0 0.3]);
controladormppt = addvar(controladormppt, 'output','Ki',[1 12]);
controladormppt = addvar(controladormppt, 'output','Kp',[0.1 0.5]);

%_________________Funções de Pertinência_____________
% Para Erro
controladormppt = addMF(controladormppt,'E','trimf',[-10.5 -8 -4],'Name','NP');
controladormppt = addMF(controladormppt,'E','trimf',[-8 -4 0],'Name','NE');
controladormppt = addMF(controladormppt,'E','trimf',[-4 0 4],'Name','ZO');
controladormppt = addMF(controladormppt,'E','trimf',[0 4 8],'Name','PO');
controladormppt = addMF(controladormppt,'E','trimf',[4 8 10.5],'Name','PP');

% Para derivada do Erro - dE
controladormppt = addMF(controladormppt,'dE','trimf',[-200 -100 -50],'Name','NP');
controladormppt = addMF(controladormppt,'dE','trimf',[-100 -50 0],'Name','NE');
controladormppt = addMF(controladormppt,'dE','trimf',[-50 0 50],'Name','ZO');
controladormppt = addMF(controladormppt,'dE','trimf',[0 50 100],'Name','PO');
controladormppt = addMF(controladormppt,'dE','trimf',[50 100 200],'Name','PP');


%Para Ki
controladormppt = addMF(controladormppt,'Ki','trimf',[-4 1 4],'Name','Z');
controladormppt = addMF(controladormppt,'Ki','trimf',[1 4 7],'Name','S');
controladormppt = addMF(controladormppt,'Ki','trimf',[4 7 10],'Name','M');
controladormppt = addMF(controladormppt,'Ki','trimf',[7 10 13],'Name','B');

%Para Kp
controladormppt = addMF(controladormppt,'Kp','trimf',[-0.1 0.1 0.2],'Name','Z');
controladormppt = addMF(controladormppt,'Kp','trimf',[0.1 0.2 0.3],'Name','S');
controladormppt = addMF(controladormppt,'Kp','trimf',[0.2 0.3 0.45],'Name','M');
controladormppt = addMF(controladormppt,'Kp','trimf',[0.3 0.5 0.7'],'Name','B');

%_____________________________Conjunto de Regras___________________________
controladormppt = addRule(controladormppt,["E==NP &  dE==NP => Kp==B"]);
controladormppt = addRule(controladormppt,["E==NP &  dE==NE => Kp==B"]);
controladormppt = addRule(controladormppt,["E==NP &  dE==ZO => Kp==B"]);
controladormppt = addRule(controladormppt,["E==NP &  dE==PO => Kp==B"]);
controladormppt = addRule(controladormppt,["E==NP &  dE==PP => Kp==M"]);

controladormppt = addRule(controladormppt,["E==NE &  dE==NP => Kp==M"]);
controladormppt = addRule(controladormppt,["E==NE &  dE==NE => Kp==B"]);
controladormppt = addRule(controladormppt,["E==NE &  dE==ZO => Kp==S"]);
controladormppt = addRule(controladormppt,["E==NE &  dE==PO => Kp==S"]);
controladormppt = addRule(controladormppt,["E==NE &  dE==PP => Kp==S"]);

controladormppt = addRule(controladormppt,["E==ZO &  dE==NP => Kp==M"]);
controladormppt = addRule(controladormppt,["E==ZO &  dE==NE => Kp==B"]);
controladormppt = addRule(controladormppt,["E==ZO &  dE==ZO => Kp==Z"]);
controladormppt = addRule(controladormppt,["E==ZO &  dE==PO => Kp==S"]);
controladormppt = addRule(controladormppt,["E==ZO &  dE==PP => Kp==B"]);

controladormppt = addRule(controladormppt,["E==PO &  dE==NP => Kp==S"]);
controladormppt = addRule(controladormppt,["E==PO &  dE==NE => Kp==S"]);
controladormppt = addRule(controladormppt,["E==PO &  dE==ZO => Kp==S"]);
controladormppt = addRule(controladormppt,["E==PO &  dE==PO => Kp==S"]);
controladormppt = addRule(controladormppt,["E==PO &  dE==PP => Kp==S"]);

controladormppt = addRule(controladormppt,["E==PP &  dE==NP => Kp==M"]);
controladormppt = addRule(controladormppt,["E==PP &  dE==NE => Kp==B"]);
controladormppt = addRule(controladormppt,["E==PP &  dE==ZO => Kp==B"]);
controladormppt = addRule(controladormppt,["E==PP &  dE==PO => Kp==M"]);
controladormppt = addRule(controladormppt,["E==PP &  dE==PP => Kp==B"]);

controladormppt = addRule(controladormppt,["E==NP &  dE==NP => Ki==Z"]);
controladormppt = addRule(controladormppt,["E==NP &  dE==NE => Ki==Z"]);
controladormppt = addRule(controladormppt,["E==NP &  dE==ZO => Ki==Z"]);
controladormppt = addRule(controladormppt,["E==NP &  dE==PO => Ki==Z"]);
controladormppt = addRule(controladormppt,["E==NP &  dE==PP => Ki==Z"]);

controladormppt = addRule(controladormppt,["E==NE &  dE==NP => Ki==M"]);
controladormppt = addRule(controladormppt,["E==NE &  dE==NE => Ki==M"]);
controladormppt = addRule(controladormppt,["E==NE &  dE==ZO => Ki==M"]);
controladormppt = addRule(controladormppt,["E==NE &  dE==PO => Ki==M"]);
controladormppt = addRule(controladormppt,["E==NE &  dE==PP => Ki==M"]);

controladormppt = addRule(controladormppt,["E==ZO &  dE==NP => Ki==B"]);
controladormppt = addRule(controladormppt,["E==ZO &  dE==NE => Ki==B"]);
controladormppt = addRule(controladormppt,["E==ZO &  dE==ZO => Ki==Z"]);
controladormppt = addRule(controladormppt,["E==ZO &  dE==PO => Ki==B"]);
controladormppt = addRule(controladormppt,["E==ZO &  dE==PP => Ki==B"]);

controladormppt = addRule(controladormppt,["E==PO &  dE==NP => Ki==S"]);
controladormppt = addRule(controladormppt,["E==PO &  dE==NE => Ki==M"]);
controladormppt = addRule(controladormppt,["E==PO &  dE==ZO => Ki==M"]);
controladormppt = addRule(controladormppt,["E==PO &  dE==PO => Ki==M"]);
controladormppt = addRule(controladormppt,["E==PO &  dE==PP => Ki==M"]);

controladormppt = addRule(controladormppt,["E==PP &  dE==NP => Ki==Z"]);
controladormppt = addRule(controladormppt,["E==PP &  dE==NE => Ki==S"]);
controladormppt = addRule(controladormppt,["E==PP &  dE==ZO => Ki==B"]);
controladormppt = addRule(controladormppt,["E==PP &  dE==PO => Ki==B"]);
controladormppt = addRule(controladormppt,["E==PP &  dE==PP => Ki==B"]);


%plotmf(controladormppt,'input',1)
%plotmf(controladormppt,'input',2)
%plotmf(controladormppt,'output',1)
%plotfis(controladormppt)
%gensurf(controladormppt)
%fuzzyLogicDesigner(controladormppt)
