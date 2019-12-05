from django.test import TestCase
from django.contrib.auth import authenticate, login, logout
# Create your tests here.


class TestAccount(TestCase):

    def test_can_save_a_POST_request(self):
        email = "asd@cea.com"
        password = "adlkf"
        response = self.client.post(
            '/login/', data={'id_email': email, 'id_password': password})
        user = authenticate(email=email, password=password)
        self.assertEqual(user is not None, False)
