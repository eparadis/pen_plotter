include <common.scad>;

module pulley() {
  cylinder(d=pulley_diameter + belt_thickness, h=15);
}

module stepper_pulleys() {
  translate([x_rod_length/2 + stepper_body_width/2, 0, 0]) 
    pulley();
  translate([-x_rod_length/2 - stepper_body_width/2, 0, 0]) 
    pulley();
}

module x_carriage_pulleys() {
  translate([inner_idler_spacing/2, 0, 0])
    pulley();
  translate([-inner_idler_spacing/2, 0, 0])
    pulley();
  translate([outer_idler_spacing/2, -outer_idler_offset, 0])
    pulley();
  translate([-outer_idler_spacing/2, -outer_idler_offset, 0])
    pulley();
}

module y_carriage_pulleys() {
  translate([0, -y_rod_length/2 + y_carriage_depth/2 - 5, 0]) 
    pulley();
}

module y_axis_endcap_pulleys() {
  translate([outer_idler_spacing/2, -y_rod_length, 0])
    pulley();
  translate([-outer_idler_spacing/2, -y_rod_length, 0])
    pulley();
}

module pulleys() {
  stepper_pulleys();
  x_carriage_pulleys();
  y_carriage_pulleys();
  y_axis_endcap_pulleys();
}