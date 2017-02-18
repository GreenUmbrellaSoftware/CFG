$(document).ready(function() {
  var renderUserResponse = function($user) {
    var $ul = $user.parent();
    $user.remove();

    if(!$ul.children().length) {
      $ul.append("<li class='list-group-item empty_requests'>There are no pending users at this time</li>")
    }
  };

  // Add a listener on the parent ul so that if we add another child dynamically it will get picked up
  $(".list-group").on("click", function (e) {
    e.preventDefault();

    var $this = $(e.target),
        $parent = $this.parent();

    // Only want to send the request if we are pressing on the approve, or reject button
    if($this.is("span") && $parent.is("a")) {
      $this = $parent;
    }

    if($this.is("a")) {
      $.ajax({
        url: $this.attr("href") + ".json",
        method: $this.hasClass("add-user") ? "GET" : "PUT"
      }).done(function() {
        renderUserResponse($this.parents(".list-group-item"));
      });
    }
  });
});
