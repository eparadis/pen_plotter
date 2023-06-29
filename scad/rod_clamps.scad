// this can be used to clamp on to the y or x axis rods
// in order to improve tension in the belt

include <common.scad>;

width = 10;
height = 15;
thickness = 10;

rod_offset = 5;
screw_offset = 2.5;
slot_thickeness = 1;

module rod_clamp() {
  difference() {
    // the body
    cube([width, height, thickness]);
    // the rod pass through
    translate([width/2, rod_offset, -eps])
      cylinder(h=thickness+2*eps, d=rod_pressfit_horiz);
    // the slot
    translate([width/2-slot_thickeness/2, rod_offset, -eps])
      cube([slot_thickeness, height-rod_offset+eps, thickness+2*eps]);
    // clamp screw, threaded side
    translate([-width/2, height-screw_offset, thickness/2])
      rotate([0, 90, 0])
      cylinder(h=width+2*eps, d=M3_self_thread_horiz);
    // clamp screw, unthreaded side
    translate([width/2, height-screw_offset, thickness/2])
      rotate([0, 90, 0])
      cylinder(h=width+2*eps, d=M3_pass_through_horiz);
  }
}

rod_clamp();