<!doctype html>
<html>
	<head>
		<meta name="layout" content="main"/>
        <r:require modules="application"/>
        <r:require modules="bootstrap"/>
        <r:require modules="bootstrap-responsive-css"/>
		<title>Welcome to Grails</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}
            
			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
        <g:javascript>
            function onSubmit(text) {
            }

        </g:javascript>
	</head>
	<body>
    <div class="row">
        <g:form class="well span8" action="save" controller="post">
            <sec:ifLoggedIn>
                <h4>What's on your mind?</h4>
                <g:textArea name="text" placeholder="Enter text..." class="input-block-level"/><br />
                <div class="controls">
                    <g:submitToRemote controller="user" action="addPost" id="${user.id}" update="posts"
                                  class="btn btn-primary followBtn" value="Save" onComplete="onSubmit('ge')">
                    </g:submitToRemote>

                    %{--<g:submitButton name="Save" class="btn btn-primary" />--}%
                </div>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                <h4>Please <g:link controller="login" action="auth">Log in</g:link> to contribute to this community!</h4>
            </sec:ifNotLoggedIn>
        </g:form>
    </div>

    <div id="posts">
        <g:render template="/common/posts"/>
    </div>
	</body>
</html>
