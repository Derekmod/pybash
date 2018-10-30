from note import Note, getFilepath
import pickle

def getNote(name):
    filepath = getFilepath(name)
    note = None
    try:
        note = pickle.load(open(filepath, 'rb'))
    except Exception:
        note = Note(name)
    return note

def saveNote(note):
    pickle.dump(note, open(getFilepath(note.name), 'wb'))
