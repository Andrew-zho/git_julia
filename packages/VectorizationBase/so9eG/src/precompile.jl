function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    precompile(Tuple{typeof(VectorizationBase.T_shift),Type{Float32}})
    precompile(Tuple{typeof(VectorizationBase.T_shift),Type{Int32}})
    precompile(Tuple{typeof(VectorizationBase.llvmtype),Type{T} where T})
    precompile(Tuple{typeof(VectorizationBase.mask_type),Type{Float32}})
    precompile(Tuple{typeof(VectorizationBase.pick_vector_width),Int64,Type{Float32}})
    precompile(Tuple{typeof(VectorizationBase.pick_vector_width),Int64,Type{Float64}})
    precompile(Tuple{typeof(VectorizationBase.pick_vector_width),Type{Float32}})
    precompile(Tuple{typeof(VectorizationBase.pick_vector_width),Val{3},Type{Float32}})
    precompile(Tuple{typeof(VectorizationBase.pick_vector_width),Val{3},Type{Float64}})
    precompile(Tuple{typeof(VectorizationBase.vzero),Val{8},Type{Float32}})
    precompile(Tuple{typeof(which(VectorizationBase.pick_vector_width_val,(Vararg{Any,N} where N,)).generator.gen),Any,Any})
end
