use accenture_proj;

select * from content;
select * from reactiontypes;
select * from reactions;

describe content;
describe reactiontypes;
describe reactions;

ALTER table content drop column User_ID;
ALTER table content rename column Type to Content_type;

ALTER table reactions drop column User_ID;
ALTER table reactions rename column Type to reaction_type;
ALTER table reactions drop column User_ID;

create table model1 as
SELECT c.Content_ID, c.Content_type, c.Category, c.URL, r.User_ID, r.reaction_type, r.Datetime
FROM content c
INNER JOIN reactions r ON c.Content_ID = r.Content_ID;

create table model2 as 
SELECT m.*, r.Sentiment, r.Score
FROM model1 m
INNER JOIN reactiontypes r ON m.reaction_type = r.Type;


select * from model3;

SELECT total_score,
       RANK() OVER (ORDER BY total_score DESC) AS Score_Rank
FROM model3;


create table scores select distinct(total_score) as scores from model3 order by total_score desc;

ALTER TABLE scores
ADD Score_Rank INT; -- Adding a new column to store the rank

select * from model3;
alter table model3 
add score_rank int;

create table scores1 select scores, rank() over(order by scores desc) as rank_no from scores;



SELECT scores, RANK() OVER (ORDER BY scores DESC) AS Number_Rank FROM score;

SELECT m.Category, m.total_score, s.rank_no from model3 m
inner join scores1 s
on m.total_score=s.scores;


