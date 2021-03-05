import bottle
from bottle import static_file, template, request
import canister
from canister import session
from logic.coin_logic import init_coins, search_coin, get_coin_info

from logic.user_logic import UserLogic

from entities.user import CoinFav, User

app = bottle.Bottle()
app.install(canister.Canister())


@app.route('/')
@app.route('/index')
def index():
    coins = init_coins(user=current_user())
    return template('index.tpl', coins=coins, user=current_user())


@app.post('/')
@app.post('/index')
def index():
    query = request.forms.get('query')
    coins = search_coin(query, current_user())
    return template('index.tpl', coins=coins, user=current_user())


@app.route('/login')
def login():
    session.data['user'] = None
    return static_file('login.html', root='./public/')


@app.post('/login')
def login():
    email = request.forms.get('inputEmail')
    password = request.forms.get('inputPassword')
    user_logic = UserLogic()
    user = user_logic.get_one_by_credentials(email=email, password=password)
    if user is not None:
        session.data['user'] = user
        return index()
    else:
        return static_file('login.html', root='./public/')


@app.route('/registration')
def registration():
    session.data['user'] = None
    return static_file('registration.html', root='./public/')


@app.post('/registration')
def registration():
    try:
        password = request.forms.get('inputPassword')
        email = request.forms.get('inputEmail')
        user = User(password=password, email=email, coins_fav=[])
        user_logic = UserLogic()
        user_logic.insert(user)
        session.data['user'] = user
        return index()
    except:
        return registration()


@app.post('/add_coin_fav')
def add_coin_fav():
    data = request.json
    id_user = data['id_user']
    ticker = data['ticker']
    coin_fav = CoinFav(ticker=ticker, id_user=id_user, user=current_user(), trade_quantity=0.0, trade_price=0.0)
    user_logic = UserLogic()
    user_logic.insert_coin_fav(coin_fav)


@app.post('/remove_coin_fav')
def remove_coin_fav():
    data = request.json
    id_user = data['id_user']
    ticker = data['ticker']
    user_logic = UserLogic()
    user_logic.remove_coin_fav(id_user, ticker)


@app.route('/my_coins')
def my_coins():
    user_logic = UserLogic()
    user = current_user()
    if user is None:
        return index()
    else:
        coins = []
        fav_coin = user_logic.coin_fav_user(user.id_user)
        for fc in fav_coin:
            c = get_coin_info(coin=fc, user=user)
            coins.append(c)
        return template('my_coins.tpl', coins=coins, user=user)


@app.post('/trade')
def trade():
    ticker = request.forms.get('inputCoin')
    quantity = request.forms.get('inputQuantity')
    price = request.forms.get('inputPrice')
    user_logic = UserLogic()
    user = current_user()
    user_logic.updateCoin(id_user=user.id_user,  ticker=ticker, quantity=quantity, price=price)
    return my_coins()


@app.post('/remove_trade')
def remove_trade():
    ticker = request.forms.get('ticker')
    user_logic = UserLogic()
    user = current_user()
    user_logic.updateCoin(id_user=user.id_user,  ticker=ticker, quantity=0, price=0)
    return my_coins()






def current_user():
    if 'user' in session.data:
        user = session.data['user']
        return user
    else:
        return None


if __name__ == "__main__":
    app.run(host='localhost', reloader=True, port=8080, debug=True)
