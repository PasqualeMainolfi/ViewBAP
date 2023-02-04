
Vbap v;

void setup() {
    size(800, 800);

    v = new Vbap(25);

}

void draw() {
    background(0);
    v.get_source_position(mouseX, mouseY);
    v.show();
}
