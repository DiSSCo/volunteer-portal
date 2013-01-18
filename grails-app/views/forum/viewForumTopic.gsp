<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Volunteer Portal - Atlas of Living Australia</title>
        <meta name="layout" content="${grailsApplication.config.ala.skin}"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'vp.css')}"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'forum.css')}"/>
        <script type="text/javascript" src="${resource(dir: 'js/fancybox', file: 'jquery.fancybox-1.3.4.pack.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/fancybox', file: 'jquery.fancybox-1.3.4.css')}"/>

        <style type="text/css">

        .buttonBar {
            margin-bottom: 10px;
        }

        .button {
            height: 30px;
        }

        </style>

    </head>

    <body class="sublevel sub-site volunteerportal">

        <script type="text/javascript">

            $(document).ready(function () {

                $("#btnReply").click(function (e) {
                    e.preventDefault();
                    window.location = "${createLink(controller:'forum', action:'postMessage', params: [topicId:topic.id])}";
                });

                $("#btnReturnToForum").click(function(e) {
                    e.preventDefault();
                    window.location = "${createLink(controller:'forum', action:'redirectTopicParent', id: topic.id)}";
                });

            });

        </script>

        <cl:navbar selected=""/>

        <header id="page-header">
            <div class="inner">
                <cl:messages/>
                <vpf:forumNavItems topic="${topic}" />
            </div>
        </header>

        <div>
            <div class="inner">
                <div class="buttonBar">
                    <button id="btnReturnToForum" class="button"><img src="${resource(dir: 'images', file: 'left_arrow.png')}"/>&nbsp;Return to forum</button>
                    <g:if test="${!topic.locked}">
                        <button id="btnReply" class="button"><img src="${resource(dir: 'images', file: 'reply.png')}"/>&nbsp;Post Reply</button>
                    </g:if>
                </div>

                <vpf:topicMessagesTable topic="${topic}"/>

            </div>
        </div>
    </body>
</html>
