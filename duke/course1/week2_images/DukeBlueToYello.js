// write your code here
// https://www.coursera.org/learn/duke-programming-web/supplement/xApiL/programming-exercise-modifying-images
var img = new SimpleImage("duke_blue_devil.png");
print(img);
for (var pixel of img.values()) {
    var r = pixel.getRed();
    var g = pixel.getGreen();
    var b = pixel.getBlue();
    if (r==255 && g==255 && b==255) continue;
    pixel.setRed(255);
    pixel.setGreen(255);
    pixel.setBlue(0);
    // pixel.swapRedGreen();
}
print(img);
