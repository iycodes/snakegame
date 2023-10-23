snake game using flutter only..
Wasn't as hard as i thought it was going to be actually, Just data manipulation basically

How i did it,
Well basically i used a gridview builder to map out the squares(field of play)
the snake position in that gridview is store in an array
so if the index of a square in the grid view is a value in the snakeposition array, a snake pixel(basically a decoraredBox widget) is returned that square;
a timer runs every 100 millisecond to update position of the snake in the gridview builder
used gesturedetector to detect swipes and handle each swipe accordingly,
