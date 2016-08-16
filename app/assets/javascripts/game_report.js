$( document ).ready(function() {
  var ctx = document.getElementById("weapons");
  var data = {
    labels: ["Stone Sword", "Bow", "Fists", "Wooden Hoe", "Stone Pickaxe", "Wooden Sword","Stone Sword", "Bow", "Fists", "Wooden Hoe", "Stone Pickaxe", "Wooden Sword","Stone Sword", "Bow", "Fists", "Wooden Hoe", "Stone Pickaxe", "Wooden Sword","Stone Sword", "Bow", "Fists", "Wooden Hoe", "Stone Pickaxe", "Wooden Sword","Stone Sword"],
    datasets: [{
      label: '# of Votes',
      data: [24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
    }]
  }

  var options = {
      legend:{
        display: false
      },
      animation:{
          animateScale:true
      }
  }

  var weaponsChart = new Chart(ctx, {
      type: 'line',
      data: data,
      options: options
  });
});