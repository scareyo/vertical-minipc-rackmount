$fn=64;

// device constants
device_w = 189;
device_h = 48;
device_d = 196;

// rack constants
unit_w = 254;
unit_h = 44.5;
post_w = 15.875;
screw_offset = 6.35;

module faceplate(ru = 1, depth = 6, screw_radius = 3, num_devices = 4) {
  difference() {
    rounded_plate([unit_w, unit_h * ru, depth], 4);
  
    // screws
    for (i = [0 : 2 : ru - 1]) {
      echo(i);
      translate([post_w / 2, screw_offset + (unit_h * i), -1])
        cylinder(depth + 2, screw_radius, screw_radius);
      
      translate([post_w / 2, unit_h - screw_offset + (unit_h * i), -1])
        cylinder(depth + 2, screw_radius, screw_radius);
      
      translate([unit_w - post_w / 2, screw_offset + (unit_h * i), -1])
        cylinder(depth + 2, screw_radius, screw_radius);
      
      translate([unit_w - post_w / 2, unit_h - screw_offset + (unit_h * i), -1])
        cylinder(depth + 2, screw_radius, screw_radius);
    }
    
    gap = ((unit_w - 2 * post_w) - (device_h * num_devices)) / num_devices + 1;
    
    // device cutout
    translate([
      (unit_w - (device_h * num_devices + gap * (num_devices - 1))) / 2,
      (unit_h * ru - device_w) / 2,
      0
    ])
    for (i = [0 : 1 : num_devices - 1]) {
      translate([(device_h + gap) * i, 0, -1])
        rounded_plate([device_h, device_w, depth + 2], 4);
    }
  }
}

module rounded_plate(dimensions = [10, 10, 10], radius = 10) {
  linear_extrude(dimensions[2])
  minkowski() {
    translate([radius, radius])
    square([dimensions[0] - 2 * radius, dimensions[1] - 2 * radius]);
    circle(radius);
  }
}

//rotate([90])
faceplate(ru = 5, num_devices = 4);