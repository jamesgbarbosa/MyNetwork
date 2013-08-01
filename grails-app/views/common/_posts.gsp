<g:if test="${posts}">

    <div id="postDiv">
        <g:each in="${posts}">
            <div class="well well-light ${newpost}" id="post${it.id}">
                <div class="pull-right">
                    <prettytime:display date="${it.dateCreated}" />
                    <g:if test="${currentUser?.id == it.user.id || newPost == true}">
                        <g:remoteLink class="" name="deletePostButton" controller="user" action="deletePost" id="${it.id}" update="temporary"
                                      value="Delete" onComplete="onCompletePostDeletion('#post${it.id}')">
                            <i class='icon-remove-sign' alt="delete"></i>
                        </g:remoteLink>
                    </g:if>
                </div>
                <div class="pull-left" style="width:60px; padding-right: 15px;">

                    <img src="${g.createLink(controller: 'user', action:'viewAvatar', id: it.user.id)}" alt="${it.user.username}" class="smallAvatar"/>
                </div>
                <p><g:link controller="user" action="show" id="${it.user.id}">${it.user.username}</g:link></p>
                <p>${it.text}</p>

                <sec:ifAnyGranted roles="ROLE_USER">
                %{--<g:link class="btn btn-mini" action="edit" controller="post" id="${it.id}"> <i class='icon-remove-sign'></i> Delete</g:link>--}%
                    <g:hiddenField name="userId" value="${it.user.id}"/>
                </sec:ifAnyGranted>

            </div>
        </g:each>

    </div>
</g:if>