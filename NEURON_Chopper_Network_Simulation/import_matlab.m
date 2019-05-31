%import data von NEURON
clear all
close all

data=load('rothman.txt'); %erase first line in this file (only 2 elements)
[m,n]=size(data);
imagesc((1:n-1)*0.025,data(2:end,end),data(2:end,1:end-1))
xlabel('Time [ms]')
ylabel('Input [pA]')
colormap(1-gray)

%%action potentials
%ap=(data(2:end,1:end-1)>-20);
ap=(data(2:end,1:end-1)>0);
figure
imagesc((1:n-1)*0.025,data(2:end,end),ap)
colormap(1-gray)

%%--------Analysis

zeit=data(1,1:end-1)*0.001;


for za1=1:m-1
clear isi isi2
isi=diff(zeit(find(ap(za1,:))));
isi2=isi(find(isi>0.0001));
g(za1)=data(za1+1,end);
g2(za1)=mean(isi2);
g3(za1)=length(isi2);
end

figure
p1 = line(g,g2*1000,'Color','k');
ax1 = gca;
set(ax1,'XColor','k','YColor','k')
set(get(ax1,'YLabel'),'String','ISI [ms]')
set(ax1,'YLim',[ 0 20], 'XLim',[0 max(g)])
ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','bottom',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
       set(ax2, 'XLim',[0 max(g)])
   p2 = line(g,g3*1/0.1,'Color','k','Parent',ax2);
   ylabel(  'Spikerrate [spikes/s]')
xlabel('Input [pA]')