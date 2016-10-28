$(document).ready(function() {
    // Initialize the vertical navigation
    $().setupVerticalNavigation(true);
    check_restfull_a.initialize();
});

var check_restfull_a = {
    initialize: function() {
        this.methodLinks = $('a[data-method]');
        this.registerEvents();
    },

    registerEvents: function() {
        this.methodLinks.on('click', this.handleMethod);
    },

    handleMethod: function(e) {
        var link = $(this);
        var httpMethod = link.data('method').toUpperCase();
        var form;
        // If the data-method attribute is not PUT or DELETE,
        // then we don't know what to do. Just ignore.
        if ( $.inArray(httpMethod, ['PUT', 'DELETE']) === - 1 ) {
            return;
        }
        // Allow user to optionally provide data-confirm="Are you sure?"
        if ( link.data('confirm') ) {
            if ( ! check_restfull_a.verifyConfirm(link) ) {
                return false;
            }
        }
        form = check_restfull_a.createForm(link);
        form.submit();
        e.preventDefault();
    },

    verifyConfirm: function(link) {
        return confirm(link.data('confirm'));
    },

    createForm: function(link) {
        var form =
        $('<form>', {
            'method': 'POST',
            'action': link.attr('href')
        });
        var token = $('<input type="hidden" name="authenticity_token" value="'+$('meta[name=csrf-token]').attr('content')+'">');
        var hiddenInput =
        $('<input>', {
            'name': '_method',
            'type': 'hidden',
            'value': link.data('method')
        });
        return form.append(token, hiddenInput)
        .appendTo('body');
    }
};
