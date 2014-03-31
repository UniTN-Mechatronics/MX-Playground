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

# Make it silent
ocp.data.InfoLevel = 0

# Lets start a new parametric analysis with the ocp solver
pa = Mechatronix::ParametricAnalysis.new
pa.solver = ocp

# Define the exploration domain: it must be a Hash with the name of the
# parameters to be explored as keys, and Arrays of values as values.
pa.parameters = {:Fmax => [0.9, 1, 1.1], :L => [0.9, 1.0, 1.5]}

# Give some feedback
puts "STARTING PARAMETRIC ANALYSIS on parameters #{pa.parameters.keys}"
puts "Parameters table:"
p pa.parameters.keys
pa.combinations.each {|combo| p combo }
puts 

# Calling ParametricAnalysis#each loops on each possible combination, calling
# the given block on it
i = 0 # for indexing output files
Dir.mkdir("data") unless Dir.exist? "data"
puts "STARTING CALCULATIONS"
pa.each do |solver, combination|
  # Description to be added in the comment header of the output file
  desc =  "alpha = #{solver.data.Parameters[:Fmax]}, beta = #{solver.data.Parameters[:L]}"
  # Give some feedback
  print "Solving case for #{desc}"
  # Calculate the solution
  solver.solve
  unless solver.ocp_solution[:Error] then
    # Non-convergence is not an error!
    solver.write_ocp_solution("data/#{problem_name}_OCP_result_#{i}.txt", desc)
    puts " OK"
  else
    puts " Error"
  end
  i += 1 # Increment the output file index
end

figlet "All done."

# EOF
