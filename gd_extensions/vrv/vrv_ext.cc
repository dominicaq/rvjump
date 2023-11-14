
#include "vrv_ext.h"

#include <gdextension_interface.h>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/core/defs.hpp>
#include <godot_cpp/godot.hpp>

namespace godot {
void GDVRVExt::_bind_methods() {}

GDVRVExt::GDVRVExt() {
  // Initialize any variables here.
  val = 0.0;
}

GDVRVExt::~GDVRVExt() {
  // Add your cleanup here.
}

double GDVRVExt::_mul_val(double a) { return a * val; }

void initialize_vrv_module(ModuleInitializationLevel p_level) {
  if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
    return;
  }

  ClassDB::register_class<GDVRVExt>();
}

void uninitialize_vrv_module(ModuleInitializationLevel p_level) {
  if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
    return;
  }
}

extern "C" {
// Initialization.
GDExtensionBool GDE_EXPORT
vrv_lib_init(GDExtensionInterfaceGetProcAddress p_get_proc_address,
             const GDExtensionClassLibraryPtr p_library,
             GDExtensionInitialization *r_initialization) {
  godot::GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library,
                                                 r_initialization);

  init_obj.register_initializer(initialize_vrv_module);
  init_obj.register_terminator(uninitialize_vrv_module);
  init_obj.set_minimum_library_initialization_level(
      MODULE_INITIALIZATION_LEVEL_SCENE);

  return init_obj.init();
}
}

} // namespace godot
