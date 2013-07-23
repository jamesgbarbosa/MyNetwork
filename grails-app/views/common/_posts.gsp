<g:if test="${posts}">
    <div id="postDiv" class="row span7">
        <g:each in="${posts}">
            <div class="well well-light ${newpost}" id="post${it.id}">
                <div class="pull-right"><prettytime:display date="${it.dateCreated}" /></div>
                <div class="pull-left" style="width:60px; padding-right: 15px;">
                    <img src="${g.createLink(controller: 'user', action:'viewAvatar', id: it.user.id)}" alt="${it.user.username}" class="smallAvatar"/>
                </div>
                <p><i class="icon-comment"></i> <g:link controller="user" action="show" id="${it.user.id}">${it.user.username}</g:link> wrote:</p>
                <p>${it.text}</p>
                <sec:ifAnyGranted roles="ROLE_USER">
                %{--<g:link class="btn btn-mini" action="edit" controller="post" id="${it.id}"> <i class='icon-remove-sign'></i> Delete</g:link>--}%
                    <g:hiddenField name="userId" value="${it.user.id}"/>
                    <g:if test="${currentUser?.id == it.user.id || newPost == true}">
                        <g:submitToRemote name="deletePostButton" controller="user" action="deletePost" id="${it.id}" update="temporary"
                                          value="Delete" onComplete="onCompletePostDeletion('#post${it.id}')">

                        </g:submitToRemote>
                    </g:if>
                </sec:ifAnyGranted>
            </div>
        </g:each>
    </div>
</g:if>