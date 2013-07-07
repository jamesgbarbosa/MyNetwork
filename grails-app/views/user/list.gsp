
<%@ page import="com.mynetwork.User" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require modules="application"/>
        <r:require modules="bootstrap"/>
        <r:require modules="bootstrap-responsive-css"/>
	</head>
	<body>
    <div class="row">
        <ul class="thumbnails">
            <g:each in="${users}" status="i" var="it">
                <li class="span2">
                    <g:link class="thumbnail well-light" action="show" id="${it.id}">
                        <img src="${g.createLink(action:'viewAvatar', id: it.id)}" alt="${it.username}" class="avatar"/>
                        <div class="center">
                            <h4>${it.username}</h4>

                            %{--<p>${it.town ?: "&nbsp;"}</p>--}%
                        </div>
                    </g:link>
                </li>
            </g:each>
        </ul>
    </div>
	</body>
</html>
