<g:if test="${flash.message || flash.error}">
    <div class="row">
        <div id="topMessage" class="hide alert <g:if test="${flash.message}">alert-info</g:if><g:else>alert-error</g:else>" data-alert="alert">
            <button type="button" class="close" data-dismiss="alert">×</button>
            <g:if test="${flash.error}">${flash.error}</g:if>
            <g:else>${flash.message}</g:else>
        </div>
    </div>

    <script type="text/javascript">
        $(function() {
            $("#topMessage").fadeIn();
        })
    </script>

</g:if>

<div id="ajaxMessage" class="row">
</div>
