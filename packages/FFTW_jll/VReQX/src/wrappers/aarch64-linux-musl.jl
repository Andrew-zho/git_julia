# Autogenerated wrapper script for FFTW_jll for aarch64-linux-musl
export libfftw3, libfftw3f

JLLWrappers.@generate_wrapper_header("FFTW")
JLLWrappers.@declare_library_product(libfftw3, "libfftw3.so.3")
JLLWrappers.@declare_library_product(libfftw3f, "libfftw3f.so.3")
function __init__()
    JLLWrappers.@generate_init_header()
    JLLWrappers.@init_library_product(
        libfftw3,
        "lib/libfftw3.so",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@init_library_product(
        libfftw3f,
        "lib/libfftw3f.so",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@generate_init_footer()
end  # __init__()
