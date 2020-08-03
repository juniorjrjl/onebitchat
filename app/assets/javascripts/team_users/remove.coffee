$(document).on 'turbolinks:load', ->
	self_remove = false

	show_remove_modal = (e) ->
		$('#remove_user_modal').modal('open')
		$('.remove_user_form').attr('action', 'team_users/' + e.target.id)
		$('#user_remove_id').val(e.target.id)
		return false

	$('body').on 'click', 'a.remove_user', (e) ->
		self_remove = false
		show_remove_modal(e)

	$('body').on 'click', 'a.leave_team', (e) ->
		self_remove = true
		show_remove_modal(e)

	$('.remove_user_form').on 'submit', (e) ->
		$.ajax e.target.action,
			type: 'DELETE',
			dataType: 'json',
			data: {team_id: $('.team_id').val()}
			success: (data, text, jqXHR) ->
				Materialize.toast('Success in remove User &nbsp;<b>:)</b>', 4000, 'green')
				if self_remove
					$(location).attr('href','/')
				else 
					$('.user_' + $('#user_remove_id').val()).remove()
				return
			error: (jqXHR, textStatus, errotThrown) ->
				Materialize.toast('Problem to remove User &nbsp;<b>:(</b>', 4000, 'red')
		
		$('#remove_user_modal').modal('close')
		return false