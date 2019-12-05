from django import template
from voca_site.models import User, Pspage, Univs, Depart, Position, Orgniza
from voca_site.forms import SendMessageForm
from django.urls import reverse


register = template.Library()


@register.filter
def get_set(value, attr):
    pspage = value
    user = pspage.user
    if attr == "univs_attend" or attr == 'univs_gra':
        set = getattr(user, attr).all()
    else:
        set = getattr(user, attr)
    return set


@register.filter
def get_univs_enroll_time(value, pspage):
    univs = value
    user = pspage.user
    enroll_time = univs.userunivsattend_set.get(
        user=user.id).enroll_time
    return enroll_time


@register.filter
def get_univs_grad_time(value, pspage):
    univs = value
    user = pspage.user
    grad_time = univs.userunivsgra_set.get(
        user=user.id).grad_time
    return grad_time


@register.filter
def get_pspage_url_with_id(value):
    pspage = Pspage.objects.get(pspage_id=value)
    return pspage.get_absolut_url()


@register.filter
def get_pspage_update_url(value):
    pspage = value
    return pspage.get_absolut_url() + 'edit'


@register.filter
def get_model_delete_friend_target(value):
    return '#model_delete_friend_' + str(value)


@register.filter
def get_model_delete_friend_id(value):
    return 'model_delete_friend_' + str(value)


@register.filter
def get_model_apply_friend_target(value):
    return '#model_apply_friend_' + str(value)


@register.filter
def get_model_apply_friend_id(value):
    return 'model_apply_friend_' + str(value)


@register.filter
def get_model_send_message_target(value):
    return '#model_send_message_' + str(value)


@register.filter
def get_model_send_message_id(value):
    return 'model_send_message_' + str(value)


@register.filter
def get_model_send_message_owner_target(value):
    return '#model_send_message_owner_' + str(value)


@register.filter
def get_model_send_message_owner_id(value):
    return 'model_send_message_owner_' + str(value)


@register.filter
def get_model_delete_message_target(value):
    return '#model_delete_message_' + str(value)


@register.filter
def get_model_delete_message_id(value):
    return 'model_delete_message_' + str(value)


@register.filter
def get_friend_delete_url(value, friend_id):
    pspage = value
    return reverse('friend_delete', args=[pspage.pspage_id, friend_id])


@register.filter
def get_friend_apply_url(value):
    pspage = value
    return reverse('friend_apply', args=[pspage.pspage_id])


@register.filter
def get_confirm_friend_apply_url(value, message):
    pspage = value
    return reverse('confirm_friend_apply', args=[pspage.pspage_id, message.id])


@register.filter
def get_message_delete_url(value, message_id):
    pspage = value
    return reverse('delete_message', args=[pspage.pspage_id, message_id])


@register.filter
def get_send_message_url(value, friend_id):
    pspage = value
    return reverse('send_message', args=[pspage.pspage_id, friend_id])


@register.filter
def get_message_read_url(value, message_id):
    pspage = value
    return reverse('set_read_message', args=[pspage.pspage_id, message_id])


@register.filter
def get_message_to_read_url(value, message_id):
    pspage = value
    return reverse('set_to_read_message', args=[pspage.pspage_id, message_id])


@register.filter
def get_message_form(value, i):
    message_forms = value
    return message_forms[i - 1]


@register.filter
def convert_dict(value, dict):
    return dict[value]


@register.filter
def show_message_read_str(value):
    message = value
    if message.message_read:
        return "已读"
    else:
        return "未读"


@register.filter
def get_unread_message_num(value):
    message_forms = value
    if message_forms:
        num = message_forms.filter(message_read=False).count()
    else:
        num = 0
    return num


@register.filter
def get_message_form_owner(value):
    message_form = SendMessageForm()
    return message_form


@register.filter
def message_check_friend_apply(value, friend_apply_key):
    message = value
    if message.message == friend_apply_key:
        return True
    else:
        return False
