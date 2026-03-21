from flask import Blueprint, render_template, request, flash, redirect, url_for
from flask_login import login_required, current_user
from app.models import db, Game, Registration, Attendance

volunteer_bp = Blueprint('volunteer', __name__, url_prefix='/volunteer')

@volunteer_bp.route('/attendance/<int:game_id>', methods=['GET', 'POST'])
@login_required # In a real app, verify they have volunteer/admin privileges
def attendance(game_id):
    if current_user.role not in ['admin', 'volunteer', 'superadmin']:
        flash('Access denied.', 'danger')
        return redirect(url_for('index'))
        
    game = Game.query.get_or_404(game_id)
    registrations = Registration.query.filter_by(game_id=game.id).all()
    
    if request.method == 'POST':
        for reg in registrations:
            status = request.form.get(f'status_{reg.student_id}')
            if status:
                att = Attendance.query.filter_by(student_id=reg.student_id, game_id=game.id).first()
                if not att:
                    att = Attendance(student_id=reg.student_id, game_id=game.id, marked_by=current_user.id)
                    db.session.add(att)
                att.status = status
        db.session.commit()
        flash('Attendance updated successfully.', 'success')
        return redirect(url_for('volunteer.attendance', game_id=game.id))
        
    attendance_records = {att.student_id: att.status for att in Attendance.query.filter_by(game_id=game.id).all()}
    
    return render_template('volunteer/attendance.html', game=game, registrations=registrations, attendance_records=attendance_records)
