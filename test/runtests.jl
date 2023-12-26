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

@testset "ICEDynModel_Simple" begin
    r = 1.0;    # Crankshaft Radius # needs to be smaller than l
    l = 2.0;    # Rod length
    ρ = 8000.0;
    h = 0.1;
    f = 1000.0;
    tspan = (0.0,50.0)
    @mtkbuild icedyns = ICEDyn_simple()
    prob = ODEProblem(icedyns, [icedyns.θ => π/2, icedyns.ω => 0.0, icedyns.x => 3.0, icedyns.v => 0, icedyns.a => 0, icedyns.F => 0.0], tspan, [icedyns.l => l, icedyns.r => r,icedyns.ρ => ρ, icedyns.f => f, icedyns.h => h])
    sol = solve(prob)
    @test sol[3][1] ≈ 0.011 atol = 1e-4
    @test sol[4][1] ≈ 0.0947 atol = 1e-4
    @test sol[5][1] ≈ 0.3066 atol = 1e-4
    @test sol[6][1] ≈ 0.6317 atol = 1e-4
    # Plots.plot(sol, idxs = [icedyns.x, icedyns.v, icedyns.a])
    # Plots.plot(sol, idxs = [icedyns.F])
end
