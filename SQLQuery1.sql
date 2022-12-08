
-------------------------------------------Stored procedures---------------------------------------

-------------------------------------------GetAllPosts---------------------------------------

create procedure GetAllPosts
as
begin
select * from MyPosts;
end
exec GetAllPosts

-------------------------------------------GetAllComments---------------------------------------


create procedure GetAllComments
	@postId int
as 
begin
select * from MyComments where MyComments.postID = @postId;
end
exec GetAllComments @postId = 6

-------------------------------------------GetAllVotes---------------------------------------


create procedure GetAllVotes
	@postId int
as 
begin
select * from MyVotes where MyVotes.postID = @postId;
end
exec GetAllVotes @postId = 6

-------------------------------------------CreatePost---------------------------------------

create procedure CreatePost
	@title varchar(255), @content varchar(1000), @userId int, @userName varchar(100)
as 
Begin
	insert into MyPosts
	Values (@title,@content,GETDATE(),@userId,@userName);
End
exec CreatePost 'Hello Guys','Lorem Ipsum',1,'Ahmad'

-------------------------------------------CreateComment---------------------------------------

create procedure CreateComment
	@postID int, @userName varchar(100), @userId int, @content Varchar(1000)
as 
Begin
	insert into MyComments
	Values (@postID,@userName,@userId,@content,GETDATE());
End
exec CreateComment 6,'Ahmad',1,'Thank you got it'

-------------------------------------------DeletePost---------------------------------------

create procedure DeletePost
	@postId int
As
Begin
	delete from MyPosts where MyPosts.id = @postID;
End
exec DeletePost @postId = 5

-------------------------------------------EditPost---------------------------------------

create procedure EditPost
	@postId int,@title varchar(255), @content varchar(1000)
As
Begin
	update MyPosts
	set title = @title,
	content = @content
	where id = @postId
End
exec EditPost 6, 'Hello edit', 'lorem ipsum edit'

-------------------------------------------DeleteComment---------------------------------------

create procedure DeleteComment
	@commentId int
As
Begin
	delete from MyComments where MyComments.id = @commentID;
End
exec DeleteComment @commentId = 12

-------------------------------------------EditComment---------------------------------------

create procedure EditComment
	@commentId int, @content varchar(1000)
As
Begin
	update MyComments
	set content = @content
	where id = @commentId
End
exec EditComment 13, 'Edited'

-------------------------------------------Vote---------------------------------------

create procedure Vote
	@postId int, @voteType varchar(10), @userId int
As
Begin
	if exists (select * from MyVotes where userID = @userId and postID = @postId and voteType = @voteType)
		begin
			delete from MyVotes where userID = @userId and postID = @postId;
		End
	else if exists (select * from MyVotes where userID = @userId and postID = @postId)
		begin
			update MyVotes set voteType = @voteType where userID = @userId and postID = @postId;
		end
	else
		Begin
			insert into MyVotes values(@postId, @userId, @voteType);
		End
End

exec Vote 6,'Down',1

