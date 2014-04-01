MX-Playground
=====================

Examples and tricks on using the Mechatronix library. In order to play with these examples, you need:

* A computer running Windows (7 or later), Mac OS X (10.8 or later), or Linux (Debian 7 or later)
* [Maplesoft Maple](http://www.maplesoft.com) 16 or later
* A valid license of the Mechatronix library and of the XOptima generator for Maple
* Some basic knowledge on console and terminal applications

General comments
================

Windows and colorized console output
------------------------------------
The scripting engine of the Mechatronix library (a.k.a `mxint`) can colorize strings on terminal. For example:

```
require "colorize"

puts "Hello, World!".green
```

This comes for free on Linux and Mac OS X. On Windows, you first have to install [ansicon](http://adoxa.hostmyway.net/ansicon/). To install ANSICON:

* grab it from http://adoxa.hostmyway.net/ansicon/
* open a command prompt, move into the relevant dir in it (x68 or x64)
* type `ansicon -i`

From now on, ansicon is enabled in every Command Prompt window.