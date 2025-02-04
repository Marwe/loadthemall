from qgis.core import (QgsRasterLayer,
                       QgsVectorLayer)


def get_vector_layer(layer_path, layer_name, layer_dict, rename=False):
    res = layer_dict[layer_path]
    if res is None:
        res = QgsVectorLayer(layer_path, layer_name, 'ogr')
    elif rename:
        res.setName(layer_name)

    return res


def get_raster_layer(layer_path, layer_name, layer_dict, rename=False):
    res = layer_dict[layer_path]
    if res is None:
        res = QgsRasterLayer(layer_path, layer_name, 'ogr')
    elif rename:
        res.setName(layer_name)

    return res
