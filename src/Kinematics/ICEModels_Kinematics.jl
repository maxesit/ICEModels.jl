"""
Simple Single ICE Piston Kinematics model
# States: 
    - `θ` | Angle of the Crankshaft w.r.t. the vertical axis
    - `x` | Piston position( Distance from piston joint to center of the Crankshaft)
    - `v` | Vertical velocity of the piston                 # It makes sense for such a simple model to assume that the piston center only moves vertically
    - `a` | Vertical acceleration of the piston

# Parameters:
    - `l` | Rod length
    - `r` | Radius of the Crankshaft
    - `w` | Angular velocity of the Crankshaft | for simplicity = constant

"""
@mtkmodel ICEKin begin
    @parameters begin
        l
        r
        ω
    end
    @variables begin
        θ(t)
        x(t)
        v(t)
        a(t)
    end
    @equations begin
        D(θ) ~ ω
        x ~ r * cos(θ) + √(l^2 - r^2 * sin(θ)^2)
        v ~ D(x)
        a ~ D(v)
    end
end
