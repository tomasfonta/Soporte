import requests
import json

from entities.coin import Coin

from logic.user_logic import UserLogic


def search_coin(query, user):
    if not query:
        return init_coins(user)
    coins = []
    api_url = 'https://api.coingecko.com/api/v3/coins/' + str(query)
    r = requests.get(api_url)
    result = (json.loads(r.text))
    name = result['name']
    ticker = result['id']
    image = result['image']['large']
    price = result['market_data']['current_price']['usd']
    favorite = is_fav(ticker, user)
    percentage = result['market_data']['price_change_percentage_24h']
    coin = Coin(name=name, ticker=ticker, price=price, percentage=percentage, favorite=favorite, image=image, trade_price=0, trade_quantity=0)
    coins.append(coin)

    return coins


def init_coins(user):
    coins = []
    api_url = 'https://api.coingecko.com/api/v3/coins/'
    r = requests.get(api_url)
    res = (json.loads(r.text))

    for result in res:
        name = result['name']
        ticker = result['id']
        image = result['image']['large']
        price = result['market_data']['current_price']['usd']
        if user is not None:
            favorite = is_fav(ticker, user)
        else:
            favorite = False
        percentage = result['market_data']['price_change_percentage_24h']
        coin = Coin(name=name, ticker=ticker, price=price, percentage=percentage, favorite=favorite, image=image, trade_price=0, trade_quantity=0)
        coins.append(coin)

    return coins


def get_coin_info(coin, user):
    api_url = 'https://api.coingecko.com/api/v3/coins/' + coin.ticker + '?tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false'
    r = requests.get(api_url)
    result = (json.loads(r.text))
    name = result['name']
    ticker = result['id']
    image = result['image']['large']
    price = result['market_data']['current_price']['usd']
    if user is not None:
        favorite = is_fav(ticker, user)
    else:
        favorite = False
    percentage = result['market_data']['price_change_percentage_24h']
    coin = Coin(name=name, ticker=ticker, price=price, percentage=percentage, favorite=favorite, image=image, trade_price=coin.trade_price, trade_quantity=coin.trade_quantity)
    return coin

def is_fav(ticker, user):
    userLogic = UserLogic()
    return userLogic.is_coin_fav(ticker=ticker, id_user=user.id_user)
