<%@ page import="com.mynetwork.Profile" %>



<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="profile.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" maxlength="50" required="" value="${profileInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'country', 'error')} ">
	<label for="country">
		<g:message code="profile.country.label" default="Country" />
		
	</label>
	<g:textField name="country" maxlength="60" value="${profileInstance?.country}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'town', 'error')} ">
	<label for="town">
		<g:message code="profile.town.label" default="Town" />
		
	</label>
	<g:textField name="town" maxlength="60" value="${profileInstance?.town}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'gender', 'error')} ">
	<label for="gender">
		<g:message code="profile.gender.label" default="Gender" />
		
	</label>
	<g:select name="gender" from="${com.mynetwork.Gender?.values()}" keys="${com.mynetwork.Gender.values()*.name()}" value="${profileInstance?.gender?.name()}" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'info', 'error')} ">
	<label for="info">
		<g:message code="profile.info.label" default="Info" />
		
	</label>
	<g:textArea name="info" cols="40" rows="5" maxlength="4000" value="${profileInstance?.info}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'yearBorn', 'error')} ">
	<label for="yearBorn">
		<g:message code="profile.yearBorn.label" default="Year Born" />
		
	</label>
	<g:field type="number" name="yearBorn" value="${profileInstance.yearBorn}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'avatar', 'error')} ">
	<label for="avatar">
		<g:message code="profile.avatar.label" default="Avatar" />
		
	</label>
	<input type="file" id="avatar" name="avatar" />
</div>

<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'avatarType', 'error')} ">
	<label for="avatarType">
		<g:message code="profile.avatarType.label" default="Avatar Type" />
		
	</label>
	<g:textField name="avatarType" value="${profileInstance?.avatarType}"/>
</div>

