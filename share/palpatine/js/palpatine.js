
$(function(){

  console.log('Starting Palpatine JS...');

  $('.nav-button').each(function(){
    var button = $(this)
    var target = button.attr('href').split('#')[1];
    if (!target) { target = 'home' }
    $(this).click(function(){
      goto_target(target, button.data('no-data'));
    });
  });

  var url = document.location.toString();
  var target = url.split('#')[1];
  if (target) goto_target(target);

  var last_search;

  $("#search").keyup(function(){
    var search = $(this).val();
    if (search.length > 0 && search != last_search) {
      last_search = search;
      goto_target('search',1);
      $.post('/search.json', { search: search }, function(data) {
        console.log(data);
      });
    }
  });

  $("#searchform").submit(function(){
    return false;
  });

});

var cached_templates = {};

function run_template(path, target, args, finish) {
  var source;
  var template;

  if (cached_templates[path]) {
    $(target).html(cached_templates[path](args));
    if (finish && typeof v === "function") {
      finish.call(target);
    }
  } else {
    $(target).html('<img src="/img/ajaxload.gif">');
    $.ajax({
      url: '/tmpl/' + path + '.hb',
      cache: true,
      complete: function(xhr, error) {
        if (error != 'success') {
          $(target).html('<div class="alert alert-danger"><strong>Error while loading...</strong></div>');          
        }
      },
      success: function(data) {
        source = data;
        cached_templates[path] = Handlebars.compile(source);
        $(target).html(cached_templates[path](args));
        if (finish && typeof v === "function") {
          finish.call(target);
        }
      }
    });
  }
}

function goto_target(target, no_data) {
  location.hash = target;
  var args = target.split('/');
  var base = args.shift();
  if (no_data) {
    run_template(base, '#main', { args: args });
  } else {
    $('#main').html('<img src="/img/ajaxload.gif">');
    $.ajax({
      url: '/' + target,
      cache: false,
      complete: function(xhr, error) {
        if (error != 'success') {
          $('#main').html('<div class="alert alert-danger"><strong>Error while loading...</strong></div>');          
        }
      },
      success: function(data) {
        run_template(base, '#main', data);
      }
    });
  }
}