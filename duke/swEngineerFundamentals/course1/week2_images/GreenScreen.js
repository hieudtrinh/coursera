// write your code here
var fgImage = new SimpleImage("drewRobert.png");
//... and with the background image you want (bgImage)
var bgImage = new SimpleImage("dinos.png");
//Make a blank image of the same size (output)
var output  = new SimpleImage(fgImage.getWidth(), fgImage.getHeight());

for (var pixel of fgImage.values()) {
    var x = pixel.getX();
    var y = pixel.getY();
    if (pixel.getGreen() >= pixel.getRed() + pixel.getBlue()) {
        var newPixel = bgImage.getPixel(x,y);
        output.setPixel(x,y, newPixel);
    } else {
        output.setPixel(x,y, pixel);
    }
}
print(output);