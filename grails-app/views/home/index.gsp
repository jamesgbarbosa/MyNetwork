<!doctype html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <r:require modules="grailsEvents"/>
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

    <r:script>
    $(document).ready(function () {
      /*
       Register a grailsEvents handler for this window, constructor can take a root URL,
       a path to event-bus servlet and options. There are sensible defaults for each argument
       */
      window.grailsEvents = new grails.Events("${createLink(uri: '')}");
            //Event fired when a user posted new entry.
            // Entry posted by current user will be displayed
            // simultaneously to the followers news feed in real time
            grailsEvents.on('savedTodo_'+${currentUser?.id}, function (data) {
                //TODO REMOVE TEMPORARY DIV
                $('#temporary').hide()
                $('#temporary').load('/MyNetwork/user/getPost?id='+data.as+'&new=true', function(data) {
                     var new_div = $(data).hide();
                    $('#posts').prepend(new_div);
                    new_div.fadeIn("slow");
                 });
            });
        });
    </r:script>
    <g:javascript>
        //Set limit
        $('#counter').text(100)
         if($('#text').val() == "") {
             $('#${currentUser?.id}').attr('disabled',true)
        }
        //Posting limit / check if there is text entered, else button is disabled.
        $('#text').bind('keydown', function () {
            var self = $(this);

            clearTimeout(self.data('timeout'));
            self.data('timeout', setTimeout(function() {
                 if($('#text').val().trim() == "") {
                    $('#${currentUser?.id}').attr('disabled',true)
                 } else {
                 $('#${currentUser?.id}').attr('disabled',false)
                 }
                 $('#counter').text(100 - $('#text').val().length)
            }, 5));
        });
        // Event fired after successful posting of current user
        function onCompletePosting() {
            $('#posts').hide()
            $('#posts').prepend( $("#temporary").find('#postDiv'));
            $('#posts').fadeIn("slow");
        }
            function onCompletePostDeletion(postId) {
                var obj = $(postId)
                obj.fadeOut("slow");
            }
    </g:javascript>
</head>
<body>
<div class="row">
    <g:form class="well span8" action="save" controller="post">
        <sec:ifLoggedIn>
            <h4>What's on your mind?</h4>
            <g:textArea rows="5" name="text" placeholder="Enter text..." class="input-block-level" style="resize: none" maxlength="100"/> <br />
            <p class="pull-left text-counter" id="counter"/>
            <div class="controls">
                <g:submitToRemote name="postButton" controller="user" action="addPost" id="${user?.id}" update="temporary"
                                  class="btn btn-primary followBtn pull-right" value="Post" onComplete="onCompletePosting()">
                </g:submitToRemote>
            </div>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
            <h4>Please <g:link controller="login" action="auth">Log in</g:link> to contribute to this community!</h4>
        </sec:ifNotLoggedIn>
    </g:form>
</div>
<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<div class="span8">
    <div id="posts">
        <g:render template="/common/posts"/>
    </div>
</div>
<div id="temporary"></div>

</body>

</html>
