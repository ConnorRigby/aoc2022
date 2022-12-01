function compareNumbers(a, b) {
  return a - b;
}

window.run = function(input) {
  var bucket = []; // where each elf's callorie count will be stored
  var text = input.split(/\r?\n/); // split by every line

  var numCalories = 0;
  text.forEach(element => {
    if(element.length == 0) {
      bucket.push(numCalories);
      numCalories = 0;
      return; // don't continue when finding a empty line
    }
    console.log(element);
    numCalories += parseInt(element);
  });
  
  bucket.sort(compareNumbers);
  console.log(Math.max(...bucket));
  document.getElementById("answer").innerHTML = bucket;
}

window.onload = function() {
  document.getElementById("input").value=
`1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

`
}
