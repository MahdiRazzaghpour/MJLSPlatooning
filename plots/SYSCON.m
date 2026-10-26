%% plots
clc;
clear all;
close all;
%% Fig1
load('acc_best.mat')
load('acc_ideal.mat')
load('acc_worse.mat')
load('vel_best.mat')
load('vel_ideal.mat')
load('vel_worse.mat')
load('pos_best.mat')
load('pos_ideal.mat')
load('pos_worse.mat')
%% Fig2

filename = 'Fig2';
fontSize = 14;
linewidthvalue = 1;
time = linspace(0,55,550);

h=figure('pos', [50 50 1000 1000]);
[ha, pos] = tight_subplot(3, 1, [0.1 0.04], [0.2 0.05], [0.1 0.05]);

axes(ha(1))
plot(time,vel_ideal','MarkerSize',1);
ylim([10 30])
xlim([15 55])
grid on
box on
ylabel('Speed [m/s]','FontSize',fontSize);
xlabel('Ideal Communication     Time [s]','FontSize',fontSize);
set(gca,'FontSize', fontSize);


axes(ha(2))
plot(time,vel_best','MarkerSize',1);
ylim([10 30])
xlim([15 55])
grid on
box on
ylabel('Speed [m/s]','FontSize',fontSize);
xlabel('Best-Case Communication     Time [s]','FontSize',fontSize);
set(gca,'FontSize', fontSize);


axes(ha(3))
hi = plot(time,vel_worse','MarkerSize',1);
ylim([10 30])
xlim([15 55])
grid on
box on
ylabel('Speed [m/s]','FontSize',fontSize);
xlabel('Worst-Case Communication    Time [s]','FontSize',fontSize);
set(gca,'FontSize', fontSize);


labels = {'Vehicle 0','Vehicle 1','Vehicle 2','Vehicle 3','Vehicle 4'}
lgd=legend(hi(1:5),labels(1:5),'Orientation','horizontal','FontSize',fontSize);

% lgd2=legend(labels2,'Location', 'eastoutside' ,'Orientation','horizontal');

newPosition = [0.4 0.05 0.2 0.1]; % [left bottom width height]
newPosition2 = [0.4 0.00 0.2 0.1]; % [left bottom width height]
newUnits = 'normalized';
set(lgd,'Position', newPosition,'Units', newUnits);
legend('boxoff')

a=axes('position',get(gca,'position'),'visible','off');

lgd2=legend(a,hi(8:end),labels(8:end),'Orientation','horizontal','FontSize',fontSize);
set(lgd2,'Position', newPosition2,'Units', newUnits);
legend('boxoff')
%%
saveas(h, strcat('.\Plots\', filename, '.png'));
saveas(h, strcat('.\Plots\', filename),'epsc');
savefig(strcat('.\Plots\', filename));

%% Fig3

filename = 'Fig3';
fontSize = 14;
linewidthvalue = 1;
time = linspace(0,55,550);

h=figure('pos', [10 10 1000 800]);
[ha, pos] = tight_subplot(3, 1, [0.1 0.02], [0.2 0.05], [0.1 0.05]);

axes(ha(1))
plot(time,acc_ideal','MarkerSize',2);
ylim([-8 8])
xlim([15 55])
grid on
box on
ylabel('Acceleration [m/s^2]','FontSize',fontSize);
xlabel('Ideal Communication     Time [s]','FontSize',fontSize);
set(gca,'FontSize', fontSize);


axes(ha(2))
plot(time,acc_best','MarkerSize',2);
ylim([-8 8])
xlim([15 55])
grid on
box on
ylabel('Acceleration [m/s^2]','FontSize',fontSize);
xlabel('Best-Case Communication     Time [s]','FontSize',fontSize);
set(gca,'FontSize', fontSize);


axes(ha(3))
hi = plot(time,acc_worse','MarkerSize',2);
ylim([-8 8])
xlim([15 55])
grid on
box on
ylabel('Acceleration [m/s^2]','FontSize',fontSize);
xlabel('Worst-Case Communication    Time [s]','FontSize',fontSize);
set(gca,'FontSize', fontSize);


labels = {'Vehicle 0','Vehicle 1','Vehicle 2','Vehicle 3','Vehicle 4'}
lgd=legend(hi(1:5),labels(1:5),'Orientation','horizontal','FontSize',fontSize);

% lgd2=legend(labels2,'Location', 'eastoutside' ,'Orientation','horizontal');

newPosition = [0.4 0.05 0.2 0.1]; % [left bottom width height]
newPosition2 = [0.4 0.00 0.2 0.1]; % [left bottom width height]
newUnits = 'normalized';
set(lgd,'Position', newPosition,'Units', newUnits);
legend('boxoff')

a=axes('position',get(gca,'position'),'visible','off');

lgd2=legend(a,hi(8:end),labels(8:end),'Orientation','horizontal','FontSize',fontSize);
set(lgd2,'Position', newPosition2,'Units', newUnits);
legend('boxoff')
%%
saveas(h, strcat('.\Plots\', filename, '.png'));
saveas(h, strcat('.\Plots\', filename),'epsc');
savefig(strcat('.\Plots\', filename));

%% Fig 8

filename = 'Fig4';
fontSize = 14;

low_Base=[0.905001508609548,0.905001988813494,0.905002046272050,0.905000919789365,0.905001638266587,0.905001592760305,0.905001277756333];
low_cc=[0.905002802027980,0.905001876573549,0.905002701498860,0.905002423059591,0.905002976633997,0.905003535669183,0.905005018821486];
mod_Base=[0.905001143952523,0.905001376073193,0.905001873082306,0.905002540709886,0.905001186047931,0.905004241818309,0.905004234250800];
mod_cc=[0.905003273324780,0.905002830703905,0.905002910448406,0.905004031509304,0.905004111268995,0.905003538710032,0.905004013554142];
high_Base=[0.905002361990087,0.905002192473072,0.905002505926618,0.905004170522395,0.905005713780781,0.905007134998448,0.905006916195731];
high_cc=[0.905007709666836,0.905007662915110,0.905007272621100,0.905006743442721,0.905010702541842,0.905012240325938,0.905010874882513];

bin = linspace(25,175,7);

filename = 'Fig8';
h=figure('pos', [10 10 500 300]);
fontSize = 9;
linewidthvalue = 2;

plot(bin,low_Base','g','LineWidth',linewidthvalue);
hold on 
plot(bin,mod_Base','b','LineWidth',linewidthvalue);
hold on 
plot(bin,high_Base','r','LineWidth',linewidthvalue);
hold on 
plot(bin,low_cc','--g','LineWidth',linewidthvalue);
hold on 
plot(bin,mod_cc','--b','LineWidth',linewidthvalue);
hold on 
plot(bin,high_cc','--r','LineWidth',linewidthvalue);

xlabel('Distance [m]','FontSize',fontSize);
ylabel({'Spectral Radius'},'FontSize',fontSize);

legend({'Low Density Base','Moderate Density Base','High Density Base','Low Density CC','Moderate Density CC','High Density CC'},'FontSize',fontSize, 'Location','northwest');

ylim([0.905 0.905016])
xlim([25 175])
grid on
box on
set(gca,'FontSize', fontSize);


ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

%%
saveas(h, strcat('.\Plots\', filename, '.png'));
saveas(h, strcat('.\Plots\', filename),'epsc');
savefig(strcat('.\Plots\', filename));


%% Fig5

filename = 'Fig5';
fontSize = 9;
linewidthvalue = 2;

bin_cc = linspace(25,175,7);

low_error=[0.099984019127300,0.092115889526366,0.093389094658705,0.101921727993766,0.104613664008324,0.114795148924563,0.129304856754941];
mod_error=[0.095891618390709,0.097972123309580,0.113254647206640,0.123541321758793,0.136985537536850,0.156362027029732,0.174623341691981];
high_error=[0.102816864562794,0.106996055086630,0.123007335590833,0.163111040732434,0.178447720481662,0.184604122446232,0.186330941835487];
low_cc_error=[0.120733126695473,0.128530920038424,0.131086543824633,0.121019125371944,0.140488255651939,0.148433377242345,0.164075152078092];
mod_cc_error=[0.160552288222940,0.159090336602746,0.163380657035828,0.165320532535499,0.176564004443005,0.191337930657801,0.190664569630169];
high_cc_error=[0.194864768112666,0.188909065588631,0.205827304765253,0.204991581945045,0.217026769687400,0.231055913465104,0.208930431101618];


low_vel=[0.173926595777261,0.162174202650718,0.168092411278927,0.185371514643985,0.194923638260612,0.220372049801125,0.253236508269991];
mod_vel=[0.171544611334490,0.178927678612395,0.216195167057280,0.237299221442601,0.265710410760847,0.316814038530561,0.357941009602272];
high_vel=[0.187991585785606,0.205442236018197,0.238131582169435,0.339913642670113,0.357725084051137,0.377164834740111,0.376015753872708];
low_cc_vel=[0.232596836502801,0.233228441715229,0.258909860759902,0.233395417926932,0.269689818886440,0.297411743297441,0.338836416195912];
mod_cc_vel=[0.323809009386434,0.318838915719515,0.339736358995737,0.327287492125357,0.361461102283791,0.415934602297774,0.399526661609767];
high_cc_vel=[0.413174649666008,0.408582117243405,0.414522633945439,0.430082689416158,0.455029268109122,0.513492961695349,0.443510279396712];

low_acc=[0.312866284240556,0.225051558551415,0.274960279503732,0.378838927356035,0.426448085914177,0.465193523734953,0.566075797489376];
mod_acc=[0.289164278113343,0.349191953208706,0.493979302741525,0.558924338958204,0.617504485522726,0.688619473870624,0.716396719531846];
high_acc=[0.367335467795984,0.457937282379256,0.541491819289429,0.686093928555460,0.731999249144228,0.756804065949655,0.776784301850272];
low_cc_acc=[0.566142910946093,0.576031255055061,0.622025250744389,0.577788338392931,0.649537975292676,0.661732623611596,0.700729281488723];
mod_cc_acc=[0.703702623370895,0.706545733777007,0.744319940214751,0.748092095708632,0.758073367704838,0.744139237502888,0.765977820798193];
high_cc_acc=[0.785629627989318,0.780191536234807,0.794272606983387,0.783712938003492,0.826554847128520,0.855479226775945,0.855710001104562];


h=figure('pos', [10 10 500 600]);
[ha, pos] = tight_subplot(3, 1, [0.07 0.02], [0.1 0.05], [0.15 0.05]);

axes(ha(1))
plot(bin_cc,low_error,'g-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,mod_error,'b-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,high_error,'r-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,low_cc_error,'--g','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,mod_cc_error,'--b','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,high_cc_error,'--r','LineWidth',linewidthvalue);


ylim([0.09 0.55])
xlim([25 175])
grid on
box on
%xlabel('Distance','FontSize',fontSize);
ylabel({'Mean of','spacing error [m]'},'FontSize',fontSize);
legend({'Low Density Base','Moderate Density Base','High Density Base','Low Density CC','Moderate Density CC','High Density CC'},'FontSize',fontSize, 'Location','northwest');
set(gca,'FontSize', fontSize);


axes(ha(2))
plot(bin_cc,low_vel,'g-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,mod_vel,'b-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,high_vel,'r-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,low_cc_vel,'--g','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,mod_cc_vel,'--b','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,high_cc_vel,'--r','LineWidth',linewidthvalue);

ylim([0.15 0.55])
xlim([25 175])
grid on
box on
%xlabel('Distance','FontSize',fontSize);
ylabel({'Mean of','speed difference [m/s]'},'FontSize',fontSize);

axes(ha(3))
plot(bin_cc,low_acc,'g-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,mod_acc,'b-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,high_acc,'r-o','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,low_cc_acc,'--g','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,mod_cc_acc,'--b','LineWidth',linewidthvalue);
hold on 
plot(bin_cc,high_cc_acc,'--r','LineWidth',linewidthvalue);

ylim([0.2 0.9])
xlim([25 175])
grid on
box on
xlabel('Distance [m]','FontSize',fontSize);
ylabel({'Mean of','acceleration difference [m/s^2]'},'FontSize',fontSize);


set(gca,'FontSize', fontSize);

%%
saveas(h, strcat('.\Plots\', filename, '.png'));
saveas(h, strcat('.\Plots\', filename),'epsc');
savefig(strcat('.\Plots\', filename));