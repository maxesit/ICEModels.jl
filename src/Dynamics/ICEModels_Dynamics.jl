""" 
Simple Single ICE Piston Dynamics model // Applies the force at the piston every even rotation of the crank
# States: 
    - `F` | Force that's applied to the piston
    - `θ` | Angle of the Crankshaft w.r.t. the vertical axis
    - `ω` | Angular velocity of the Crankshaft
    - `x` | Piston position( Distance from piston joint to center of the Crankshaft)
    - `v` | Vertical velocity of the piston                 # It makes sense for such a simple model to assume that the piston center only moves vertically
    - `a` | Vertical acceleration of the piston

# Parameters:
    - `ρ` | Crankshaft material density
    - `h` | Crankshaft thickness
    - `l` | Rod length
    - `r` | Radius of the Crankshaft
    - `f` | Force value that is applied to the crank | For simplicity -> same every time it's applied

"""


@mtkmodel ICEDyn_simple begin
    @parameters begin
        ρ
        l 
        r 
        h 
        f           #   need to add connectors to do this properly!  TODO
    end
    @variables begin
        F(t)
        θ(t)
        ω(t)
        x(t)
        v(t)
        a(t)
    end
    @equations begin
        F ~ f*(((θ%(4*π))>0.0)*((θ%(4*π))<π)) + 0.0    # makes force input on certain crank positions
        D(ω) ~ (2*F*sin(θ))/(ρ*(r^3)*π*h)
        D(θ) ~ ω
        x ~ r * cos(θ) + √(l^2 - r^2 * sin(θ)^2)
        v ~ D(x)
        a ~ D(v)
    end
end