%This script-file reads the simulated nerv and onset neuron response
% and starts the simulation with Topology I or II from Bahmer and Langner
% 
% Andreas Bahmer, TU Darmstadt
% 20.3.2007

na2='nerv25ms.dat';
na3='onset25ap.dat';


storage=dlmread(na2);
storage2=dlmread(na3);
[m,n]=size(storage);
na=['Results_Chopper'];
delete (na)

for k=1:m
    anft=storage(k,:); %reads one repetition of the nerve response
    onsett=storage2(k,:); %reads one repetition of the onset response
    Topology_I %choose Topology I or II
    %Topology_II
     output2(k,:)=scope3; %action potentials from chopper number 1
     output4(k,:)=scope5; %action potentials from chopper number 5
if mod(k,50)==0 %save every 50 times of the simulation
    save(na,'output2','output4')
    end
end



