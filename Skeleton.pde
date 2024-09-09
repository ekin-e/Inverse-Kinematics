class Skeleton {
  
  float shoulder_limit;
  float shoulder_acc_cap;
  float elbow_limit;
  float elbow_acc_cap;
  float wrist_limit;
  float wrist_acc_cap;
  float l0_arm;
  float l1_arm;
  float l2_arm;
  float arm_upperW;
  float arm_lowerW;
  float handW;
  float torso_limit;
  float torso_limit2;
  float torso_acc_cap;
  float torso_len;
  float torsoW;
  float torso_len2;
  float torsoW2;
  float legW;
  float leg_len;
  float leg_limit;
  float leg_acc_cap;
  
  // Head
  Vec2 head;
  float a_head;
  float head_radius;
  
  // Torso
  Vec2 root_t1;
  float a0_t1;
  Vec2 start_t1;
  float a1_t1;

  //Right Arm
  Vec2 root_ra;
  //Right Upper Arm
  float a0_ra; //Shoulder joint
  //Right Lower Arm
  float a1_ra; //Elbow joint
  //Right Hand
  float a2_ra; //Wrist joint
  Vec2 start_l1_ra, start_l2_ra, endPoint_ra;
  
  //Right Arm
  Vec2 root_la;
  //Right Upper Arm
  float a0_la; //Shoulder joint
  //Right Lower Arm
  float a1_la; //Elbow joint
  //Right Hand
  float a2_la; //Wrist joint
  Vec2 start_l1_la, start_l2_la, endPoint_la;
  
  //Left Leg
  Vec2 root_ll;
  float a0_ll;
  Vec2 endPoint_ll;
  
  //Right Leg
  Vec2 root_rl;
  float a0_rl;
  Vec2 endPoint_rl;

  Skeleton(){
    // Arms
    shoulder_limit = radians(90);
    shoulder_acc_cap = radians(5);
    elbow_limit = radians(180);
    elbow_acc_cap = radians(6);
    wrist_limit = radians(90);
    wrist_acc_cap = radians(8);

    torso_limit = radians(1);
    torso_limit2 = radians(2);
    torso_acc_cap = radians(2);

    leg_limit = radians(45);
    leg_acc_cap = radians(5);
    
    l0_arm = 60;
    l1_arm = 80;
    l2_arm = 25;
    arm_upperW = 20;
    arm_lowerW = 15;
    handW = 20;

    // head
    head = new Vec2(0,0);
    a_head = 0.0;
    head_radius = 40;

    //hips
    torso_len = 45;
    torsoW = 45;

    torso_len2 = 100;
    torsoW2 = 40;

    //Torso
    root_t1 = new Vec2(320, 250);
    a0_t1 = 0.0;

    start_t1  = new Vec2(0,0);
    a1_t1 = 0.0;

    //Right Arm
    //Right Upper Arm
    a0_ra = 0.3; //Shoulder joint
    //Right Lower Arm
    a1_ra = 0.3; //Elbow joint
    //Right Hand
    a2_ra = 0.3; //Wrist joint
    root_ra = new Vec2(0,0);
    start_l1_ra = new Vec2(0,0);
    start_l2_ra = new Vec2(0,0);
    endPoint_ra = new Vec2(0,0);

    //Left Arm
    root_la = new Vec2(0,0);
    //Left Upper Arm
    a0_la = radians(180)-0.3; //Shoulder joint
    //Left Lower Arm
    a1_la = 0.3; //Elbow joint
    //Left Hand
    a2_la = 0.3; //Wrist joint
    start_l1_la = new Vec2(0,0);
    start_l2_la = new Vec2(0,0);
    endPoint_la = new Vec2(0,0);

    //left leg
    legW = 20;
    leg_len = 150;
    root_ll = new Vec2(0, 0);
    endPoint_ll = new Vec2(0,0);
    a0_ll = radians(90);

    //left leg
    root_rl = new Vec2(0, 0);
    endPoint_rl = new Vec2(0,0);
    a0_rl = radians(90);
  }

  void fk(int part){
    if (part == 0){ //right arm
      //torso
      start_t1 = new Vec2(cos(a0_t1+a1_t1)*torsoW-torsoW2, sin(a0_t1+a1_t1)*torso_len-torso_len2+5).plus(root_t1);
      
      //legs
      root_rl = new Vec2(cos(a0_t1+a1_t1)*legW+legW/2+5, sin(a0_t1+a1_t1)*legW+5).plus(root_t1);
      root_ll = new Vec2(cos(a0_t1+a1_t1)*legW-legW/2, sin(a0_t1+a1_t1)*legW+5).plus(root_t1);
      
      endPoint_rl = new Vec2(cos(a0_rl+a0_t1)*leg_len, sin(a0_rl+a0_t1)*leg_len).plus(root_rl);
      endPoint_ll = new Vec2(cos(a0_ll+a0_t1)*leg_len, sin(a0_ll+a0_t1)*leg_len).plus(root_ll);
      
      root_ra = new Vec2(cos(a0_t1+a1_t1)*torsoW2, sin(a0_t1+a1_t1)*torsoW2).plus(start_t1);
      root_la = new Vec2(cos(a0_t1+a1_t1)*torsoW2-torsoW+5, sin(a0_t1+a1_t1)*torsoW2).plus(start_t1);

      // head
      head = new Vec2(cos(a_head)*head_radius-torsoW-16, sin(a_head)*head_radius-torso_len+2).plus(root_ra);

      //right arm
      start_l1_ra = new Vec2(cos(a0_ra)*l0_arm, sin(a0_ra)*l0_arm).plus(root_ra);
      start_l2_ra = new Vec2(cos(a0_ra+a1_ra)*l1_arm, sin(a0_ra+a1_ra)*l1_arm).plus(start_l1_ra);
      endPoint_ra = new Vec2(cos(a0_ra+a1_ra+a2_ra)*l2_arm, sin(a0_ra+a1_ra+a2_ra)*l2_arm).plus(start_l2_ra);

      //left arm
      start_l1_la = new Vec2(cos(a0_la)*l0_arm, sin(a0_la)*l0_arm).plus(root_la);
      start_l2_la = new Vec2(cos(a0_la+a1_la)*l1_arm, sin(a0_la+a1_la)*l1_arm).plus(start_l1_la);
      endPoint_la = new Vec2(cos(a0_la+a1_la+a2_la)*l2_arm, sin(a0_la+a1_la+a2_la)*l2_arm).plus(start_l2_la);
    }
  }

  // IK SOLVER FOR THE RIGHT ARM
  void solve_right(){
    Vec2 goal = new Vec2(mouseX, mouseY);
    
    Vec2 startToGoal, startToEndEffector;
    float dotProd, angleDiff;

    //Update wrist joint
    startToGoal = goal.minus(start_l2_ra);
    startToEndEffector = endPoint_ra.minus(start_l2_ra);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    if (abs(angleDiff) > wrist_acc_cap){
      angleDiff = sign(angleDiff) * wrist_acc_cap;
    }
    if (cross(startToGoal,startToEndEffector) < 0){
      if (a2_ra + angleDiff <= wrist_limit){
        a2_ra += angleDiff;
      }
    }
    else{
      if (a2_ra - angleDiff >= -wrist_limit){
        a2_ra -= angleDiff;
      }
    }
    fk(0); //Update link positions with fk (e.g. end effector changed)

    //Update elbow joint
    startToGoal = goal.minus(start_l1_ra);
    startToEndEffector = endPoint_ra.minus(start_l1_ra);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    if (abs(angleDiff) > elbow_acc_cap){
      angleDiff = sign(angleDiff) * elbow_acc_cap;
    }
    if (cross(startToGoal,startToEndEffector) < 0){
      if (a1_ra + angleDiff <= elbow_limit){
        a1_ra += angleDiff;
      }
    }
    else{
      if (a1_ra - angleDiff >= -elbow_limit){
        a1_ra -= angleDiff;
      }
    }
    fk(0); //Update link positions with fk (e.g. end effector changed)


    //Update shoulder joint
    startToGoal = goal.minus(root_ra);
    //if (startToGoal.length() < .0001) return;
    startToEndEffector = endPoint_ra.minus(root_ra);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > shoulder_acc_cap){
      angleDiff = sign(angleDiff) * shoulder_acc_cap;
    }
    
    if (cross(startToGoal,startToEndEffector) < 0){
      if (a0_ra + angleDiff <= shoulder_limit){
        a0_ra += angleDiff;
      }
    }
    else{
      if (a0_ra - angleDiff >= -shoulder_limit){
        a0_ra -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)


    //Update torso
    startToGoal = goal.minus(start_t1);
    startToEndEffector = endPoint_ra.minus(start_t1);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > torso_acc_cap){
      angleDiff = sign(angleDiff) * torso_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (a1_t1 + angleDiff <= torso_limit){
        a1_t1 += angleDiff;
      }
    }
    else{
      if (a1_t1 - angleDiff >= -torso_limit){
        a1_t1 -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)
    
    
    startToGoal = goal.minus(root_t1);
    if (startToGoal.length() < .0001) return;
    startToEndEffector = endPoint_ra.minus(root_t1);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > torso_acc_cap){
      angleDiff = sign(angleDiff) * torso_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (a0_t1 + angleDiff <= torso_limit2){
        a0_t1 += angleDiff;
      }
    }
    else{
      if (a0_t1 - angleDiff >= -torso_limit2){
        a0_t1 -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)
  }
  
  
  // IK SOLVER FOR THE LEFT ARM
  void solve_left(){
    Vec2 goal = new Vec2(mouseX, mouseY);

    Vec2 startToGoal, startToEndEffector;
    float dotProd, angleDiff;

    //Update wrist joint
    float halfWidth = handW / 2.0 - 15;
    float halfHeight = l2_arm / 2.0 - 15;
    Vec2 corner1_la = new Vec2(endPoint_la.x - halfWidth, endPoint_la.y - halfHeight);
    Vec2 corner2_la = new Vec2(endPoint_la.x + halfWidth, endPoint_la.y + halfHeight); //again stuff for end effector collison that is not working atm
    
    startToGoal = goal.minus(start_l2_la);
    startToEndEffector = endPoint_la.minus(start_l2_la);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    do {
      if (abs(angleDiff) > wrist_acc_cap){
        angleDiff = sign(angleDiff) * wrist_acc_cap;
      }
      
      float newA2 = a2_la;
      
      if (cross(startToGoal,startToEndEffector) < 0){
          newA2 += angleDiff;
      }
      else{
          newA2 -= angleDiff;
      }
      
      // Check if the new angle is within the wrist limits
      if (newA2 <= wrist_limit && newA2 >= -wrist_limit) {
        a2_la = newA2;
      }

      fk(0); //Update link positions with fk (e.g. end effector changed)
      angleDiff *= .5;
    } while (circles.get(0).circleBoxCollision(corner1_la, corner2_la)); // trying IK collision for only the left end effector and it's not working right now
    
    fk(0);

    //Update elbow joint
    startToGoal = goal.minus(start_l1_la);
    startToEndEffector = endPoint_la.minus(start_l1_la);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    if (abs(angleDiff) > elbow_acc_cap){
      angleDiff = sign(angleDiff) * elbow_acc_cap;
    }
    if (cross(startToGoal,startToEndEffector) < 0){
      if (a1_la + angleDiff <= elbow_limit){
        a1_la += angleDiff;
      }
    }
    else{
      if (a1_la - angleDiff >= -elbow_limit){
        a1_la -= angleDiff;
      }
    }
    fk(0); //Update link positions with fk (e.g. end effector changed)



    //Update shoulder joint
    startToGoal = goal.minus(root_la);
    if (startToGoal.length() < .0001) return;
    startToEndEffector = endPoint_la.minus(root_la);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > shoulder_acc_cap){
      angleDiff = sign(angleDiff) * shoulder_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (radians(-180) + (a0_la + angleDiff) <= shoulder_limit){
        a0_la += angleDiff;
      }
    }
    else{
      if (radians(-180) + (a0_la - angleDiff) >= -shoulder_limit){
        a0_la -= angleDiff;
      }
    }
  
    fk(0); //Update link positions with fk (e.g. end effector changed)


    //Update torso
    startToGoal = goal.minus(start_t1);
    startToEndEffector = endPoint_ra.minus(start_t1);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > torso_acc_cap){
      angleDiff = sign(angleDiff) * torso_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (a1_t1 + angleDiff <= torso_limit){
        a1_t1 += angleDiff;
      }
    }
    else{
      if (a1_t1 - angleDiff >= -torso_limit){
        a1_t1 -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)


    startToGoal = goal.minus(root_t1);
    if (startToGoal.length() < .0001) return;
    startToEndEffector = endPoint_ra.minus(root_t1);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > torso_acc_cap){
      angleDiff = sign(angleDiff) * torso_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (a0_t1 + angleDiff <= torso_limit2){
        a0_t1 += angleDiff;
      }
    }
    else{
      if (a0_t1 - angleDiff >= -torso_limit2){
        a0_t1 -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)    
  }
  
  
  // IK SOLVER FOR THE LEFT LEG
  void solve_left_leg(){
    Vec2 goal = new Vec2(mouseX, mouseY);
    
    Vec2 startToGoal, startToEndEffector;
    float dotProd, angleDiff;
    
    // Update Legs
    startToGoal = goal.minus(root_ll);
    startToEndEffector = endPoint_ll.minus(root_ll);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);

    if (abs(angleDiff) > leg_acc_cap){
      angleDiff = sign(angleDiff) * leg_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (radians(-90) + a0_ll + angleDiff <= leg_limit){
        a0_ll += angleDiff;
      }
    }
    else{
      if (radians(-90) + a0_ll - angleDiff >= -leg_limit){
        a0_ll -= angleDiff;
      }
    }
    println(endPoint_ll);
    fk(0); //Update link positions with fk (e.g. end effector changed)

    //Update torso
    startToGoal = goal.minus(start_t1);
    startToEndEffector = endPoint_ll.minus(start_t1);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > torso_acc_cap){
      angleDiff = sign(angleDiff) * torso_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (a1_t1 + angleDiff <= torso_limit){
        a1_t1 += angleDiff;
      }
    }
    else{
      if (a1_t1 - angleDiff >= -torso_limit){
        a1_t1 -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)


    startToGoal = goal.minus(root_t1);
    if (startToGoal.length() < .0001) return;
    startToEndEffector = endPoint_ll.minus(root_t1);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > torso_acc_cap){
      angleDiff = sign(angleDiff) * torso_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (a0_t1 + angleDiff <= torso_limit2){
        a0_t1 += angleDiff;
      }
    }
    else{
      if (a0_t1 - angleDiff >= -torso_limit2){
        a0_t1 -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)
  }
  
  
  // IK SOLVER FOR THE RIGHT LEG
  void solve_right_leg(){
    Vec2 goal = new Vec2(mouseX, mouseY);
    
    Vec2 startToGoal, startToEndEffector;
    float dotProd, angleDiff;
    
    // Update Legs
    startToGoal = goal.minus(root_rl);
    startToEndEffector = endPoint_rl.minus(root_rl);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);

    if (abs(angleDiff) > leg_acc_cap){
      angleDiff = sign(angleDiff) * leg_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (radians(-90) + a0_rl + angleDiff <= leg_limit){
        a0_rl += angleDiff;
      }
    }
    else{
      if (radians(-90) + a0_rl - angleDiff >= -leg_limit){
        a0_rl -= angleDiff;
      }
    }
    fk(0); //Update link positions with fk (e.g. end effector changed)

    //Update torso
    startToGoal = goal.minus(start_t1);
    startToEndEffector = endPoint_rl.minus(start_t1);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > torso_acc_cap){
      angleDiff = sign(angleDiff) * torso_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (a1_t1 + angleDiff <= torso_limit){
        a1_t1 += angleDiff;
      }
    }
    else{
      if (a1_t1 - angleDiff >= -torso_limit){
        a1_t1 -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)


    startToGoal = goal.minus(root_t1);
    if (startToGoal.length() < .0001) return;
    startToEndEffector = endPoint_rl.minus(root_t1);
    dotProd = dot(startToGoal.normalized(),startToEndEffector.normalized());
    dotProd = clamp(dotProd,-1,1);
    angleDiff = acos(dotProd);
    
    if (abs(angleDiff) > torso_acc_cap){
      angleDiff = sign(angleDiff) * torso_acc_cap;
    }

    if (cross(startToGoal,startToEndEffector) < 0){
      if (a0_t1 + angleDiff <= torso_limit2){
        a0_t1 += angleDiff;
      }
    }
    else{
      if (a0_t1 - angleDiff >= -torso_limit2){
        a0_t1 -= angleDiff;
      }
    }

    fk(0); //Update link positions with fk (e.g. end effector changed)
  }
  
  // IK SOLVER FOR BOTH ARMS
  void solve(){
    solve_right();
    solve_left();
  }
  
  void walk(){
    Vec2 goal = new Vec2(mouseX, mouseY);

    Vec2 startToGoal;
    
    // Update Torso
    startToGoal = goal.minus(root_t1);
    if (abs(startToGoal.x) < .0001) return;
    if (startToGoal.x < 0){
      root_t1.x -= 1; 
    }
    else{
      root_t1.x += 1; 
    }
    
    if (abs(startToGoal.y) < .0001) return;
    if (startToGoal.y < 0){
      root_t1.y -= 1; 
    }
    else{
      root_t1.y += 1; 
    }
  }
}
