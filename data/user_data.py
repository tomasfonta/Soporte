from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from entities.user import Base, User, CoinFav

class UserData(object):
    def __init__(self):
        engine = create_engine('sqlite:///C:\\Users\\fonta\\Documents\\repository\\python\\DB.db', echo=True)
        Base.metadata.bind = engine
        Base.metadata.create_all(engine)
        db_session = sessionmaker()
        db_session.bind = engine
        self.session = db_session()

    def get_one(self, id_user):
        try:
            return self.session.query(User).filter_by(id_user=id_user).first()
        except:
            return None

    def get_one_by_credentials(self, email, password):
        try:
            return self.session.query(User).filter_by(email=email, password=password).first()
        except:
            return None

    def get_one_by_user(self, email):
        try:
            return self.session.query(User).filter_by(email=email).first()
        except:
            return None

    def get_all(self):
        return self.session.query(User).all()

    def remove_all(self):
        try:
            self.session.query(User).delete()
            return True
        except:
            return False

    def insert(self, user):
        self.session.add(user)
        self.session.commit()
        return user

    def remove(self, id_user):
        user = self.get_one(id_user)
        if user is None:
            return False
        else:
            self.session.delete(user)
            self.session.commit()
            return True

    def update(self, user):
        user_enc = self.get_one(user.id_user)
        user_enc.password = user.password
        user_enc.email = user.email
        user_enc.coin_fav = user.coin_fav
        self.session.commit()
        return user_enc

    def get_fav_user(self, id_user):
        try:
            return self.session.query(CoinFav).filter_by(id_user=id_user).all()
        except:
            return None

    def get_one_coin(self, id_user, ticker):
        try:
            return self.session.query(CoinFav).filter_by(id_user=id_user, ticker=ticker).first()
        except:
            return None

    def insert_coin_fav(self, coin_fav):
        current_db_sessions = self.session.object_session(coin_fav)
        current_db_sessions.add(coin_fav)
        current_db_sessions.commit()
        return coin_fav

    def remove_coin_fav(self, id_user, ticker):
        coin = self.get_one_coin(id_user, ticker)
        if coin is None:
            return False
        else:
            self.session.delete(coin)
            self.session.commit()
            return True

    def update_coin(self, coin):
        c = self.get_one_coin(id_user=coin.id_user, ticker=coin.ticker)
        c.trade_quantity = coin.trade_quantity
        c.trade_price = coin.trade_price
        self.session.commit()
        return c


