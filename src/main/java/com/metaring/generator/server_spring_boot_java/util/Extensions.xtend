package com.metaring.generator.server_spring_boot_java.util

import com.metaring.generator.model.data.Attribute
import com.metaring.generator.model.data.Data
import static com.metaring.generator.util.java.Extensions.*

final class Extensions {

    static def getSpringBootNativeFullyQualifiedNameForImport(Attribute attribute) {
        return getSpringBootNativeFullyQualifiedName(attribute, true)
    }

    static def getSpringBootNativeFullyQualifiedName(Attribute attribute) {
        return getSpringBootNativeFullyQualifiedName(attribute, false)
    }

    static def getSpringBootNativeFullyQualifiedName(Data data) {
        return '''«FOR pn : data.packagesChain»«pn».«ENDFOR»«data.name.toFirstUpper»Model'''
    }

    private static def getSpringBootNativeFullyQualifiedName(Attribute attribute, boolean forImport) {
        if (attribute === null) {
            return null
        }
        if (!attribute.native) {
            return '''«FOR pn : attribute.packagesChain»«pn».«ENDFOR»«attribute.name.toFirstUpper»«IF attribute.enumerator»Enumerator«ELSE»Model«ENDIF»«IF attribute.many»Series«ENDIF»'''
        }
    }

    static def getSpringBootType(Attribute attribute) {
        if (attribute === null) {
            return null
        }
        if (!attribute.native) {
            return '''«attribute.name.toFirstUpper»«IF attribute.enumerator»Enumerator«ELSE»Model«ENDIF»«IF attribute.many»Series«ENDIF»'''
        }
        return getType(attribute)
    }

    def static getSpringBootDataOrNativeTypeFromJsonCreatorMethod(Attribute attribute, String jsonVarName) {
        return getDataOrNativeTypeFromJsonCreatorMethod(attribute, jsonVarName).createSpringBootDataOrNativeTypeFromJsonCreatorMethod(attribute)
    }

    def static getSpringBootDataOrNativeTypeFromJsonCreatorMethod(Attribute attribute) {
        return getDataOrNativeTypeFromJsonCreatorMethod(attribute).createSpringBootDataOrNativeTypeFromJsonCreatorMethod(attribute)
    }

    def static getSpringBootDataOrNativeTypeFromJsonCreatorMethodForFunctionality(Attribute attribute, String jsonVarName) {
        return getDataOrNativeTypeFromJsonCreatorMethodForFunctionality(attribute, jsonVarName).createSpringBootDataOrNativeTypeFromJsonCreatorMethod(attribute)
    }

    private def static createSpringBootDataOrNativeTypeFromJsonCreatorMethod(String name, Attribute attribute) {
        if(!(attribute !== null && !attribute.native && !attribute.enumerator)) {
            return name
        }
        var findNormal = (if(attribute.many) "Series" else "") + ".class"
        var findFromJson = (if(attribute.many) "Series" else "") + ".fromJson"
        return name.replace(findNormal, "Model" + findNormal).replace(findFromJson, "Model" + findFromJson)
    }
}