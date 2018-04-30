
This code is a Matlab implementation of Local Grid Map 
Author: Alireza Asvadi

===============================================================================

The code runs on Linux/Windows with MATLAB R2013a
it needs "Piotr's Image&Video Toolbox Version 3.01" for transformation
a dataset "localized.data" is included so you can simply run Demo.m

The functions are:
init  - initialize mapping  
mp    - build current local grid map from laser data
prc   - load and pre-process data
shw   - show grid map, laser points, robot locations, and current robot direction
trns  - transform map t-1 on map t
upd   - update current local map

================================================================================

Questions regarding the code may be directed to alireza.asvadi@gmail.com
http://a-asvadi.ir/

