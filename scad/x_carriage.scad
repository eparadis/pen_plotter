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

clamp_height = 1 + rod_pressfit_horiz + 1;
module y_axis_rod_clamp() {
  // This modules's Z position is relative to the y rods' height. Thus the center of the pressfit holes are Z=0.
  cube([width, depth, clamp_height], center=true);
}

module y_axis_rod_holes() {
  // This modules's Z position is relative to the y rods' height. Thus the center of the pressfit holes are Z=0.
  translate([-y_rod_spacing/2, depth/2+eps, 0])
    rotate([90, 0, 0])
      cylinder(d=rod_pressfit_horiz, h=depth*1.1);
  translate([+y_rod_spacing/2, depth/2+eps, 0])
    rotate([90, 0, 0])
      cylinder(d=rod_pressfit_horiz, h=depth*1.1);
}

pm_height = 5;
module pulley_mount_holes() {
  // This module's Z position is relative to the pulley system's deck height. Since pulleys mount on top of this, it's top surface is Z=0.
  back = 0;
  front = -outer_idler_offset;
  inner = inner_idler_spacing / 2;
  outer = outer_idler_spacing / 2;
  pulleys = [
    [-inner, back],
    [+inner, back],
    [-outer, front],
    [+outer, front]
  ];
  translate([0, 0, -pm_height/2])
    for (i=[0:3])
      translate([pulleys[i].x, pulleys[i].y, -pm_height/2-eps])
        cylinder(d=M3_self_thread, h=pm_height*1.1);
}

module pulley_mount_deck() {
  // This module's Z position is relative to the pulley system's deck height. Since pulleys mount on top of this, it's top surface is Z=0.
  translate([0, 0, -pm_height/2])
    cube([width, depth, pm_height], center=true);
}

module x_carriage() {
  // This module's Z height is such that the center of the x rods are Z=0.
  difference(){
    union() {
      cube([width, depth, height], center=true);
      translate([0, 0, y_rod_height-x_rod_height])
        y_axis_rod_clamp();
      translate([0, 0, pulley_deck_height-x_rod_height])
        pulley_mount_deck();
    }
    rod_clearances();
    linear_bearings();
    translate([0, 0, pulley_deck_height-x_rod_height])
      pulley_mount_holes();
    translate([0, 0, y_rod_height-x_rod_height])
      y_axis_rod_holes();
  }
}

x_carriage();
