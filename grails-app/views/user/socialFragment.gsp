<%@ page contentType="text/html; charset=UTF-8" %>
<style>
.forumPostTitle {
    font-weight: bold;
}

.forumPostDate {
    font-size: 0.8em;
}

.forumPostMessage {
    font-style: italic;
}

</style>

<div class="row-fluid">

    <div class="span6">
        <h3><g:message code="user.social.recent_forum_posts" /></h3>
        <ul class="nav nav-tabs nav-stacked">
            <g:each in="${recentPosts}" var="post">
                <li>
                    <div class="well well-small">
                        <div class="forumPostTitle">
                            <g:message code="user.social.topic" /> <a
                                href="${createLink(controller: 'forum', action: 'viewForumTopic', id: post.topic.id)}">${post.topic.title}</a>
                        </div>

                        <div class="forumPostDate">
                            <g:message code="user.social.posted_on" args="${[post.date?.format("dd MMM, yyyy")]}" />
                        </div>

                        <div class="forumPostMessage">
                            ${post.text}
                        </div>
                    </div>
                </li>
            </g:each>
        </ul>
    </div>

    <div class="span6">
        <div class="row-fluid">
            <div class="span12">
                <h3><g:message code="user.social.forul_topics_you_are_watching" /></h3>
                <ul class="nav nav-tabs nav-stacked">
                    <g:each in="${watchedTopics}" var="topic">
                        <li>
                            <div class="forumPostTitle">
                                <a href="${createLink(controller: 'forum', action: 'viewForumTopic', id: topic.id)}">${topic.title}</a>
                            </div>
                        </li>
                    </g:each>
                </ul>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <H3><g:message code="user.social.friends" /></H3>
                <ul>
                    <g:each in="${friends}" var="friend">
                        <li><a href="${createLink(controller: "user", action: "show", id: friend.id)}"><cl:userDetails
                                id="${friend.userId}" displayName="true"/></a></li>
                    </g:each>
                </ul>
            </div>
        </div>
    </div>

</div>