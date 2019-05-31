% Topology II from Bahmer and Langner 2006 Biol Cybern
% 14.3.2007
% Andreas Bahmer

clear global
clear functions


f_s=40000;   % Sampling rate (25µs)
dt=1./f_s;     %// in s


AP5_realNerv=(anft==5);
AP4_realNerv=bitor(anft==4,AP5_realNerv);
AP3_realNerv=bitor(anft==3,AP4_realNerv);
AP2_realNerv=bitor(anft==2,AP3_realNerv);
AP1_realNerv=bitor(anft==1,AP2_realNerv);
onsetneuron=+onsett;

Timeaxis=0:dt:length(AP1_realNerv)*dt;
sim_steps=length(AP1_realNerv);

%-----Variables----------------------
%Somata
Loss=3000;
sigma=0;  

%Synapse
Loss_Syn=4000;
Weight=0.75;
Loss_Syn_Nerve=1300;
Weight_Nerve=0.1;
Latency_Syn_A=0.00018;
sigmasyn=0.00026;
Latency_Syn_fast=0.00018;

global Ausschuettung2
Ausschuettung2=Ausschuettung(dt,sim_steps);

threshold=schwellwert(0.0006,0.0001,dt); % fast chopper (absolute refractory period, relative refractory period, dt)
threshold2=schwellwert(0.0017,0.0002,dt); % slow chopper (absolute refractory period, relative refractory period, dt)
AP_2A=0;

for s=1:sim_steps%-----START SIMULATION---------------------------------------------------------------

[PSC_realNervAP1]=Synapse1(dt,sim_steps,Loss_Syn_Nerve,Weight_Nerve/5,+AP1_realNerv(s),Latency_Syn_A);
[PSC_realNervAP2]=Synapse2(dt,sim_steps,Loss_Syn_Nerve,Weight_Nerve/5,+AP2_realNerv(s),Latency_Syn_A);
[PSC_realNervAP3]=Synapse3(dt,sim_steps,Loss_Syn_Nerve,Weight_Nerve/5,+AP3_realNerv(s),Latency_Syn_A);
[PSC_realNervAP4]=Synapse4(dt,sim_steps,Loss_Syn_Nerve,Weight_Nerve/5,+AP4_realNerv(s),Latency_Syn_A);
[PSC_realNervAP5]=Synapse5(dt,sim_steps,Loss_Syn_Nerve,Weight_Nerve/5,+AP5_realNerv(s),Latency_Syn_A);
PSC_realNerv=PSC_realNervAP1+PSC_realNervAP2+PSC_realNervAP3+PSC_realNervAP4+PSC_realNervAP5;

%------Two fast Chopper Neurons 1 and 2------------------------
%-------------- Synapse for Onset Neuron ----------------------------
[PSC_Onset]=Synapse6(dt,sim_steps,Loss_Syn,0.8,+onsetneuron(s),Latency_Syn_A);  

%-------------- Synapse1A2-------------------von Soma2A--------------------
[PSC_1A]=Synapselatenztrauschen1(dt,sim_steps,4000,Weight,AP_2A,Latency_Syn_fast,sigmasyn);

%--------------Soma1A------------------------------------------------------
PSC_1Agesamt=PSC_Onset+PSC_realNerv+PSC_1A;
[AP_1A,Spannung_1A]=ScopeSomarausch1(dt,Loss,PSC_1Agesamt,threshold,0,sigma);


%--------------Synapse2A---------------------------------------------------
[PSC_2A]=Synapselatenztrauschen2(dt,sim_steps,4000,Weight,AP_1A,Latency_Syn_fast,sigmasyn);

%---------------Soma2A-----------------------------------------------------
PSC_2Agesamt=PSC_2A+PSC_realNerv;
[AP_2A]=Somarausch2(dt,Loss,PSC_2Agesamt,threshold,0,sigma);


%------Slow Chopper Neuron 3--------------
%--------------Synapse3A---------------------------------------------------
[PSC_3A]=Synapselatenztrauschen3(dt,sim_steps,Loss_Syn,Weight,AP_2A,0,0);
[PSC_4A]=Synapselatenztrauschen4(dt,sim_steps,Loss_Syn,Weight,AP_1A,0,0);

%--------------Soma3A------------------------------------------------------
PSC_3Agesamt=PSC_3A+PSC_4A+PSC_realNerv;
[AP_3A]=Somarausch3(dt,Loss,PSC_3Agesamt,threshold2,0,sigma);


%--------------SCOPES-------------------------------------------------
scope3(s+1)=AP_1A;
scope5(s+1)=AP_3A;

end;%----------ENDE SIMULATION---------------------------------------

