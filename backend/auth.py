from crypt import methods
from flask_login import login_user, login_required, logout_user
from flask import Blueprint, url_for, redirect, request, flash, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from .models import User
from . import db

auth = Blueprint('auth', __name__)

@auth.route('/login', methods=['POST'])
def login():
    email = request.form.get('email')
    password = request.form.get('password')

    user = User.query.filter_by(email=email).first()
    print(user)
    
    # check if the user actually exists
    # take the user-supplied password, hash it, and compare it to the hashed password in the database
    if not user or not (user.password == password):
        # flash('Please check your login details and try again.')
        response={
            "message": 'Please check your login details and try again',
        }
        return (jsonify(response)) # if the user doesn't exist or password is wrong, reload the page

    # if the above check passes, then we know the user has the right credentials
    login_user(user)
    return (url_for('main.profile'))

@auth.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('main.index'))