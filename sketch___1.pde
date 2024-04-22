//Kinectのポーズの認識

import SimpleOpenNI.*;
SimpleOpenNI kinect;

//Soundライブラリーの読み込み
import processing.sound.*;
//サウンドプレイヤー
SoundFile soundfile1;
SoundFile soundfile2;
SoundFile soundfile3;
SoundFile soundfile4;
SoundFile soundfile5;
Delay delay;
BandPass bandPass1;
BandPass bandPass5;
WhiteNoise noise;

//音量解析
Amplitude rms1;
Amplitude rms2;
Amplitude rms3;
Amplitude rms4;
Amplitude rms5;

float hand1;
float hand2;
float footl;
float footr;
float kneel;
float kneer;

float baxr;
float bcxr;

float bayr;
float bcyr;

float cosr;

float baxl;
float bcxl;

float bayl;
float bcyl;

float cosl;

int ms1;
int ms2;



void setup() {
   
  
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.enableUser();// this changed
  kinect.alternativeViewPointDepthToImage();
  size(960,720);
  fill(255, 0, 0);
  
  //サウンドファイルを読み込んでプレイヤーを初期化
  //ファイル名は読み込んだサウンドファイル名に変更
  soundfile1 = new SoundFile(this, "219_dr_bpm120_4-4_4_pop.wav");
  soundfile2 = new SoundFile(this, "hitting.wav");
  soundfile3 = new SoundFile(this, "pop.wav");
  soundfile4 = new SoundFile(this, "poca.mp3");
  soundfile5 = new SoundFile(this, "10(120BPM).wav");
  delay = new Delay(this);
  noise = new WhiteNoise(this);
  bandPass1 = new BandPass(this);
  bandPass5 = new BandPass(this);
  //ループ再生
  soundfile1.loop();
  soundfile5.loop();
  
   noise.play(0);
   bandPass1.process(soundfile1);
   bandPass5.process(soundfile5);
  // Patch the delay
   //delay.process(soundfile1, 5);
   //delay.process(soundfile5, 5);
   //音量解析を初期化
  rms1 = new Amplitude(this);
  //音量解析の入力を設定
  rms1.input(soundfile1);
  //音量解析を初期化
  rms2 = new Amplitude(this);
  //音量解析の入力を設定
  rms2.input(soundfile2);
  //音量解析を初期化
  rms3 = new Amplitude(this);
  //音量解析の入力を設定
  rms3.input(soundfile3);
  //音量解析を初期化
  rms4 = new Amplitude(this);
  //音量解析の入力を設定
  rms4.input(soundfile4);
   //音量解析を初期化
  rms5 = new Amplitude(this);
  //音量解析の入力を設定
  rms5.input(soundfile5);
}

void draw() {
  scale(1.5,1.5);
  kinect.update();
  image(kinect.rgbImage(),0, 0);

  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  if (userList.size() > 0) {
    int userId = userList.get(0);

    if ( kinect.isTrackingSkeleton(userId)) {
      drawSkeleton(userId);
    }
  }
}

void drawSkeleton(int userId) {
  stroke(0);
  strokeWeight(5);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HIP);

  noStroke();

  fill(255, 0, 0);
  drawJoint(userId, SimpleOpenNI.SKEL_HEAD);
  drawJoint(userId, SimpleOpenNI.SKEL_NECK);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
  drawJoint(userId, SimpleOpenNI.SKEL_NECK);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  drawJoint(userId, SimpleOpenNI.SKEL_TORSO);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND); 
 
  
}



void drawJoint(int userId, int jointID) {
  PVector joint = new PVector();
  //Jointが正しい位置にあるかどうか
  float confidence = kinect.getJointPositionSkeleton(userId, jointID, 
    joint);
  if (confidence < 0.5) {
    return;
  }
  PVector convertedJoint = new PVector();
  kinect.convertRealWorldToProjective(joint, convertedJoint);
 // ellipse(convertedJoint.x, convertedJoint.y, 5, 5);
  
  //頭３次元
  PVector head = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,head);
  
  //頭2次元
  PVector head2d = new PVector();
   kinect.convertRealWorldToProjective(head, head2d);
  
  //右手３次元
  PVector hand3d_r = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,hand3d_r);
  
  //右手２次元
  PVector hand2d_r = new PVector();
  kinect.convertRealWorldToProjective(hand3d_r, hand2d_r);
  
  //右肩３次元
  PVector shoulder3d_r = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,shoulder3d_r);
  
  //左肩３次元
  PVector shoulder3d_l= new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,shoulder3d_l);
  
  //右肘３次元
  PVector elbow3d_r = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_ELBOW,elbow3d_r);
  
  //左肘３次元
  PVector elbow3d_l= new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_ELBOW,elbow3d_l);

  //左手３次元
  PVector hand3d_l = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,hand3d_l);
  
  //左手２次元
  PVector hand2d_l = new PVector();
  kinect.convertRealWorldToProjective(hand3d_l, hand2d_l);
  
  ////円の生成
  //if(hand3d_r.y - shoulder3d_r.y > 0){
  //  ellipse (hand2d_r.x,hand2d_r.y,50,50);
  //}
  
   //左足３次元
  PVector foot3d_l = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_FOOT,foot3d_l);
  
  //左足２次元
  PVector foot2d_l = new PVector();
  kinect.convertRealWorldToProjective(foot3d_l, foot2d_l);
  
  //右足３次元
  PVector foot3d_r = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_FOOT,foot3d_r);
  
  //右足２次元
  PVector foot2d_r = new PVector();
  kinect.convertRealWorldToProjective(foot3d_r, foot2d_r);
  
  //左膝３次元
  PVector knee3d_l = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_KNEE,knee3d_l);
  
  //左膝２次元
  PVector knee2d_l = new PVector();
  kinect.convertRealWorldToProjective(knee3d_l, knee2d_l);
  
  //右膝３次元
  PVector knee3d_r = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_KNEE,knee3d_r);
  
  //右膝２次元
  PVector knee2d_r = new PVector();
  kinect.convertRealWorldToProjective(knee3d_r, knee2d_r);
  
  //左尻３次元
  PVector hip3d_l = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HIP,hip3d_l);
  
  //右尻３次元
  PVector hip3d_r = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HIP,hip3d_r);
  
  //速度
  float rate = map(head.y, 0, height, 1.5, 0.8);
  soundfile1.rate(rate);
  soundfile5.rate(rate);
  
  //hand1 = hand3d_r.x - hand3d_l.x;
  //float feedback = map(hand1, 400, width, 0.3, 0.5);
  //delay.feedback(feedback);
  
  
  //拍手
  //float diameter2 = map(rms2.analyze(), 0.0, 3.0, 0.0,500);
  float b2 = map(rms2.analyze(), 0.0, 1.0, 0.0,255);
  fill(255,255,b2,255);
   if( 100 < hand3d_r.x - hand3d_l.x  || hand3d_r.x - hand3d_l.x < -100){
     hand2 = hand3d_r.x - hand3d_l.x;
   }
  
  if( -30 < hand3d_r.x - hand3d_l.x  && hand3d_r.x - hand3d_l.x < 30 && hand2-hand1 > 30 && -100 < hand3d_r.y - hand3d_l.y &&  hand3d_r.y - hand3d_l.y < 300){
    soundfile2.play();
    hand2 = hand3d_r.x - hand3d_l.x;
    ellipse(hand2d_r.x,hand2d_r.y, 80, 80);
    //ms2 = millis()/1000;
  }
  
  //足踏み
   //音量を解析して値を調整
   //println(rms4.analyze());
  //float diameter4 = map(rms4.analyze(), 0.0,3.0, 0.0,500);
  float b = map(rms4.analyze(), 0.0, 1.0, 0.0,255);
  fill(255,255,b,255);
  
   if(hip3d_r.y-foot3d_r.y < 300){
    footr = foot3d_r.y;
   }
   
   if(hip3d_l.y-foot3d_l.y < 300){
    footl = foot3d_l.y;
   }
  
  if( 200 < footl-foot3d_l.y){
     soundfile4.play();
     footl = foot3d_l.y;
     footr = foot3d_r.y;
      //取得した音量で円を描く
      ellipse(foot2d_l.x,foot2d_l.y, 80, 80);
  }
  
  if(200 < footr-foot3d_r.y){
     soundfile4.play();
     footl = foot3d_l.y;
     footr = foot3d_r.y;
      //取得した音量で円を描く
      ellipse(foot2d_r.x,foot2d_r.y, 80, 80);
  }
  
  //text(footl+"  "+footr,width/2,height/2);
  
  //膝
  //float diameter3 = map(rms3.analyze(), 0.0,3.0, 0.0,500);
  float b3 = map(rms4.analyze(), 0.0, 1.0, 0.0,255);
  fill(255,255,b3,255);
  ms1 = millis()/1000;
  if(ms1-ms2 >2){
  if( hip3d_r.y < knee3d_r.y){
     soundfile3.play();
     ms2 = millis()/1000;
     ellipse(knee2d_r.x,knee2d_r.y, 80, 80);
  }
  else if(hip3d_l.y < knee3d_l.y ){
    soundfile3.play();
     ms2 = millis()/1000;
     ellipse(knee2d_l.x,knee2d_l.y, 80, 80);
  }
  }
 
  //右周波数ドラム
  baxr = elbow3d_r.x - hand3d_r.x;
  bcxr = elbow3d_r.x - shoulder3d_r.x;
  bayr = elbow3d_r.y - hand3d_r.y;
  bcyr = elbow3d_r.y - shoulder3d_r.y;
  
  cosr = ((baxr*bcxr)+(bayr*bcyr))/( sqrt((baxr*baxr)+(bayr*bayr))+sqrt((bcxr*bcxr)+(bcyr*bcyr)));
  //println(cosr);
  
  float freq_r = map(cosr, -100, 100, 3000, 10000);
   bandPass1.bw(freq_r);
   
  //左周波数ギター
  baxl = elbow3d_l.x - hand3d_l.x;
  bcxl = elbow3d_l.x - shoulder3d_l.x;
  bayl = elbow3d_l.y - hand3d_l.y;
  bcyl = elbow3d_l.y - shoulder3d_l.y;
  
  cosl = ((baxl*bcxl)+(bayl*bcyl))/( sqrt((baxl*baxl)+(bayl*bayl))+sqrt((bcxl*bcxl)+(bcyl*bcyl)));
  //println(cosr);
  println(cosl);
  
  float freq_l = map(cosl, -100, 100, 100, 1500);
  bandPass5.freq(freq_l);
   
   //中心３次元
  PVector torso = new PVector();
  kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_TORSO,torso);
  //中心２次元
  PVector torso2d = new PVector();
  kinect.convertRealWorldToProjective(torso, torso2d);
  
  //音量を解析して値を調整
  float diameter1 = map(rms1.analyze(), 0.0, 1.0, 0.0,300);
  float r = map(rms1.analyze(), 0.0, 1.0, 0.0,255);
  fill(r,255,255,50);
  //取得した音量で円を描く
  ellipse(torso2d.x,torso2d.y, diameter1, diameter1);
 
  
  float diameter5 = map(rms5.analyze(), 0.0, 1.0, 0.0,500);
  float g = map(rms5.analyze(), 0.0, 1.0, 0.0,255);
  fill(255,g,255,50);
  //取得した音量で円を描く
  ellipse(head2d.x,head2d.y, diameter5, diameter5);
}

//Calibration not required
void onNewUser(SimpleOpenNI kinect, int userID) {
  println("Start skeleton tracking");
  kinect.startTrackingSkeleton(userID);
}
