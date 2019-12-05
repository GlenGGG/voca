"""voca URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from voca_site import views as voca_site_views
from django.views.generic.base import RedirectView

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^favicon.ico$', RedirectView.as_view(
        url=r'static/logo/favicon.ico')),
    url(r'^$', voca_site_views.cover_page, name='cover'),
    url(r'^account/signin/$', voca_site_views.signin_page, name='signin'),
    url(r'^account/signup/$', voca_site_views.signup_page, name='signup'),
    url(r'^account/(\d+)/change_password/$',
        voca_site_views.change_password_page, name='change_password'),
    url(r'^operation/success/$',
        voca_site_views.operation_success_page, name='success'),
    url(r'^operation/password_change/success/$',
        voca_site_views.password_change_success_page, name='password_change_success'),
    url(r'^logout/$', voca_site_views.log_out, name='logout'),
    url(r'^pspage/(\d+)/$', voca_site_views.personal_page, name='pspage'),
    url(r'^pspage/(\d+)/edit$',
        voca_site_views.pspage_update_page, name='pspage_update'),
    url(r'^friend/(\d+)/$', voca_site_views.friend_page, name='friend'),
    url(r'^friend/(\d+)/delete/(\d+)$',
        voca_site_views.friend_delete, name='friend_delete'),
    url(r'^pspage/(\d+)/message/(\d+)/delete$',
        voca_site_views.delete_message, name='delete_message'),
    url(r'^pspage/(\d+)/message/(\d+)/set_read$',
        voca_site_views.set_read_message, name='set_read_message'),
    url(r'^pspage/(\d+)/message/(\d+)/set_to_read$',
        voca_site_views.set_to_read_message, name='set_to_read_message'),
    url(r'^pspage/(\d+)/message/(\d+)/confirm_friend',
        voca_site_views.confirm_friend_apply, name='confirm_friend_apply'),
    url(r'^friend/(\d+)/send_message/(\d+)$',
        voca_site_views.send_message, name='send_message'),
    url(r'^friend/(\d+)/friend_apply$',
        voca_site_views.friend_apply, name='friend_apply'),
    url(r'^pspage/(\d+)/message/$',
        voca_site_views.message_page, name='message'),
    url(r'^pspage/(\d+)/visitor_detail/$',
        voca_site_views.visitor_detail_page, name='visitor_detail'),
    url(r'^search$',
        voca_site_views.search_page, name='search'),
]
