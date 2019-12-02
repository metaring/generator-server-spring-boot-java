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

import static extension com.metaring.generator.util.java.Extensions.*
import static extension com.metaring.generator.model.util.Extensions.*
import com.metaring.generator.model.data.Enumerator

class EnumeratorFactory implements com.metaring.generator.model.factories.EnumeratorFactory {

    override getFilename(Enumerator enumerator) '''«enumerator.packagePath»/«enumerator.name.toFirstUpper»Enumerator.java'''

    override getManyFilename(Enumerator enumerator) '''«enumerator.packagePath»/«enumerator.name.toFirstUpper»EnumeratorSeries.java'''

    override getContent(Enumerator enumerator) '''
«enumerator.generatedPackageDeclaration»

«val enumeratorClassName = enumerator.name.toFirstUpper + "Enumerator"»
import «"Tools".combineWithSystemNamespace»;
import «"type.DataRepresentation".combineWithSystemNamespace»;
import «"GeneratedCoreType".combineWithSystemNamespace»;

«IF !enumerator.internal»public «ENDIF»class «enumeratorClassName» implements GeneratedCoreType {

    «FOR value : enumerator.values»
    public static final «enumeratorClassName» «value.name.toStaticFieldName» = new «enumeratorClassName»("«value.name.toStaticFieldName»", «value.numericValue»l, "«value.textualValue»");
    «ENDFOR»

    private String name;
    private Long numericValue;
    private String textualValue;

    private «enumeratorClassName»(String name, Long numericValue, String textualValue) {
        this.name = name;
        this.numericValue = numericValue;
        this.textualValue = textualValue;
    }

    public String getName() {
        return this.name;
    }

    public Long getNumericValue() {
        return this.numericValue;
    }

    public String getTextualValue() {
        return this.textualValue;
    }

    public static final «enumeratorClassName»Series listAll() {
        return «enumeratorClassName»Series.create(«FOR value : enumerator.values SEPARATOR ', '»«value.name.toStaticFieldName»«ENDFOR»);
    }

    public static «enumeratorClassName» getByNumericValue(Long numericValue) {
        if(numericValue == null) {
            return null;
        }
        switch(numericValue.intValue()) {
            «FOR value : enumerator.values»

            case «value.numericValue» : return «value.name.toStaticFieldName»;
            «ENDFOR»

            default: return null;
        }
    }

    public static «enumeratorClassName» getByTextualValue(String textualValue) {
        if(textualValue == null) {
            return null;
        }
        switch(textualValue) {
            «FOR value : enumerator.values»

            case "«value.textualValue»" : return «value.name.toStaticFieldName»;
            «ENDFOR»

            default: return null;
        }
    }

«var enumeratorName = enumeratorClassName.toFirstLower + "Name"»
    public static «enumeratorClassName» getByName(String «enumeratorName») {
        if(«enumeratorName» == null) {
            return null;
        }
        switch(«enumeratorName») {
            «FOR value : enumerator.values»

            case "«value.name»" : return «value.name.toStaticFieldName»;
            «ENDFOR»

            default: return null;
        }
    }

    public static «enumeratorClassName» fromJson(String json) {
        if(json == null) {
            return null;
        }
        if(json.startsWith("\"")) {
            json = json.substring(1);
        }
        if(json.endsWith("\"")) {
            json = json.substring(0, json.length() - 1);
        }
        try {
            return getByNumericValue(Long.parseLong(json));
        } catch(Exception e) {
        }
        «enumeratorClassName» result = getByTextualValue(json);
        return result != null ? result : getByName(json);
    }

    @Override
    public String toJson() {
        return "\"" + this.name + "\"";
    }

    public DataRepresentation toDataRepresentation() {
        return Tools.FACTORY_DATA_REPRESENTATION.fromJson(toJson());
    }

    @Override
    public String toString() {
        return toJson();
    }
}'''

    override getManyContent(Enumerator enumerator) '''
«enumerator.generatedPackageDeclaration»
«var enumeratorClassName = enumerator.name.toFirstUpper + "Enumerator"»
«var enumerators = enumerator.name.plural»

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.function.Predicate;
import java.util.function.UnaryOperator;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import org.apache.calcite.linq4j.Enumerable;
import org.apache.calcite.linq4j.Linq4j;
import «"GeneratedCoreType".combineWithSystemNamespace»;
import «"Tools".combineWithSystemNamespace»;
import «"type.DataRepresentation".combineWithSystemNamespace»;

«IF !enumerator.internal»public «ENDIF»class «enumeratorClassName»Series extends ArrayList<«enumeratorClassName»> implements GeneratedCoreType {

    private static final long serialVersionUID = 1L;
    private Enumerable<«enumeratorClassName»> internalEnumerable;

    private «enumeratorClassName»Series(Iterable<«enumeratorClassName»> iterable) {
        super();
        this.addAll(StreamSupport.stream(iterable.spliterator(), false).collect(Collectors.toList()));
    }

    public static «enumeratorClassName»Series create(Iterable<«enumeratorClassName»> iterable) {
        return new «enumeratorClassName»Series(iterable);
    }

    public static «enumeratorClassName»Series create(«enumeratorClassName»... «enumerators») {
        return create(«enumerators» == null ? new ArrayList<>() : Arrays.asList(«enumerators»));
    }

    public «enumeratorClassName»[] toArray() {
        return this.toArray(new «enumeratorClassName»[this.size()]);
    }

    public Enumerable<«enumeratorClassName»> asEnumerable() {
        return internalEnumerable != null ? internalEnumerable : (internalEnumerable = Linq4j.asEnumerable(this));
    }

    public boolean addAll(Enumerable<«enumeratorClassName»> enumerable) {
        return enumerable == null ? false : this.addAll(enumerable.toList());
    }

    public boolean containsAll(Enumerable<«enumeratorClassName»> enumerable) {
        return enumerable == null ? false : this.containsAll(enumerable.toList());
    }

    public boolean removeAll(Enumerable<«enumeratorClassName»> enumerable) {
        return enumerable == null ? false : this.removeAll(enumerable.toList());
    }

    public boolean retainAll(Enumerable<«enumeratorClassName»> enumerable) {
        return enumerable == null ? false : this.retainAll(enumerable.toList());
    }

    public boolean addAll(«enumeratorClassName»[] array) {
        return array == null ? false : this.addAll(Arrays.asList(array));
    }

    public boolean containsAll(«enumeratorClassName»[] array) {
        return array == null ? false : this.containsAll(Arrays.asList(array));
    }

    public boolean removeAll(«enumeratorClassName»[] array) {
        return array == null ? false : this.removeAll(Arrays.asList(array));
    }

    public boolean retainAll(«enumeratorClassName»[] array) {
        return array == null ? false : this.retainAll(Arrays.asList(array));
    }

    private void recreateEnumerable() {
        if (internalEnumerable != null) {
            internalEnumerable = Linq4j.asEnumerable(this);
        }
    }

    @Override
    public boolean add(«enumeratorClassName» e) {
        boolean test = super.add(e);
        recreateEnumerable();
        return test;
    }

    @Override
    public void add(int index, «enumeratorClassName» element) {
        super.add(index, element);
        recreateEnumerable();
    }

    @Override
    public boolean addAll(Collection<? extends «enumeratorClassName»> c) {
        boolean test = super.addAll(c);
        recreateEnumerable();
        return test;
    }

    @Override
    public boolean addAll(int index, Collection<? extends «enumeratorClassName»> c) {
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
    public «enumeratorClassName» remove(int index) {
        «enumeratorClassName» test = super.remove(index);
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
    public boolean removeIf(Predicate<? super «enumeratorClassName»> filter) {
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
    public void replaceAll(UnaryOperator<«enumeratorClassName»> operator) {
        super.replaceAll(operator);
        recreateEnumerable();
    }

    public static «enumeratorClassName»Series fromJson(String jsonString) {
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
        «enumeratorClassName»[] values = new «enumeratorClassName»[dataRepresentation.length()];
        for(int i = 0; i < values.length; i++) {
            values[i] = dataRepresentation.get(i, «enumeratorClassName».class);
        }
        return create(values);
    }

    @Override
    public String toString() {
        return toJson();
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

    public DataRepresentation toDataRepresentation() {
        return Tools.FACTORY_DATA_REPRESENTATION.fromJson(toJson());
    }
}'''

}