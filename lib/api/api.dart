class Api {

  static const String BASE_URL = "http://192.168.1.11:9024/makefriends";

  static const String WEBSOCKET_URL = "ws://192.168.1.11:9024/makefriends";

  static const String LOGIN = "/user/login";

  static const String REGISTER = "/user/register";

  static const String GETUSERINFOBYID = "/user/getUserInfoById";

  static const String GETTOPICSBYCONTENTTYPE = "/topic/getTopicsByContentType";

  static const String GETTOPICSBYCONTENTTYPEANDCREATORID = "/topic/getTopicsByContentTypeAndCreatorId";

  static const String ADDLIKES = "/topic/addLikes";

  static const String GETCOMMENTS = "/comment/getCommentsByTopicId";

  static const String ADDCOMMENTS = "/comment/addComment";

  static const String ADDTOPIC = "/topic/addTopic";

  static const String CHANGEPASSWORD = "/user/changePassword";

  static const String GETBASICINFO = "/user/getBasicInfo";

  static const String GETLEAVEMESSAGE = "/leaveMessage/getLeaveMessageByCreateFor";

  static const String GETMEMORYDAY = "/commemorationDay/getDays";

  static const String ADDDAYS = "/commemorationDay/addDays";

  static const String GETALLSTUDYGOALS = "/studyGoal/getStudyGoals";

  static const String GETSTUDYGOALSBYCREATORID = "/studyGoal/getStudyGoalsByCreatorId";

  static const String ADDSTUDYGOAL = "/studyGoal/addStudyGoal";

  static const String EDITUSERINFO = "/user/editUser";

  static const String GETTOKEN = "/user/getToken";

  static const String FOCUSON = "/follower/addFollower";

  static const String GETCONNECTION = "/follower/getConnection";

  static const String DELETECONNECTION = "/follower/deleteConnection";

  static const String GETBEWATCHEDUSERINFO = "/follower/getBewatchedUserInfo";

  static const String ADDLEAVEMESSAGE = "/leaveMessage/addLeaveMessage";

  static const String GETUSERSBYNICKNAME = "/user/getUserByUsername";
}