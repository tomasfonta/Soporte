import requests
import json
import logging

from entities.receta import Receta
from data.usuarios_data import UsuariosData


def buscar_recetas(query, usuario):
    api_url = 'https://test-es.edamam.com/search?q=' + \
        str(query) + '&from=0&to=100'

    api_url = 'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD&api_key={b5dba6a9c2a59990e496e7bf59623c28fff7ca16bf2e0a7ee2fcc91a261462dc}'

    response = requests.get(api_url).json()
    logging.warning("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    logging.warning(response)
    recetas = []
    recetas.append(Receta(response))

    return recetas

def pagina_con_imagen(url):
    if 'http://www.elle.es/' in url or 'http://www.comidakraft.com/' in url or 'http://www.recetasgratis.net/' in url or 'http://www.hogarmania.com/' in url or 'http://www.kiwilimon.com/' in url or 'https://www.hogarmania.com/' in url:
        return False
    else:
        return True


def existe_imagen(url):
    try:
        r = requests.head(url, timeout=0.3)
        if r.status_code == requests.codes.ok:
            return True
    except:
        return False


def es_favorita(uri, label, usuario):
    try:
        if usuario != None:
            usuarios_data = UsuariosData()
            if usuarios_data.get_one_receta(usuario.id_usuario, uri, label) != None:
                return True
            else:
                return False
        else:
            return False
    except:
        return False
