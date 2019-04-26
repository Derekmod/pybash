class Argument(object):
    def __init__(self, name, type=None, required=False, description=""):
        self.name = name
        self.type = type
        self.required = required
        self.description = description

    def summary(self):
        ret = self.name
        if self.type is not None:
            ret += ': ' + self.type
        if self.required:
            ret = '[' + ret + ']'
        else:
            ret = '(' + ret + ')'
        return ret

    def fullDescription(self):
        ret = self.name
        if self.type:
            ret += ' <' + str(self.type) + '>'

        full_desc = ''
        if not self.required:
            full_desc += ' (optional)'
        if self.description:
            full_desc += ' ' + self.description

        if full_desc:
            ret += ':' + full_desc

        return ret


class Alias(object):
    def __init__(self, name, value, module_name='', args=None, function=None, desc=None):
        self.module_name = module_name
        self.name = name
        self.value = value
        self.args = args or []
        self.function = function
        self.desc = desc
        self.unique = True

        self.nrequired = 0
        for arg in self.args:
            if arg.required:
                self.nrequired += 1

        # TODO: sort args by required

    def getName(self):
        name = self.name
        if not self.unique:
            name = '.'.join([self.module_name, self.name])
        return name

    def usage(self):
        return '%s %s' % (self.getName(), ' '.join(
            (arg.summary() for arg in self.args) ) )

    def fullDescription(self):
        name = self.getName()
        ret = 'alias {name}="{self.value}"\n'.format(**locals())
        ret += 'USAGE: ' + self.usage() + '\n'
        ret += 'Module: "' + self.module_name + '"'
        if self.desc:
            ret += '\n' + self.desc

        if self.args:
            ret += '\nArguments:'
            for arg in self.args:
                ret += '\n\t' + arg.fullDescription()

        return ret

    def genFunction(self):
        if not self.function:
            return ''
        return '''{self.value}() {  # GENERATED
{self.function}
}'''

    def bashCommand(self):
        ret = ''
        if self.unique:
            self.unique = False
            ret = self.bashCommand()
            self.unique = True
        full_desc = self.fullDescription()
        usage = self.usage()
        name = self.getName()
        function = self.genFunction()
        return ret + '''
{function}
alias {name}="{self.name}_wrapper"
{name}_wrapper() {{
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo '{full_desc}'
    return
  fi
  if [ $# -lt {self.nrequired} ]; then
    echo "USAGE: {usage}"
    return
  fi
  {self.value} $*
}}'''.format(**locals())
