package au.org.ala.volunteer

class ForumTopic {

    Date dateCreated
    User creator
    String title
    Boolean sticky
    Boolean locked
    ForumTopicPriority priority = ForumTopicPriority.Normal
    Integer views = 0
    Boolean deleted
    Date lastReplyDate

    static belongsTo = [creator: User]

    static hasMany = [ messages: ForumMessage ]

    static constraints = {
        dateCreated nullable: false
        creator nullable: false
        title nullable: false
        sticky nullable:  true
        locked nullable:  true
        priority nullable: true
        views nullable: true
        deleted nullable: true
        lastReplyDate nullable: true
    }

    static mapping = {
        priority enumType:"ordinal"
    }

}