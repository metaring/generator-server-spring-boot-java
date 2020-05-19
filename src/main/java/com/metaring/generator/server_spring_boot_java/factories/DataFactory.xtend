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

import com.metaring.generator.model.data.Data

import static extension com.metaring.generator.util.java.Extensions.*
import static extension com.metaring.generator.model.util.Extensions.*

class DataFactory implements com.metaring.generator.model.factories.DataFactory {

    override getFilename(Data data) '''«data.packagePath»/«IF data.incomplete»Abstract«ENDIF»«data.name.toFirstUpper»Model.java'''

    override getManyFilename(Data data) '''«data.packagePath»/«data.name.toFirstUpper»ModelSeries.java'''

    override getContent(Data data) '''
«data.generatedPackageDeclaration»

«val dataClassName = data.name.toFirstUpper + "Model"»
«val dataFQN = data.nativeFullyQualifiedName»
«val dataAttributeTypes = data.attributes.map[it.type + (it.data ? 'Model' : '')]»
«val dataAttributeNames = data.attributes.map[it.valueName]»
«FOR attributeFQN : data.attributes.filter[attribute | !attribute.unknown].map[it.nativeFullyQualifiedNameForImport + (it.data ? 'Model' : '')].filter[it !== null && !it.isInSamePackage(dataFQN) && !it.trim.equalsIgnoreCase('null')].toSet»
import «attributeFQN»;
«ENDFOR»
import «"Tools".combineWithSystemNamespace»;
import «"type.DataRepresentation".combineWithSystemNamespace»;
import «"GeneratedCoreType".combineWithSystemNamespace»;

«IF !data.internal»public «ENDIF»«IF data.incomplete»abstract «ENDIF»class «IF data.incomplete»Abstract«ENDIF»«dataClassName» implements GeneratedCoreType {

    public static final String FULLY_QUALIFIED_NAME = "«data.fullyQualifiedName»";

«var fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    fields+="    private " + dataAttributeTypes.get(i) + " " + dataAttributeNames.get(i) + ";\n"
}»
«fields»

«fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    fields+=dataAttributeTypes.get(i) + " " + dataAttributeNames.get(i)
    if(i < dataAttributeTypes.size -1) {
        fields+=", "
    }
}»
    «IF data.incomplete»protected«ELSE»private«ENDIF» «IF data.incomplete»Abstract«ENDIF»«dataClassName»(«fields») {
    «fields = ""»
    «for(var i = 0; i < dataAttributeTypes.size; i++) {
        fields+="    this." + dataAttributeNames.get(i) + " = " + dataAttributeNames.get(i) + ";\n"
    }»
    «fields»
    }

    «fields = ""»
    «for(var i = 0; i < dataAttributeTypes.size; i++) {
        fields+="    public " + dataAttributeTypes.get(i) + " get" + dataAttributeNames.get(i).toFirstUpper + "() {\n"
        fields+="        return this." + dataAttributeNames.get(i) + ";\n    }\n\n"
    }»
«fields»
«fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    fields+=dataAttributeTypes.get(i) + " " + dataAttributeNames.get(i)
    if(i < dataAttributeTypes.size -1) {
        fields+=", "
    }
}»
    public static «dataClassName» create(«fields») {
«fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    fields+=dataAttributeNames.get(i)
    if(i < dataAttributeTypes.size -1) {
        fields+=", "
    }
}»
        return new «dataClassName»(«fields»);
    }

    public static «dataClassName» fromJson(String jsonString) {

        if(jsonString == null) {
            return null;
        }

        jsonString = jsonString.trim();
        if(jsonString.isEmpty()) {
            return null;
        }

        if(jsonString.equalsIgnoreCase("null")) {
            return null;
        }

        DataRepresentation dataRepresentation = Tools.FACTORY_DATA_REPRESENTATION.fromJson(jsonString);

«fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    var fieldName = dataAttributeNames.get(i)
    fields+= "        " + dataAttributeTypes.get(i) + " " + fieldName + " = null;\n"
    fields+= "        if(dataRepresentation.hasProperty(\"" + fieldName + "\")) {\n"
    fields+= "            try {\n"
    fields+= "                " + fieldName + " = "
    fields+=data.attributes.get(i).getDataOrNativeTypeFromJsonCreatorMethod(fieldName).replace('.class', (data.attributes.get(i).data ? 'Model.class' : '.class'));
    fields+=";\n            } catch (Exception e) {\n            }\n        }\n\n"
}»
«fields»
«fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    fields+=dataAttributeNames.get(i)
    if(i < dataAttributeTypes.size -1) {
        fields+=", "
    }
}»
        «dataClassName» «dataClassName.toFirstLower» = create(«fields»);
        return «dataClassName.toFirstLower»;
    }

    public static «dataClassName» fromObject(Object object) {

        if(object == null) {
            return null;
        }

        DataRepresentation dataRepresentation = Tools.FACTORY_DATA_REPRESENTATION.fromObject(object);

«fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    var fieldName = dataAttributeNames.get(i)
    fields+= "        " + dataAttributeTypes.get(i) + " " + fieldName + " = null;\n"
    fields+= "        if(dataRepresentation.hasProperty(\"" + fieldName + "\")) {\n"
    fields+= "            try {\n"
    fields+= "                " + fieldName + " = "
    fields+=data.attributes.get(i).getDataOrNativeTypeFromJsonCreatorMethod(fieldName).replace('.class', (data.attributes.get(i).data ? 'Model.class' : '.class'));
    fields+=";\n            } catch (Exception e) {\n            }\n        }\n\n"
}»
«fields»
«fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    fields+=dataAttributeNames.get(i)
    if(i < dataAttributeTypes.size -1) {
        fields+=", "
    }
}»
        «dataClassName» «dataClassName.toFirstLower» = create(«fields»);
        return «dataClassName.toFirstLower»;
    }

    public DataRepresentation toDataRepresentation() {
        DataRepresentation dataRepresentation = Tools.FACTORY_DATA_REPRESENTATION.create();
«fields = ""»
«for(var i = 0; i < dataAttributeTypes.size; i++) {
    var fieldName = dataAttributeNames.get(i)
    var fieldAttributeType = data.attributes.get(i)
    fields+="        if (" + fieldName + " != null) {\n"
    fields+="            dataRepresentation.add(\"" + fieldName + "\", " + fieldName
    if(!fieldAttributeType.unknown && fieldAttributeType.many) {
        fields += ".toArray()"
    }
    fields+=");\n"
    fields+="        }\n\n"
}»
«fields»
«fields = ""»
        return dataRepresentation;
    }

    @Override
    public String toJson() {
        return toDataRepresentation().toJson();
    }

    @Override
    public String toString() {
        return this.toJson();
    }
}'''

    override getManyContent(Data data) '''
«data.generatedPackageDeclaration»

«val dataClassName = data.name.toFirstUpper + "Model"»
«val datas = dataClassName.toFirstLower.plural»
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.function.Predicate;
import java.util.function.UnaryOperator;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import org.apache.calcite.linq4j.Enumerable;
import org.apache.calcite.linq4j.Linq4j;
import «"Tools".combineWithSystemNamespace»;
import «"type.DataRepresentation".combineWithSystemNamespace»;
import «"GeneratedCoreType".combineWithSystemNamespace»;

«IF !data.internal»public «ENDIF»class «dataClassName»Series extends ArrayList<«dataClassName»> implements GeneratedCoreType {

    private static final long serialVersionUID = 1L;
    private Enumerable<«dataClassName»> internalEnumerable;

    private «dataClassName»Series(Iterable<«dataClassName»> iterable) {
        super();
        this.addAll(StreamSupport.stream(iterable.spliterator(), false).collect(Collectors.toList()));
    }

    public static «dataClassName»Series create(Iterable<«dataClassName»> iterable) {
        return new «dataClassName»Series(iterable);
    }

    public static «dataClassName»Series create(«dataClassName»... «datas») {
        return create(«datas» == null ? new ArrayList<>() : Arrays.asList(«datas»));
    }

    public «dataClassName»[] toArray() {
        return this.toArray(new «dataClassName»[this.size()]);
    }


    public Enumerable<«dataClassName»> asEnumerable() {
        return internalEnumerable != null ? internalEnumerable : (internalEnumerable = Linq4j.asEnumerable(this));
    }

    public boolean addAll(Enumerable<«dataClassName»> enumerable) {
        return enumerable == null ? false : this.addAll(enumerable.toList());
    }

    public boolean containsAll(Enumerable<«dataClassName»> enumerable) {
        return enumerable == null ? false : this.containsAll(enumerable.toList());
    }

    public boolean removeAll(Enumerable<«dataClassName»> enumerable) {
        return enumerable == null ? false : this.removeAll(enumerable.toList());
    }

    public boolean retainAll(Enumerable<«dataClassName»> enumerable) {
        return enumerable == null ? false : this.retainAll(enumerable.toList());
    }

    public boolean addAll(«dataClassName»[] array) {
        return array == null ? false : this.addAll(Arrays.asList(array));
    }

    public boolean containsAll(«dataClassName»[] array) {
        return array == null ? false : this.containsAll(Arrays.asList(array));
    }

    public boolean removeAll(«dataClassName»[] array) {
        return array == null ? false : this.removeAll(Arrays.asList(array));
    }

    public boolean retainAll(«dataClassName»[] array) {
        return array == null ? false : this.retainAll(Arrays.asList(array));
    }

    private void recreateEnumerable() {
        if (internalEnumerable != null) {
            internalEnumerable = Linq4j.asEnumerable(this);
        }
    }

    @Override
    public boolean add(«dataClassName» e) {
        boolean test = super.add(e);
        recreateEnumerable();
        return test;
    }

    @Override
    public void add(int index, «dataClassName» element) {
        super.add(index, element);
        recreateEnumerable();
    }

    @Override
    public boolean addAll(Collection<? extends «dataClassName»> c) {
        boolean test = super.addAll(c);
        recreateEnumerable();
        return test;
    }

    @Override
    public boolean addAll(int index, Collection<? extends «dataClassName»> c) {
        boolean test = super.addAll(index, c);
        recreateEnumerable();
        return test;
    }

    @Override
    public boolean remove(Object o) {
        boolean test = super.remove(o);
        recreateEnumerable();
        return test;
    }

    @Override
    public «dataClassName» remove(int index) {
        «dataClassName» test = super.remove(index);
        recreateEnumerable();
        return test;
    }

    @Override
    public boolean removeAll(Collection<?> c) {
        boolean test = super.removeAll(c);
        recreateEnumerable();
        return test;
    }

    @Override
    public boolean removeIf(Predicate<? super «dataClassName»> filter) {
        boolean test = super.removeIf(filter);
        recreateEnumerable();
        return test;
    }

    @Override
    public boolean retainAll(Collection<?> c) {
        boolean test = super.retainAll(c);
        recreateEnumerable();
        return test;
    }

    @Override
    public void replaceAll(UnaryOperator<«dataClassName»> operator) {
        super.replaceAll(operator);
        recreateEnumerable();
    }

    public static «dataClassName»Series fromJson(String jsonString) {
        if (jsonString == null) {
            return null;
        }
        jsonString = jsonString.trim();
        if(jsonString.isEmpty()) {
            return null;
        }
        if(jsonString.equalsIgnoreCase("null")) {
            return null;
        }

        DataRepresentation dataRepresentation = Tools.FACTORY_DATA_REPRESENTATION.fromJson(jsonString);
        List<«dataClassName»> list = new ArrayList<>();
        for(DataRepresentation data : dataRepresentation) {
            list.add(«dataClassName».fromJson(data.asText()));
        }
        return new «dataClassName»Series(list);
    }

    public static «dataClassName»Series fromObject(Object object) {
        if (object == null) {
            return null;
        }

        DataRepresentation dataRepresentation = Tools.FACTORY_DATA_REPRESENTATION.fromObject(object);
        List<«dataClassName»> list = new ArrayList<>();
        for(DataRepresentation data : dataRepresentation) {
            list.add(«dataClassName».fromJson(data.asText()));
        }
        return new «dataClassName»Series(list);
    }

    public DataRepresentation toDataRepresentation() {
        return Tools.FACTORY_DATA_REPRESENTATION.fromJson(toJson());
    }

    @Override
    public String toJson() {
        StringBuilder sb = new StringBuilder("[");
        if(!isEmpty()) {
            forEach(it -> sb.append(it.toJson()).append(","));
            sb.delete(sb.length() - 1, sb.length());
        }
        return sb.append("]").toString();
    }

    @Override
    public String toString() {
        return toJson();
    }
}'''

}
