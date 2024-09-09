class Obstacles{
  int radius;
  int x;
  int y;
  
  Obstacles(int r, int cx, int cy){
    radius = r;
    x = cx;
    y = cy;
  }
  
  boolean circleBoxCollision(Vec2 boxTopLeft, Vec2 boxbotRight) {
    float closestX = constrain(x, boxTopLeft.x, boxbotRight.x);
    float closestY = constrain(y, boxTopLeft.y, boxbotRight.y);
    Vec2 closestPoint = new Vec2(closestX, closestY);
    Vec2 circleCenter = new Vec2(x, y);

    float distance = circleCenter.distanceTo(closestPoint);
    if (distance < radius) {
        Vec2 pushDir = circleCenter.minus(closestPoint).normalized();
        float overlap = radius - distance + 0.1;
        circleCenter.add(pushDir.times(overlap));
        return true;
    }
    return false;
  }
}
