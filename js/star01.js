const line = 7;
let column = 1;

for (let row = 1; row <= line; row++) {
    console.log("*".repeat(column));
    
    if (row < line / 2) {
        column++;
    } else {
        column--;
    }
}
