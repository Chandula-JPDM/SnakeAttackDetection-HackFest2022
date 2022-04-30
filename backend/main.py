from flask import Blueprint
from flask_login import login_required
from . import db

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return 'Landing page'

@main.route('/profile')
@login_required
def profile():
    return 'Profile page'