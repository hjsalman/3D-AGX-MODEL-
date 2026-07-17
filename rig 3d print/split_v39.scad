// box_body.scad v5.7
//  HANDHELD/ROVER RIG  v3.9  (EXACT base - do not change measurements)
$fn=44; eps=0.8; inch=25.4;
wall=5; floor_th=4; edge=8; win_r=6; clr=1.5; pt=2.5;
m3=3.4; cb_d=7; cb_h=2.5; boss_od=8; insert_h=6; ins_d=4.2;
plate_t=3; wash_d=8; wash_h=2.0;
nut_hex=6.6; nut_th=2.6; wcb_d=9; wcb_h=3;
ant_dx = 34;  ant_dz = 8;  ant_x = 0;
zed_w=175.25; zed_h=30.25; zed_d=43.1; zed_base=120;
rad_w=90; rad_h=102; rad_d=34; ant_win=32;
agx_w=105; agx_d=105; agx_h=65; agx_so=6; agx_mt=97;
jack_gap=42; rad_stick=3; rad_standoff=15;
zed_conn_w=40; zed_conn_h=22;
rad_hole_dx=76.30; rad_hole_dy=56.89;
cord_gap=63.5;
imu_cx=-60; imu_screw=2.4;
imu_hole_dx=22.86; imu_hole_dy=27.94;
half = max(zed_w/2, ant_dx + ant_x + rad_w/2) + edge; IW = 2*half; OW = IW + 2*wall;
agx_top=floor_th+agx_so+agx_h;
zed_z0=floor_th+10; zed_cz=zed_z0+zed_h/2;
rad_z0=zed_z0+zed_h+jack_gap; rad_cz=rad_z0+rad_h/2;
OH=rad_cz+(rad_hole_dy+22)/2+8;
zed_y0=wall; zed_back=zed_y0+zed_d; rad_back=-rad_stick+rad_d;
agx_rear=63.5;
agx_cy=zed_back+cord_gap+agx_d/2; OD=agx_cy+agx_d/2+agx_rear+wall;
rad_cx=ant_dx+ant_x;
hm_dz=46; handle_reach=95; hsec=18; grip_rise=52; grip_back=190;
handle_y=agx_cy-10; handle_z=OH*0.52;
module rbox(w,d,h,r=4){ hull() for(x=[r,w-r],y=[r,d-r]) translate([x,y,0]) cylinder(r=r,h=h); }
module holes4(dx,dy){ for(x=[-dx/2,dx/2],y=[-dy/2,dy/2]) translate([x,y,0]) children(); }
module ycut(w,h,depth,r){ hull() for(a=[-1,1],b=[-1,1]) translate([a*(w/2-r),0,b*(h/2-r)]) rotate([-90,0,0]) cylinder(r=r,h=depth); }
module shell(){ translate([-OW/2,0,0]) rbox(OW,OD,OH,8); }
module cavity(){ translate([-IW/2,wall,floor_th]) rbox(IW,OD-2*wall,OH+eps,4); }
module rad_window(){ translate([rad_cx,-eps,rad_cz]) ycut(rad_w+clr, rad_h+clr, wall+2*eps, 10); }
module rad_standoffs(){ translate([rad_cx, rad_back, rad_cz]) rotate([-90,0,0]) holes4(rad_hole_dx, rad_hole_dy)
        difference(){ cylinder(d=8,h=rad_standoff); translate([0,0,-eps]) cylinder(d=2.6,h=rad_standoff+2*eps); } }
module rad_plate(){ fh=rad_hole_dy+22; py=rad_back+rad_standoff;
    difference(){
        translate([-IW/2-2, py, rad_cz-fh/2]) cube([IW+4, plate_t, fh]);
        translate([rad_cx, py-eps, rad_cz]) rotate([-90,0,0]) holes4(rad_hole_dx,rad_hole_dy) cylinder(d=m3,h=plate_t+2*eps);
        translate([rad_cx, py+plate_t-wash_h, rad_cz]) rotate([-90,0,0]) holes4(rad_hole_dx,rad_hole_dy) cylinder(d=wash_d,h=wash_h+eps);
    } }
module imu_mount(){ translate([imu_cx,-eps,rad_cz]) rotate([-90,0,0]) holes4(imu_hole_dx,imu_hole_dy) cylinder(d=1.7,h=wall+2*eps);
    translate([imu_cx,-eps,rad_cz]) rotate([-90,0,0]) holes4(imu_hole_dx,imu_hole_dy) cylinder(d=wcb_d,h=wcb_h+eps); }
module zed_window(){ translate([0,-eps,zed_cz]) ycut(zed_base+44, zed_h-2, wall+2*eps, 6); }
zed_mt_dx=153.4; zed_mt_dz=14;
module zed_plate(){ fh=zed_h+18; py=zed_back;
    difference(){
        translate([-IW/2-2, py, zed_cz-fh/2]) cube([IW+4, plate_t, fh]);
        translate([-zed_conn_w/2, py-eps, zed_cz-zed_conn_h/2]) cube([zed_conn_w, plate_t+2*eps, zed_conn_h]);
        translate([0, py-eps, zed_cz]) rotate([-90,0,0]) holes4(zed_mt_dx, zed_mt_dz) cylinder(d=m3,h=plate_t+2*eps);
        translate([0, py+plate_t-wash_h, zed_cz]) rotate([-90,0,0]) holes4(zed_mt_dx, zed_mt_dz) cylinder(d=wash_d,h=wash_h+eps);
    } }
module agx_screws(){ translate([0,agx_cy,-eps]) holes4(agx_mt,agx_mt) cylinder(d=m3,h=floor_th+agx_so+2*eps);
                     translate([0,agx_cy,-eps]) holes4(agx_mt,agx_mt) cylinder(d=wcb_d,h=wcb_h); }
module agx_mount(){ translate([0,agx_cy,floor_th]) holes4(agx_mt,agx_mt) difference(){
        cylinder(d=boss_od,h=agx_so); translate([0,0,-1]) cylinder(d=2.6,h=agx_so+3); } }
module rear_cables(){ translate([0,OD-wall-eps,floor_th+20]) ycut(104,30,wall+2*eps,8); }
module handle_mounts(){ for(s=[-1,1]) for(dz=[-hm_dz/2,hm_dz/2]) translate([s*(OW/2+eps),handle_y,handle_z+dz]) rotate([0,-90*s,0]) cylinder(d=m3,h=wall+2*eps); }
module handle_nuts(){ for(s=[-1,1]) for(dz=[-hm_dz/2,hm_dz/2])
    translate([s*(IW/2),handle_y,handle_z+dz]) rotate([0,90*s,0]) difference(){
        cylinder(d=12,h=7); translate([0,0,-eps]) cylinder(d=m3,h=8);
        translate([0,0,7-nut_th]) cylinder(d=nut_hex,h=nut_th+1,$fn=6); } }
module box_body(){ union(){
        difference(){ shell(); cavity(); rad_window(); imu_mount(); zed_window(); rear_cables(); agx_screws(); handle_mounts(); }
        agx_mount(); handle_nuts(); rad_plate(); rad_standoffs(); zed_plate();
    } }
module handle(){ ft=6; fw=26; fh=hm_dz+34;
    difference(){ translate([0,-fw/2,-fh/2]) cube([ft,fw,fh]);
        for(dz=[-hm_dz/2,hm_dz/2]){ translate([-eps,0,dz]) rotate([0,90,0]) cylinder(d=m3,h=ft+2*eps);
            translate([ft-wcb_h,0,dz]) rotate([0,90,0]) cylinder(d=wcb_d,h=wcb_h+eps); } }
    translate([ft-1,-hsec/2,-hsec/2]) cube([handle_reach-ft+1, hsec, hsec]);
    translate([handle_reach-hsec,-hsec/2,-hsec/2]) cube([hsec, grip_back+hsec/2, hsec]);
    translate([handle_reach-hsec, grip_back-hsec/2,-hsec/2]) cube([hsec, hsec, grip_rise+hsec/2]); }
module handles(){ translate([55,0,0]) handle(); translate([-55,0,0]) mirror([1,0,0]) handle(); }

// ===================== SPLIT / BOLT-TOGETHER (v3.9 exact, sliced) =====================
jclr=3.4; jins=4.2; jins_h=6;                 // M3 screw + M3 heat-set insert
yfs=28; ybs=OD-28;                            // front/back seam (past r=8 corner)
zc=[floor_th+40, OH-40];                       // 2 corner screws per seam
tab_in=8; tab_ov=12;
xCL=-(OW/2-wall/2); xCR=(OW/2-wall/2);
rad_py=rad_back+rad_standoff;                  // 46
rad_pz=[rad_cz-30, rad_cz+30];
zed_pz=[zed_cz-11, zed_cz+11];
fp_front=[[-60,2.5],[60,2.5]]; fp_back=[[-60,OD-2.5],[60,OD-2.5]];
fp_left=[[xCL,70],[xCL,OD-70]]; fp_right=[[xCR,70],[xCR,OD-70]];

module wallsolid(){ union(){
    difference(){ shell(); cavity(); rad_window(); imu_mount(); zed_window(); rear_cables(); agx_screws(); handle_mounts(); }
    handle_nuts();
} }
module R_floor(){ translate([-OW,-20,-2]) cube([2*OW,OD+40,floor_th+2]); }
module R_front(){ translate([-OW,-20,floor_th]) cube([2*OW,yfs+20,OH+2]); }
module R_back(){  translate([-OW,ybs,floor_th]) cube([2*OW,OD-ybs+20,OH+2]); }
module R_left(){  translate([-OW-2,yfs,floor_th]) cube([OW+2,ybs-yfs,OH+2]); }
module R_right(){ translate([0,yfs,floor_th]) cube([OW+2,ybs-yfs,OH+2]); }
module Rside(s){ if(s<0) R_left(); else R_right(); }
module Xin(s,y,z,dia,len){ translate([s*OW/2,y,z]) rotate([0,-s*90,0]) cylinder(d=dia,h=len); }
module Zup(x,y,dia,len){ translate([x,y,floor_th-eps]) cylinder(d=dia,h=len); }
module Zdn(x,y,dia,len){ translate([x,y,-eps]) cylinder(d=dia,h=len); }

module corner_tab(s, yseam, ydir){
    xi=s*(OW/2-wall); xc=(s<0)? xi : xi-tab_in;
    y0=(ydir>0)? yseam-tab_ov : yseam;
    ym=(ydir>0)? yseam-tab_ov/2 : yseam+tab_ov/2;
    difference(){
        translate([xc, y0, floor_th]) cube([tab_in, tab_ov, OH-floor_th]);
        for(z=zc) translate([xi,ym,z]) rotate([0,-s*90,0]) cylinder(d=jins,h=tab_in+eps);
    }
}
module joins_floorclear(){ for(p=concat(fp_front,fp_back,fp_left,fp_right)){ Zdn(p[0],p[1],jclr,floor_th+2*eps); Zdn(p[0],p[1],wcb_d,wcb_h); } }

module p_floor(){ difference(){ union(){ intersection(){ wallsolid(); R_floor(); } agx_mount(); } joins_floorclear(); } }
module p_front(){ difference(){ intersection(){ wallsolid(); R_front(); }
    for(s=[-1,1],z=zc) Xin(s, yfs-tab_ov/2, z, jclr, wall+2*eps);
    for(p=fp_front) Zup(p[0],p[1],jins,jins_h+eps);
} }
module p_back(){ difference(){ intersection(){ wallsolid(); R_back(); }
    for(s=[-1,1],z=zc) Xin(s, ybs+tab_ov/2, z, jclr, wall+2*eps);
    for(p=fp_back) Zup(p[0],p[1],jins,jins_h+eps);
} }
module side(s){ difference(){
        union(){ intersection(){ wallsolid(); Rside(s); } corner_tab(s,yfs,+1); corner_tab(s,ybs,-1); }
        for(p=(s<0?fp_left:fp_right)) Zup(p[0],p[1],jins,jins_h+eps);
        for(z=rad_pz) Xin(s, rad_py+plate_t/2, z, jclr, wall+2*eps);
        for(z=zed_pz) Xin(s, zed_back+plate_t/2, z, jclr, wall+2*eps);
    } }
module p_left(){ side(-1); }
module p_right(){ side(1); }

// separate plates: IDENTICAL positions/holes, just IW-wide (fit between walls) + end inserts
module p_rad(){ fh=rad_hole_dy+22; py=rad_py; union(){
    difference(){
        translate([-IW/2, py, rad_cz-fh/2]) cube([IW, plate_t, fh]);
        translate([rad_cx, py-eps, rad_cz]) rotate([-90,0,0]) holes4(rad_hole_dx,rad_hole_dy) cylinder(d=2.8,h=plate_t+2*eps);   // smaller (M3 self-tap)
        for(s=[-1,1],z=rad_pz) translate([s*(IW/2)+(s<0?-eps:eps-jins_h), py+plate_t/2, z]) rotate([0,90,0]) cylinder(d=jins,h=jins_h+eps);
    }
    rad_standoffs();
} }
module p_zed(){ fh=zed_h+18; py=zed_back; difference(){
    translate([-IW/2, py, zed_cz-fh/2]) cube([IW, plate_t, fh]);
    translate([-zed_conn_w/2, py-eps, zed_cz-zed_conn_h/2]) cube([zed_conn_w, plate_t+2*eps, zed_conn_h]);
    translate([0, py-eps, zed_cz]) rotate([-90,0,0]) holes4(zed_mt_dx, zed_mt_dz) cylinder(d=3.2,h=plate_t+2*eps);   // smaller (snug M3)
    for(s=[-1,1],z=zed_pz) translate([s*(IW/2)+(s<0?-eps:eps-jins_h), py+plate_t/2, z]) rotate([0,90,0]) cylinder(d=jins,h=jins_h+eps);
} }

module split_assembly(){ p_floor(); p_front(); p_back(); p_left(); p_right(); p_rad(); p_zed();
    translate([ OW/2,handle_y,handle_z]) handle(); translate([-OW/2,handle_y,handle_z]) mirror([1,0,0]) handle(); }

part="assembly";
if      (part=="assembly")  split_assembly();
else if (part=="floor")     p_floor();
else if (part=="front")     p_front();
else if (part=="back")      p_back();
else if (part=="left")      p_left();
else if (part=="right")     p_right();
else if (part=="rad_plate") p_rad();
else if (part=="zed_plate") p_zed();
else if (part=="handles")   handles();
else if (part=="handle")    handle();
