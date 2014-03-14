module AutoSessionTimeoutHelper
  def auto_session_timeout_js(options={})
    frequency = options[:frequency] || 60
    code = <<JS
function PeriodicalQuery() {
  $.ajax({
    url: '/active',
    success: function(data) {
      if(data == 'false'){
        window.location.href = '/timeout';
      }
    }
  });
  setTimeout(PeriodicalQuery, (#{frequency} * 1000));
}
setTimeout(PeriodicalQuery, (#{frequency} * 1000));
JS
    javascript_tag(code)
  end
end

ActionView::Base.send :include, AutoSessionTimeoutHelper