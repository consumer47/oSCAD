$fn = 100;
use<threads.scad>
use</home/gapi/.local/share/OpenSCAD/libraries/MCAD/metric_fastners.scad>;

MountingPipeDia = 25;

ClipUp = 23.2;
ClipDn = 20;
ClipH = 57;
ClipOut = 28;

fast=false;

snapOn = false;

teethDepth = 2;
numTeeth = 15;


//translate([0,0,-200])
//	MountingPipe();

ShowerHolder();


module ShowerHolder()
{
	dia = 45;
	l = 55;

	Screw(dia, l);
    Clamp(dia, l, snapOn);
	Clip(dia, l);
	Cover(dia, l);
	
	//Hardware(l);	
	
}

module Clamp(dia=45, l=55, openEnd=false)
{
	
	insertAngle = 10;
	difference()
	{
		union()
		{
			translate([-l/2, 0, 0])
				rotate([0,90,0])
					cylinder(d=dia, h=l);
			translate([-l/2,0,0])
				rotate([0,-90,0])
					Ratchet(dia, numTeeth, teethDepth);
		}
		
		translate([0,0,-dia])
			cylinder(d = MountingPipeDia + 1, h = 2*dia);
		
		if(openEnd){
			translate([-(MountingPipeDia + 1)/2*cos(insertAngle), ((MountingPipeDia + 1)/2)*sin(insertAngle), -dia])
				rotate([0,0,-insertAngle])
					cube([MountingPipeDia + 1, dia, 2*dia]);
		}
		
		translate([-13,0,0])
			rotate([0,-90,0])
				bolt(9, 50);
		translate([-11,0,0])
			rotate([0,-90,0])
				bolt(9, 50);
		
		translate([(l-MountingPipeDia),0,0])		
			rotate([0,-90,0])		
				metric_thread (diameter=(0.45*dia)+1, pitch=(l-MountingPipeDia)/(2*4), length=(l-MountingPipeDia)/2+10);
	}
}

module Screw(dia=45, l=55)
{
	translate([l/2+l/3+1,0,0])
		rotate([0,-90,0])	
			cylinder(d=dia, h=l/3);
	translate([(l-MountingPipeDia)+(l-MountingPipeDia)/(2*4),0,0])		
			rotate([0,-90,0])		
				metric_thread (diameter=0.45*dia, pitch=(l-MountingPipeDia)/(2*4), length=(l-MountingPipeDia)/2+10);
}

module Clip(dia=45, l=55)
{
	difference()
	{
		union()
		{
			translate([-(l/2+teethDepth),0,0])
				rotate([0,-90,0])	
					cylinder(d=dia, h=l/3);
			//rotate([360/30,0,0])
			translate([-l/2-teethDepth,0,0])
				rotate([0,90,0])
					Ratchet(dia, numTeeth, teethDepth);
		}
		
		translate([-(l/2+1+5),0,0])
			rotate([0,-90,0])	
				cylinder(d=18, h=l/3);
		
		translate([-13,0,0])
			rotate([0,-90,0])
				bolt(9, 50);		
	}
	
	difference()
	{		
		translate([-(l/2+32.5),-ClipOut/2,-ClipH/2])
		{
			difference()
			{
				union()
				{
					cylinder(h=ClipH, d=ClipOut);
					difference()
					{
						translate([ClipOut/2,ClipOut/2,ClipH/2])
							rotate([0,-90,0])	
								cylinder(d=dia, h=l/3);
						
						translate([0,ClipOut,ClipH/2-(dia/2)])
							cylinder(d=31, h=dia+2);
					}
				}
				translate([0,0,-1])
					cylinder(h=ClipH+2, d2=ClipUp, d1=ClipDn);
				translate([-8,-15,-1])
					cube([16,10,ClipH+2]);
			}
		}		
	
		translate([25-60,0,0])
			rotate([0,-90,0])	
				cylinder(d=20, h=50);
	}
	
}

module Cover(dia=45, l=55)
{
	difference()
	{
		translate([-(l/2+1+5+5),0,0])
				rotate([0,-90,0])	
					cylinder(d=18, h=9);
		translate([-(l/2+1+5+4),0,0])
				rotate([0,-90,0])	
					cylinder(d=16, h=10);
	}
	
	translate([-(l/2+1+5+5+9),0,0])
				rotate([0,-90,0])	
					cylinder(d=20, h=1);
}

module Hardware(l=55)
{
	translate([l*(-13/55),0,0])
			rotate([0,-90,0])
				bolt(8, l*(30/55));
	
	translate([l*(-33.5/55),0,0])
			rotate([0,-90,0])
				washer(8);
	
	translate([l*(-36/55),0,0])
			rotate([0,-90,0])
				washer(8);
	
	translate([l*(-36/55),0,0])
			rotate([0,-90,0])
				flat_nut(8);
}

module Ratchet(dia=45, nTeeth=10, depth=2)
{
	for (i=[0:1:nTeeth-1])
	{
		polyhedron(
			points=[ 	[0,0,0],
							[dia/2*cos(i*360/nTeeth),dia/2*sin(i*360/nTeeth),0],
							[dia/2*cos((i+1)*360/nTeeth),dia/2*sin((i+1)*360/nTeeth),0],
							
							[dia/2*cos((i+0.5)*360/nTeeth),dia/2*sin((i+0.5)*360/nTeeth),depth]  ],   
			faces=[ [1,0,3],[2,1,3],[0,2,3],              // each triangle side
				[0,1,2] ]                         //  base
		);
	}

}



module MountingPipe()
{
	cylinder(h=1000, d=MountingPipeDia);
}