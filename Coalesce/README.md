=====
ABOUT
=====

Control Optimization Accelerated by Large-scale Export of Symbolic
Collocated Elements (COALESCE) is a MATLAB object-oriented toolbox for
formulating, building, and solving optimization problems.

Features:

* Uses a object-oriented interface to abstract the problem formulation,
  allowing for a simple, intuitive and robust symbolic problem generation.
* Automatically generates analytical gradients and exports them to
  functions to provide exact gradients.
* Supports a wide variety of optimization problems including linear,
  nonlinear, constrained, and unconstrained single objective problems.
* Interfaces with MATLAB optimization solvers as well select other popular
  solvers including SNOPT and IPOPT.
* Supports single and multi-phase trajectory optimization problems using
  a variety of direct collocation methods.
* Provides easy to use tools for plotting solutions, visualizing Jacobian
  sparsity patterns, identifying infeasible constraints, and saving results.

For more details on toolbox usage, see the examples directory.

Copyright 2013-2014 Mikhail S. Jones

============
INSTALLATION
============

Requirements:

* Mathworks MATLAB 2012b or newer (Tested on 2012b and 2014b)

Recommended:

* MATLAB Optimization Toolbox
* IPOPT
* SNOPT

To install COALESCE on Linux:

* Open a terminal and navigate to your desired install directory
* Clone the repository (git clone https://github.com/MikhailJones/coalesce)
* (Recommended) Add any supported third-party solvers to the coalesce/lib/solvers directory
  * IPOPT is highly recommended and used in most examples. To install, download the most recent version for free from (http://www.coin-or.org/download/binary/Ipopt/) and extract the contents into the /lib/solvers/ipopt folder.
  * See the README.md in the solvers directory for more information about third party solvers.

===============
GETTING STARTED
===============

* Open MATLAB, navigate to the coalesce directory and run startCoalesce.m
* Open the examples directory and run runAllExamples.m to get started!
* Individual examples can be run by entering into the example directory and running any script starting with run or the unittest.m script to run them all.
  * Most run without inputs but some don't, for example to run the pendulum on a cart passive example with 10 links simply run runPassive(10).
