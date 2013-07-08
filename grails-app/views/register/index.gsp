<html>

<head>
    <meta name='layout' content='main'/>

    <r:require modules="application"/>
    <r:require modules="bootstrap"/>
    <r:require modules="bootstrap-responsive-css"/>
</head>

<body>

<div class="row">

    <g:if test='${emailSent}'>
        <h3><g:message code='spring.security.ui.register.sent'/></h3>
    </g:if>
    <g:else>

        <g:form action='register' name='registerForm' class="span8">

            <h2><g:message code='spring.security.ui.register.description'/></h2>

            <table>
                <tbody>

                <s2ui:textFieldRow name='username' labelCode='user.username.label' bean="${command}"
                                   size='40' labelCodeDefault='Username' value="${command.username}"/>

                <s2ui:textFieldRow name='email' bean="${command}" value="${command.email}"
                                   size='40' labelCode='user.email.label' labelCodeDefault='E-mail'/>

                <s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${command}"
                                       size='40' labelCodeDefault='Password' value="${command.password}"/>

                <s2ui:passwordFieldRow name='password2' labelCode='user.password2.label' bean="${command}"
                                       size='40' labelCodeDefault='Password (again)' value="${command.password2}"/>

                </tbody>
            </table>

            <s2ui:submitButton class="btn btn-primary" elementId='create' form='registerForm'
                               messageCode='spring.security.ui.register.submit'/>

        </g:form>

    </g:else>

</div>

<script>
    $(document).ready(function () {
        $('#username').focus();
    });
</script>

</body>
</html>
