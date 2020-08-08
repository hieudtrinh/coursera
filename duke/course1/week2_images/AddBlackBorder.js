// write your code here
// https://www.coursera.org/learn/duke-programming-web/supplement/4x9Bk/programming-exercise-advanced-modifying-images
// Part 3
var img = new SimpleImage("smallpanda.png");
print(img);

addBorder(img, 10);
print(img);


function addBorder(img, border) {
    var w = img.getWidth();
    var h = img.getHeight();
    for (var pix of img.values()) {
        var x = pix.getX();
        var y = pix.getY();
        if (x < border || x >= w - border || y < border | y >= h-border) {
            setBlack(pix);
        }
    }
}

function setBlack(pixel) {
    pixel.setRed(0);
    pixel.setGreen(0);
    pixel.setBlue(0);
}