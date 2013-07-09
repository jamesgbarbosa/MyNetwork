
<%@ page import="com.mynetwork.Profile" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'profile.label', default: 'Profile')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-profile" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-profile" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="country" title="${message(code: 'profile.country.label', default: 'Country')}" />
					
						<g:sortableColumn property="town" title="${message(code: 'profile.town.label', default: 'Town')}" />
					
						<g:sortableColumn property="gender" title="${message(code: 'profile.gender.label', default: 'Gender')}" />
					
						<g:sortableColumn property="info" title="${message(code: 'profile.info.label', default: 'Info')}" />
					
						<g:sortableColumn property="yearBorn" title="${message(code: 'profile.yearBorn.label', default: 'Year Born')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${profileInstanceList}" status="i" var="profileInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: profileInstance, field: "country")}</td>
					
						<td>${fieldValue(bean: profileInstance, field: "town")}</td>
					
						<td>${fieldValue(bean: profileInstance, field: "gender")}</td>
					
						<td>${fieldValue(bean: profileInstance, field: "info")}</td>
					
						<td>${fieldValue(bean: profileInstance, field: "yearBorn")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${profileInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
