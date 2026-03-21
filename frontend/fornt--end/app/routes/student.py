from flask import Blueprint, render_template, request, flash, redirect, url_for
from app.models import db, Game, Student, Registration, Fixture, EventHistory
from app.forms import StudentRegistrationForm

student_bp = Blueprint('student', __name__)

@student_bp.route('/events')
def events():
    games = Game.query.all()
    return render_template('student/events.html', games=games)

@student_bp.route('/game/<int:game_id>', methods=['GET', 'POST'])
def game_details(game_id):
    game = Game.query.get_or_404(game_id)
    form = StudentRegistrationForm(game_id=game.id)
    
    if form.validate_on_submit():
        # Retrieve or create student
        student = Student.query.filter_by(mobile=form.mobile.data).first()
        if not student:
            student = Student(name=form.name.data, reg_number=form.reg_number.data, department=form.department.data, batch_year=form.batch_year.data, mobile=form.mobile.data)
            db.session.add(student)
            db.session.commit()
        elif not student.reg_number:
            student.reg_number = form.reg_number.data
            db.session.commit()
            
        # Register for game
        existing = Registration.query.filter_by(student_id=student.id, game_id=game.id).first()
        if existing:
            flash(f'You are already registered for {game.name}.', 'warning')
        else:
            reg = Registration(student_id=student.id, game_id=game.id)
            db.session.add(reg)
            db.session.commit()
            flash(f'Successfully registered for {game.name}!', 'success')
            return redirect(url_for('student.game_details', game_id=game.id))
            
    registrations = Registration.query.filter_by(game_id=game.id).all()
    return render_template('student/game_details.html', game=game, form=form, registrations=registrations)

@student_bp.route('/fixtures')
def fixtures():
    schedules = Fixture.query.order_by(Fixture.match_date.desc()).all()
    return render_template('student/fixtures.html', fixtures=schedules)

@student_bp.route('/history')
def history():
    events = EventHistory.query.order_by(EventHistory.date.desc()).all()
    return render_template('student/history.html', events=events)
