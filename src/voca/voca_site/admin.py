from django.contrib import admin

# Register your models here.

from django import forms
from django.contrib import admin
from django.contrib.auth.models import Group
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.forms import ReadOnlyPasswordHashField
from .models import Pspage, Univs, Position, UserMessages, Depart, Orgniza, PspageUserVisit
from voca_site.models import User


class UserCreationForm(forms.ModelForm):
    """A form for creating new users. Includes all the required
    fields, plus a repeated password."""
    password1 = forms.CharField(
        label='密码', widget=forms.PasswordInput, max_length=100)
    password2 = forms.CharField(
        label='密码确认', widget=forms.PasswordInput)
    email = forms.EmailField(label='email', widget=forms.EmailInput, max_length=100, error_messages={
                             "required": "邮箱不能为空", "unique": "邮箱已注册"})

    class Meta:
        model = User
        fields = ('email', 'name')

    def clean_password2(self):
        # Check that the two password entries match
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            self.add_error('password2', "密码不一致！")
        return password2

    def save(self, commit=True):
        # Save the provided password in hashed format
        user = super(UserCreationForm, self).save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()

        return user


class UserChangeForm(forms.ModelForm):
    """A form for updating users. Includes all the fields on
    the user, but replaces the password field with admin's
    password hash display field.
    """
    password = ReadOnlyPasswordHashField()

    class Meta:
        model = User
        fields = ('email', 'password',
                  'is_active', 'is_admin',)

    def clean_password(self):
        # Regardless of what the user provides, return the initial value.
        # This is done here, rather than on the field, because the
        # field does not have access to the initial value
        return self.initial["password"]


class UnivsAttendTerm(admin.TabularInline):
    model = User.univs_attend.through
    extra = 1


class UnivsGraTerm(admin.TabularInline):
    model = User.univs_gra.through
    extra = 1


class UserMessageTerm(admin.TabularInline):
    model = User.message_receiver.through
    extra = 1
    fk_name = 'message_sender'


class UserMessageTerm1(admin.TabularInline):
    model = User.message_receiver.through
    extra = 1
    fk_name = 'message_receiver'


class MyUserAdmin(UserAdmin):
    # The forms to add and change user instances
    form = UserChangeForm
    add_form = UserCreationForm

    # The fields to be used in displaying the User model.
    # These override the definitions on the base UserAdmin
    # that reference specific fields on auth.User.
    list_display = ('id', 'email', 'name', 'is_admin', 'date_of_register')
    list_filter = ('is_admin',)

    fieldsets = (
        (None, {'fields': ('email', 'password',)}),
        ('Personal info', {'fields': ('name', 'gender',
                                      'position', 'orgniza', 'depart', 'friend',)}),
        ('Permissions', {'fields': ('is_admin',)}),
    )
    # add_fieldsets is not a standard ModelAdmin attribute. UserAdmin
    # overrides get_fieldsets to use this attribute when creating a user.
    inlines = (UnivsAttendTerm, UnivsGraTerm,
               UserMessageTerm, UserMessageTerm1,)
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'name', 'password1', 'password2')}
         ),
    )
    search_fields = ('email',)
    ordering = ('email',)

    filter_horizontal = ('friend',)


class PspageAdmin(admin.ModelAdmin):
    list_display = ('pspage_id', 'email', 'show_user_name_',
                    'update_time', 'visitor_cnt')

    def show_user_name_(self, obj):
        return obj.user.name


class UnivsAdmin(admin.ModelAdmin):
    list_display = ('univs_id', 'name', )


class UserMessagesAdmin(admin.ModelAdmin):
    list_display = ('message_sender', 'message_receiver', 'message_read',
                    'show_message_brief_', 'message_sent_time')

    def show_message_brief_(self, obj):
        return obj.message[:10]


# Now register the new UserAdmin...
admin.site.register(User, MyUserAdmin)
admin.site.register([Position, PspageUserVisit, Depart, Orgniza])
admin.site.register(Pspage, PspageAdmin)
admin.site.register(Univs, UnivsAdmin)
admin.site.register(UserMessages, UserMessagesAdmin)

# ... and, since we're not using Django's built-in permissions,
# unregister the Group model from admin.
admin.site.unregister(Group)
