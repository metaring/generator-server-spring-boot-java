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

import com.metaring.generator.model.data.Module

import static extension com.metaring.generator.util.java.Extensions.*
import static extension com.metaring.generator.model.util.Extensions.*

class ModuleFactory implements com.metaring.generator.model.factories.ModuleFactory {

    override getModuleInfoFilename(Module module) '''«module.packagePath»/ModuleInfo.java'''

    override getModuleInfoContent(Module module) '''
«module.generatedPackageDeclaration»

public interface ModuleInfo {

}'''

    override getIdentificationHelperFilename(Module module) '''«module.packagePath»/IdentificationHelper.java'''

    override getIdentificationHelperContent(Module module) '''
«module.generatedPackageDeclaration»

import «"functionality.FunctionalityContext".combineWithSystemNamespace»;

public class IdentificationHelper {

    private static final String IDENTIFICATION_DATA = "IDENTIFICATION_DATA";

    public static final IdentificationDataModel getIdentificationData(FunctionalityContext functionalityContext) {
        return (IdentificationDataModel) functionalityContext.getData().get(IDENTIFICATION_DATA);
    }
}'''

    override getIdentificationModuleInfoFilename(Module module) {
        "auth/IdentificationModuleInfo".combineWithSystemNamespace.replace(".", "/") + ".java"
    }

    override getIdentificationModuleInfoContent(Module module) '''
package «"auth".combineWithSystemNamespace»;

import «"functionality.FunctionalityInfo".combineWithSystemNamespace»;

public interface IdentificationModuleInfo {

    public static final FunctionalityInfo INFO = FunctionalityInfo.create("«module.fullyQualifiedName».verifyIdentification", true, false, false, "«module.fullyQualifiedName».IdentificationDataModel", "java.lang.Boolean");

}'''

    override getVerifiyIdentificationFunctionalityFilename(
        Module module) '''«module.packagePath»/VerifyIdentificationFunctionality.java'''

    override getVerifiyIdentificationFunctionalityContent(Module module) '''
«module.generatedPackageDeclaration»

import «"functionality.AbstractFunctionality".combineWithSystemNamespace»;
import «"functionality.GeneratedFunctionality".combineWithSystemNamespace»;
import java.util.concurrent.CompletableFuture;
import «"auth.IdentificationModuleInfo".combineWithSystemNamespace»;
import «module.packageFQN».IdentificationDataModel;

public abstract class VerifyIdentificationFunctionality extends AbstractFunctionality implements GeneratedFunctionality {

    static final VerifyIdentificationFunctionality INSTANCE = new VerifyIdentificationFunctionalityImpl();

    protected VerifyIdentificationFunctionality() {
        super(IdentificationModuleInfo.INFO, Boolean.class);
    }

    @Override
    protected final CompletableFuture<Void> beforePreConditionCheck(Object input) throws Exception {
        return beforePreConditionCheck(input == null ? null : (IdentificationDataModel) input);
    }

    protected CompletableFuture<Void> beforePreConditionCheck(IdentificationDataModel input) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Void> preConditionCheck(Object input) throws Exception {
        return preConditionCheck(input == null ? null : (IdentificationDataModel) input);
    }

    protected abstract CompletableFuture<Void> preConditionCheck(IdentificationDataModel input) throws Exception;

    @Override
    protected final CompletableFuture<Void> afterPreConditionCheck(Object input) throws Exception {
        return afterPreConditionCheck(input == null ? null : (IdentificationDataModel) input);
    }

    protected CompletableFuture<Void> afterPreConditionCheck(IdentificationDataModel input) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Void> beforeCall(Object input) throws Exception {
        return beforeCall(input == null ? null : (IdentificationDataModel) input);
    }

    protected CompletableFuture<Void> beforeCall(IdentificationDataModel input) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Object> call(Object input) throws Exception {
        CompletableFuture<Boolean> call = call(input == null ? null : (IdentificationDataModel) input);
        if(call == null) {
            return CompletableFuture.completedFuture(null);
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

    protected abstract CompletableFuture<Boolean> call(IdentificationDataModel input) throws Exception;

    @Override
    protected final CompletableFuture<Void> afterCall(Object input, Object output) throws Exception {
        return afterCall(input == null ? null : (IdentificationDataModel) input, output == null ? null : (Boolean) output);
    }

    protected CompletableFuture<Void> afterCall(IdentificationDataModel input, Boolean output) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Void> beforePostConditionCheck(Object input, Object output) throws Exception {
        return beforePostConditionCheck(input == null ? null : (IdentificationDataModel) input, output == null ? null : (Boolean) output);
    }

    protected CompletableFuture<Void> beforePostConditionCheck(IdentificationDataModel input, Boolean output) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Void> postConditionCheck(Object input, Object output) throws Exception {
        return postConditionCheck(input == null ? null : (IdentificationDataModel) input, output == null ? null : (Boolean) output);
    }

    protected abstract CompletableFuture<Void> postConditionCheck(IdentificationDataModel input, Boolean output) throws Exception;

    @Override
    protected final CompletableFuture<Void> afterPostConditionCheck(Object input, Object output) throws Exception {
        return afterPostConditionCheck(input == null ? null : (IdentificationDataModel) input, output == null ? null : (Boolean) output);
    }

    protected CompletableFuture<Void> afterPostConditionCheck(IdentificationDataModel input, Boolean output) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final Object getInputFromJsonWork(String inputJson) {
        return IdentificationDataModel.fromJson(inputJson);
    }
}'''

    override getLimitedAccessHelperFilename(Module module) '''«module.packagePath»/LimitedAccessHelper.java'''

    override getLimitedAccessHelperContent(Module module) '''
«module.generatedPackageDeclaration»

import «"functionality.FunctionalityContext".combineWithSystemNamespace»;

public class LimitedAccessHelper {

    private static final String ENABLE_DATA = "ENABLE_DATA";

    public static final EnableDataModel getEnableData(FunctionalityContext functionalityContext) {
        return (EnableDataModel) functionalityContext.getData().get(ENABLE_DATA);
    }
}'''

    override getLimitedAccessModuleInfoFilename(Module module) {
        "auth/LimitedAccessModuleInfo".combineWithSystemNamespace.replace(".", "/") + ".java"
    }

    override getLimitedAccessModuleInfoContent(Module module) '''
package «"auth".combineWithSystemNamespace»;

import «"functionality.FunctionalityInfo".combineWithSystemNamespace»;

public interface LimitedAccessModuleInfo {

    public static final FunctionalityInfo INFO = FunctionalityInfo.create("«module.fullyQualifiedName».verifyEnable", true, false, false, "«module.fullyQualifiedName».EnableDataModel", "java.lang.Boolean");

}'''

    override getVerifiyEnableFunctionalityFilename(
        Module module) '''«module.packagePath»/VerifyEnableFunctionality.java'''

    override getVerifiyEnableFunctionalityContent(Module module) '''
«module.generatedPackageDeclaration»

import «"functionality.AbstractFunctionality".combineWithSystemNamespace»;
import «"functionality.GeneratedFunctionality".combineWithSystemNamespace»;
import «"auth.LimitedAccessModuleInfo".combineWithSystemNamespace»;
import «module.packageFQN».EnableDataModel;
import java.util.concurrent.CompletableFuture;

public abstract class VerifyEnableFunctionality extends AbstractFunctionality implements GeneratedFunctionality {

    static final VerifyEnableFunctionality INSTANCE = new VerifyEnableFunctionalityImpl();

    protected VerifyEnableFunctionality() {
        super(LimitedAccessModuleInfo.INFO, Boolean.class);
    }

    @Override
    protected final CompletableFuture<Void> beforePreConditionCheck(Object input) throws Exception {
        return beforePreConditionCheck(input == null ? null : (EnableDataModel) input);
    }

    protected CompletableFuture<Void> beforePreConditionCheck(EnableDataModel input) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Void> preConditionCheck(Object input) throws Exception {
        return preConditionCheck(input == null ? null : (EnableDataModel) input);
    }

    protected abstract CompletableFuture<Void> preConditionCheck(EnableDataModel input) throws Exception;

    @Override
    protected final CompletableFuture<Void> afterPreConditionCheck(Object input) throws Exception {
        return afterPreConditionCheck(input == null ? null : (EnableDataModel) input);
    }

    protected CompletableFuture<Void> afterPreConditionCheck(EnableDataModel input) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Void> beforeCall(Object input) throws Exception {
        return beforeCall(input == null ? null : (EnableDataModel) input);
    }

    protected CompletableFuture<Void> beforeCall(EnableDataModel input) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Object> call(Object input) throws Exception {
        CompletableFuture<Boolean> call = call(input == null ? null : (EnableDataModel) input);
        if(call == null) {
            return CompletableFuture.completedFuture(null);
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

    protected abstract CompletableFuture<Boolean> call(EnableDataModel input) throws Exception;

    @Override
    protected final CompletableFuture<Void> afterCall(Object input, Object output) throws Exception {
        return afterCall(input == null ? null : (EnableDataModel) input, output == null ? null : (Boolean) output);
    }

    protected CompletableFuture<Void> afterCall(EnableDataModel input, Boolean output) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Void> beforePostConditionCheck(Object input, Object output) throws Exception {
        return beforePostConditionCheck(input == null ? null : (EnableDataModel) input, output == null ? null : (Boolean) output);
    }

    protected CompletableFuture<Void> beforePostConditionCheck(EnableDataModel input, Boolean output) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final CompletableFuture<Void> postConditionCheck(Object input, Object output) throws Exception {
        return postConditionCheck(input == null ? null : (EnableDataModel) input, output == null ? null : (Boolean) output);
    }

    protected abstract CompletableFuture<Void> postConditionCheck(EnableDataModel input, Boolean output) throws Exception;

    @Override
    protected final CompletableFuture<Void> afterPostConditionCheck(Object input, Object output) throws Exception {
        return afterPostConditionCheck(input == null ? null : (EnableDataModel) input, output == null ? null : (Boolean) output);
    }

    protected CompletableFuture<Void> afterPostConditionCheck(EnableDataModel input, Boolean output) throws Exception {
        return CompletableFuture.completedFuture(null);
    }

    @Override
    protected final Object getInputFromJsonWork(String inputJson) {
        return EnableDataModel.fromJson(inputJson);
    }
}'''

    override getEmailModuleFilename() {
        "email/EmailTemplatesModuleInfo".combineWithSystemNamespace.replace(".", "/") + ".java"
    }

    override getEmailModuleContent() '''
package «"email".combineWithSystemNamespace»;

public interface EmailTemplatesModuleInfo {

}'''
}
