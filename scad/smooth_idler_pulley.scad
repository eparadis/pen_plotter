
include <common.scad>;

base_dia = 14;
base_height = 8;
smooth_dia = 12;
smooth_height = 8;
bore_dia = 3.2;

difference() {
  union() {
    cylinder(h=base_height, d=base_dia);
    translate([0,0,base_height])
      cylinder(h=smooth_height, d=smooth_dia);
  }
  translate([0,0, -eps])
    cylinder(h=base_height+smooth_height+2*eps, d=bore_dia);
}