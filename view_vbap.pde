
Vbap v;
int n = 21;

void setup() {
    size(800, 800);
    v = new Vbap(n);
}

void draw() {
    background(0);
    v.get_source_position(mouseX, mouseY);
    v.show();
}
