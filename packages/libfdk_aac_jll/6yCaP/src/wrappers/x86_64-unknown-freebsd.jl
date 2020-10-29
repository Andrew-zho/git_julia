# Autogenerated wrapper script for libfdk_aac_jll for x86_64-unknown-freebsd
export libfdk

JLLWrappers.@generate_wrapper_header("libfdk_aac")
JLLWrappers.@declare_library_product(libfdk, "libfdk-aac.so.1")
function __init__()
    JLLWrappers.@generate_init_header()
    JLLWrappers.@init_library_product(
        libfdk,
        "lib/libfdk-aac.so",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@generate_init_footer()
end  # __init__()
