--#1
Select Name FROM Grade
--Answer: 1st-5th

--#2
Select Name FROM Emotion
--Answer: anger, fear, sadness, joy

--#3
--Answer: 32842
Select Count(poem.Id) AS 'Poem Count'
From Poem poem

--#4 Sort authors alphabetically by name. What are the names of the top 76 authors?

Select TOP 76 author.Name
From Author author

--#5 Starting with the above query, add the grade of each of the authors.

Select TOP 76 author.Name, grade.Name
From Author author
JOIN Grade grade ON grade.id = author.GradeId

--#6 Starting with the above query, add the recorded gender of each of the authors.

Select TOP 76 author.Name, grade.Name, gender.Name
From Author author
JOIN Grade grade ON grade.id = author.GradeId
JOIN Gender gender ON gender.Id = author.GenderId

--#7 What is the total number of words in all poems in the database?
--Answer: 374584
Select SUM(poem.WordCount) AS 'All Poem Word Count'
From Poem poem

--#8 Which poem has the fewest characters?

Select poem.Title, poem.WordCount
From Poem poem
Where poem.WordCount = (
			SELECT MIN(poem.WordCount)
			From Poem poem)

--#9 How many authors are in the third grade?
--Answer: 2344
Select Count(author.Id)
From Author author
JOIN Grade grade ON grade.id = author.GradeId
WHERE grade.id = 3

--#10 How many authors are in the first, second or third grades?
--Answer: 4404
SELECT Count(author.Id) as 'Author Total'
From Author author 
WHERE author.GradeId < 4


--#11 What is the total number of poems written by fourth graders?
--Answer: 10806
SELECT Count(poem.Id) as 'Total 4th Grader Poems'
From Poem poem 
JOIN Author author ON poem.AuthorId = author.Id
Where author.GradeId = 4

--#12 How many poems are there per grade?
SELECT grade.Name, COUNT(poem.Id) as 'Total Poems'
FROM Grade grade
JOIN Author author ON grade.Id = author.GradeId
JOIN Poem poem ON poem.AuthorId = author.Id
Group by (grade.Name)

--#13 How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT grade.Name, COUNT(author.Id) as 'Total Authors'
FROM Grade grade
JOIN Author author ON grade.Id = author.GradeId
Group by (grade.Name)

--#14 What is the title of the poem that has the most words?
Select poem.Title, poem.WordCount
From Poem poem
Where poem.WordCount = (
			SELECT MAX(poem.WordCount)
			From Poem poem)

--#15 Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT TOP 1 COUNT(poem.Id) AS 'Poem Count', author.Name 
FROM Author author 
JOIN Poem poem ON poem.AuthorId = author.Id
GROUP BY author.Id, author.Name
ORDER BY COUNT(poem.Id) DESC

--#16 How many poems have an emotion of sadness?
SELECT COUNT(poem.Id) AS 'Poem Count'
FROM Poem poem 
JOIN PoemEmotion pe ON pe.PoemId = poem.Id
WHERE pe.EmotionId = 3

--#17 How many poems are not associated with any emotion?
SELECT COUNT(poem.Id) AS 'Poem Count'
FROM Poem poem 
LEFT JOIN PoemEmotion pe ON pe.PoemId = poem.Id
WHERE pe.EmotionId IS NULL  

--#18 Which emotion is associated with the least number of poems? 
--answer: Anger 
SELECT TOP 1 COUNT(pe.EmotionId) AS 'Emotion Count', emotion.Name 
FROM PoemEmotion pe 
JOIN Emotion emotion ON pe.EmotionId = emotion.Id
GROUP BY emotion.Name
ORDER BY 'Emotion Count' 

--#19 Which grade has the largest number of poems with an emotion of joy?
--Answer 5th Grade
SELECT TOP 1 COUNT(pe.PoemId) AS 'Poem Count', grade.Name as 'Grade'
FROM Grade grade 
JOIN Author author ON grade.Id=author.GradeId
JOIN Poem poem ON poem.AuthorId= author.Id
JOIN PoemEmotion pe ON poem.Id = pe.PoemId
Where pe.EmotionId=4
Group By grade.Name
Order by 'Poem Count' DESC

--#20 Which gender has the least number of poems with an emotion of fear? 
--Answer: "Ambiguous"
SELECT TOP 1 COUNT(pe.PoemId) AS 'Poem Count', gender.Name AS 'Gender'
FROM Gender gender 
JOIN Author author ON gender.Id=author.GenderId
JOIN Poem poem ON poem.AuthorId= author.Id
JOIN PoemEmotion pe ON poem.Id = pe.PoemId
Where pe.EmotionId=2
Group By gender.Name
Order by 'Poem Count' 




