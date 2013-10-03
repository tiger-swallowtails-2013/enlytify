$(document).ready(function(){
  $("#next-day").bind("click", function() {
    $.get( "/dashboard/")
  });
  // $("#prev-day").bind("click", function() {
  //   alert("previous day bound")
  // });
});

// function bindNextButton(){
//    $('#next-day').click(function(event){
//     event.preventDefault();



// function bindRightButton(){
//   $('#next-day').click(function(event){
//     event.preventDefault();
//     $('#date').innerHTML('Lightning Talks - 
//   });
// }

// function bindLeftButton(){
//   $('#prev-day').click()
// }
