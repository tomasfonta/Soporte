<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
% if user != None:
var id_user = {{user.id_user}}
% end
 function add_fav(element) {
  var ticker = document.getElementById(element.id).getAttribute('ticker');
  document.getElementById(element.id).src = "https://cdn2.iconfinder.com/data/icons/color-svg-vector-icons-part-2/512/dating_eating_vector_icon-512.png";
  document.getElementById(element.id).setAttribute("onclick", "remove_coin_fav(this);");
  $.ajax({
    type: "POST", 
    data: JSON.stringify({ 'ticker': ticker , 'id_user': id_user}),
    url: "/add_coin_fav" ,
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    });
  }
  function remove_coin_fav(element) {
    var ticker = document.getElementById(element.id).getAttribute('ticker');
    document.getElementById(element.id).src = "https://cdn1.iconfinder.com/data/icons/circle-outlines/512/Like_Favourite_Love_Health_Heart_Favourites_Favorite-512.png";
    document.getElementById(element.id).setAttribute("onclick","add_fav(this);");
      $.ajax({
    type: "POST", 
    data: JSON.stringify({'id_user': id_user, "ticker": ticker}),
    url: "/remove_coin_fav" ,
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    });
  }
</script>

<title>CoinSearch</title>

<!-- Bootstrap core CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


<style>
.bd-placeholder-img {
font-size: 1.125rem;
text-anchor: middle;
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
background-color: #e9ecef;
}

@media (min-width: 768px) {
.bd-placeholder-img-lg {
  font-size: 3.5rem;
}
}
</style>
<!-- Custom styles for this template -->
<!-- <link href="/style/style.css" rel="stylesheet"> -->
</head>

<body style="background-color:#e9ecef;">

<nav class="navbar navbar-expand-lg navbar-dark bg-secondary">
<img class="navbar-brand" src="https://cdn3.iconfinder.com/data/icons/fintech-color-pop-vol-1/64/cryptocurrency-512.png" width="55" height="65"></img>
<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
<span class="navbar-toggler-icon"></span>
</button>

<div class="collapse navbar-collapse" id="navbarColor01">
<ul class="navbar-nav mr-auto">
<li class="nav-item active">
  <a class="nav-link" href="\index"> <span class="sr-only">(current)</span></a>
</li>
% if user != None:
<li class="nav-item">
  <a class="nav-link" href="\my_coins">Mis Coins</a>
</li>
% end
</ul>       
% if user != None:
<form class="form-inline my-2 my-lg-0" action="login">
<button class="btn btn-secondary my-2 my-sm-0" type="submit">Cerrar Sesión</button>
</form>
% else:
<form class="form-inline my-2 my-lg-0" action="login">
<button class="btn btn-secondary my-2 my-sm-0" type="submit">Ingresar</button>
</form>
% end
</div>
</nav>

<main role="main">
  <form method="post" action="\index">
    <section class="text-center">
      <div class="container">
        <h1 class="jumbotron-heading">Coins</h1>
        <p class="lead text-muted">Encontrá aquí, solo con un click, todas tús Coins!</p>
        <div class="input-group mb-3">
          <input type="text" placeholder="bitcoin" class="form-control" aria-label="Username" id='query' name="query">
        </div>
        <p>
          <button type="submit" class="btn btn-primary my-2">Buscar</button>
        </p>
      </div>
    </section>
  </form>
  <div class="album py-5">
      <div class="container">
        <div class="row">
%if coins != []:
            % for c in coins:
            <div class="col-md-3">
            <div class="card mb-3 shadow-sm">
              <img class="bd-placeholder-img card-img-top" width="100%" height="225" src="{{c.image}}"
                preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
                aria-label="Placeholder: Thumbnail"></img>
              <div class="card-body">
                <p class="card-text">{{c.name}}</p>
                <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                   <h4>${{c.price}}</h4>
                  </div>
                  <small class="text-muted"> %: {{c.percentage}}</small>
                  % if user != None:
                      % if c.favorite == True:
                      <form>
                        <img hspace="10" src="https://cdn2.iconfinder.com/data/icons/color-svg-vector-icons-part-2/512/dating_eating_vector_icon-512.png" width="30" height="30" id={{c.ticker}} ticker={{c.ticker}} onclick="remove_coin_fav(this);" />
                      </form>
                      % else:
                      <form>
                        <img hspace="10" src="https://cdn1.iconfinder.com/data/icons/circle-outlines/512/Like_Favourite_Love_Health_Heart_Favourites_Favorite-512.png" width="30" height="30" id={{c.ticker}} ticker={{c.ticker}} onclick="add_fav(this);" />
                      </form>
                      % end
                    % end
                </div>
              </div>
            </div>
            </div>
            % end
%else:
            <div class="col-md-12">
                <div class="d-flex justify-content-center align-items-center alert alert-secondary" role="alert">
                    No se encontraron resultados...
                </div>
            </div>
        %end
%end
        </div>
      </div>
    </div>

</main>
</body>

</html>