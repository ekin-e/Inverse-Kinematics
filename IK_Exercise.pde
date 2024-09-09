//Inverse Kinematics
//CSCI 5611 IK [Solution]
// Stephen J. Guy <sjguy@umn.edu>


void setup(){
  size(640,480,P3D);
  camera = new Camera();
  surface.setTitle("Inverse Kinematics");
  circles.add(circle1);
  //circles.add(circle2);
}

Camera camera;
int part_of_body = 0; // 0: right arm, 1: left arm, 2: right leg, 3; left leg
Skeleton skeleton = new Skeleton();

ArrayList<Obstacles> circles = new ArrayList<Obstacles>();
Obstacles circle1 = new Obstacles(60,0,0);
Obstacles circle2 = new Obstacles(30,0,0);

// Determine the sign of a value
float sign(float value) {
  if (value > 0) {
    return 1.0; // Positive value
  } else if (value < 0) {
    return -1.0; // Negative value
  } else {
    return 0.0; // Value is zero
  }
}

void drawCheckerboardGround(float size, int rowsAndColumns) {
  float squareSize = size / rowsAndColumns;

  for (int i = 0; i < rowsAndColumns; i++) {
    for (int j = 0; j < rowsAndColumns; j++) {
      pushMatrix();
      translate(-size / 2 + i * squareSize, -size / 2 + j * squareSize, 0);
      if ((i + j) % 2 == 0) {
        fill(31, 81, 255); // Color for even squares
      } else {
        fill(252, 15, 192); // Color for odd squares
      }
      box(squareSize, squareSize, 1);
      popMatrix();
    }
  }
}


void draw(){
  skeleton.fk(0);
  skeleton.fk(1);
  
  if (part_of_body == 0){
    skeleton.solve_right();
  }
  if (part_of_body == 1){
    skeleton.solve_left();
  }
  if (part_of_body == 2){
    skeleton.solve_left_leg();
  }
  if (part_of_body == 3){
    skeleton.solve_right_leg();
  }
  if (part_of_body == 4){
    skeleton.walk();
  }
  if (part_of_body == 5){
    skeleton.solve();
  }


  background(170, 150, 150);
  lights();
  camera.Update(1.0/frameRate);
  
  // GROUND
  fill(100, 250, 100); // Set the color for the ground
  pushMatrix();
  translate(width / 2, height - 50, 0); // Adjust the height of the ground as needed
  rotateX(PI / 2); // Rotate the ground to be horizontal
  float size = 1000;
  drawCheckerboardGround(size, 8);
  popMatrix();

  noStroke();
  //LEFT LEG
  fill(60,60,60);
  pushMatrix();
  translate(skeleton.root_ll.x, skeleton.root_ll.y, 10);
  rotate(skeleton.a0_ll);
  rect(0, -skeleton.legW/2, skeleton.leg_len, skeleton.legW, 5);
  popMatrix();

  //RIGHT LEG
  fill(60,60,60);
  pushMatrix();
  translate(skeleton.root_rl.x, skeleton.root_rl.y, 10);
  rotate(skeleton.a0_rl);
  rect(0, -skeleton.legW/2, skeleton.leg_len, skeleton.legW, 5);
  popMatrix();

  // TORSO
  fill(60,60,60);
  pushMatrix();
  translate(skeleton.root_t1.x, skeleton.root_t1.y, 11);
  rotate(skeleton.a0_t1);
  rect(0, -skeleton.torsoW/2, skeleton.torso_len, skeleton.torsoW, 30);
  popMatrix();

  fill(255, 105, 180);
  pushMatrix();
  translate(skeleton.start_t1.x, skeleton.start_t1.y, 11);
  rotate(skeleton.a1_t1);
  rect(0, -skeleton.torsoW2/2, skeleton.torsoW2, skeleton.torso_len2, 20);
  popMatrix();

  // RIGHT ARM
  fill(255, 105, 180);
  pushMatrix();
  translate(skeleton.root_ra.x, skeleton.root_ra.y, 12);
  rotate(skeleton.a0_ra);
  rect(0, -skeleton.arm_upperW/2, skeleton.l0_arm, skeleton.arm_upperW, 30);
  popMatrix();

  fill(224,172,105);
  pushMatrix();
  translate(skeleton.start_l1_ra.x, skeleton.start_l1_ra.y, 12);
  rotate(skeleton.a0_ra + skeleton.a1_ra);
  rect(0, -skeleton.arm_lowerW/2, skeleton.l1_arm, skeleton.arm_lowerW, 30);
  popMatrix();

  pushMatrix();
  translate(skeleton.start_l2_ra.x, skeleton.start_l2_ra.y, 12);
  rotate(skeleton.a0_ra + skeleton.a1_ra + skeleton.a2_ra);
  rect(0, -skeleton.handW/2, skeleton.l2_arm, skeleton.handW, 30);
  popMatrix();


  // LEFT ARM
  fill(255, 105, 180);
  pushMatrix();
  translate(skeleton.root_la.x, skeleton.root_la.y, 12);
  rotate(skeleton.a0_la);
  rect(0, -skeleton.arm_upperW/2, skeleton.l0_arm, skeleton.arm_upperW, 30);
  popMatrix();

  fill(224,172,105);
  pushMatrix();
  translate(skeleton.start_l1_la.x, skeleton.start_l1_la.y, 12);
  rotate((skeleton.a0_la + skeleton.a1_la));
  rect(0, -skeleton.arm_lowerW/2, skeleton.l1_arm, skeleton.arm_lowerW, 30);
  popMatrix();

  pushMatrix();
  translate(skeleton.start_l2_la.x, skeleton.start_l2_la.y, 12);
  rotate((skeleton.a0_la + skeleton.a1_la + skeleton.a2_la));
  rect(0, -skeleton.handW/2, skeleton.l2_arm, skeleton.handW, 30);
  popMatrix();
  
  //HEAD
  fill(224,172,105);
  pushMatrix();
  translate(skeleton.head.x, skeleton.head.y, 10);
  rotate(skeleton.a_head);
  //circle(0,0,40);
  sphere(25);
  popMatrix();
  
  //OBSTACLES
  for(Obstacles c: circles){
    pushMatrix();
    stroke(2);
    ambientLight(102, 102, 102);
    lightSpecular(204, 204, 204);
    directionalLight(102, 102, 102, 0, 0, -1);
    specular(255, 255, 255);
    fill(0, 51, 102);
    shininess(10.0);
    sphere(c.radius);
    popMatrix();
  }
  
}

void keyPressed(){
  camera.HandleKeyPressed();
  if (key == '1') {
    // move right arm
    part_of_body = 0;
  }
  if (key == '2') {
    // move left arm
    part_of_body = 1;
  }
  if (keyCode == ' ') {
    // move both arms
    part_of_body = 5;
  }
  if (key == '3') {
    // move left leg
    part_of_body = 2;
  }
  if (key == '4') {
    // move right leg
    part_of_body = 3;
  }
  if (key == '5') {
    // move root
    part_of_body = 4;
  }
}

void keyReleased()
{
  camera.HandleKeyReleased();
}



//-----------------
// Vector Library
//-----------------

//Vector Library
//CSCI 5611 Vector 2 Library [Example]
// Stephen J. Guy <sjguy@umn.edu>

public class Vec2 {
  public float x, y;
  
  public Vec2(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public String toString(){
    return "(" + x+ "," + y +")";
  }
  
  public float length(){
    return sqrt(x*x+y*y);
  }
  
  public Vec2 plus(Vec2 rhs){
    return new Vec2(x+rhs.x, y+rhs.y);
  }
  
  public void add(Vec2 rhs){
    x += rhs.x;
    y += rhs.y;
  }
  
  public Vec2 minus(Vec2 rhs){
    return new Vec2(x-rhs.x, y-rhs.y);
  }
  
  public void subtract(Vec2 rhs){
    x -= rhs.x;
    y -= rhs.y;
  }
  
  public Vec2 times(float rhs){
    return new Vec2(x*rhs, y*rhs);
  }
  
  public void mul(float rhs){
    x *= rhs;
    y *= rhs;
  }
  
  public void clampToLength(float maxL){
    float magnitude = sqrt(x*x + y*y);
    if (magnitude > maxL){
      x *= maxL/magnitude;
      y *= maxL/magnitude;
    }
  }
  
  public void setToLength(float newL){
    float magnitude = sqrt(x*x + y*y);
    x *= newL/magnitude;
    y *= newL/magnitude;
  }
  
  public void normalize(){
    float magnitude = sqrt(x*x + y*y);
    x /= magnitude;
    y /= magnitude;
  }
  
  public Vec2 normalized(){
    float magnitude = sqrt(x*x + y*y);
    return new Vec2(x/magnitude, y/magnitude);
  }
  
  public float distanceTo(Vec2 rhs){
    float dx = rhs.x - x;
    float dy = rhs.y - y;
    return sqrt(dx*dx + dy*dy);
  }
}

Vec2 interpolate(Vec2 a, Vec2 b, float t){
  return a.plus((b.minus(a)).times(t));
}

float interpolate(float a, float b, float t){
  return a + ((b-a)*t);
}

float dot(Vec2 a, Vec2 b){
  return a.x*b.x + a.y*b.y;
}

float cross(Vec2 a, Vec2 b){
  return a.x*b.y - a.y*b.x;
}


Vec2 projAB(Vec2 a, Vec2 b){
  return b.times(a.x*b.x + a.y*b.y);
}

float clamp(float f, float min, float max){
  if (f < min) return min;
  if (f > max) return max;
  return f;
}
