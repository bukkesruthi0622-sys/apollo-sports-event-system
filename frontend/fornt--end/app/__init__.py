import os
from flask import Flask, render_template

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'default-secret-key-for-dev')
    
    basedir = os.path.abspath(os.path.dirname(__file__))
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'sqlite:///' + os.path.join(basedir, 'sports.db'))
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    from app.models import db, Admin
    db.init_app(app)
    
    with app.app_context():
        db.create_all()

    from flask_login import LoginManager
    login_manager = LoginManager()
    login_manager.login_view = 'auth.admin_login'
    login_manager.login_message_category = 'info'
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(user_id):
        return Admin.query.get(int(user_id))
    
    from app.routes.auth import auth_bp
    from app.routes.admin import admin_bp
    from app.routes.student import student_bp
    from app.routes.volunteer import volunteer_bp
    from app.routes.errors import errors_bp
    
    app.register_blueprint(auth_bp)
    app.register_blueprint(admin_bp)
    app.register_blueprint(student_bp)
    app.register_blueprint(volunteer_bp)
    app.register_blueprint(errors_bp)

    @app.route('/')
    def index():
        return render_template('index.html')

    return app
