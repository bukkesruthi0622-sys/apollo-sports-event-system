Final Output of Day-1 Testing

game_rules.md ✔
Basic understanding of system ✔

# Game Rules

## General Rules
1. All players must register before the game.
2. Each player can participate in multiple games.
3. Fair play must be followed.
4. Misconduct leads to disqualification.

## Cricket
- 11 players per team
- 10 overs match
- Team with highest runs wins

## Kabaddi
- 7 players per team
- Raid time: 30 seconds
- Match duration: 20 minutes per half

## Volleyball
- 6 players per team
- Best of 3 sets
- First to 25 points wins a set

## Badminton
- Singles match
- Played up to 21 points
- Best of 3 sets

## Result Rules
- Winner is decided based on score
- Results will be stored in the system

#Understand System Flow (VERY IMPORTANT)
Landing Page → Events → Game → Registration

#Identify What to Test (Basic Thinking)
They should note:

What happens when user registers?
What happens if data is missing?
What should be shown on game page?

#Check Frontend (Basic)
If frontend is ready, they should check:

Does page open?
Are buttons working?
Are links correct.

Sports Rules Reference
College Sports Event Management App
Official Rules for Cricket · Kabaddi · Volleyball · Badminton

🏏  Cricket
Players	11 per team on the field
Format	Fixed overs (e.g. 10 overs per team)
1 Over	6 legal deliveries by one bowler
Win condition	Team with more runs at the end wins

Match Basics
•	Match begins with a coin toss between the two captains.
•	The toss winner chooses to bat first or bowl first.
•	The batting team tries to score as many runs as possible.
•	The bowling team tries to dismiss batsmen and limit runs.
•	Each team plays one innings.
•	After one over, a new bowler bowls from the opposite end.
•	When 10 batsmen are out, the innings ends.
•	The team with more runs wins. Equal runs = tie or super over.

Scoring Runs
•	1 run: batsmen run between the two wickets after hitting the ball.
•	Multiple runs possible if batsmen complete more trips before the ball is returned.
•	4 runs: ball crosses the boundary after bouncing on the ground.
•	6 runs: ball clears the boundary without touching the ground.
•	Wide ball: delivery outside the batsman's reach = +1 extra run.
•	No-ball: bowler oversteps the crease = +1 extra run.

Ways to Get Out (Dismissals)
•	Bowled — ball hits the stumps and dislodges the bails.
•	Caught — fielder catches the ball before it touches the ground.
•	Run out — fielding team hits the stumps before the batsman reaches the crease while running.
•	LBW (Leg Before Wicket) — ball hits the batsman's leg in front of the stumps and the umpire judges it would have hit the stumps.
•	Stumped — wicketkeeper removes bails while batsman is outside the crease and not attempting a run.

🤼  Kabaddi
Players	7 per team on the court + substitutes on bench
Format	Two halves of 20 minutes each with a short break
Objective	Score more points than the opposing team
Win condition	Team with the most points at the end wins

Match Basics
•	Coin toss decides which team raids or defends first.
•	Match is played in two halves of 20 minutes each with a short break.
•	A player who is declared out must leave the court.
•	A player from the out list can re-enter when their team scores a point.
•	If all 7 players of one team are out, the opponent earns extra points (All Out).
•	Team with the most points at the end of the match wins.

Raiding Rules
•	The raider from the attacking team enters the opponent's half alone.
•	The raider must continuously chant 'Kabaddi, Kabaddi' throughout the raid.
•	Each defender tagged by the raider = 1 point for the attacking team.
•	The raider must return safely to their own half to earn the points.
•	If the raider is caught by defenders and cannot return = 1 point for the defending team.
•	If any player steps outside the boundary line, that player is declared out.

🏐  Volleyball
Players	6 per team on court + substitutes on bench
Format	Best of 5 sets
Set win	First to 25 points with at least a 2-point lead
Match win	First team to win 3 sets

Match Basics
•	Coin toss; winner chooses to serve first or pick a side of the court.
•	A team must score 25 points to win a set with at least a 2-point lead.
•	If both teams reach 24–24, play continues until one team leads by 2 points.
•	The team that wins 3 sets first wins the match.
•	After winning back the serve, players must rotate clockwise before serving.

Play Rules
•	The ball must cross the net into the opponent's court to continue play.
•	Each team is allowed a maximum of 3 touches to return the ball over the net.
•	Typical sequence: pass → set → spike.
•	A player cannot touch the ball twice consecutively, except during a block.
•	Ball landing inside the opponent's court = point for the attacking team.
•	Ball landing outside the boundary lines = point for the opposing team.
•	Touching the net during play = fault.

🏸  Badminton
Players	Singles (1 per side) or Doubles (2 per side)
Format	Best of 3 sets
Set win	First to 21 points with at least a 2-point lead
Match win	First player/team to win 2 sets

Match Basics
•	Toss winner chooses to serve first or select a side of the court.
•	Each set is played up to 21 points; must win by at least 2 points.
•	If the score reaches 20–20, play continues until one side leads by 2 points.
•	If the score reaches 29–29, the side that scores the 30th point wins the set.
•	The player or team that wins 2 sets first wins the match.

Play Rules
•	Shuttle landing inside the opponent's court = point.
•	Shuttle landing outside the court boundary = opponent's point.
•	Shuttle hitting the net and falling back = opponent's point.
•	During service, the shuttle must be hit below the server's waist level.
•	Players must not touch the net with their racket or body during play.
•	Umpires and line judges supervise the match and ensure all rules are followed.
•	Players must respect the umpire's decisions and maintain fair play.


All players must follow fair play and respect referee/umpire decisions in all sports.
