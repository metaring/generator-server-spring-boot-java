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

import com.metaring.generator.model.data.Functionality
import com.metaring.generator.model.data.Module
import com.metaring.generator.model.util.Extensions

class ModuleFactory implements com.metaring.generator.model.factories.ModuleFactory {

    override getDefaultConfigurationFilename(Module root) {
        Extensions.getDefaultConfigurationFilename().toString
    }

    override getDefaultConfigurationFileContent(Module root, Functionality verifyIdentificationDataFunctionality, Functionality verifyEnableDataFunctionality) {
        Extensions.getDefaultConfigurationFileContent(root, verifyIdentificationDataFunctionality, verifyEnableDataFunctionality).toString
    }
}