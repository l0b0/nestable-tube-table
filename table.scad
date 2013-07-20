// CONFIGURATION

table_width = 50; // Total sizes
table_depth = 30;
table_height = 20;

foot_rest_height = 5; // Height of the *top*

tube_thickness = 1;
tube_gauge = 1/8;

// CONFIGURATION END

// CALCULATIONS

table_x_size = table_width;
table_y_size = table_depth;
table_z_size = table_height;

foot_rest_z_position = foot_rest_height - tube_thickness;

// CALCULATIONS END

// MODULES
module leg() {
    difference() {
        cube(size = [tube_thickness, tube_thickness, table_z_size]);
        translate([tube_gauge, tube_gauge, -1]) {
            cube(size = [tube_thickness - tube_gauge * 2, tube_thickness - tube_gauge * 2, table_z_size + 2]);
        }
    }
}

module legs() {
    union() {
        translate([tube_thickness, tube_thickness, 0]) {
            leg();
        }
        translate([table_x_size - tube_thickness * 2, tube_thickness, 0]) {
            leg();
        }
        translate([table_x_size - tube_thickness * 2, table_y_size - tube_thickness * 2, 0]) {
            leg();
        }
        translate([tube_thickness, table_y_size - tube_thickness * 2, 0]) {
            leg();
        }
    }
}

module width_bar() {
    difference() {
        cube(size = [table_x_size, tube_thickness, tube_thickness]);
        translate([-1, tube_gauge, tube_gauge]) {
            cube(size = [table_x_size + 2, tube_thickness - tube_gauge * 2, tube_thickness - tube_gauge * 2]);
        }
    }
}

module width_bars() {
    union() {
        translate([0, 0, foot_rest_z_position]) {
            width_bar();
        }
        translate([0, 0, table_z_size - tube_thickness]) {
            width_bar();
        }
    }
}

module depth_bar() {
    difference() {
        cube(size = [tube_thickness, table_y_size - tube_thickness, tube_thickness]);
        translate([tube_gauge, -1, tube_gauge]) {
            cube(size = [tube_thickness - tube_gauge * 2, table_y_size + 2, tube_thickness - tube_gauge * 2]);
        }
    }
}

module depth_bars() {
    union() {
        translate([0, tube_thickness, foot_rest_z_position]) {
            depth_bar();
        }
        translate([table_x_size - tube_thickness, tube_thickness, foot_rest_z_position]) {
            depth_bar();
        }
        translate([0, tube_thickness, table_z_size - tube_thickness]) {
            depth_bar();
        }
        translate([table_x_size - tube_thickness, tube_thickness, table_z_size - tube_thickness]) {
            depth_bar();
        }
    }
}

module table() {
    legs();
    width_bars();
    depth_bars();
}

// MODULES END

table();
