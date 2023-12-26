module ICEModels
using ForwardDiff
using DifferentialEquations
using ModelingToolkit
@parameters t
D = Differential(t)

include("Kinematics/ICEModels_Kinematics.jl")
include("Dynamics/ICEModels_Dynamics.jl")
include("myexample.jl")
# Write your package code here.
export(my_f)
export(derivative_of_my_f)
export(ICEKin)
export(ICEDyn_simple)
end
