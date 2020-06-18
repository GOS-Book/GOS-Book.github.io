const desiredRepo = "GOS-Book.github.io";

var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function()
{
  if (this.readyState == 4 && this.status == 200)
  {
    let repos = JSON.parse(this.responseText);

    repos.forEach((repo)=>{
      if (repo.name == desiredRepo)
      {
        var lastUpdated = new Date(repo.updated_at);
        var day = lastUpdated.getUTCDate();
        var month = 1+lastUpdated.getUTCMonth();
        var year = lastUpdated.getUTCFullYear();
        var myDayMonthYear = ("00" + day.toString()).slice (-2) +"."+ ("00" + month.toString()).slice (-2) +"."+ year.toString();         
        document.getElementById("myDate").innerHTML = myDayMonthYear;
      }
    });
  }
};
xhttp.open("GET", "https://api.github.com/users/GOS-Book/repos", true);
xhttp.send();