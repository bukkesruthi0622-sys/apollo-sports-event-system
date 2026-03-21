from flask import Blueprint, render_template, request, flash, redirect, url_for
from flask_login import login_required, current_user
from app.models import db, Game, Score, Fixture, Registration, Student
from datetime import datetime

admin_bp = Blueprint('admin', __name__, url_prefix='/admin')

@admin_bp.route('/dashboard')
@login_required
def dashboard():
    return render_template('admin/dashboard.html')

@admin_bp.route('/events', methods=['GET', 'POST'])
@login_required
def manage_events():
    if request.method == 'POST':
        name = request.form.get('name')
        rules = request.form.get('rules')
        new_game = Game(name=name, rules=rules)
        db.session.add(new_game)
        db.session.commit()
        flash('Game added successfully!', 'success')
        return redirect(url_for('admin.manage_events'))
    
    games = Game.query.all()
    return render_template('admin/events.html', games=games)

@admin_bp.route('/events/delete/<int:game_id>', methods=['POST'])
@login_required
def delete_event(game_id):
    game = Game.query.get_or_404(game_id)
    
    from app.models import Attendance, Volunteer
    Registration.query.filter_by(game_id=game.id).delete()
    Score.query.filter_by(game_id=game.id).delete()
    Fixture.query.filter_by(game_id=game.id).delete()
    Attendance.query.filter_by(game_id=game.id).delete()
    
    volunteers = Volunteer.query.filter_by(assigned_game_id=game.id).all()
    for v in volunteers:
        v.assigned_game_id = None
        
    db.session.delete(game)
    db.session.commit()
    flash('Event and all connected data deleted successfully!', 'success')
    return redirect(url_for('admin.manage_events'))

@admin_bp.route('/registrations')
@login_required
def view_registrations():
    query = Registration.query.join(Student)
    
    dept_filter = request.args.get('department')
    game_filter = request.args.get('game_id')
    
    if dept_filter:
        query = query.filter(Student.department.contains(dept_filter))
    if game_filter:
        query = query.filter(Registration.game_id == game_filter)
        
    registrations = query.order_by(Registration.registered_at.desc()).all()
    games = Game.query.all()
    return render_template('admin/registrations.html', registrations=registrations, games=games)

@admin_bp.route('/scores', methods=['GET', 'POST'])
@login_required
def manage_scores():
    if request.method == 'POST':
        game_id = request.form.get('game_id')
        team_a = request.form.get('team_a')
        team_b = request.form.get('team_b')
        score_a = request.form.get('score_a')
        score_b = request.form.get('score_b')
        
        new_score = Score(game_id=game_id, team_a=team_a, team_b=team_b, score_a=score_a, score_b=score_b, updated_by=current_user.id)
        db.session.add(new_score)
        db.session.commit()
        flash('Score updated successfully!', 'success')
        return redirect(url_for('admin.manage_scores'))
        
    games = Game.query.all()
    scores = Score.query.order_by(Score.updated_at.desc()).all()
    return render_template('admin/scores.html', games=games, scores=scores)

@admin_bp.route('/fixtures', methods=['GET', 'POST'])
@login_required
def manage_fixtures():
    if request.method == 'POST':
        game_id = request.form.get('game_id')
        team_a = request.form.get('team_a')
        team_b = request.form.get('team_b')
        match_date_str = request.form.get('match_date')
        match_time_str = request.form.get('match_time')
        
        match_date = datetime.strptime(match_date_str, '%Y-%m-%d').date()
        match_time = datetime.strptime(match_time_str, '%H:%M').time()
        
        new_fixture = Fixture(game_id=game_id, team_a=team_a, team_b=team_b, match_date=match_date, match_time=match_time)
        db.session.add(new_fixture)
        db.session.commit()
        flash('Fixture scheduled successfully!', 'success')
        return redirect(url_for('admin.manage_fixtures'))
        
    games = Game.query.all()
    fixtures = Fixture.query.order_by(Fixture.match_date.desc()).all()
    return render_template('admin/fixtures.html', games=games, fixtures=fixtures)

@admin_bp.route('/fixtures/delete/<int:fixture_id>', methods=['POST'])
@login_required
def delete_fixture(fixture_id):
    fixture = Fixture.query.get_or_404(fixture_id)
    db.session.delete(fixture)
    db.session.commit()
    flash('Fixture deleted successfully!', 'success')
    return redirect(url_for('admin.manage_fixtures'))
