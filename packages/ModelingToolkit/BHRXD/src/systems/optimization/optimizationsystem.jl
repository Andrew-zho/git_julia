"""
$(TYPEDEF)

A scalar equation for optimization.

# Fields
$(FIELDS)

# Examples

```
@variables x y z
@parameters σ ρ β

op = σ*(y-x) + x*(ρ-z)-y + x*y - β*z
os = OptimizationSystem(eqs, [x,y,z],[σ,ρ,β])
```
"""
struct OptimizationSystem <: AbstractSystem
    """Vector of equations defining the system."""
    op::Operation
    """Unknown variables."""
    states::Vector{Variable}
    """Parameters."""
    ps::Vector{Variable}
    pins::Vector{Variable}
    observed::Vector{Equation}
    equality_constraints::Vector{Equation}
    inequality_constraints::Vector{Operation}
    """
    Name: the name of the system
    """
    name::Symbol
    """
    systems: The internal systems
    """
    systems::Vector{OptimizationSystem}
end

function OptimizationSystem(op, states, ps;
                            pins = Variable[],
                            observed = Operation[],
                            equality_constraints = Equation[],
                            inequality_constraints = Operation[],
                            name = gensym(:OptimizationSystem),
                            systems = OptimizationSystem[])
    OptimizationSystem(op, convert.(Variable,states), convert.(Variable,ps), pins, observed, equality_constraints, inequality_constraints, name, systems)
end

function calculate_gradient(sys::OptimizationSystem)
    expand_derivatives.(gradient(equations(sys), [dv() for dv in states(sys)]))
end

function generate_gradient(sys::OptimizationSystem, vs = states(sys), ps = parameters(sys); kwargs...)
    grad = calculate_gradient(sys)
    return build_function(grad, convert.(Variable,vs), convert.(Variable,ps);
                          conv = AbstractSysToExpr(sys),kwargs...)
end

function calculate_hessian(sys::OptimizationSystem)
    expand_derivatives.(hessian(equations(sys), [dv() for dv in states(sys)]))
end

function generate_hessian(sys::OptimizationSystem, vs = states(sys), ps = parameters(sys);
                          sparse = false, kwargs...)
    if sparse
        hess = sparsehessian(equations(sys),[dv() for dv in states(sys)])
    else
        hess = calculate_hessian(sys)
    end
    return build_function(hess, convert.(Variable,vs), convert.(Variable,ps);
                          conv = AbstractSysToExpr(sys),kwargs...)
end

function generate_function(sys::OptimizationSystem, vs = states(sys), ps = parameters(sys); kwargs...)
    vs′ = convert.(Variable,vs)
    ps′ = convert.(Variable,ps)
    return build_function(equations(sys), vs′, ps′;
                          conv = AbstractSysToExpr(sys),kwargs...)
end

equations(sys::OptimizationSystem) = isempty(sys.systems) ? sys.op : sys.op + reduce(+,namespace_operation.(sys.systems))
namespace_operation(sys::OptimizationSystem) = namespace_operation(sys.op,sys.name,nothing)

hessian_sparsity(sys::OptimizationSystem) =
    hessian_sparsity(sys.op,[dv() for dv in states(sys)])

struct AutoModelingToolkit <: DiffEqBase.AbstractADType end

DiffEqBase.OptimizationProblem(sys::OptimizationSystem,args...;kwargs...) =
    DiffEqBase.OptimizationProblem{true}(sys::OptimizationSystem,args...;kwargs...)

"""
```julia
function DiffEqBase.OptimizationProblem{iip}(sys::OptimizationSystem,
                                          parammap=DiffEqBase.NullParameters();
                                          u0=nothing, lb=nothing, ub=nothing,
                                          grad = false,
                                          hess = false, sparse = false,
                                          checkbounds = false,
                                          linenumbers = true, parallel=SerialForm(),
                                          kwargs...) where iip
```

Generates an OptimizationProblem from an OptimizationSystem and allows for automatically
symbolically calculating numerical enhancements.
"""
function DiffEqBase.OptimizationProblem{iip}(sys::OptimizationSystem, u0,
                                          parammap=DiffEqBase.NullParameters();
                                          lb=nothing, ub=nothing,
                                          grad = false,
                                          hess = false, sparse = false,
                                          checkbounds = false,
                                          linenumbers = true, parallel=SerialForm(),
                                          kwargs...) where iip
    dvs = states(sys)
    ps = parameters(sys)

    f = generate_function(sys,checkbounds=checkbounds,linenumbers=linenumbers,
                              expression=Val{false})
    u0 = varmap_to_vars(u0,dvs)

    if grad
        grad_oop,grad_iip = generate_gradient(sys,checkbounds=checkbounds,linenumbers=linenumbers,
                                  parallel=parallel,expression=Val{false})
        _grad(u,p) = grad_oop(u,p)
        _grad(J,u,p) = (grad_iip(J,u,p); J)
    else
        _grad = nothing
    end

    if hess
        hess_oop,hess_iip = generate_hessian(sys,checkbounds=checkbounds,linenumbers=linenumbers,
                                 sparse=sparse,parallel=parallel,expression=Val{false})
       _hess(u,p) = hess_oop(u,p)
       _hess(J,u,p) = (hess_iip(J,u,p); J)
    else
        _hess = nothing
    end

    _f = DiffEqBase.OptimizationFunction{iip,AutoModelingToolkit,typeof(f),typeof(_grad),typeof(_hess),Nothing,Nothing,Nothing,Nothing}(f,AutoModelingToolkit(),_grad,_hess,nothing,nothing,nothing,nothing,0)

    p = varmap_to_vars(parammap,ps)
    lb = varmap_to_vars(lb,dvs)
    ub = varmap_to_vars(ub,dvs)
    OptimizationProblem{iip}(_f,u0,p;lb=lb,ub=ub,kwargs...)
end

"""
```julia
function DiffEqBase.OptimizationProblemExpr{iip}(sys::OptimizationSystem,
                                          parammap=DiffEqBase.NullParameters();
                                          u0=nothing, lb=nothing, ub=nothing,
                                          grad = false,
                                          hes = false, sparse = false,
                                          checkbounds = false,
                                          linenumbers = true, parallel=SerialForm(),
                                          kwargs...) where iip
```

Generates a Julia expression for an OptimizationProblem from an
OptimizationSystem and allows for automatically symbolically
calculating numerical enhancements.
"""
struct OptimizationProblemExpr{iip} end

OptimizationProblemExpr(sys::OptimizationSystem,args...;kwargs...) =
    OptimizationProblemExpr{true}(sys::OptimizationSystem,args...;kwargs...)
    
function OptimizationProblemExpr{iip}(sys::OptimizationSystem, u0,
                                          parammap=DiffEqBase.NullParameters();
                                          lb=nothing, ub=nothing,
                                          grad = false,
                                          hess = false, sparse = false,
                                          checkbounds = false,
                                          linenumbers = false, parallel=SerialForm(),
                                          kwargs...) where iip
    dvs = states(sys)
    ps = parameters(sys)
    idx = iip ? 2 : 1
    f = generate_function(sys,checkbounds=checkbounds,linenumbers=linenumbers,
                              expression=Val{true})
    if grad
        _grad = generate_gradient(sys,checkbounds=checkbounds,linenumbers=linenumbers,
                             parallel=parallel,expression=Val{false})[idx]
    else
        _grad = :nothing
    end

    if hess
        _hess = generate_hessian(sys,checkbounds=checkbounds,linenumbers=linenumbers,
                                         sparse=sparse,parallel=parallel,expression=Val{false})[idx]
    else
        _hess = :nothing
    end

    u0 = varmap_to_vars(u0,dvs)
    p = varmap_to_vars(parammap,ps)
    lb = varmap_to_vars(lb,dvs)
    ub = varmap_to_vars(ub,dvs)
    quote
        f = $f
        p = $p
        u0 = $u0
        grad = $_grad
        hess = $_hess
        lb = $lb
        ub = $ub
        _f = OptimizationFunction{$iip,typeof(f),typeof(grad),typeof(hess),Nothing,Nothing,Nothing,Nothing}(f,grad,hess,nothing,AutoModelingToolkit(),nothing,nothing,nothing,0)
        OptimizationProblem{$iip}(_f,u0,p;lb=lb,ub=ub,kwargs...)
    end
end

function OptimizationFunction(f, x, ::AutoModelingToolkit,p = DiffEqBase.NullParameters();
                              grad=false, hess=false, cons = nothing, cons_j = nothing, cons_h = nothing,
                              num_cons = 0, chunksize = 1, hv = nothing)

    sys = modelingtoolkitize(OptimizationProblem(f,x,p))
    u0map = states(sys) .=> x
    if p == DiffEqBase.NullParameters()
        parammap = DiffEqBase.NullParameters()
    else
        parammap = parameters(sys) .=> p
    end
    OptimizationProblem(sys,u0map,parammap,grad=grad,hess=hess).f
end
