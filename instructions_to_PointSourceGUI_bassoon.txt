% contributors: Malte Kob (modeling concept, PointSourceClass), Jithin Thilakan (visualization, jupyter GUI), Walter Buchholtzer (visualization) Timo Grothe (visualization, Matlab GUI)

%GUI with Matlabs guide for the point source modelling software
%Bassoon version with 14 editable sources
%Timo Grothe, ETI, 30.05.2022
%
% Requires: 
% -PointSourceGUI_bassoon.m    => the Matlabscript for GUI control
% -PointSourceGUI_bassoon.fig  => the Matlab figure file with the GUI 
% -PointSourceClass.m          => a Matlab class definition for a point source     
% -PointSourceClassD.m         => a Matlab class definition for a directional source
%
% Required additional data files: 
% -param_<freq>Hz.csv , where freq = 176,612,940,1520 => source parameters for 14 bassoon tone holes, organized in a .csv table file
% ==
% Optional bassoon data files:
% -param(ow)_<freq>Hz.csv , where freq = 176,612,940,1520 => source
% parameters for 14 bassoon tone holes, organized in a .csv table file,
% computed with a different waveguide model
%
% Optional demo file
% -dipole_80Hz => a file that can be used as a template for custom source definitions.
%
% INSTRUCTIONS
% To run the GUI, make sure that all required files are in the same
% folder. 
% 1) Open PointSourceGUI_bassoon.m in a Matlab editor
% 2) Run the file in Matlab
% OBJECTIVE
% With the GUI figure that opens, you can visualize bassoon radiation data
% as calculated by the point source model described in Kob et al.
% "Simulation and interpretation of wind instrument directivity using a
% point source approach" (Manuscript to be submitted to Acta Acustica)
% LOAD PRESETS
% By clicking the checkboxes, you can compare the simulated radiation pattern of a bassoon fingered F3 (175 Hz)
% in three different model flavors ("PS", "WG", "WG+CA"), at four different frequencies.
% These models directly relate to the data shown in Fig.6 of the accompanying manuscript.
% Having loaded one of these presets by checking one of the checkboxes, you can modify
% the source parameters freely to see how this affects the radiation
% pattern. 
% INTERACTION WITH THE GUI
% The model is instantaneously updated, such that any modification of the
% parameters in the GUI is directly plotted. 
% Geometry: In the edit fields, you can type the source position (coordinates x,y,z).
% Excitation: With the sliders, you can modify each sources strength (Q) an acoustical distance(D) by +/- 100%.
% Frequency: You can also vary the frequency of the model with the slider.
% View: You may freely change the view on the ballon radiation plot by use of the rotate- and tilt-sliders.
% PRINT
% Click the print button to make a pdf print of the current model.
% RESET
% To compare these bassoon radiation data to a simpler radiator, you can click on the "reset to line array" button,
% which loads a line array with 14 regularly spaced sources, symmetrically
% aligned along the y-axis. 7 sources are left and the other 7 sources
% right of the origin. Sources within these two groups are synchronous, but the
% phase shift between the two groups is pi.
% CUSTOM SOURCES
% To test a specific model, you can set up a csv- table with custom source
% parameters. The convention for such a table is: each source is definte by five parametres
% in a row: the fist three indicate the position (x,y,z), and the latter two the excitation
% (source strength Q, and acoustical distance D) (for details see
% PointSourceClass.m). The filename can be chosen freely, a file ending
% suffix _1234Hz.csv will set the initial modeling frequency on the slider to 1234 Hz.
% To match the GUI, you will need to set 14 source (set the source strength to 0 if you need less than 14 sources).
% As a template, the file dipole_80Hz.csv shows a parameter table for a dipole. 

% Timo Grothe, ETI, 05.06.2023

