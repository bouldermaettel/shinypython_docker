class Hello:

    def __init__(self, text: str):
        self._text = text

    def print_hello(self):
        return(self._text)

    @staticmethod
    def print_sys_version():
        import platform
        return f'Python Version: {platform.python_version()}'
