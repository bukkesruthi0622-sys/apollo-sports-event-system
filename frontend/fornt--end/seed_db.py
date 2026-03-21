from app import create_app
from app.models import db, Admin, Venue, Game
from werkzeug.security import generate_password_hash

app = create_app()

with app.app_context():
    # Only seed if no admins exist
    if Admin.query.count() == 0:
        print("Seeding database...")
        admin = Admin(username='admin', password_hash=generate_password_hash('admin123'), role='superadmin')
        db.session.add(admin)

        v1 = Venue(venue_name='Main Ground', location='North Campus', capacity=2000)
        v2 = Venue(venue_name='Indoor Stadium', location='Sports Complex', capacity=500)
        db.session.add_all([v1, v2])

        db.session.commit()

        g1 = Game(name='Cricket', rules='T20 format, knockout basis', venue_id=v1.id)
        g2 = Game(name='Kabaddi', rules='Standard pro-kabaddi rules', venue_id=v1.id)
        g3 = Game(name='Badminton', rules='Singles and doubles knockout', venue_id=v2.id)
        g4 = Game(name='Volleyball', rules='Best of 3 sets', venue_id=v2.id)
        g5 = Game(name='Chess', rules='Standard time format', venue_id=v2.id)

        db.session.add_all([g1, g2, g3, g4, g5])
        db.session.commit()
        print("Done!")
    else:
        print("Database already seeded.")
