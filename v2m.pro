# references:
# https://github.com/cspiegel/qmmp-adplug
# https://github.com/cspiegel/qmmp-openmpt

HEADERS += decoderv2mfactory.h \
           decoder_v2m.h \
           v2mhelper.h \
           archivereader.h
    
SOURCES += decoderv2mfactory.cpp \
           decoder_v2m.cpp \
           v2mhelper.cpp \
           archivereader.cpp \
           libv2m/sounddef.cpp \
           libv2m/synth_core.cpp \
           libv2m/v2mconv.cpp \
           libv2m/v2mplayer.cpp

CONFIG += warn_on plugin link_pkgconfig

TEMPLATE = lib

QMAKE_CLEAN += lib$${TARGET}.so

unix {
	CONFIG += link_pkgconfig
	PKGCONFIG += qmmp
	
	QMMP_PREFIX = $$system(pkg-config qmmp --variable=prefix)
	PLUGIN_DIR = $$system(pkg-config qmmp --variable=plugindir)/Input
	LOCAL_INCLUDES = $${QMMP_PREFIX}/include
	LOCAL_INCLUDES -= $$QMAKE_DEFAULT_INCDIRS
	INCLUDEPATH += $$LOCAL_INCLUDES
	
	plugin.path = $${PLUGIN_DIR}
	plugin.files = lib$${TARGET}.so
	INSTALLS += plugin
}
