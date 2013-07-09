<g:if test="${posts}">
    <div class="row span8">
        <div class="well">
            <g:each in="${posts}">
                <div class="well well-light">
                    <div class="pull-right"><prettytime:display date="${it.dateCreated}" /></div>
                    <div class="pull-left" style="width:60px; padding-right: 15px;">
                        <img src="${g.createLink(controller: 'user', action:'viewAvatar', id: it.user.id)}" alt="${it.user.username}" class="smallAvatar"/>
                    </div>
                    <p><i class="icon-comment"></i> <g:link controller="user" action="show" id="${it.user.id}">${it.user.username}</g:link> wrote:</p>
                    <p>${it.text}</p>
                    <sec:ifAnyGranted roles="ROLE_ADMIN"><g:link class="btn btn-mini" action="edit" controller="post" id="${it.id}"> <i class='icon-edit'></i> Edit</g:link></sec:ifAnyGranted>
                </div>
            </g:each>
        </div>
    </div>
</g:if>