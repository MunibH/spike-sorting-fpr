clear,clc,close all
addpath(genpath(pwd))
% originally written by Michael Economo
% revamped by Jack Vincent, Munib Hasnain


%% parameters
Rtot = logspace(-1, 1.5, 21); % firing rates
fp = logspace(-2, 0.6, 20);   % false positive rates

% Rtot = 0.1:0.5:20;
% fp = 0.02:0.02:0.5;


tviol = 0.0025;  % refractory period
rtime = 0.005;   % ???

%% simulation

dat = zeros(numel(Rtot), numel(fp));
pred = zeros(numel(Rtot), numel(fp));
fpall = zeros(numel(Rtot), numel(fp));

for i = 1:numel(Rtot)
    for j = 1:numel(fp)
        fpall(i,j) = fp(j);
        [dat(i,j), pred(i,j)] = simViolations(Rtot(i), fp(j), tviol, rtime);
    end
end


%% plot results

f = figure; 
f.Position = [-1463         180        1188         588];
plot(fp, pred','.','MarkerSize',20);
hold on; 
ax = f.CurrentAxes;
xl = ax.XLim;
plot(xl(1):xl(2), xl(1):xl(2), 'k:', 'LineWidth', 3);
xlabel(ax,'True FPR')
ylabel(ax,'Pred FPR')
% rotateYLabel(ax);
ax.FontSize = 20;

%%

function [pctViol, predFP] = simViolations(Rtot, fp, tviol, rtime)

% Rtot = 10;
% fp = 0.6;

tend = 500000./Rtot;

% Rout = Rtot*fp;
% Rin = Rtot - Rout;

Rin = Rtot./(fp+1); % in cluster firing rate is total firing rate over fp rate
Rout = Rtot-Rin;    % fp spiking rate is then total - Rin


remainingSpikes = round(Rin*tend);
realTimes = [];

DONE = 0;
while ~DONE
    newTimes = tend*rand(1, remainingSpikes);
    realTimes = sort([realTimes newTimes]);
    bad = diff([realTimes inf])<(rtime);
    
    realTimes = realTimes(~bad);
    remainingSpikes = sum(bad);
    
    if remainingSpikes==0
        DONE=1;
    end
end
% isi = diff([realTimes inf]);
% figure; hist([isi -isi], -0.5:0.0005:0.5);
% xlim([-0.025 0.025]);

falseTimes = tend*rand(1, round(Rout*tend));
Nreal = numel(realTimes);
Nfalse = numel(falseTimes);

% isi = diff(sort([falseTimes inf]));
% figure; hist([isi -isi], -0.5:0.0005:0.5);
% xlim([-0.025 0.025]);

spktm = sort([realTimes, falseTimes]);

isi = diff([spktm inf]);
Nviol = sum(isi<=tviol);

Ntot = numel(spktm);
Nout = numel(falseTimes);
Nin = numel(realTimes);


% figure; hist([isi -isi], -0.5:0.0005:0.5);
% xlim([-0.025 0.025]);

pctViol = 100*Nviol./(Nreal+Nfalse);
Rviol = Nviol./tend;

% predRout = (Rviol./((Rin+0.5*Rout).*tviol.*2));
% predFP = predRout./(Rtot - predRout);


a = -1/2;
b = Rtot;
c = -Rviol./(2.*tviol);

predRout = (-b + sqrt(b.^2 - 4*a*c))./(2.*a);
predFP = predRout./(Rtot - predRout);

disp(['Rtot = ' num2str(Rtot) '  : FP = ' num2str(fp) ' % Viol = ' num2str(100.*Nviol./Ntot) '  PredFP = ' num2str(predFP)]);


end










