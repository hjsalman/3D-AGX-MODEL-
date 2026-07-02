// =====================================================================
//  HANDHELD/ROVER RIG  v3.4
//  - Mounting plates span WALL-TO-WALL, fused into both side walls
//  - AGX pushed back -> cord space behind the ZED (+ cord notch in ZED plate)
//  - Antenna centered X=0 (board offset right by ant_off)
//  Frame: +X right, +Y back, +Z up. FRONT=Y=0. X=0 = center.
// =====================================================================
part="handles";    // HANDLES only
$fn=44; eps=0.8; inch=25.4;
wall=5; floor_th=4; edge=8; win_r=6; clr=1.5; pt=2.5;
m3=3.4; cb_d=7; cb_h=2.5; boss_od=8; insert_h=6; ins_d=4.2;
plate_t=3; wash_d=8; wash_h=2.0;
nut_hex=6.6; nut_th=2.6; wcb_d=9; wcb_h=3;
m4=4.5; wash_d4=10;   // M4 clearance + washer/nut seat

// ANTENNA CENTERING (measure & set): antenna sits ~ant_off left of board center
ant_off = 19;

// ---- COMPONENTS ----
zed_w=175.25; zed_h=30.25; zed_d=43.1; zed_base=120;
rad_w=100; rad_h=100; rad_d=40; ant_win=32;
agx_w=105; agx_d=105; agx_h=65; agx_so=6; agx_mt=97;   // dev kit 105x105, main mount holes 97x97 M3
jack_gap=42; pmarg=inch; rad_stick=8;   // raised so mmWave plate clears ZED plate
zed_hole_dx=60;
zed_conn_w=40; zed_conn_h=22;   // ZED USB-C + 2 lock screws (18.5 apart), from drawing
rad_hole_dx=167; rad_hole_dy=124;    // from old mmBox_cover: 4 holes at 167 x 124, dia4.1 = M4
cord_gap=58;                                    // clear space behind ZED for its cable

// ---- width ----
half = max(zed_w/2, ant_off + rad_hole_dx/2) + edge; IW = 2*half; OW = IW + 2*wall;  // fit mmWave bolt pattern
// ---- heights ----
agx_top=floor_th+agx_so+agx_h;
zed_z0=agx_top+8; zed_cz=zed_z0+zed_h/2;
rad_z0=zed_z0+zed_h+jack_gap; rad_cz=rad_z0+rad_h/2;
OH=rad_cz+(rad_hole_dy+22)/2+8;   // clear the mmWave plate top
// ---- depth (AGX pushed back for cord room) ----
zed_y0=wall; zed_back=zed_y0+zed_d; rad_back=-rad_stick+rad_d;
agx_cy=zed_back+cord_gap+agx_d/2; OD=agx_cy+agx_d/2+14+wall;
rad_cx=ant_off;

hm_dz=46; handle_reach=46; hsec=18; grip_rise=52; grip_back=145;
handle_y=agx_cy-40; handle_z=OH*0.52;

// =====================================================================
module rbox(w,d,h,r=4){ hull() for(x=[r,w-r],y=[r,d-r]) translate([x,y,0]) cylinder(r=r,h=h); }
module holes4(dx,dy){ for(x=[-dx/2,dx/2],y=[-dy/2,dy/2]) translate([x,y,0]) children(); }
module ycut(w,h,depth,r){ hull() for(a=[-1,1],b=[-1,1]) translate([a*(w/2-r),0,b*(h/2-r)]) rotate([-90,0,0]) cylinder(r=r,h=depth); }

module shell(){ translate([-OW/2,0,0]) rbox(OW,OD,OH,8); }
module cavity(){ translate([-IW/2,wall,floor_th]) rbox(IW,OD-2*wall,OH+eps,4); }
module rad_window(){ translate([rad_cx,-eps,rad_cz]) ycut(rad_w+clr, rad_h+clr, wall+rad_stick+2*eps, 10); } // whole board shows; board offset right, antenna still at X=0
module zed_window(){ translate([0,-eps,zed_cz]) ycut(zed_base+44, zed_h-2, wall+2*eps, 6); }

// ---- FULL-WIDTH mounting plates fused into both side walls ----
module rad_plate(){
    fh=rad_hole_dy+22; py=rad_back;
    difference(){
        translate([-IW/2-2, py, rad_cz-fh/2]) cube([IW+4, plate_t, fh]);
        translate([rad_cx, py-eps, rad_cz]) rotate([-90,0,0]) holes4(rad_hole_dx,rad_hole_dy) cylinder(d=m4,h=plate_t+2*eps);      // 4x M4 @ 167x124, on the board
        translate([rad_cx, py+plate_t-wash_h, rad_cz]) rotate([-90,0,0]) holes4(rad_hole_dx,rad_hole_dy) cylinder(d=wash_d4,h=wash_h+eps);
    }
}
zed_mt_dx=153.4; zed_mt_dz=14;   // ZED 2i back mount: 4x M3 (dia3.13) at 153.4 x 14  [EXACT, Stereolabs drawing]
module zed_plate(){
    fh=zed_h+18; py=zed_back;
    difference(){
        translate([-IW/2-2, py, zed_cz-fh/2]) cube([IW+4, plate_t, fh]);
        // wide opening for the USB-C connector + thumbscrews (centered on the back)
        translate([-zed_conn_w/2, py-eps, zed_cz-zed_conn_h/2]) cube([zed_conn_w, plate_t+2*eps, zed_conn_h]);
        // 4 mount holes near the ends (through + washer seat)  [pattern = PLACEHOLDER]
        translate([0, py-eps, zed_cz]) rotate([-90,0,0]) holes4(zed_mt_dx, zed_mt_dz) cylinder(d=m3,h=plate_t+2*eps);
        translate([0, py+plate_t-wash_h, zed_cz]) rotate([-90,0,0]) holes4(zed_mt_dx, zed_mt_dz) cylinder(d=wash_d,h=wash_h+eps);
    }
}
module agx_screws(){ translate([0,agx_cy,-eps]) holes4(agx_mt,agx_mt) cylinder(d=m3,h=floor_th+agx_so+2*eps);
                     translate([0,agx_cy,-eps]) holes4(agx_mt,agx_mt) cylinder(d=wcb_d,h=wcb_h); }
module agx_mount(){ translate([0,agx_cy,floor_th]) holes4(agx_mt,agx_mt) difference(){
        cylinder(d=boss_od,h=agx_so);
        translate([0,0,-1]) cylinder(d=m3,h=agx_so+2);   // hole THROUGH standoff for the screw
    } }
module rear_cables(){ translate([0,OD-wall-eps,floor_th+18]) ycut(96,26,wall+2*eps,8); }
module handle_mounts(){ for(s=[-1,1]) for(dz=[-hm_dz/2,hm_dz/2]) translate([s*(OW/2+eps),handle_y,handle_z+dz]) rotate([0,-90*s,0]) cylinder(d=m3,h=wall+2*eps); }
module handle_nuts(){ for(s=[-1,1]) for(dz=[-hm_dz/2,hm_dz/2])
    translate([s*(IW/2),handle_y,handle_z+dz]) rotate([0,90*s,0]) difference(){
        cylinder(d=12,h=7); translate([0,0,-eps]) cylinder(d=m3,h=8);
        translate([0,0,7-nut_th]) cylinder(d=nut_hex,h=nut_th+1,$fn=6); } }

module box_body(){
    union(){
        difference(){
            shell(); cavity();
            rad_window(); zed_window(); rear_cables(); agx_screws(); handle_mounts();
        }
        agx_mount(); handle_nuts(); rad_plate(); zed_plate();
    }
}

module handle(){
    ft=6; fw=26; fh=hm_dz+34;
    difference(){
        translate([0,-fw/2,-fh/2]) cube([ft,fw,fh]);
        for(dz=[-hm_dz/2,hm_dz/2]){
            translate([-eps,0,dz]) rotate([0,90,0]) cylinder(d=m3,h=ft+2*eps);
            translate([ft-wcb_h,0,dz]) rotate([0,90,0]) cylinder(d=wcb_d,h=wcb_h+eps);
        }
    }
    translate([ft-1,-hsec/2,-hsec/2]) cube([handle_reach-ft+1, hsec, hsec]);
    translate([handle_reach-hsec,-hsec/2,-hsec/2]) cube([hsec, grip_back+hsec/2, hsec]);
    translate([handle_reach-hsec, grip_back-hsec/2,-hsec/2]) cube([hsec, hsec, grip_rise+hsec/2]);
}
module handles(){ translate([55,0,0]) handle(); translate([-55,0,0]) mirror([1,0,0]) handle(); }

module gc(){
    color([0.6,0.1,0.1]) translate([rad_cx-rad_w/2,-rad_stick,rad_cz-rad_h/2]) cube([rad_w,rad_d,rad_h]);
    color([0.1,0.1,0.12]) translate([-zed_w/2,zed_y0,zed_cz-zed_h/2]) cube([zed_w,zed_d,zed_h]);
    color([0.2,0.2,0.24]) translate([-agx_w/2,agx_cy-agx_d/2,floor_th+agx_so]) cube([agx_w,agx_d,agx_h]);
    color([0.9,0.85,0.4]) translate([-ant_win/2,-rad_stick-1.5,rad_cz-ant_win/2]) cube([ant_win,2,ant_win]);
}
module assembly(){
    box_body();
    translate([ OW/2,handle_y,handle_z]) handle();
    translate([-OW/2,handle_y,handle_z]) mirror([1,0,0]) handle();
    %gc();
}
if      (part=="assembly") assembly();
else if (part=="box_body") box_body();
else if (part=="handles")  handles();
else if (part=="handle")   handle();
