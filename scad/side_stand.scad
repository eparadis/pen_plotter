// sits on either side of the X axis and holds the motors and axis rods


include <common.scad>

depth = stepper_body_depth+10;
height = pulley_deck_height;
width = 10;

module x_axis_rod_clamps() {
  translate([-eps, x_rod_spacing/2, x_rod_height])
    rotate([0, 90, 0])
      cylinder(d=rod_pressfit_horiz, h=width*1.1);
  translate([-eps, -x_rod_spacing/2, x_rod_height])
    rotate([0, 90, 0])
      cylinder(d=rod_pressfit_horiz, h=width*1.1);
}

module stepper_mount() {
  sm_height = 4;
  // Z=0 is defined as the pulley deck height, since a pulley goes on top
  translate([width, -depth/2, pulley_deck_height-sm_height]) 
  difference() {
    cube([stepper_body_width, depth, sm_height]);
    translate([stepper_body_width/2, depth/2, -eps])
      cylinder(d=stepper_boss_diameter, h=sm_height+2*eps);
    // four mounting holes around a cicle of diameter "stepper_bolt_pattern_diameter"
    for(theta=[45:90:360]) {
      translate([stepper_body_width/2, depth/2, -eps])
        rotate([0, 0, theta])
          translate([stepper_bolt_pattern_diameter/2, 0, 0])
            cylinder(d=M3_pass_through, h=sm_height+2*eps);
    }
  }

  module triangular_support() {
    rotate([0, 90, -90])
      linear_extrude(4)
        polygon(points=[[0,0], [stepper_body_width/2, 0], [0, stepper_body_width/2]]);
  }

  translate([width, depth/2, pulley_deck_height-sm_height])
    triangular_support();

  translate([width, -depth/2 + 4, pulley_deck_height-sm_height])
    triangular_support();
     
}

module side_stand() {
  translate([-width, 0, 0]) {
    difference() {
      translate([0, -depth/2, 0])
        cube([width, depth, height]);
      x_axis_rod_clamps();
    }
    stepper_mount();
  }
}

module stepper_motor() {
  cube([stepper_body_width, stepper_body_depth, stepper_body_height]);
  translate([ stepper_body_width/2, stepper_body_depth/2, -stepper_rear_axle_length]) 
  cylinder(d=stepper_axle_diameter, h=stepper_rear_axle_length+stepper_body_height+stepper_axle_length);
}

side_stand();
%translate([0, -stepper_body_depth/2, stepper_rear_axle_length+1.5]) stepper_motor();