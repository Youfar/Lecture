# encoding: utf-8

APPNAME = 'multiplicationTable'
VERSION = '1.0'

top = '.'
builddir = 'build'


def configure(conf):
    d_compilers = ['dmd']
    
    for d_compiler in d_compilers:
        try:
            conf.find_program(d_compiler, var='D_COMPILER')
        except:
            continue
        else:
            break
    else:
        conf.fatal('D compiler ' + str(d_compilers) + ' are not found.')

    # Release option
    conf.env.append_value('DFLAGS', ['-O', '-release', '-boundscheck=off', '-inline'])

    # Unittest option
    conf.env.append_value('DFLAGS_TEST', ['-unittest', '-main'])

    
def build(bld):
    # compile
    bld(rule = '${D_COMPILER} ${DFLAGS} ${SRC} -of${TGT}',
        source = 'multiplicationTabele.d',
        target = APPNAME)

from waflib.Build import BuildContext
class TestContext(BuildContext):
        fun = cmd = 'test'

def test(ctx):
    # unit test
    ctx(rule = '${D_COMPILER} ${DFLAGS_TEST} -run ${SRC}',
        source = 'multiplicationTabele.d')
