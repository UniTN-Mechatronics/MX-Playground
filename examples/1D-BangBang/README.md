1D Bang-Bang example
====================

Description
-----------
This examples applies to the case of a mass moving in one direction under the effect of an external force, which is the control. See the Maple worksheet for details.

Step to solve
-------------
To solve the OC problem, proceed as follows:

1. Open the Maple worksheet on `model` folder and execute it. This generates four folders into the root directory (the folder containing this file): `case_[A-D]`
2. Open a console window (Terminal.app on Mac, Command Prompt on Windows), change the current directory to `case_A`, and type `mxint ./OneDBangBang_run.rb`. This compiles the dynamic library (in `lib/libOneDBangBang.[dylib|lib]`) and solves the problem using input data contained in `data/OneDBangBang_data.rb`.
3. Repeat the last step for problems in the remaining `case_*` folders.


Scripting
---------
The problem folder contains some scripts that illustrate `mxint` scripting features:

* `runme.rb`: simple solution
* `custom_output.rb`: how to customize data output
* `parametric.rb`: example of parametric analysis