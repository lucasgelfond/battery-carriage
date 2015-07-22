//By Lucas Gelfond. Licensed officially under GPL V3, but I'm not quite sure if that works. Have fun!

//Width of used battery.
batteryWidth = 42;

//Height of used battery.
batteryHeight = 22;

holeSize = 4.42;
//Size of mounting plate holes.

//The mounting hole pattern. For instance, 45x45.
mountingPattern = 45;

//The size of the mounting plate.
plateSize = 52.5;

//Thickness of the mounting plate.
plateThick = 2;

//Thickness of walls for the battery carriage.;
carriageThick = 5;

//Distance from the mounting holes to the start of the carriage walls.
holeToCarriage = 2.5;

//Extra height for the battery wall to fit the battery more comfortably.
extraBatteryWall = 2.5;

//Extra width for battery.
extraBatteryWidth = 5;

//The height of the battery strap slit.
batteryStrapHeight = 5;

//The width of the battery strap slit.
batteryStrapWidth = 15;

//The height off of the carriage that the slit is.
batteryStrapLift = 10;

//Lift the mounting plate into the main carriage? 0 = no, 1 = yes
liftMount = 1;


$fn = 100;


module mountingHole() {
    cylinder(r=holeSize/2, h=plateThick*2, center=true);
}
module mountingPlate() {
    difference() {
        cube([plateSize, plateSize, plateThick], center=true);
        for(i = [1, -1], n = [1, -1]) translate([mountingPattern/2, mountingPattern/2,0])mountingHole();
        }
}



module batteryCarriageSides() {
    for(i = [1, -1]) translate([0,(batteryWidth+extraBatteryWidth+carriageThick)/-2,(batteryHeight+plateThick+extraBatteryWall+carriageThick*2)/2]) cube([mountingPattern-holeSize-holeToCarriage*2, carriageThick, batteryHeight+extraBatteryWall], center=true);
}
module batteryCarriage() {
    translate([0,0,plateThick*liftMount]) {
        mountingPlate();
    }
    batteryCarriageSides();
     translate([0,0,(plateThick+carriageThick)/2]) {
        cube([mountingPattern-holeSize-holeToCarriage*2,batteryWidth+extraBatteryWidth+carriageThick*2,carriageThick], center=true);
    }
    translate([0,0,plateThick/2+batteryHeight+extraBatteryWall+carriageThick*1.5]) {
        cube([mountingPattern-holeSize-holeToCarriage*2,batteryWidth+extraBatteryWidth+carriageThick*2,carriageThick], center=true);
    }
    translate([0,0,batteryHeight+extraBatteryWall+carriageThick*2+plateThick-plateThick*liftMount]) {
        mountingPlate();
    }
}
module carriageWithBatteryStrap() {
    difference() {
        batteryCarriage();
        translate([0,(batteryWidth+extraBatteryWidth+carriageThick)/-2,(plateThick+batteryStrapHeight)/2+carriageThick+batteryStrapLift]) {
            cube([batteryStrapWidth, carriageThick*5, batteryStrapHeight], center=true);
        }
        translate([0,(batteryWidth+extraBatteryWidth+carriageThick)/2,(plateThick+batteryStrapHeight)/2+carriageThick+batteryStrapLift]) {
            cube([batteryStrapWidth, carriageThick*5, batteryStrapHeight], center=true);
        }            
    }
}

carriageWithBatteryStrap();
