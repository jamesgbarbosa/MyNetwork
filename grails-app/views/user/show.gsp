
<%@ page import="com.mynetwork.User" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
        <r:require modules="application"/>
        <r:require modules="bootstrap"/>
        <r:require modules="bootstrap-responsive-css"/>
        <r:require module="fileuploader" />

		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>

        <g:javascript>
            function followLoading() {
                $('.followBtn').attr("disabled", "true");
            }

            function followComplete() {
                $('.followBtn').removeAttr("disabled");
                if ($('.followBtn').text().indexOf("Stop") != -1) {
                    $('.followBtn').text("Follow");
                } else {
                    $('.followBtn').text("Stop following");
                }
            }

            $(function() {
                $('#profileEdit').bind('hidden', function () {
                    $('.qq-upload-button').css("display", "block");
                });
            });

        </g:javascript>

	</head>
	<body>
    <div class="row">
        <h2>${user.username}
        <sec:ifLoggedIn>
            <g:if test="${user.id != loggedUserId}">
                <g:remoteLink action="followToggle" id="${user.id}" update="ajaxMessage" onLoading="followLoading();"
                              onComplete="followComplete();" class="btn btn-primary followBtn">
                    <g:followIndicator user="${user}" followText="Follow" stopFollowText="Stop following"/>
                </g:remoteLink>
            </g:if>
        </sec:ifLoggedIn>
        </h2>
    </div>

    %{--Dialog box for editing the user--}%
    <g:if test="${user.id == loggedUserId}">
        <div id="profileEdit" class="modal hide fade in" style="display: none; ">
            <g:form action="update" id="${user.id}" style="margin:0; padding:0">
                <div class="modal-header">
                    <a class="close" data-dismiss="modal">×</a>

                    <h3>Edit your profile</h3>
                </div>

                <div class="modal-body">
                    <div class="pull-right">
                        <img id="tmpAvatar" src="${g.createLink(action:'viewAvatar', id: user.id)}" alt="${user.username}" class="avatar"/>
                        <uploader:uploader id="${user.id}" params="${[userId: user.id]}" sizeLimit="10000" multiple="false" allowedExtensions="${"['jpeg', 'jpg']"}"  url="${[action:'uploadAvatar']}">
                            <uploader:onComplete>
                                d = new Date();
                               $('#tmpAvatar').attr("src", "${g.createLink(action:'viewAvatar', id: user.id, params: [temporary: true])}&d=" + d.getTime() + Math.random());
                            $('.qq-upload-button').css("display", "none");
                            </uploader:onComplete>
                        </uploader:uploader>
                    </div>
                    <table>
                        <tr><td>Gender:</td><td><g:select from="${['MALE', 'FEMALE']}" name="gender" value="${user.profile.gender?.id ?: 'MALE'}" class="input-small"/></td><td>Born:</td><td><g:select from="${(1900..2010).reverse()}" name="yearBorn" value="${user.profile.yearBorn ?: 1980}" class="input-small"/></td></tr>
                        <tr><td>Country:</td><td colspan="3"><g:textField name="country" value="${user.profile.country}"/></td></tr>
                        <tr><td>Town:</td><td colspan="3"><g:textField name="town" value="${user.profile.town}"/></td></tr>
                        %{--<tr><td>Info:</td><td colspan="3"><g:textArea name="info" value="${user.profile.info}"/></td></tr>--}%
                    </table>
                </div>

                <div class="modal-footer">
                    <g:submitButton class="btn btn-primary" name="Save"/>
                    <a href="#" class="btn" data-dismiss="modal">Close</a>
                </div>
            </g:form>
        </div>
    </g:if>

    %{--User description--}%
    <div class="row">
        <div class="well">
            <p class="pull-right">
                <img src="${g.createLink(action:'viewAvatar', id: user.id)}" alt="${user.username}" class="avatar"/>
            </p>

            <p>Gender: <strong>${user.profile.gender ?: "?"}</strong></p>
            <p>Born: <strong>${user.profile.yearBorn  ?: "?"}</strong></p>
            <p>Country: <strong>${user.profile.country  ?: "?"}</strong></p>
            <p>Town: <strong>${user.profile.town ?: "?"}</strong></p>
            <g:if test="${user.profile.info}">
                <br/>

                <p>More about ${user.username}: <strong>${user.profile.info}</strong></p>
            </g:if>
            <g:if test="${user.id == loggedUserId}">
                <a data-toggle="modal" href="#profileEdit" class="btn"><i class="icon-align-justify"></i> Edit Profile</a>
            </g:if>
        </div>
    </div>
	</body>
</html>
