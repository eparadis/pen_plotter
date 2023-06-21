// slides along X axis (left and right) and holds the Y axis rods

include <common.scad>;

width = x_carriage_width;
height = 1 + lin_bearing_OD + 1;
depth = x_rod_spacing + (lin_bearing_OD * 0.7);


module rod_clearances() {
  module rod_clearance() {
    translate([-width*0.55, 0, 0])
      rotate([0, 90, 0])
        cylinder(d=rod_OD+rod_clr, h=width*1.1);
  }
  translate([0, -x_rod_spacing/2, 0]) {
    rod_clearance();
    translate([0, x_rod_spacing, 0 ]) {
      rod_clearance();
    }
  }
}

module linear_bearings() {
  module linear_bearing() {
    rotate([0, 90, 0])
    cylinder(d=lin_bearing_OD, h=lin_bearing_length, center=true);
  }

  translate([-width/2+lin_bearing_length/2-eps, -x_rod_spacing/2, 0]) {
    linear_bearing();
    translate([0, x_rod_spacing, 0 ])
      linear_bearing();
  }

  translate([width/2-lin_bearing_length/2+eps, -x_rod_spacing/2, 0]) {
    linear_bearing();
    translate([0, x_rod_spacing, 0 ])
      linear_bearing();
  }
}

module y_axis_rod_clamps() {
  clamp_height = 1 + rod_pressfit_horiz + 1;
  translate([0, 0, clamp_height/2])
  difference() {
      cube([width, depth, clamp_height], center=true);
    translate([-y_rod_spacing/2, depth/2+eps, 0])
      rotate([90, 0, 0])
        cylinder(d=rod_pressfit_horiz, h=depth*1.1);
    translate([+y_rod_spacing/2, depth/2+eps, 0])
      rotate([90, 0, 0])
        cylinder(d=rod_pressfit_horiz, h=depth*1.1);
  }
}

difference(){
  union() {
    translate([0, 0, height/2])
      y_axis_rod_clamps();
    cube([width, depth, height], center=true);
  }
  rod_clearances();
  linear_bearings();
}

