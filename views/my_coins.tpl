<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Mis Coins</title>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

  <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>



  <!-- Bootstrap core CSS -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>



  <style>
    .bd-placeholder-img {
      font-size: 1.125rem;
      text-anchor: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
    }

    @media (min-width: 768px) {
      .bd-placeholder-img-lg {
        font-size: 3.5rem;
      }
    }
  </style>
  <!-- Custom styles for this template -->
  <!-- <link href="/style/style.css" rel="stylesheet"> -->


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
</head>

<body style="background-color:#e9ecef;">

<nav class="navbar navbar-expand-lg navbar-dark bg-secondary">
  <img class="navbar-brand" src="https://cdn3.iconfinder.com/data/icons/fintech-color-pop-vol-1/64/cryptocurrency-512.png" width="55" height="65"></img>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="\index">Buscador</a>
      </li>
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

  <div class="album py-5">
    <div class="container">
      <div class="row justify-content-md-center">

        <!-- Button trigger modal -->
        <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModal">
          Crear Trade
        </button>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
            <form class="form-signin" method="post" action="trade">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Crear Trade</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">

                               <select  id="inputCoin" name="inputCoin"  class="form-control">

                                   % for c in coins:
                                        <option value="{{c.ticker}}">{{c.name}}</option>
                                   %end
                                </select>
                                 <br>
                                <div class="form-label-group">
                                    <input type="text" id="price" name="inputPrice" class="form-control"
                                        placeholder="Price" required>
                                </div>
                                <br>
                                 <div class="form-label-group">
                                    <input type="text" id="inputQuantity" name="inputQuantity" class="form-control"
                                        placeholder="Quantity" required>
                                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="sumbit" class="btn btn-primary">Crear</button>
              </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
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
                  %if c.trade_quantity > 0:
                        %if (c.price - c.trade_price) > 0:
                            <div class="container border border-success p-0">
                                <div class="row justify-content-center mt-2 md-2 ml-0 mr-0">
                                    <div class="col-9 p-0 ml-1 text-center">
                                        <h6 class="p-1 mt-1 mb-1"> <i class="fas fa-arrow-up"></i> ${{round((c.price - c.trade_price) * c.trade_quantity, 1)}}    % {{ round( (c.price * 100)/c.trade_price -100 , 2) }}</h6>
                                    </div>
                                     <div class="col p-0 align-self-end">
                                         <form method="post" action="remove_trade">
                                           <input type="hidden" name="ticker" value="{{c.ticker}}" />
                                           <button type="submit" class="btn"><i class="fa fa-trash" aria-hidden="true"></i></button>
                                         </form>
                                    </div>
                                </div>
                            </div>
                        %else:
                            <div class="container border border-danger p-0">
                                <div class="row  justify-content-center  mt-2 md-2 ml-0 mr-0">
                                    <div class="col-9 p-0 ml-1 text-center">
                                         <h6 class="p-1 mt-1 mb-1"><i class="fas fa-arrow-down"></i> ${{round((c.price - c.trade_price) * c.trade_quantity, 1)}}   % {{ round( (c.price * 100)/c.trade_price -100 , 2) }}</h6>
                                    </div>
                                    <div class="col p-0 align-self-end">
                                         <form method="post" action="remove_trade">
                                           <input type="hidden" name="ticker" value="{{c.ticker}}" />
                                           <button type="submit" class="btn"><i class="fa fa-trash" aria-hidden="true"></i></button>
                                         </form>
                                    </div>
                                </div>
                            </div>
                        %end
                    %end
                </div>
            </div>
            % end
%else:
            <div class="col-md-12">
                <div class="d-flex justify-content-center align-items-center alert alert-secondary" role="alert">
                    No tienes monedas favoritas...
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