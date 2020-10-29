"""
$(TYPEDEF)
"""
struct LinearProblem{uType,isinplace,F,bType,P,K} <: AbstractLinearProblem{bType,isinplace}
    A::F
    b::bType
    u0::uType
    p::P
    kwargs::K
    @add_kwonly function LinearProblem{iip}(A,b,p=NullParameters();u0=nothing,
                                            kwargs...) where iip
        new{typeof(u0),iip,typeof(A),typeof(b),typeof(p),typeof(kwargs)}(
            A,b,u0,p,kwargs
        )
    end
end

function LinearProblem(A,b,args...;kwargs...)
    if A isa AbstractArray
        LinearProblem{true}(DiffEqArrayOperator(A),b,args...;kwargs...)
    else
        LinearProblem{isinplace(A, 4)}(A,b,args...;kwargs...)
    end
end

"""
$(TYPEDEF)
"""
struct NonlinearProblem{uType,isinplace,P,F,K} <: AbstractNonlinearProblem{uType,isinplace}
    f::F
    u0::uType
    p::P
    kwargs::K
    @add_kwonly function NonlinearProblem{iip}(f,u0,p=NullParameters();kwargs...) where iip
        new{typeof(u0),iip,typeof(p),typeof(f),typeof(kwargs)}(f,u0,p,kwargs)
    end
end

NonlinearProblem(f,u0,args...;kwargs...) = NonlinearProblem{isinplace(f, 3)}(f,u0,args...;kwargs...)

"""
$(TYPEDEF)
"""
struct QuadratureProblem{isinplace,P,F,L,U,K} <: AbstractQuadratureProblem{isinplace}
    f::F
    lb::L
    ub::U
    nout::Int
    p::P
    batch::Int
    kwargs::K
    @add_kwonly function QuadratureProblem{iip}(f,lb,ub,p=NullParameters();
                                                nout=1,
                                                batch = 0, kwargs...) where iip
        new{iip,typeof(p),typeof(f),typeof(lb),
            typeof(ub),typeof(kwargs)}(f,lb,ub,nout,p,batch,kwargs)
    end
end

QuadratureProblem(f,lb,ub,args...;kwargs...) = QuadratureProblem{isinplace(f, 3)}(f,lb,ub,args...;kwargs...)

struct NoAD <: AbstractADType end

struct OptimizationFunction{iip,AD,F,G,H,HV,C,CJ,CH} <: AbstractOptimizationFunction
    f::F
    adtype::AD
    grad::G
    hess::H
    hv::HV
    cons::C
    cons_j::CJ
    cons_h::CH
end

(f::OptimizationFunction)(args...) = f.f(args...)

OptimizationFunction(args...;kwargs...) = OptimizationFunction{true}(args...;kwargs...)

function OptimizationFunction{iip}(f,adtype::AbstractADType=NoAD();
                     grad=nothing,hess=nothing,hv=nothing,
                     cons=nothing, cons_j=nothing,cons_h=nothing) where iip
    OptimizationFunction{iip,typeof(adtype),typeof(f),typeof(grad),typeof(hess),typeof(hv),
                         typeof(cons),typeof(cons_j),typeof(cons_h)}(
                         f,adtype,grad,hess,hv,cons,cons_j,cons_h)
end

"""
$(TYPEDEF)
"""
struct OptimizationProblem{iip,F,uType,P,B,LC,UC,K} <: AbstractOptimizationProblem{isinplace}
    f::F
    u0::uType
    p::P
    lb::B
    ub::B
    lcons::LC
    ucons::UC
    kwargs::K
    @add_kwonly function OptimizationProblem{iip}(f::OptimizationFunction{iip}, u0, p=DiffEqBase.NullParameters();
                                                  lb = nothing, ub = nothing,
                                                  lcons = nothing, ucons = nothing,
                                                  kwargs...) where iip
        new{iip, typeof(f), typeof(u0), typeof(p),
            typeof(lb), typeof(lcons), typeof(ucons),
            typeof(kwargs)}(f, u0, p, lb, ub, lcons, ucons, kwargs)
    end
end

OptimizationProblem(f::OptimizationFunction,args...;kwargs...) = OptimizationProblem{isinplace(f)}(f,args...;kwargs...)
OptimizationProblem(f,args...;kwargs...) = OptimizationProblem{true}(OptimizationFunction{true}(f),args...;kwargs...)

isinplace(f::OptimizationFunction{iip}) where iip = iip
isinplace(f::OptimizationProblem{iip}) where iip = iip
