#!/usr/bin/env mxint
 #--------------------------------------------------------------------------#
 #  file: OneDBangBang_run.rb                                               #
 #                                                                          #
 #  version: 1.0   date 31/3/2014                                           #
 #                                                                          #
 #  Copyright (C) 2014                                                      #
 #                                                                          #
 #      Enrico Bertolazzi and Francesco Biral and Paolo Bosetti             #
 #      Dipartimento di Ingegneria Industriale                              #
 #      Universita` degli Studi di Trento                                   #
 #      Via Mesiano 77, I-38050 Trento, Italy                               #
 #      email: enrico.bertolazzi@unitn.it                                   #
 #             francesco.biral@unitn.it                                     #
 #             paolo.bosetti@unitn.it                                       #
 #--------------------------------------------------------------------------#

require 'mechatronix'
require './case_A/data/OneDBangBang_Data.rb'

# Set the model name
problem_name = "OneDBangBang"

# Compile the scripts, unless the library already exists
# the command line flag '-f' forces recompilation
if ! File.exist?("case_A/lib/lib#{problem_name}.dylib") || ARGV[0] == '-f' then
  require "build"
  MXBuilder.new(problem_name).build
end

# Link the library
ocp = Mechatronix::OCPSolver.new "case_A/lib/lib#{problem_name}.dylib"

# Setup the solver
ocp.setup

# Calculate the OCP solution. Result is into ocp.ocp_solution
ocp.solve

# Write results
unless ocp.ocp_solution[:Error] then
  Dir.mkdir("data") unless Dir.exist? "data"
  ocp.write_ocp_solution("data/#{problem_name}_A_OCP_result.txt")
  figlet "All Done Folks!"
else
  figlet "Solver crash"
end


# EOF
