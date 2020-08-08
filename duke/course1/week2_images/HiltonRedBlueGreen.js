// write your code here
// https://www.coursera.org/learn/duke-programming-web/supplement/xApiL/programming-exercise-modifying-images
var img = new SimpleImage("hilton.jpg");
print(img);
var w = img.getWidth();
print(w);
for (var pixel of img.values()) {
    if (pixel.getX() < w/3) {
        pixel.setRed(255);
    } else if (pixel.getX() < 2*w/3) {
        pixel.setGreen(255);
    } else {
        pixel.setBlue(255);
    }
}
print(img);

