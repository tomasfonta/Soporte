from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, ForeignKey, Float
from sqlalchemy.orm import relationship

Base = declarative_base()


class User(Base):
    __tablename__ = 'user'
    id_user = Column(Integer, primary_key=True, unique=True, autoincrement=True)
    password = Column(String(250), nullable=False)
    email = Column(String(250), nullable=False)
    coins_fav = relationship('CoinFav', back_populates='user')


class CoinFav(Base):
    __tablename__ = 'coin_fav'
    id_coin_fav = Column(
        Integer, primary_key=True, unique=True, autoincrement=True)
    ticker = Column(String(250), nullable=False)
    id_user = Column(Integer, ForeignKey('user.id_user'))
    user = relationship('User', back_populates='coins_fav')
    trade_quantity = Column(Float)
    trade_price = Column(Float)
