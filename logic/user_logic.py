from data.user_data import UserData


class UserException(Exception):
    pass


class UserLogic(object):
    def __init__(self):
        self.userData = UserData()

    def get_one(self, id_user):
        try:
            return self.userData.get_one(id_user)
        except:
            return None

    def get_one_by_credentials(self, email, password):
        try:
            return self.userData.get_one_by_credentials(email=email, password=password)
        except:
            return None

    def get_one_by_user(self, email):
        try:
            return self.userData.get_one_by_user(email=email)
        except:
            return None

    def get_all(self):
        return self.userData.get_all()

    def insert(self, user):
        self.userData.insert(user)
        return True

    def remove(self, id_user):
        user = self.get_one(id_user)
        if user is None:
            return False
        else:
            self.userData.remove(user.id_user)
            return True

    def update(self, user):
        self.userData.update(user)
        return True

    def regla_1(self, user):
        if self.get_one_by_user(user.email) is not None:
            raise UserException("El usuario ya existe.")
        return True

    def insert(self, user):
        if not self.regla_1(user):
            return False
        self.userData.insert(user)
        return True

    def remove(self, id_user):
        user = self.get_one(id_user)
        if user is None:
            return False
        else:
            self.userData.remove(user.id_user)
            return True

    def insert_coin_fav(self, coin_fav):
        self.userData.insert_coin_fav(coin_fav)
        return True

    def remove_coin_fav(self, id_user, ticker):
        coin_fav = self.userData.get_one_coin(id_user, ticker)
        if coin_fav is None:
            return False
        else:
            self.userData.remove_coin_fav(id_user, ticker)
            return True

    def coin_fav_user(self, id_user):
        fav = []
        fav = self.userData.get_fav_user(id_user)
        return fav

    def is_coin_fav(self, id_user, ticker):
        coin = self.userData.get_one_coin(id_user, ticker)
        if coin is None:
            return False
        else:
            return True

    def updateCoin(self, id_user, ticker, quantity, price):
        coin = self.userData.get_one_coin(id_user=id_user, ticker=ticker)
        if coin is not None:
            coin.trade_price = price
            coin.trade_quantity = quantity
        self.userData.update_coin(coin)

