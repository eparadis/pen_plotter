// slides along the Y axis (up and down) and holds the pen lifter

include <common.scad>

width = y_rod_spacing + lin_bearing_OD + 2;
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

pm_height = 5;
module pulley_mount_holes() {
  // This module's Z position is relative to the pulley system's deck height. Since pulleys mount on top of this, its top surface is Z=0.
  // the y carriage has a single pulley and rigid mount where the ends of the belt are securely fastened. Both are centered between the y axis rods
  pulleys = [
    [0, depth/2 - 5],
    [0, -depth/2 + 5], // the belt-end mount is attached using
    [0, -depth/2 + 15] //   these two mounting holes
  ];
  translate([0, 0, -pm_height/2])
  for (i=[0:2])
    translate([pulleys[i].x, pulleys[i].y, -pm_height/2-eps])
      cylinder(d=M3_self_thread, h=pm_height*1.1);
}

module pulley_mount_deck() {
  // This module's Z position is relative to the pulley system's deck height. Since pulleys mount on top of this, its top surface is Z=0.
  translate([0, 0, -pm_height/2])
    cube([width, depth, pm_height], center=true);  // pulley mount deck
}

module pen_lifter_mounts_and_cutout() {
  // This module's Z position is relative to the pulley system's deck height. Since the pen lifter mounts on top of this, its top surface is Z=0.

  // cutout. clearance from the drawing surface to above the pulley deck
  translate([0, 0, -pulley_deck_height])
    cylinder(d=20, h=pulley_deck_height*1.1, center=false);
  
  // a bolt pattern for mounting future variety of pen lifters
  for( theta = [45:90:360] ) {
    translate([0, 0, -pm_height])
      rotate([0, 0, theta])
        translate([0, pen_lifter_bolt_pattern_diameter/2, 0])
          cylinder(d=M3_self_thread, h=pm_height*1.1);
  }
}

module y_carriage() {
  // This module's Z height is referenced so that the center of the Y axis rods are Z=0
  difference() {
    union() {
      cube([width, depth, height], center=true);
      translate([0, 0, pulley_deck_height-y_rod_height])
        pulley_mount_deck();
    }
    rod_clearances();
    linear_bearings();
    translate([0, 0, pulley_deck_height-y_rod_height])
      pulley_mount_holes();
    translate([0, 5, pulley_deck_height-y_rod_height])
      pen_lifter_mounts_and_cutout();
  }
}

y_carriage();
