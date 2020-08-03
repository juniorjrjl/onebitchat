set_chat = (name) ->
	$('.chat_name').html(name)

clean_messages = () ->
	$('.messages').html('')
	$('.chat_name').html('')

window.add_message = (message, message_data, name) ->
	$('.messages').append('<div class="message col s12">' +
						'<div class="col m2|1">' +
						'<i class="material-icons prefix right profile_icon">account_circle</i>' +
						'</div>'+
						'<div class="col m10 s9">' +
						'<div class="row">' +
						'<b>' + name + '</b><span class="date">' + message_data + '</span>' +
						'</div>' +
						'<div class="row">' + message + '</div>'
						'</div>' +
						'</div>')
	$('.messages').animate({ scrollTop: $('.messages').prop("scrollHeight")}, 100);

window.open = (id, type) ->
	clean_messages()
	$.ajax "/" + type + "/" + id,
		type: 'GET',
		contentType: 'application/json',
		dataType: 'json',
		data: {team_id: $('.team_id').val()}
		success: (data, text, jqXHR) ->
			set_chat(if type == "talks" then data['user']['name'] else data['slug'])
			window.change_chat(id, type, $('.team_id').val())

			if (data['messages'])
				for m in data['messages']
					do ->
						window.add_message(m['body'], m['date'], m['user']['name'])
		error: (jqXHR, textStatus, errorThrown) ->
			Materialize.toast('Problem to get ' + type + ' informations &nbsp;<b>:(</b>', 4000, 'red')
	return false

window.add = (slug, id, type) ->
	additional = if type == "channel" then "#" else ""
	$('.' + type + 's').prepend('<li class="' + type + '_' + id + '">' +
								'<div>' +
								'<a href="#" class="open_' + type + '">' +
								'<span id="' + id + '">' + additional + slug + '</span>' +
								'</a>' +
								'<a class="right remove_' + type + '" href="#" id="' + id + '">' +
								'<i class="material-icons" id="' + id + '">settings</i>' +
								'</a>' +
								'</div>' +
								'</li>')