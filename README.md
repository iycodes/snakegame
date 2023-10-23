snake game using flutter only..
Wasn't as hard as i thought it was going to be actually, Just data manipulation basically.

How i did it,
Well basically i used a gridview builder to map out the squares(field of play)
the snake position in that gridview is stored in an array.
So if the index of a square in the grid view is a value in the snakeposition array, a snake pixel(basically a decoraredBox widget) is returned that square.
A timer runs every 100 millisecond to update position of the snake in the gridview builder.
Used gesturedetector to detect swipes and handle each swipe accordingly,
![Simulator Screenshot - iPhone 14 Pro - 2023-10-23 at 11 43 07](https://github.com/iycodes/snakegame/assets/142503117/0fc95fbf-4ed0-4d0f-bc73-3af0e7ad0708)
