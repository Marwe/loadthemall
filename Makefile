#set a different deployment path in Makefile.ini (create, if not existing)
QGIS_PROFILE :="${HOME}/.local/share/QGIS/QGIS3/profiles/development"
-include Makefile.ini

all: ui/Ui_DockWidget.py ui/Ui_Base_LoadThemAll.py resources/resources_rc.py i18n/loadthemall_es.qm i18n/loadthemall_es.qm

clean:
	rm -f ui/Ui_DockWidget.py ui/Ui_Base_LoadThemAll.py
	rm -f resources/resources_rc.py
	rm -f i18n/*.qm
	rm -f *.pyc *~
	rm -rf deploy/

resources/resources_rc.py: resources/resources.qrc
	pyrcc5 -o resources/resources_rc.py resources/resources.qrc

ui/Ui_DockWidget.py: ui/Ui_DockWidget.ui
	pyuic5 -o ui/Ui_DockWidget.py ui/Ui_DockWidget.ui

ui/Ui_Base_LoadThemAll.py: ui/Ui_Base_LoadThemAll.ui
	pyuic5 -o ui/Ui_Base_LoadThemAll.py ui/Ui_Base_LoadThemAll.ui

i18n/loadthemall_es.qm i18n/loadthemall_fr.qm: i18n/loadthemall.pro
	lrelease i18n/loadthemall.pro

build:
	mkdir -p deploy; rm -f deploy/loadthemall.zip; cd ..;zip -r loadthemall/deploy/loadthemall.zip loadthemall -x loadthemall/deploy/\* -x loadthemall/.git/\* loadthemall/.idea/\* \
	loadthemall/.gitignore loadthemall/README.md loadthemall/changelog.txt loadthemall/Makefile \
	loadthemall/i18n/*.ts loadthemall/i18n/*.pro loadthemall/resources/resources.qrc \
	loadthemall/ui/*.ui

deploy: all build
	if [ -d "$(QGIS_PROFILE)" ] ;\
	then \
	    unzip -o deploy/loadthemall.zip -d "$(QGIS_PROFILE)/python/plugins/" ;\
	else \
	    echo "QGIS3 profile path not found, configure QGIS_PROFILE :="path/to" in Makefile.ini. Cannot deploy." ;\
	fi

