#ifndef VRV_H
#define VRV_H

#ifdef WIN32
#include <windows.h>
#endif

#include <godot_cpp/classes/node.hpp>

namespace godot {

class GDVRVExt : public Node {
  GDCLASS(GDVRVExt, Node)

private:
  double val;

protected:
  static void _bind_methods();

public:
  GDVRVExt();
  ~GDVRVExt();

  double _mul_val(double a);
  float real;
};

} // namespace godot
void initialize_vrv_module();
void uninitialize_vrv_module();

#endif
