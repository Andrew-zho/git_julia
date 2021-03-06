# Autogenerated wrapper script for METIS_jll for i686-linux-gnu
export libmetis

## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"
LIBPATH_default = ""

# Relative path to `libmetis`
const libmetis_splitpath = ["lib", "libmetis.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libmetis_path = ""

# libmetis-specific global declaration
# This will be filled out by __init__()
libmetis_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libmetis = "libmetis.so"


"""
Open all libraries
"""
function __init__()
    global artifact_dir = abspath(artifact"METIS")

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    # We first need to add to LIBPATH_list the libraries provided by Julia
    append!(LIBPATH_list, [joinpath(Sys.BINDIR, Base.LIBDIR, "julia"), joinpath(Sys.BINDIR, Base.LIBDIR)])
    global libmetis_path = normpath(joinpath(artifact_dir, libmetis_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libmetis_handle = dlopen(libmetis_path)
    push!(LIBPATH_list, dirname(libmetis_path))

    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

