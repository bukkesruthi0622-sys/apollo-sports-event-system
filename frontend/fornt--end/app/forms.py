from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, HiddenField, SelectField
from wtforms.validators import DataRequired, EqualTo

class AdminLoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Login')

class StudentRegistrationForm(FlaskForm):
    name = StringField('Full Name', validators=[DataRequired()])
    reg_number = StringField('Registration / Roll No:', validators=[DataRequired()])
    department = StringField('Department', validators=[DataRequired()])
    batch_year = SelectField('Batch/Year', choices=[
        ('1st Year', '1st Year'),
        ('2nd Year', '2nd Year'),
        ('3rd Year', '3rd Year'),
        ('4th Year', '4th Year'),
        ('Other', 'Other')
    ], validators=[DataRequired()])
    mobile = StringField('Mobile Number', validators=[DataRequired()])
    game_id = HiddenField('Game ID', validators=[DataRequired()])
    submit = SubmitField('Register Now')
