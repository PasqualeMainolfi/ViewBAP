

class Vbap {

    PVector[] s;
    int n;
    float radius = width/2 - 50;
    float[] pos_rad;
    PVector origin = new PVector(width/2, height/2);


    Vbap(int ls_num) {
        n = ls_num;
        s = new PVector[ls_num];
        pos_rad = new float[n];
        float angle_step = 2 * PI/ls_num;

        for (int i = 0; i < ls_num; i++) {
            float p = angle_step * i;
            float x = radius * cos(p);
            float y = radius * sin(p);
            s[i] = new PVector(x, y);
            s[i].add(origin);
            pos_rad[i] = p;

        }
    }

    void show() {
        fill(255);
        ellipse(origin.x, origin.y, 7, 7);
        fill(255, 0, 0);
        for (PVector p : s) {
            ellipse(p.x, p.y, 15, 15);
        }
    }

    boolean is_intersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

        float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);

        if (den == 0) {
            return false;
        }

        float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4))/den;
        float u = ((x1 - x3) * (y1 - y2) - (y1 - y3) * (x1 - x2))/den;

        if (t > 0 && t < 1 && u > 0) {
            float xi = x1 + t * (x2 - x1);
            float yi = y1 + t * (y2 - y1);
            PVector intersect_point = new PVector(xi, yi);
            ellipse(xi, yi, 10, 10);
            return true;
        }
        return false;
    }

    int[] get_active_arc(float xsource, float ysource) {

        for (int j = 0; j < n; j++) {

            int curr = j;
            int next = (j + 1)%n;

            PVector s1 = s[curr];
            PVector s2 = s[next];

            boolean inter = is_intersect(s1.x, s1.y, s2.x, s2.y, origin.x, origin.y, xsource, ysource);

            if (inter) {
                int[] ans = {curr, next};
                return ans;
            }
        }
        return null;
    }
    
    void get_source_position(float xsource, float ysource) {

        PVector source = new PVector(xsource, ysource);
        
        fill(0, 255, 0);
        ellipse(xsource, ysource, 10, 10);

        float source_angle = atan2(source.y, source.x);
        int index = -1;
        for (int i = 0; i < n; i++) {
            if (pos_rad[i] == source_angle) {
                index = i;
            }
        }
        push();
        stroke(255);
        if (index != -1) {
            line(source.x, source.y, s[index].x, s[index].y);
        } else {
            int[] pair = get_active_arc(source.x, source.y);
            if (pair != null) {
                line(source.x, source.y, s[pair[0]].x, s[pair[0]].y);
                line(source.x, source.y, s[pair[1]].x, s[pair[1]].y);
            }
        }
        pop();
    }
}