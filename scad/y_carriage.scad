// slides along the Y axis (up and down) and holds the pen lifter

include <common.scad>

width = y_rod_spacing + (lin_bearing_OD * 0.7);
depth = y_carriage_depth;
height = 1 + lin_bearing_OD + 1;

module rod_clearances() {
  module rod_clearance() {
    translate([0, depth*0.55, 0])
      rotate([90, 0, 0])
        cylinder(d=rod_OD+rod_clr, h=depth*1.1);
  }
  translate([-y_rod_spacing/2, 0, 0]) {
    rod_clearance();
    translate([y_rod_spacing, 0, 0]) {
      rod_clearance();
    }
  }
}

module linear_bearings() {
  module linear_bearing() {
    rotate([90, 0, 0])
    cylinder(d=lin_bearing_OD, h=lin_bearing_length, center=true);
  }

  translate([-y_rod_spacing/2, -depth/2+lin_bearing_length/2-eps, 0]) {
    linear_bearing();
    translate([y_rod_spacing, 0, 0])
      linear_bearing();
  }

  translate([-y_rod_spacing/2, depth/2-lin_bearing_length/2+eps, 0]) {
    linear_bearing();
    translate([y_rod_spacing, 0, 0])
      linear_bearing();
  }
}

module y_carriage() {
  difference() {
    cube([width, depth, height], center=true);
    rod_clearances();
    linear_bearings();
  }
}

y_carriage();
