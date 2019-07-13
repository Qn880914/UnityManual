using System;
using UnityEditor;

public class Optimize_AssetPostProcess : AssetPostprocessor
{
    private static string platformStandalone = "Standalone";
    private static string platformWeb = "Web";
    private static string platformIphone = "iPhone";
    private static string platformAndroid = "Android";
    private static string platformWebGL = "WebGL";
    private static string platformWindowsStoreApps = "Windows Store Apps";
    private static string platformPS4 = "PS4";
    private static string platformXboxOne = "XboxOne";
    private static string platformNintendo3DS = "Nintendo 3DS";
    private static string platformTvOS = "tvOS";

    #region Texture import
    public void OnPreprocessTexture()
    {
        bool modify = false;
        TextureImporter importer = assetImporter as TextureImporter;

        modify |= TextureImportSettingCommon(importer);

        //modify |= TextureImportSettingAndroid(importer);

        modify |= TextureImportSettingIOS(importer);

        if (modify)
        {
            importer.SaveAndReimport();
        }
    }

    private bool TextureImportSettingCommon(TextureImporter importer)
    {
        bool modify = false;
        if(importer.assetPath.IndexOf("Normalmap", StringComparison.OrdinalIgnoreCase) != -1 && 
            importer.textureType != TextureImporterType.NormalMap)
        {
            importer.textureType = TextureImporterType.NormalMap;
            modify = true;
        }
        else if(importer.assetPath.IndexOf("Sprite", StringComparison.OrdinalIgnoreCase) != -1 &&
            importer.textureType != TextureImporterType.Sprite)
        {
            importer.textureType = TextureImporterType.Sprite;
            modify = true;
        }
        else if(importer.assetPath.IndexOf("Cursor", StringComparison.OrdinalIgnoreCase) != -1 &&
            importer.textureType != TextureImporterType.Cursor)
        {
            importer.textureType = TextureImporterType.Cursor;
            modify = true;
        }
        else if(importer.assetPath.IndexOf("Cookie", StringComparison.OrdinalIgnoreCase) != -1 &&
            importer.textureType != TextureImporterType.Cursor)
        {
            importer.textureType = TextureImporterType.Cookie;
            modify = true;
        }
        else if(importer.assetPath.IndexOf("Lightmap", StringComparison.OrdinalIgnoreCase) != -1 &&
            importer.textureType != TextureImporterType.Lightmap)
        {
            importer.textureType = TextureImporterType.Lightmap;
            modify = true;
        }
        else if(importer.assetPath.IndexOf("SingleChannel", StringComparison.OrdinalIgnoreCase) != -1 &&
            importer.textureType != TextureImporterType.SingleChannel)
        {
            importer.textureType = TextureImporterType.SingleChannel;
            modify = true;
        }


        if (importer.assetPath.IndexOf("Readable", StringComparison.OrdinalIgnoreCase) == -1 &&
            importer.isReadable)
        {
            importer.isReadable = false;
            modify = true;
        }
        if (importer.assetPath.IndexOf("mipmap", StringComparison.OrdinalIgnoreCase) == -1 &&
            importer.mipmapEnabled)
        {
            importer.mipmapEnabled = false;
            modify = true;
        }

        return modify;
    }
    private bool TextureImportSettingAndroid(TextureImporter importer)
    {
        bool modify = false;

        TextureImporterPlatformSettings platformSettings = importer.GetPlatformTextureSettings(platformAndroid);
        if (platformSettings.maxTextureSize != 2048)
        {
            platformSettings.maxTextureSize = 2048;
            modify = true;
        }
        if (platformSettings.format != TextureImporterFormat.ETC2_RGBA8)
        {
            platformSettings.format = TextureImporterFormat.ETC2_RGBA8;
            modify = true;
        }

        return modify;
    }
    private bool TextureImportSettingIOS(TextureImporter importer)
    {
        bool modify = false;

        TextureImporterPlatformSettings platformSettings = importer.GetPlatformTextureSettings(platformIphone);

        if(platformSettings.overridden == false)
        {
            platformSettings.overridden = true;
            modify = true;
        }

        if (platformSettings.maxTextureSize != 2048)
        {
            platformSettings.maxTextureSize = 2048;
            modify = true;
        }
        if (platformSettings.format != TextureImporterFormat.PVRTC_RGBA4)
        {

            platformSettings.format = TextureImporterFormat.PVRTC_RGBA4;
            modify = true;
        }

        importer.SetPlatformTextureSettings(platformSettings);

        return modify;
    }
    #endregion  Texture import


    #region Model import
    public void OnPreprocessModel()
    {
        bool modify = false;

        ModelImporter importer = assetImporter as ModelImporter;

        #region rig
        if(importer.assetPath.IndexOf("Legacy", StringComparison.OrdinalIgnoreCase) != -1 && 
            importer.animationType != ModelImporterAnimationType.Legacy)
        {
            importer.animationType = ModelImporterAnimationType.Legacy;
            modify = true;
        }
        else if(importer.assetPath.IndexOf("Generic", StringComparison.OrdinalIgnoreCase) != -1 &&
            importer.animationType != ModelImporterAnimationType.Generic)
        {
            importer.animationType = ModelImporterAnimationType.Generic;
            modify = true;
        }
        else if(importer.assetPath.IndexOf("Humanoid", StringComparison.OrdinalIgnoreCase) != -1 &&
            importer.animationType != ModelImporterAnimationType.Human)
        {
            importer.animationType = ModelImporterAnimationType.Human;
            modify = true;
        }
        else if(importer.animationType != ModelImporterAnimationType.None)
        {
            importer.animationType = ModelImporterAnimationType.None;
            modify = true;
        }
        #endregion rig

        #region model

        #region Scene
        // scale factor
        if (importer.globalScale != 1)
        {
            importer.globalScale = 1;
            modify = true;
        }

        // convert units
        if (importer.useFileScale == false)
        {
            importer.useFileScale = true;
            modify = true;
        }

        // import blendShapes
        if (importer.importBlendShapes == false)
        {
            importer.importBlendShapes = true;
            modify = true;
        }

        // import visibility
        if(importer.importVisibility == false)
        {
            importer.importVisibility = true;
            modify = true;
        }

        // import cameras
        if(importer.importCameras == false)
        {
            importer.importCameras = true;
            modify = true;
        }

        // import lights
        if(importer.importLights == false)
        {
            importer.importLights = true;
            modify = true;
        }

        // preserve hierarchy
        if (importer.preserveHierarchy == true)
        {
            importer.preserveHierarchy = false;
            modify = true;
        }
        #endregion Scene

        #region meshes
        // mesh compression
        if (importer.meshCompression != ModelImporterMeshCompression.Medium)
        {
            importer.meshCompression = ModelImporterMeshCompression.Medium;
            modify = true;
        }

        // read/write enabled
        if (importer.isReadable)
        {
            importer.isReadable = false;
            modify = true;
        }

        // optimize mesh
        if(importer.meshOptimizationFlags != MeshOptimizationFlags.Everything)
        {
            importer.meshOptimizationFlags = MeshOptimizationFlags.Everything;
            modify = true;
        }

        // generate colliders
        if(importer.addCollider == true)
        {
            importer.addCollider = false;
            modify = true;
        }

        /*if (importer.optimizeGameObjects == false)
        {
            importer.optimizeGameObjects = true;
            modify = true;
        }*/
        #endregion meshes

        #region geometry
        // keep quads
        if(importer.keepQuads == true)
        {
            importer.keepQuads = false;
            modify = true;
        }

        // weld vertices
        if(importer.weldVertices == false)
        {
            importer.weldVertices = true;
            modify = true;
        }

        // index format
        if(importer.indexFormat != ModelImporterIndexFormat.Auto)
        {
            importer.indexFormat = ModelImporterIndexFormat.Auto;
            modify = true;
        }

        // normals
        if(importer.importNormals != ModelImporterNormals.Import)
        {
            importer.importNormals = ModelImporterNormals.Import;
            modify = true;
        }

        // blend shape normals
        if(importer.importBlendShapeNormals != ModelImporterNormals.Calculate)
        {
            importer.importBlendShapeNormals = ModelImporterNormals.Calculate;
            modify = true;
        }

        // normals mode
        if(importer.normalCalculationMode != ModelImporterNormalCalculationMode.AreaAndAngleWeighted)
        {
            importer.normalCalculationMode = ModelImporterNormalCalculationMode.AreaAndAngleWeighted;
            modify = true;
        }

        // smoothness source
        if(importer.normalSmoothingSource != ModelImporterNormalSmoothingSource.PreferSmoothingGroups)
        {
            importer.normalSmoothingSource = ModelImporterNormalSmoothingSource.PreferSmoothingGroups;
            modify = true;
        }

        // smoothing angle
        if(importer.normalSmoothingAngle != 60)
        {
            importer.normalSmoothingAngle = 60;
            modify = true;
        }

        // tangents
        if(importer.importTangents != ModelImporterTangents.CalculateMikk)
        {
            importer.importTangents = ModelImporterTangents.CalculateMikk;
            modify = true;
        }

        // swap uvs
        if(importer.swapUVChannels == true)
        {
            importer.swapUVChannels = false;
            modify = true;
        }

        // generate lightmap uvs
        if(importer.generateSecondaryUV == true)
        {
            importer.generateSecondaryUV = false;
            modify = true;
        }
        #endregion geometry

        #endregion model

        if (modify)
        {
            importer.SaveAndReimport();
        }
    }
    #endregion  Model import


    #region Animation import
    public void OnPreprocessAnimation()
    {
    }
    #endregion Animation import


    #region Audio import
    public void OnPreprocessAudio()
    {
    }
    #endregion Audio import
}
