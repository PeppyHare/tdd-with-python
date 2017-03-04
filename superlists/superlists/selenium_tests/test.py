from django.test import LiveServerTestCase


class SeleniumTestCase(LiveServerTestCase):
    """
    A base test case for selenium, providing hepler methods for generating
    clients and logging in profiles.
    """
