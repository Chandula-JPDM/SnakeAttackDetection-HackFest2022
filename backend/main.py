from flask import Blueprint
from flask import request
from flask_login import login_required
from . import db

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return 'Landing page'

@main.route('/uploads', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        f = request.files['the_file']
        f.save('/var/www/uploads/uploaded_file.txt') 


@main.route('/profile')
@login_required
def profile():
    return 'Profile page'