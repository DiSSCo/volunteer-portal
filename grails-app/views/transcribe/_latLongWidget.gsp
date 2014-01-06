<%@ page import="au.org.ala.volunteer.WebUtils; java.util.regex.Pattern" %>
<%
    def values = WebUtils.parseLatLong(value as String)
%>

<g:set var="latLongFormat" value="${values?.decimalDegrees ? "DD" : "DMS" }" />

<div class="latLongWidget ${cssClass}" targetField="${field.fieldType}" latLongFormat="${latLongFormat}">
    <div class="row-fluid control-group">
        <div class="span12">
            <div class="span4">
                <g:select class="span12 latLongFormatSelector" optionKey="value" optionValue="label" name="${field.fieldType}.format" value="" from="${[[label:"D°M'S\"",value:"DMS"], [label:"Dec. Deg.", value:"DD"]]}" />
            </div>
            <div class="latLongWidget_DMS span8">
                <div class="span4">
                    <g:textField name="${field.fieldType}.degrees" placeholder="D" class="span12 degrees" value="${values.degrees}" validationRule="${field.validationRule}" />
                </div>
                <div class="span2">
                    <g:textField name="${field.fieldType}.minutes" placeholder="M" class="span12 minutes" value="${values.minutes}" validationRule="${field.validationRule}" />
                </div>
                <div class="span2">
                    <g:textField name="${field.fieldType}.seconds" placeholder="S" class="span12 seconds" value="${values.seconds}" validationRule="${field.validationRule}"/>
                </div>
                <div class="span4">
                    <g:if test="${field.fieldType?.toString()?.toLowerCase().contains("lat")}">
                        <g:set var="directionFrom" value="${["", "N", "S"]}" />
                    </g:if>
                    <g:else>
                        <g:set var="directionFrom" value="${["", "E", "W"]}" />
                    </g:else>
                    <g:select class="span12 direction" name="${field.fieldType}.direction" value="${values.direction}" from="${directionFrom}" />
                </div>
            </div>
            <div class="latLongWidget_DD span8" style="display: none">
                <g:textField name="${field.fieldType}.decimalDegrees" class="span12 decimalDegrees" placeholder="Decimal" value="${values.decimalDegrees}" validationRule="${field.validationRule}" />
            </div>
        </div>
    </div>
    <g:hiddenField id="recordValues.0.${field.fieldType}" name="recordValues.0.${field.fieldType}" value="${value}" />
</div>

%{--<div class="row-fluid">--}%
    %{--<div class="span12">--}%
        %{--<small class="muted">${value}</small>--}%
    %{--</div>--}%
%{--</div>--}%

<script>

    $(document).ready(function() {



    });

</script>