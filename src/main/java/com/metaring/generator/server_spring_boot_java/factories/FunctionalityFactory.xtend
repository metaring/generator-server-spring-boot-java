/**
 *    Copyright 2019 MetaRing s.r.l.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

package com.metaring.generator.server_spring_boot_java.factories

import static extension com.metaring.generator.server_spring_boot_java.util.Extensions.*
import static extension com.metaring.generator.util.java.Extensions.*
import static extension com.metaring.generator.model.util.Extensions.*
import com.metaring.generator.model.data.Functionality
import java.util.List
import java.util.ArrayList
import com.metaring.generator.model.data.Module

class FunctionalityFactory implements com.metaring.generator.model.factories.FunctionalityFactory {

    override getFilename(
        Functionality functionality) '''«functionality.packagePath»/«functionality.name.toFirstUpper»Functionality.java'''

    override getContent(Functionality functionality) '''
«functionality.generatedPackageDeclaration»

import java.util.concurrent.CompletableFuture;
«IF functionality.shouldImportTools»
import «"Tools".combineWithSystemNamespace»;
«ENDIF»
import «"functionality.AbstractFunctionality".combineWithSystemNamespace»;
import «"functionality.GeneratedFunctionality".combineWithSystemNamespace»;
import «"functionality.FunctionalityInfo".combineWithSystemNamespace»;
«val functionalityClassName = functionality.name.toFirstUpper + "Functionality"»
«var String inputPackage=null»
«var String input=null»
«IF functionality.input !== null»
«IF (inputPackage = functionality.input.springBootNativeFullyQualifiedNameForImport) !== null && !inputPackage.isInThisPackage(functionality.packageFQN)»
import «inputPackage»;
«ENDIF»
«ENDIF»
«var String outputPackage=null»
«var String output=null»
«IF functionality.output !== null»
«IF (outputPackage = functionality.output.springBootNativeFullyQualifiedNameForImport) !== null && outputPackage != inputPackage && !outputPackage.isInThisPackage(functionality.packageFQN)»
import «outputPackage»;
«ENDIF»
«ENDIF»

abstract class «functionalityClassName» extends AbstractFunctionality implements GeneratedFunctionality {

    static final FunctionalityInfo INFO = FunctionalityInfo.create("«functionality.fullyQualifiedName»", «IF functionality.internal»true«ELSE»false«ENDIF», «IF functionality.reserved»true«ELSE»false«ENDIF», «IF functionality.restricted»true«ELSE»false«ENDIF», «IF functionality.input !== null»"«functionality.input.springBootNativeFullyQualifiedName»"«ELSE»null«ENDIF», «IF functionality.output !== null»"«functionality.output.springBootNativeFullyQualifiedName»"«ELSE»null«ENDIF»);

    static final «functionalityClassName» INSTANCE = new «functionalityClassName»Impl();

    protected «functionalityClassName»() {
        super(INFO, «IF functionality.output !== null»«output = functionality.output.springBootType».class«ELSE»null«ENDIF»);
    }

    @Override
    protected final CompletableFuture<Void> beforePreConditionCheck(Object input) throws Exception {
        CompletableFuture<Void> response = beforePreConditionCheck(«IF functionality.input !== null»input == null ? null : («input = functionality.input.springBootType») input«ENDIF»);
        return response == null ? end : response;
    }

    protected CompletableFuture<Void> beforePreConditionCheck(«IF input!==null»«input» input«ENDIF») throws Exception {
        return end;
    }

    @Override
    protected final CompletableFuture<Void> preConditionCheck(Object input) throws Exception {
        CompletableFuture<Void> response = preConditionCheck(«IF input !== null»input == null ? null : («input») input«ENDIF»);
        return response == null ? end : response;
    }

    protected abstract CompletableFuture<Void> preConditionCheck(«IF input!==null»«input» input«ENDIF») throws Exception;

    @Override
    protected final CompletableFuture<Void> afterPreConditionCheck(Object input) throws Exception {
        CompletableFuture<Void> response = afterPreConditionCheck(«IF input !== null»input == null ? null : («input») input«ENDIF»);
        return response == null ? end : response;
    }

    protected CompletableFuture<Void> afterPreConditionCheck(«IF input!==null»«input» input«ENDIF») throws Exception {
        return end;
    }

    @Override
    protected final CompletableFuture<Void> beforeCall(Object input) throws Exception {
        CompletableFuture<Void> response = beforeCall(«IF input !== null»input == null ? null : («input») input«ENDIF»);
        return response == null ? end : response;
    }

    protected CompletableFuture<Void> beforeCall(«IF input!==null»«input» input«ENDIF») throws Exception {
        return end;
    }

    @Override
    protected final CompletableFuture<Object> call(Object input) throws Exception {
        CompletableFuture<«IF output === null»Void«ELSE»«output»«ENDIF»> call = call(«IF input !==null»(«input») input«ENDIF»);
        if(call == null) {
            return end(null);
        }
        final CompletableFuture<Object> response = new CompletableFuture<>();
        call.whenCompleteAsync((result, error) -> {
            if(error != null) {
                response.completeExceptionally(error);
                return;
            }
            response.complete(result);
        }, EXECUTOR);
        return response;
    }

    protected abstract CompletableFuture<«IF output === null»Void«ELSE»«output»«ENDIF»> call(«IF input !==null»«input» input«ENDIF») throws Exception;

    @Override
    protected final CompletableFuture<Void> afterCall(Object input, Object output) throws Exception {
        CompletableFuture<Void> response = afterCall(«IF input !== null»input == null ? null : («input») input«IF output !== null», «ENDIF»«ENDIF»«IF output !== null»output == null ? null : («output») output«ENDIF»);
        return response == null ? end : response;
    }

    protected CompletableFuture<Void> afterCall(«IF input!==null»«input» input«IF output !== null», «ENDIF»«ENDIF»«IF output!==null»«output» output«ENDIF») throws Exception {
        return end;
    }

    @Override
    protected final CompletableFuture<Void> beforePostConditionCheck(Object input, Object output) throws Exception {
        CompletableFuture<Void> response = beforePostConditionCheck(«IF input !== null»input == null ? null : («input») input«IF output !== null», «ENDIF»«ENDIF»«IF output !== null»output == null ? null : («output») output«ENDIF»);
        return response == null ? end : response;
    }

    protected CompletableFuture<Void> beforePostConditionCheck(«IF input!==null»«input» input«IF output !== null», «ENDIF»«ENDIF»«IF output!==null»«output» output«ENDIF») throws Exception {
        return end;
    }

    @Override
    protected final CompletableFuture<Void> postConditionCheck(Object input, Object output) throws Exception {
        CompletableFuture<Void> response = postConditionCheck(«IF input !== null»input == null ? null : («input») input«IF output !== null», «ENDIF»«ENDIF»«IF output !== null»output == null ? null : («output») output«ENDIF»);
        return response == null ? end : response;
    }

    protected abstract CompletableFuture<Void> postConditionCheck(«IF input !== null»«input» input«IF output !== null», «ENDIF»«ENDIF»«IF output !== null»«output» output«ENDIF») throws Exception;

    @Override
    protected final CompletableFuture<Void> afterPostConditionCheck(Object input, Object output) throws Exception {
        CompletableFuture<Void> response = afterPostConditionCheck(«IF input !== null»input == null ? null : («input») input«IF output !== null», «ENDIF»«ENDIF»«IF output !== null»output == null ? null : («output») output«ENDIF»);
        return response == null ? end : response;
    }

    protected CompletableFuture<Void> afterPostConditionCheck(«IF input !== null»«input» input«IF output !== null», «ENDIF»«ENDIF»«IF output!==null»«output» output«ENDIF») throws Exception {
        return end;
    }
    «IF input !== null»

    @Override
    protected final Object getInputFromJsonWork(String inputJson) {
        return «functionality.input.getSpringBootDataOrNativeTypeFromJsonCreatorMethodForFunctionality("inputJson")»;
    }
    «ENDIF»
}'''

    override getModuleFunctionalitiesManagerFilename(Module module, List<Functionality> functionalities) '''«module.packagePath»/«module.dotAwareName.toFirstUpper»FunctionalitiesManager.java'''

    override getModuleFunctionalitiesManagerContent(Module module, List<Functionality> functionalities) '''
«module.generatedPackageDeclaration»

import «"functionality.FunctionalityInfo".combineWithSystemNamespace»;
import «"functionality.FunctionalityManager".combineWithSystemNamespace»;
import «"functionality.GeneratedFunctionalitiesManager".combineWithSystemNamespace»;
import «"functionality.Functionality".combineWithSystemNamespace»;
«IF functionalities.exists[it.reserved || it.restricted]»import «"type.DataRepresentation".combineWithSystemNamespace»;«ENDIF»
import java.util.concurrent.CompletableFuture;
«FOR importation : functionalities.getImportsForManager»
«IF !importation.equalsIgnoreCase("functionality.FunctionalityExecutionResult".combineWithSystemNamespace) && !importation.isInThisPackage(module.packageFQN) && (!functionalities.exists[it.reserved || it.restricted] || importation != "type.DataRepresentation".combineWithSystemNamespace)»import «importation»;«ENDIF»
«ENDFOR»
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Component
@Configuration
public class «module.dotAwareName.toFirstUpper»FunctionalitiesManager implements GeneratedFunctionalitiesManager {

«functionalities.generateFunctionalitiesInfoForManager»
«functionalities.generateFunctionalitiesCallsForManager»
«functionalities.generateFunctionalitiesBeans»
}
'''

    def static List<String> getImportsForManager(List<Functionality> functionalities) {
        var imports = new ArrayList<String>
        for (functionality : functionalities) {
            if (functionality.input !== null) {
                var import = functionality.input.springBootNativeFullyQualifiedName
                if (!imports.contains(import)) {
                    imports.add(import)
                }
            }
            if (functionality.output !== null) {
                var import = functionality.output.springBootNativeFullyQualifiedName
                if (!imports.contains(import)) {
                    imports.add(import)
                }
            }
        }
        return imports
    }

    def static generateFunctionalitiesInfoForManager(List<Functionality> functionalities) '''
«FOR functionality : functionalities»    public static final FunctionalityInfo «functionality.name.toStaticFieldName» = «functionality.name.toFirstUpper»Functionality.INFO;

«ENDFOR»
'''

    def static generateFunctionalitiesCallsForManager(List<Functionality> functionalities) '''
«FOR functionality : functionalities»
«var String input=null»
«var String inputLower=null»
«var String output=null»
    public static final CompletableFuture<«IF functionality.output !== null»«output = functionality.output.springBootType»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»(«IF functionality.input !== null»«input = functionality.input.springBootType» «inputLower = (input == "Boolean" ? "input" : input.toFirstLower)»«ENDIF») {
        return FunctionalityManager.call(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, (String) null, (String) null«IF inputLower !== null», «inputLower»«ENDIF»«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

    public static final CompletableFuture<«IF output !== null»«output»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»(Functionality functionality«IF input !== null», «input» «inputLower»«ENDIF») {
        return FunctionalityManager.call(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, functionality, (String) null, (String) null«IF inputLower !== null», «inputLower»«ENDIF»«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«IF input !== null»    public static final CompletableFuture<«IF output !== null»«output»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»FromJson(String «inputLower»Json) {
        return FunctionalityManager.callFromJson(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, (String) null, (String) null, «inputLower»Json«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«ENDIF»
«IF input !== null»    public static final CompletableFuture<«IF output !== null»«output»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»FromJson(Functionality callingFunctionality, String «inputLower»Json) {
        return FunctionalityManager.callFromJson(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, callingFunctionality, (String) null, (String) null, «inputLower»Json«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«ENDIF»
«IF functionality.reserved || functionality.restricted»    public static final CompletableFuture<«IF functionality.output !== null»«output = functionality.output.type»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»(String identificationDataJson«IF functionality.restricted», String enableDataJson«ENDIF»«IF input !== null», «input» «inputLower»«ENDIF») {
        return FunctionalityManager.call(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, identificationDataJson, «IF functionality.restricted»enableDataJson«ELSE»(String) null«ENDIF»«IF inputLower !== null», «inputLower»«ENDIF»«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

    public static final CompletableFuture<«IF functionality.output !== null»«output = functionality.output.type»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»(Functionality functionality, String identificationDataJson«IF functionality.restricted», String enableDataJson«ENDIF»«IF input !== null», «input» «inputLower»«ENDIF») {
        return FunctionalityManager.call(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, functionality, identificationDataJson, «IF functionality.restricted»enableDataJson«ELSE»(String) null«ENDIF»«IF inputLower !== null», «inputLower»«ENDIF»«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«IF input !== null»    public static final CompletableFuture<«IF output !== null»«output»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»FromJson(String identificationDataJson, «IF functionality.restricted»String enableDataJson, «ENDIF»String «inputLower»Json) {
        return FunctionalityManager.callFromJson(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, identificationDataJson, «IF functionality.restricted»enableDataJson«ELSE»(String) null«ENDIF», «inputLower»Json«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«ENDIF»
«IF input !== null»    public static final CompletableFuture<«IF output !== null»«output»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»FromJson(Functionality callingFunctionality, String identificationDataJson, «IF functionality.restricted»String enableDataJson, «ENDIF»String «inputLower»Json) {
        return FunctionalityManager.callFromJson(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, callingFunctionality, identificationDataJson, «IF functionality.restricted»enableDataJson«ELSE»(String) null«ENDIF», «inputLower»Json«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«ENDIF»
    public static final CompletableFuture<«IF functionality.output !== null»«output = functionality.output.type»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»(DataRepresentation identificationData«IF functionality.restricted», DataRepresentation enableData«ENDIF»«IF input !== null», «input» «inputLower»«ENDIF») {
        return FunctionalityManager.call(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, identificationData, «IF functionality.restricted»enableData«ELSE»(DataRepresentation) null«ENDIF»«IF inputLower !== null», «inputLower»«ENDIF»«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

    public static final CompletableFuture<«IF functionality.output !== null»«output = functionality.output.type»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»(Functionality functionality, DataRepresentation identificationData«IF functionality.restricted», DataRepresentation enableData«ENDIF»«IF input !== null», «input» «inputLower»«ENDIF») {
        return FunctionalityManager.call(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, functionality, identificationData, «IF functionality.restricted»enableData«ELSE»(DataRepresentation) null«ENDIF»«IF inputLower !== null», «inputLower»«ENDIF»«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«IF input !== null»    public static final CompletableFuture<«IF output !== null»«output»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»FromJson(DataRepresentation identificationData, «IF functionality.restricted»DataRepresentation enableData, «ENDIF»String «inputLower»Json) {
        return FunctionalityManager.callFromJson(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, identificationData, «IF functionality.restricted»enableData«ELSE»(DataRepresentation) null«ENDIF», «inputLower»Json«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«ENDIF»
«IF input !== null»    public static final CompletableFuture<«IF output !== null»«output»«ELSE»Void«ENDIF»> «functionality.name.toFirstLower»FromJson(Functionality callingFunctionality, DataRepresentation identificationData, «IF functionality.restricted»DataRepresentation enableData, «ENDIF»String «inputLower»Json) {
        return FunctionalityManager.callFromJson(«functionality.name.toStaticFieldName», «functionality.name.toFirstUpper»Functionality.class, callingFunctionality, identificationData, «IF functionality.restricted»enableData«ELSE»(DataRepresentation) null«ENDIF», «inputLower»Json«IF functionality.output !== null», result -> result«functionality.output.getSpringBootDataOrNativeTypeFromJsonCreatorMethod»«ENDIF»);
    }

«ENDIF»
«ENDIF»
«ENDFOR»
'''

    def static generateFunctionalitiesBeans(List<Functionality> functionalities) '''
«FOR functionality : functionalities»    @Bean
    static final «functionality.name.toFirstUpper»Functionality «functionality.name.toFirstLower»Functionality() {
        return «functionality.name.toFirstUpper»Functionality.INSTANCE;
    }

«ENDFOR»
'''
}