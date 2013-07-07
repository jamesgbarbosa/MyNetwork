<div id="cometMessages">
    %{--
  - Copyright (c) 2013 Rene Puchinger.
  - http://renepuchinger.com
  --}%

<g:each in="${messages}" status="i" var="msg">
        <div class='span3 well <g:if test="${i == messages?.size() - 1 && messages?.size() >= 5}">lastMsg</g:if>'>${msg.text}</div>
    </g:each>
</div>