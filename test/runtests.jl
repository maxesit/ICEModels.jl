using ICEModels
using Test

@testset "ICEModels.jl" begin
    @test my_f(2,1) == 5
    @test my_f(2,4) == 8
    @test my_f(2,5) == 9
end
