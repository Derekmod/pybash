import os

NOTES_DIR = os.environ['PYBASH__NOTES_DIR']


class Note(object):
    def __init__(self, name):
        self.name = name
        self.items = []

    def render(self):
        rendered_items = []
        for i, item in enumerate(self.items):
            rendered_items.append( str(i) + ': ' + str(item) )
        return '\n'.join(rendered_items)

    def addItem(self, item):
        self.items.append(item)

def getFilepath(name):
    return os.path.join(NOTES_DIR, name)
