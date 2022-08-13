contributors: Malte Kob (modeling concept, PointSourceClass), Jithin Thilakan (visualization, jupyter GUI), Walter Buchholtzer (visualization) Timo Grothe (visualization, Matlab GUI)


Guideline to run jupyter notebook
PointSourceGUI_v1_0.ipynb 
===========================================

windows user
(if you have python/ jupyter installed, you may omit STEPS 1-3)
-----------------------
STEP 1)
download and install anaconda framework
https://www.anaconda.com/

STEP 2)
open the anaconda.navigator app

STEP 3)
run jupyter notebook 
(locate jupyter notebook, locate and press "Launch" button, jupyter notebook opens in your default webbrowser)

STEP 4)
run PointSourceGUI_v1_0.ipynb
(in the menu, choose "File", locate PointSourceGUI_v1_0.ipynb in the file browser view.
locate the "Run"-Button in the toolbar below the menu, click run tun the gui)
 
----------------------------------
see also:
https://www.anaconda.com/products/distribution#Downloads
https://docs.jupyter.org/en/latest/running.html#running
-----------------------------------

The current script is tested with 
Python 3.9.2

IPython          : 8.4.0
ipykernel        : 6.15.0
ipywidgets       : 7.7.0
jupyter_client   : 7.3.4
jupyter_core     : 4.10.0
nbclient         : 0.6.4
nbconvert        : 6.5.0
nbformat         : 5.4.0
notebook         : 6.4.12
traitlets        : 5.3.0

(all contained in
https://repo.anaconda.com/archive/Anaconda3-2022.05-Windows-x86_64.exe (600 MB))

================================

linux user
(if you have python3 and jupyter installed, you may omit STEPS 1-3)
-----------------------

STEP 1) install pip3
$ sudo apt install python3-pip

STEP 2) update pip3
$ pip3 install --upgrade pip

STEP 3) install jupyter using pip3
$ pip3 install jupyter 
 * see additional notes below

STEP 4) install additional packages numpy and plotly
$ pip3 install numpy
$ pip3 install plotly

STEP 5) run jupyter notebook
$ jupyter notebook
(opens jupyter notebook in your default webbrowser)

STEP 6) run PointSourceGUI_v1_0.ipynb
(in the menu, choose "File", locate PointSourceGUI_v1_0.ipynb in the file browser view.
locate the "Run"-Button in the toolbar below the menu, click run tun the gui)

-------------------------------
see also:
https://docs.jupyter.org/en/latest/install/notebook-classic.html
https://docs.jupyter.org/en/latest/running.html#running
-------------------------------


* notes additional to STEP 3) 
I can be useful to add jupyter installation directory manually to path 
$ PATH="$PATH:/home/<my User Name>/.local/bin"
to do this automatically when opening a terminal, add the above line to ~/.bashrc
If you experience the Jupyter Lab ImportError: cannot import name ‘soft_unicode’ from ‘markupsafe’,
it can be fixed by downgrading the markupsafe package:
$ pip3 install markupsafe==2.0.1

--------------

The current script is tested with 
Python 3.8.10
numpy-1.23.1
plotly-5.9.0

IPython          : 8.4.0
ipykernel        : 6.15.1
ipywidgets       : 7.7.1
jupyter_client   : 7.3.4
jupyter_core     : 4.11.1
nbclient         : 0.6.6
nbconvert        : 6.5.0
nbformat         : 5.4.0
notebook         : 6.4.12
qtconsole        : 5.3.1
traitlets        : 5.3.0

===============
Timo Grothe, ETI, 09.08.2022