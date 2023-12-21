using ICEModels
using Test
using ModelingToolkit
using DifferentialEquations

@testset "ICEModels.jl" begin
    @test my_f(2,1) == 6
    @test my_f(2,4) == 12
    @test my_f(2,5) == 14
end

@testset "DerOfMyF" begin
    @test derivative_of_my_f(3,1) == 3
    @test derivative_of_my_f(3,2) == 4
    @test derivative_of_my_f(0,5) == 7
end

@testset "ICEKinModel_Simple" begin
    r = 1.0;    # Crankshaft Radius # needs to be smaller than l
    l = 2.0;    # Rod length
    ω = 1.0;    # Angular velocity of the crankshaft (constant)
    @mtkbuild icekin = ICEKin()
    prob = ODEProblem(icekin, [icekin.θ => 0.0, icekin.x => 3.0, icekin.v => 0, icekin.a => 0], (0.0, 10.0), [icekin.l => l, icekin.r => r,icekin.ω => ω])
    sol = solve(prob)
    @test sol[3][1] ≈ 0.001 atol = 1e-4
    @test sol[4][1] ≈ 0.011 atol = 1e-4
    @test sol[5][1] ≈ 0.111 atol = 1e-4
    # Plots.plot(sol, idxs = [icekin.x])
end;
