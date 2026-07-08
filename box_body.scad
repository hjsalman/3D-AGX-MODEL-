// box_body.scad - self-contained, renders ONLY the box body (v4.4)
// =====================================================================
//  HANDHELD/ROVER RIG  v3.9
//  mmWave mount MATCHED TO THE ZED: the board bolts to a full-width plate
//  fused into both side walls (same scheme as the ZED plate), not through
//  the front wall. Antenna shows through the front window. Screws = M3
//  through the board into the plate, washer seat on the back (like ZED).
//
//  METROLOGY (all from official files, unchanged):
//   DCA1000EVM holes 4x dia4.32 @ 76.30x56.89   (TI SPRR350 STEP)
//   IWR1443BOOST holes 4x dia4.06 (0.160") @ 75.55x56.90  (TI SPRR253 NPTH.drl)
//   DCA board 90x102x1.6 (SPRUIJ4A); stack depth ~28-30, plate at DCA back.
//   ZED 2i 175.25x30.25x43.1, back mount 4x M3 @153.4x14 (Stereolabs drawing).
//   Jetson AGX dev kit 105x105x65, mount 4x M3 @97x97 (NVIDIA).
//  All enclosure holes are M3 CLEARANCE (3.4) for screw + washer + nut or a
//  heat-set insert; 3D-printed threads are intentionally not modeled.
//  Frame: +X right, +Y back, +Z up. FRONT=Y=0. X=0 = center between ZED eyes.
// =====================================================================
$fn=44; eps=0.8; inch=25.4;
wall=5; floor_th=4; edge=8; win_r=6; clr=1.5; pt=2.5;
m3=3.4; cb_d=7; cb_h=2.5; boss_od=8; insert_h=6; ins_d=4.2;
plate_t=3; wash_d=8; wash_h=2.0;
nut_hex=6.6; nut_th=2.6; wcb_d=9; wcb_h=3;

ant_off = 19;   // antenna offset from board center; board flipped so antenna lands on X=0

// ---- COMPONENTS ----
zed_w=175.25; zed_h=30.25; zed_d=43.1; zed_base=120;
rad_w=90; rad_h=102; rad_d=34; ant_win=32;            // DCA1000 90x102; stack depth 34
agx_w=105; agx_d=105; agx_h=65; agx_so=6; agx_mt=97;
jack_gap=42; rad_stick=8;                              // board protrudes 8 out front (antenna near window)
zed_conn_w=40; zed_conn_h=22;
rad_hole_dx=76.30;   // horizontal (X)  DCA1000 hole pitch (TI SPRR350 STEP)
rad_hole_dy=56.89;   // vertical   (Z)  DCA1000 hole pitch (TI SPRR350 STEP)
cord_gap=63.5;   // 2.5 in front clearance (AGX front to ZED)

// ---- width ----
half = max(zed_w/2, ant_off + rad_hole_dx/2) + edge; IW = 2*half; OW = IW + 2*wall;
// ---- heights ----
agx_top=floor_th+agx_so+agx_h;
zed_z0=floor_th+10; zed_cz=zed_z0+zed_h/2;   // ZED near the base (was tied to AGX top; AGX is behind, not below)
rad_z0=zed_z0+zed_h+jack_gap; rad_cz=rad_z0+rad_h/2;
OH=rad_cz+(rad_hole_dy+22)/2+8;          // clear the mmWave plate top
// ---- depth ----
zed_y0=wall; zed_back=zed_y0+zed_d; rad_back=-rad_stick+rad_d;   // plate at the DCA back
agx_rear=63.5;   // 2.5 in back clearance (both sides 2.5 in; no HDMI bend needed)
agx_cy=zed_back+cord_gap+agx_d/2; OD=agx_cy+agx_d/2+agx_rear+wall;
rad_cx=-ant_off;   // flipped: board bulk to opposite side; antenna stays on X0 (ZED center)

hm_dz=46; handle_reach=72; hsec=18; grip_rise=52; grip_back=240;   // grab bar 240mm long; reach 72 = 54mm hand clearance
handle_y=(OD-grip_back)/2; handle_z=OH*0.52;   // grab bar centered along box length

// =====================================================================
module rbox(w,d,h,r=4){ hull() for(x=[r,w-r],y=[r,d-r]) translate([x,y,0]) cylinder(r=r,h=h); }
module holes4(dx,dy){ for(x=[-dx/2,dx/2],y=[-dy/2,dy/2]) translate([x,y,0]) children(); }
module ycut(w,h,depth,r){ hull() for(a=[-1,1],b=[-1,1]) translate([a*(w/2-r),0,b*(h/2-r)]) rotate([-90,0,0]) cylinder(r=r,h=depth); }

module shell(){ translate([-OW/2,0,0]) rbox(OW,OD,OH,8); }
module cavity(){ translate([-IW/2,wall,floor_th]) rbox(IW,OD-2*wall,OH+eps,4); }

// ---- mmWave: front antenna window + REAR PLATE (same scheme as the ZED plate) ----
module rad_window(){ translate([rad_cx,-eps,rad_cz]) ycut(rad_w+clr, rad_h+clr, wall+rad_stick+2*eps, 10); } // whole 90x102 board shows; antenna at X=0
module rad_plate(){
    fh=rad_hole_dy+22; py=rad_back;
    difference(){
        translate([-IW/2-2, py, rad_cz-fh/2]) cube([IW+4, plate_t, fh]);                                                     // full-width plate, fused into both side walls
        translate([rad_cx, py-eps, rad_cz]) rotate([-90,0,0]) holes4(rad_hole_dx,rad_hole_dy) cylinder(d=m3,h=plate_t+2*eps); // 4x M3 @ 76.30x56.89 (DCA holes)
        translate([rad_cx, py+plate_t-wash_h, rad_cz]) rotate([-90,0,0]) holes4(rad_hole_dx,rad_hole_dy) cylinder(d=wash_d,h=wash_h+eps); // washer seat on the back
    }
}

module zed_window(){ translate([0,-eps,zed_cz]) ycut(zed_base+44, zed_h-2, wall+2*eps, 6); }
zed_mt_dx=153.4; zed_mt_dz=14;   // ZED 2i back mount: 4x M3 (dia3.13) at 153.4 x 14 [Stereolabs drawing]
module zed_plate(){
    fh=zed_h+18; py=zed_back;
    difference(){
        translate([-IW/2-2, py, zed_cz-fh/2]) cube([IW+4, plate_t, fh]);
        translate([-zed_conn_w/2, py-eps, zed_cz-zed_conn_h/2]) cube([zed_conn_w, plate_t+2*eps, zed_conn_h]);
        translate([0, py-eps, zed_cz]) rotate([-90,0,0]) holes4(zed_mt_dx, zed_mt_dz) cylinder(d=m3,h=plate_t+2*eps);
        translate([0, py+plate_t-wash_h, zed_cz]) rotate([-90,0,0]) holes4(zed_mt_dx, zed_mt_dz) cylinder(d=wash_d,h=wash_h+eps);
    }
}
module agx_screws(){ translate([0,agx_cy,-eps]) holes4(agx_mt,agx_mt) cylinder(d=m3,h=floor_th+agx_so+2*eps);
                     translate([0,agx_cy,-eps]) holes4(agx_mt,agx_mt) cylinder(d=wcb_d,h=wcb_h); }
module agx_mount(){ translate([0,agx_cy,floor_th]) holes4(agx_mt,agx_mt) difference(){
        cylinder(d=boss_od,h=agx_so); translate([0,0,-1]) cylinder(d=m3,h=agx_so+2); } }
module rear_cables(){ translate([0,OD-wall-eps,floor_th+20]) ycut(104,30,wall+2*eps,8); }   // ~AGX board width
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

box_body();
