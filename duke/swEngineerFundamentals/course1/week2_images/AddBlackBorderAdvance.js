// write your code here
// https://www.coursera.org/learn/duke-programming-web/supplement/4x9Bk/programming-exercise-advanced-modifying-images
// Part 3
var img = new SimpleImage("smallpanda.png");
// print(img);

addBorders(img, 10, 25);
print(img);


function pixelOnEdge(image,pixel,horizontalThick, verticalThick){
    var x = pixel.getX();
    var y = pixel.getY();
    if (x < verticalThick || x >= image.getWidth() - verticalThick){
        return true;
    }
    if (y < horizontalThick || y >= image.getHeight() - horizontalThick){
        return true;
    }
    return false;
}

function addBorders(image,horizontalThick, verticalThick){
    for (var px of image.values()){
        if (pixelOnEdge(image,px,horizontalThick,verticalThick)){
            px = setBlack(px);
        }
    }
    return image;
}

function setBlack(pixel) {
    pixel.setRed(0);
    pixel.setGreen(0);
    pixel.setBlue(0);
    return pixel;
}