// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavedTranslationsCollection on Isar {
  IsarCollection<SavedTranslations> get savedTranslations => this.collection();
}

const SavedTranslationsSchema = CollectionSchema(
  name: r'SavedTranslations',
  id: -1261295554797333718,
  properties: {
    r'source': PropertySchema(
      id: 0,
      name: r'source',
      type: IsarType.string,
    ),
    r'translation': PropertySchema(
      id: 1,
      name: r'translation',
      type: IsarType.object,
      target: r'Translation',
    )
  },
  estimateSize: _savedTranslationsEstimateSize,
  serialize: _savedTranslationsSerialize,
  deserialize: _savedTranslationsDeserialize,
  deserializeProp: _savedTranslationsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Translation': TranslationSchema,
    r'AudioLinks': AudioLinksSchema,
    r'Example': ExampleSchema
  },
  getId: _savedTranslationsGetId,
  getLinks: _savedTranslationsGetLinks,
  attach: _savedTranslationsAttach,
  version: '3.1.0+1',
);

int _savedTranslationsEstimateSize(
  SavedTranslations object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.source.length * 3;
  bytesCount += 3 +
      TranslationSchema.estimateSize(
          object.translation, allOffsets[Translation]!, allOffsets);
  return bytesCount;
}

void _savedTranslationsSerialize(
  SavedTranslations object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.source);
  writer.writeObject<Translation>(
    offsets[1],
    allOffsets,
    TranslationSchema.serialize,
    object.translation,
  );
}

SavedTranslations _savedTranslationsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavedTranslations(
    reader.readString(offsets[0]),
    reader.readObjectOrNull<Translation>(
          offsets[1],
          TranslationSchema.deserialize,
          allOffsets,
        ) ??
        Translation(),
  );
  object.id = id;
  return object;
}

P _savedTranslationsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<Translation>(
            offset,
            TranslationSchema.deserialize,
            allOffsets,
          ) ??
          Translation()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _savedTranslationsGetId(SavedTranslations object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _savedTranslationsGetLinks(
    SavedTranslations object) {
  return [];
}

void _savedTranslationsAttach(
    IsarCollection<dynamic> col, Id id, SavedTranslations object) {
  object.id = id;
}

extension SavedTranslationsQueryWhereSort
    on QueryBuilder<SavedTranslations, SavedTranslations, QWhere> {
  QueryBuilder<SavedTranslations, SavedTranslations, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SavedTranslationsQueryWhere
    on QueryBuilder<SavedTranslations, SavedTranslations, QWhereClause> {
  QueryBuilder<SavedTranslations, SavedTranslations, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SavedTranslationsQueryFilter
    on QueryBuilder<SavedTranslations, SavedTranslations, QFilterCondition> {
  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }
}

extension SavedTranslationsQueryObject
    on QueryBuilder<SavedTranslations, SavedTranslations, QFilterCondition> {
  QueryBuilder<SavedTranslations, SavedTranslations, QAfterFilterCondition>
      translation(FilterQuery<Translation> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'translation');
    });
  }
}

extension SavedTranslationsQueryLinks
    on QueryBuilder<SavedTranslations, SavedTranslations, QFilterCondition> {}

extension SavedTranslationsQuerySortBy
    on QueryBuilder<SavedTranslations, SavedTranslations, QSortBy> {
  QueryBuilder<SavedTranslations, SavedTranslations, QAfterSortBy>
      sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension SavedTranslationsQuerySortThenBy
    on QueryBuilder<SavedTranslations, SavedTranslations, QSortThenBy> {
  QueryBuilder<SavedTranslations, SavedTranslations, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterSortBy>
      thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<SavedTranslations, SavedTranslations, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension SavedTranslationsQueryWhereDistinct
    on QueryBuilder<SavedTranslations, SavedTranslations, QDistinct> {
  QueryBuilder<SavedTranslations, SavedTranslations, QDistinct>
      distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }
}

extension SavedTranslationsQueryProperty
    on QueryBuilder<SavedTranslations, SavedTranslations, QQueryProperty> {
  QueryBuilder<SavedTranslations, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SavedTranslations, String, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<SavedTranslations, Translation, QQueryOperations>
      translationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'translation');
    });
  }
}
