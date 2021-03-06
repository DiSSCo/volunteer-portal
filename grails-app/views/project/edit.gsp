<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="au.org.ala.volunteer.Project" %>

<g:set var="initZoom" value="${projectInstance.mapInitZoomLevel ?: 3}"/>
<g:set var="initLatitude" value="${projectInstance.mapInitLatitude ?: -24.766785}"/>
<g:set var="initLongitude" value="${projectInstance.mapInitLongitude ?: 134.824219}"/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="${grailsApplication.config.ala.skin}"/>
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
    <link rel="stylesheet" href="${resource(file: '/css/vp.css')}"/>

    <script type='text/javascript' src='https://www.google.com/jsapi'></script>

    <style type="text/css">

    .table tr td {
        border: none;
    }

    #recordsMap {
        width: 280px;
        height: 280px;
        max-height: 280px;
        max-width: 280px;
        margin: 0px 0;
    }

    #recordsMap img {
        max-width: none;
        max-height: none;
    }

    </style>

</head>

<body>
<cl:headerContent title="${message(code: 'default.edit.label', args: [entityName])} - ${projectInstance.name}"
                  selectedNavItem="expeditions">
    <%
        pageScope.crumbs = [
                [link: createLink(controller: 'project', action: 'index', id: projectInstance.id), label: projectInstance.i18nName]
        ]
    %>
</cl:headerContent>

<div class="row">
    <div class="span12">
        <g:hasErrors bean="${projectInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectInstance}" as="list"/>
            </div>
        </g:hasErrors>
        <g:form method="post">
            <g:hiddenField name="id" value="${projectInstance?.id}"/>
            <g:hiddenField name="version" value="${projectInstance?.version}"/>

            <g:render template="projectDetailsTable" model="${[projectInstance: projectInstance]}"/>

            <div style="margin: 10px">
                <g:actionSubmit class="save btn btn-primary" action="update"
                                value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                <g:actionSubmit class="delete btn btn-danger" action="delete"
                                value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
            </div>
        </g:form>
    </div>
</div>

<div class="row">
    <div class="span12">
        <table class="table">
            <thead><tr><td colspan="3">Other Settings</td></tr></thead>
            <tr>
                <td style="vertical-align: middle;padding:20px">
                    <label><strong><g:message code="project.featuredImage.label" default="Featured Image"/></strong>
                    </label>
                </td>
                <td style="padding: 20px">
                    <img src="${projectInstance?.featuredImage}" align="middle"/>
                </td>
                <td style="vertical-align: middle;padding: 20px">
                    <g:form action="uploadFeaturedImage" controller="project" method="post"
                            enctype="multipart/form-data">
                        <input type="file" name="featuredImage"/>
                        <input type="hidden" name="id" value="${projectInstance.id}"/>
                        <g:submitButton class="btn btn-small btn-primary" name="Upload"/>
                        <a href="${createLink(action: 'resizeExpeditionImage', id: projectInstance.id)}"
                           class="btn btn-small"><g:message code="project.edit.resize_image"/></a>
                    </g:form>
                    <br/>

                    <div class="alert alert-danger">
                        <g:message code="project.edit.resize_image.description"/>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <strong><g:message code="project.edit.map.initial_position"/></strong>
                </td>
                <td>
                    <div id="recordsMap">
                    </div>
                </td>
                <td>
                    <g:message code="project.edit.map.initial_position.description"/>
                    <g:form action="updateMapSettings" class="form-horizontal">
                        <g:hiddenField name="projectId" value="${projectInstance.id}"/>
                        <div class="control-group">
                            <label class="control-label" for="mapZoomLevel"><g:message code="default.zoom.label"/></label>

                            <div class="controls">
                                <g:textField name="mapZoomLevel" value="${initZoom}"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="mapLatitude"><g:message code="project.map_settings.map.center_latitude"/>:</label>

                            <div class="controls">
                                <g:textField name="mapLatitude" value="${initLatitude}"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="mapLongitude"><g:message code="project.map_settings.map.center_longitude"/>:</label>

                            <div class="controls">
                                <g:textField name="mapLongitude" value="${initLongitude}"/>
                            </div>
                        </div>
                        <button id="btnUpdateMap" type="button" class="btn btn-small"><i
                                class="icon-arrow-left"></i>&nbsp;<g:message code="project.edit.map.update_from_fields"/></button>
                        <button type="submit" class="btn btn-small btn-primary"><g:message code="project.edit.map.save"/></button>
                    </g:form>
                </td>
            </tr>

        </table>
    </div>
</div>
<asset:javascript src="tinymce-simple" asset-defer=""/>
<asset:script type="text/javascript">

    function confirmDeleteAllTasks() {
        return confirm("${message(code: 'project.delete.all.tasks', args: [taskCount, projectInstance.i18nName])}");
            }

            google.load("maps", "3.23", {other_params: ""});
            var map, infowindow;
            var mapListenerActive = true;

            function loadMap() {

                var mapElement = $("#recordsMap");

                if (!mapElement) {
                    return;
                }

                var myOptions = {
                    scaleControl: false,
                    center: new google.maps.LatLng(${initLatitude}, ${initLongitude}),
                    zoom: ${initZoom},
                    minZoom: 1,
                    streetViewControl: false,
                    scrollwheel: true,
                    mapTypeControl: false,
                    navigationControl: true,
                    navigationControlOptions: {
                        style: google.maps.NavigationControlStyle.SMALL // DEFAULT
                    },
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                map = new google.maps.Map(document.getElementById("recordsMap"), myOptions);

                google.maps.event.addListener(map, 'zoom_changed', function() {
                    if (mapListenerActive) {
                        updateFieldsFromMap();
                    }
                });

                google.maps.event.addListener(map, 'center_changed', function() {
                    if (mapListenerActive) {
                        updateFieldsFromMap();
                    }
                });
            }

            function updateFieldsFromMap() {
                var zoomLevel = map.getZoom();

                $("#mapZoomLevel").val(zoomLevel);

                var center = map.getCenter();
                $("#mapLatitude").val(center.lat());
                $("#mapLongitude").val(center.lng());
            }

            function updateMapFromFields() {

                try {
                    mapListenerActive = false;
                    map.setZoom(parseInt($('#mapInitZoomLevel').val()));
                    var lat =  parseFloat($("#mapLatitude").val());
                    var lng = parseFloat($("#mapLongitude").val());
                    map.setCenter(new google.maps.LatLng(lat, lng));
                } finally {
                    mapListenerActive = true;
                }
            }

            $(document).ready(function() {
                loadMap();
                updateFieldsFromMap();

                $("#btnUpdateMap").click(function(e) {
                    e.preventDefault();
                    updateMapFromFields();
                });
            });

</asset:script>
</body>
</html>
