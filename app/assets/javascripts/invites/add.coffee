$(document).on 'turbolinks:load', ->
	$('.invite_user').on 'click', (e) ->
		$('#send_invite_modal').modal('open')
		$('#invite_team_id').val(e.target.id)
		return false

	$('.send_invite_form').on 'submit', (e) ->
		$.ajax e.target.action,
			type: 'POST',
			dataType: 'json',
			data: {
				invite: 
					recipient_email: $('#invite_recipient_email').val()
					team_id: $('#invite_team_id').val()
			}
			success: (data, text, jqXHR) ->
				Materialize.toast('Success to invite a new USer &nbsp;<b>:)</b>', 4000, 'green')
				return
			error: (jqXHR, textStatus, errorThrown) ->
				Materialize.toast('Problem in send invite to User &nbsp;<b>:(</b>', 4000, 'red')
		$('#send_invite_modal').modal('close')
		return false