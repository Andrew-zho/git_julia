# Autogenerated wrapper script for Opus_jll for aarch64-linux-gnu
export libopus

JLLWrappers.@generate_wrapper_header("Opus")
JLLWrappers.@declare_library_product(libopus, "libopus.so.0")
function __init__()
    JLLWrappers.@generate_init_header()
    JLLWrappers.@init_library_product(
        libopus,
        "lib/libopus.so",
        RTLD_LAZY | RTLD_DEEPBIND,
    )

    JLLWrappers.@generate_init_footer()
end  # __init__()
