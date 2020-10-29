export DEBUG_METADATA_VERSION, strip_debuginfo!

DEBUG_METADATA_VERSION() = API.LLVMDebugMetadataVersion()

strip_debuginfo!(mod::Module) = API.LLVMStripModuleDebugInfo(mod)

if version() >= v"8.0"
set_subprogram!(func::Function, sp::Metadata) = API.LLVMSetSubprogram(func, sp)
get_subprogram(func::Function) = Metadata(API.LLVMGetSubprogram(func))
end
