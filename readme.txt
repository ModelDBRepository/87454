This is the readme for the models associated with the papers:

Bahmer A, Langner G (2006) Oscillating neurons in the cochlear nucleus: 
I. Experimental basis of a simulation paradigm. Biol Cybern 95:371-9

Bahmer A, Langner G (2006) Oscillating neurons in the cochlear nucleus:
II. Simulation results. Biol Cybern 95:381-92

Bahmer A, Langner G (2007) Simulation of oscillating neurons in the
cochlear nucleus: a possible role for neural nets, onset cells, and
synaptic delays. Andreas Bahmer and Gerald Langner, in "Hearing - from
basis research to applications", Eds.: B KOllmeier, G Klump, V
Hohmann, U Langemann, M Mauermann, S Uppenkamp, J Verhey; Springer,
Heidelberg, in press.

The NEURON files are the basis for the figure 2b in Bahmer A, 
Langner G (2007) The matlab files for the Chopper neurons (Topology I and II
correspond to Bahmer and Langner 2006 I II

Usage:

NEURON_Chopper_Network_Simulation:

Either Auto-launch from ModelDB or 
--------------------
1) download and extract the archive.
2) compile the mod files

   unix/linux: use the nrnivmod command in the
   NEURON_Chopper_Network_Simulation folder

   mswin: use mknrndll to compile the mode files in the
   NEURON_Chopper_Network_Simulation folder

   mac OS X: drag and drop the NEURON_Chopper_Network_Simulation
   folder on the mknrndll icon
3) run the simulation by

   unix/linux: type nrngui mosinit.hoc in the
   NEURON_Chopper_Network_Simulation folder.

   mswin: double click on mosinit.hoc in the
   NEURON_Chopper_Network_Simulation folder

   mac OS X: drag and drop the NEURON_Chopper_Network_Simulation
   folder on the nrngui icon.
--------------------

Now that the simulation is running you can recreate the figure 2b in
the paper by clicking on the "Run" button above the "save matrix"
button".  The simulation runs 20 times.  Then press the "save matrix"
button.  This saves the traces in rothman.txt for later analysis and
graphing in matlab with the import_matlab.m script. Please erase the
first line in "rothman.txt" by hand for the import_matlab.m script.

General description of script contents:

circuitroth120pA.ses: Network of two chopper neurons.

loop.hoc: Loops the network with increasing input strength. The file
has to be loaded within the circuitroth120pA Session from the GUI. A
matrix can be saved in a file "rothman.txt". This file can be read in
matlab with "import_matlab.m" (after it's first line is erased)

More matlab notes:

In addition in the "include" folder there are function files which are
the neurons and synapses and some other files that are needed for the
simulation.  The interface for the nerve and the onset simulation is
open:

"anft" is the variable for the nerve input (example:
000205010020033...  sampling 25us). As it is presumed that the chopper
have an input of a frequency channel with 5 synapses it is
subdivided. (anft==5 anft==4...)

"onsett" is the variable for the onset neuron input. (only zeros and
ones, example: 001000010000) Onset neuron is from Rothman and Manis
(which is also stored in ModelDB).

Good test choices are anft as long as onsett, anft can contain numbers
up to 5, onsett only 1 and 0, like:

anft=  [1 1 0 0 3 5 4 1 0 0 5 4 3 0]
onsett=[0 0 0 0 0 1 1 0 0 0 1 1 0 0]


The LIF neurons have a stochastic component.

In my simulations, I have simulated the nerve and onset neuron with
many repetitions (the nerve contains stochastic elements) and stored
it. The data was a matrix, in which each colomns are time slits and
rows are one repetition with 25 us precision.  The next step was that
matlab reads one line of nerv ( number for amount of APs and zeros)
and onset (just zeros and ones, ones for an AP) and then simulates the
choppers and stores the chopper result.  This step was repeated as
often as the number of repetions.


Dr. Andreas Bahmer
Dr.rer.nat. Dipl.-Phys. cand. med.
Klinkum der Johann Wolfgang Goethe Universität
Klinik für Hals-Nasen-Ohrenheilkunde
Audiologische Akustik, Prof. Dr.- Ing. Uwe Baumann
Theodor-Stern-Kai 7, 60590 Frankfurt am Main

Update 2008-07-04:
For a graphical user interface: with the compiler toolbox from matlab
we made a standalone exe-file provided in the distrib subfolder in the
ModelDB (expanded) archive but you have to install a "MCR-installer"
(free) which I also provide on my homepage (sorry it is in german)
http://home.arcor.de/a.bahmer/software.html
Installationsprogramm für neue compilierte Matlabprogramme ab R2007a (EXE-File)
