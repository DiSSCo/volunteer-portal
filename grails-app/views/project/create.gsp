<%@ page import="au.org.ala.volunteer.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="${grailsApplication.config.ala.skin}"/>
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title>Create Expedition</title>
    </head>

    <body>

        <content tag="page-header">
            <nav id="breadcrumb">
                <ol>
                    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><a href="${createLink(controller:'admin', action:'index')}"><g:message code="default.admin.label" default="Admin"/></a></li>
                    <li class="last"><g:message code="default.create.label" args="[entityName]" /></li>
                </ol>
            </nav>
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
        </content>

        <div class="row">
            <div class="span12">
                <g:hasErrors bean="${projectInstance}">
                  <div class="errors">
                    <g:renderErrors bean="${projectInstance}" as="list" />
                  </div>
                </g:hasErrors>
                <g:form action="save" >
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="project.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="200" value="${projectInstance?.name}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="project.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'description', 'errors')}">
                                    %{--<g:textArea name="description" cols="40" rows="5" value="${projectInstance?.description}" />--}%
                                    <tinyMce:renderEditor type="advanced" name="description" cols="60" rows="10" style="width:500px;">
                                        ${projectInstance?.description}
                                    </tinyMce:renderEditor>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="project.tutorialLinks.label" default="Tutorial Links" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'tutorialLinks', 'errors')}">
                                    %{--<g:textArea name="tutorialLinks" cols="40" rows="5" value="${projectInstance?.tutorialLinks}" />--}%
                                    <tinyMce:renderEditor type="advanced" name="description" cols="60" rows="10" style="width:500px;">
                                        ${projectInstance?.tutorialLinks}
                                    </tinyMce:renderEditor>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="template"><g:message code="project.template.label" default="Template" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'template', 'errors')}">
                                    <g:select name="template.id" from="${au.org.ala.volunteer.Template.list()}" optionKey="id" value="${projectInstance?.template?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="shortDescription"><g:message code="project.shortDescription.label" default="Short description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'shortDescription', 'errors')}">
                                    <g:textArea name="shortDescription" value="${projectInstance?.shortDescription}" rows="5" cols="100" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="featuredLabel"><g:message code="project.featuredLabel.label" default="Featured Label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'featuredLabel', 'errors')}">
                                    <g:textField name="featuredLabel" value="${projectInstance?.featuredLabel}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="featuredImageCopyright"><g:message code="project.featuredImageCopyright.label" default="Featured Image Copyright (Optional)" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'featuredImageCopyright', 'errors')}">
                                    <g:textField name="featuredImageCopyright" value="${projectInstance?.featuredImageCopyright}" />
                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="featuredOwner"><g:message code="project.featuredOwner.label" default="Featured Owner" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'featuredOwner', 'errors')}">
                                    <g:textField name="featuredOwner" value="${projectInstance?.featuredOwner}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="created"><g:message code="project.created.label" default="Created" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'created', 'errors')}">
                                    <g:datePicker name="created" precision="day" value="${projectInstance?.created}" noSelection="['': '']" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bannerImage"><g:message code="project.bannerImage.label" default="Banner Image" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'bannerImage', 'errors')}">
                                    <g:textField name="bannerImage" value="${projectInstance?.bannerImage}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="showMap"><g:message code="project.showMap.label" default="Show Map" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'showMap', 'errors')}">
                                    <g:checkBox name="showMap" value="${projectInstance?.showMap}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="inactive"><g:message code="project.inactive.label" default="Deactivate this project (will not appear in expedition list if ticked)" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'inactive', 'errors')}">
                                    <g:checkBox name="inactive" value="${projectInstance?.inactive}" />
                                </td>
                            </tr>

                        </tbody>
                    </table>
                    <div class="buttons">
                        <g:submitButton class="btn btn-primary save" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    </div>
                </g:form>
            </div>
        </div>
    </body>
</html>
