// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPoemCacheCollection on Isar {
  IsarCollection<PoemCache> get poemCaches => this.collection();
}

const PoemCacheSchema = CollectionSchema(
  name: r'PoemCache',
  id: 878829061886856608,
  properties: {
    r'authorName': PropertySchema(
      id: 0,
      name: r'authorName',
      type: IsarType.string,
    ),
    r'cachedAt': PropertySchema(
      id: 1,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
    ),
    r'content': PropertySchema(id: 3, name: r'content', type: IsarType.string),
    r'contentSnippet': PropertySchema(
      id: 4,
      name: r'contentSnippet',
      type: IsarType.string,
    ),
    r'dynastyName': PropertySchema(
      id: 5,
      name: r'dynastyName',
      type: IsarType.string,
    ),
    r'poemId': PropertySchema(id: 6, name: r'poemId', type: IsarType.string),
    r'title': PropertySchema(id: 7, name: r'title', type: IsarType.string),
  },

  estimateSize: _poemCacheEstimateSize,
  serialize: _poemCacheSerialize,
  deserialize: _poemCacheDeserialize,
  deserializeProp: _poemCacheDeserializeProp,
  idName: r'id',
  indexes: {
    r'poemId': IndexSchema(
      id: 2593119689657661897,
      name: r'poemId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'poemId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
    r'authorName': IndexSchema(
      id: -8957794046943539008,
      name: r'authorName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'authorName',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
    r'dynastyName': IndexSchema(
      id: 1762962912213334091,
      name: r'dynastyName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dynastyName',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _poemCacheGetId,
  getLinks: _poemCacheGetLinks,
  attach: _poemCacheAttach,
  version: '3.3.0-dev.1',
);

int _poemCacheEstimateSize(
  PoemCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.authorName.length * 3;
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.content.length * 3;
  {
    final value = object.contentSnippet;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.dynastyName.length * 3;
  bytesCount += 3 + object.poemId.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _poemCacheSerialize(
  PoemCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.authorName);
  writer.writeDateTime(offsets[1], object.cachedAt);
  writer.writeString(offsets[2], object.category);
  writer.writeString(offsets[3], object.content);
  writer.writeString(offsets[4], object.contentSnippet);
  writer.writeString(offsets[5], object.dynastyName);
  writer.writeString(offsets[6], object.poemId);
  writer.writeString(offsets[7], object.title);
}

PoemCache _poemCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PoemCache();
  object.authorName = reader.readString(offsets[0]);
  object.cachedAt = reader.readDateTimeOrNull(offsets[1]);
  object.category = reader.readStringOrNull(offsets[2]);
  object.content = reader.readString(offsets[3]);
  object.contentSnippet = reader.readStringOrNull(offsets[4]);
  object.dynastyName = reader.readString(offsets[5]);
  object.id = id;
  object.poemId = reader.readString(offsets[6]);
  object.title = reader.readString(offsets[7]);
  return object;
}

P _poemCacheDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _poemCacheGetId(PoemCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _poemCacheGetLinks(PoemCache object) {
  return [];
}

void _poemCacheAttach(IsarCollection<dynamic> col, Id id, PoemCache object) {
  object.id = id;
}

extension PoemCacheByIndex on IsarCollection<PoemCache> {
  Future<PoemCache?> getByPoemId(String poemId) {
    return getByIndex(r'poemId', [poemId]);
  }

  PoemCache? getByPoemIdSync(String poemId) {
    return getByIndexSync(r'poemId', [poemId]);
  }

  Future<bool> deleteByPoemId(String poemId) {
    return deleteByIndex(r'poemId', [poemId]);
  }

  bool deleteByPoemIdSync(String poemId) {
    return deleteByIndexSync(r'poemId', [poemId]);
  }

  Future<List<PoemCache?>> getAllByPoemId(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'poemId', values);
  }

  List<PoemCache?> getAllByPoemIdSync(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'poemId', values);
  }

  Future<int> deleteAllByPoemId(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'poemId', values);
  }

  int deleteAllByPoemIdSync(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'poemId', values);
  }

  Future<Id> putByPoemId(PoemCache object) {
    return putByIndex(r'poemId', object);
  }

  Id putByPoemIdSync(PoemCache object, {bool saveLinks = true}) {
    return putByIndexSync(r'poemId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPoemId(List<PoemCache> objects) {
    return putAllByIndex(r'poemId', objects);
  }

  List<Id> putAllByPoemIdSync(
    List<PoemCache> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'poemId', objects, saveLinks: saveLinks);
  }
}

extension PoemCacheQueryWhereSort
    on QueryBuilder<PoemCache, PoemCache, QWhere> {
  QueryBuilder<PoemCache, PoemCache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhere> anyTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'title'),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhere> anyAuthorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'authorName'),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhere> anyDynastyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dynastyName'),
      );
    });
  }
}

extension PoemCacheQueryWhere
    on QueryBuilder<PoemCache, PoemCache, QWhereClause> {
  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> poemIdEqualTo(
    String poemId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'poemId', value: [poemId]),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> poemIdNotEqualTo(
    String poemId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [],
                upper: [poemId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [poemId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [poemId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [],
                upper: [poemId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> titleEqualTo(
    String title,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'title', value: [title]),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> titleNotEqualTo(
    String title,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'title',
                lower: [],
                upper: [title],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'title',
                lower: [title],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'title',
                lower: [title],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'title',
                lower: [],
                upper: [title],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> titleGreaterThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'title',
          lower: [title],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> titleLessThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'title',
          lower: [],
          upper: [title],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> titleBetween(
    String lowerTitle,
    String upperTitle, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'title',
          lower: [lowerTitle],
          includeLower: includeLower,
          upper: [upperTitle],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> titleStartsWith(
    String TitlePrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'title',
          lower: [TitlePrefix],
          upper: ['$TitlePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'title', value: ['']),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'title', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'title', lower: ['']),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'title', lower: ['']),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'title', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> authorNameEqualTo(
    String authorName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'authorName', value: [authorName]),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> authorNameNotEqualTo(
    String authorName,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'authorName',
                lower: [],
                upper: [authorName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'authorName',
                lower: [authorName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'authorName',
                lower: [authorName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'authorName',
                lower: [],
                upper: [authorName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> authorNameGreaterThan(
    String authorName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'authorName',
          lower: [authorName],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> authorNameLessThan(
    String authorName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'authorName',
          lower: [],
          upper: [authorName],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> authorNameBetween(
    String lowerAuthorName,
    String upperAuthorName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'authorName',
          lower: [lowerAuthorName],
          includeLower: includeLower,
          upper: [upperAuthorName],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> authorNameStartsWith(
    String AuthorNamePrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'authorName',
          lower: [AuthorNamePrefix],
          upper: ['$AuthorNamePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> authorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'authorName', value: ['']),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> authorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'authorName', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'authorName',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'authorName',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'authorName', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> dynastyNameEqualTo(
    String dynastyName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'dynastyName',
          value: [dynastyName],
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> dynastyNameNotEqualTo(
    String dynastyName,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dynastyName',
                lower: [],
                upper: [dynastyName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dynastyName',
                lower: [dynastyName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dynastyName',
                lower: [dynastyName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dynastyName',
                lower: [],
                upper: [dynastyName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> dynastyNameGreaterThan(
    String dynastyName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dynastyName',
          lower: [dynastyName],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> dynastyNameLessThan(
    String dynastyName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dynastyName',
          lower: [],
          upper: [dynastyName],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> dynastyNameBetween(
    String lowerDynastyName,
    String upperDynastyName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dynastyName',
          lower: [lowerDynastyName],
          includeLower: includeLower,
          upper: [upperDynastyName],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> dynastyNameStartsWith(
    String DynastyNamePrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dynastyName',
          lower: [DynastyNamePrefix],
          upper: ['$DynastyNamePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause> dynastyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'dynastyName', value: ['']),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterWhereClause>
  dynastyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'dynastyName', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'dynastyName',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'dynastyName',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'dynastyName', upper: ['']),
            );
      }
    });
  }
}

extension PoemCacheQueryFilter
    on QueryBuilder<PoemCache, PoemCache, QFilterCondition> {
  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> authorNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  authorNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> authorNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> authorNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'authorName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  authorNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> authorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> authorNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> authorNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'authorName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  authorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'authorName', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  authorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'authorName', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> cachedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cachedAt'),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  cachedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cachedAt'),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> cachedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedAt', value: value),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> cachedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> cachedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> cachedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'category'),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'category'),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'category',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'category',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'content',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'content',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'content',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'content', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'content', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'contentSnippet'),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'contentSnippet'),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'contentSnippet',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'contentSnippet',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'contentSnippet', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  contentSnippetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'contentSnippet', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> dynastyNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dynastyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  dynastyNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dynastyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> dynastyNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dynastyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> dynastyNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dynastyName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  dynastyNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dynastyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> dynastyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dynastyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> dynastyNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dynastyName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> dynastyNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dynastyName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  dynastyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dynastyName', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition>
  dynastyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dynastyName', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'poemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'poemId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'poemId', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> poemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'poemId', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }
}

extension PoemCacheQueryObject
    on QueryBuilder<PoemCache, PoemCache, QFilterCondition> {}

extension PoemCacheQueryLinks
    on QueryBuilder<PoemCache, PoemCache, QFilterCondition> {}

extension PoemCacheQuerySortBy on QueryBuilder<PoemCache, PoemCache, QSortBy> {
  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByAuthorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByAuthorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByContentSnippet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentSnippet', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByContentSnippetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentSnippet', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByDynastyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dynastyName', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByDynastyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dynastyName', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByPoemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByPoemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension PoemCacheQuerySortThenBy
    on QueryBuilder<PoemCache, PoemCache, QSortThenBy> {
  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByAuthorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByAuthorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByContentSnippet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentSnippet', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByContentSnippetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentSnippet', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByDynastyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dynastyName', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByDynastyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dynastyName', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByPoemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByPoemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.desc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension PoemCacheQueryWhereDistinct
    on QueryBuilder<PoemCache, PoemCache, QDistinct> {
  QueryBuilder<PoemCache, PoemCache, QDistinct> distinctByAuthorName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<PoemCache, PoemCache, QDistinct> distinctByCategory({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QDistinct> distinctByContent({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QDistinct> distinctByContentSnippet({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'contentSnippet',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PoemCache, PoemCache, QDistinct> distinctByDynastyName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dynastyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QDistinct> distinctByPoemId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poemId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PoemCache, PoemCache, QDistinct> distinctByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension PoemCacheQueryProperty
    on QueryBuilder<PoemCache, PoemCache, QQueryProperty> {
  QueryBuilder<PoemCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PoemCache, String, QQueryOperations> authorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authorName');
    });
  }

  QueryBuilder<PoemCache, DateTime?, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<PoemCache, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<PoemCache, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<PoemCache, String?, QQueryOperations> contentSnippetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentSnippet');
    });
  }

  QueryBuilder<PoemCache, String, QQueryOperations> dynastyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dynastyName');
    });
  }

  QueryBuilder<PoemCache, String, QQueryOperations> poemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poemId');
    });
  }

  QueryBuilder<PoemCache, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPoemDetailCacheCollection on Isar {
  IsarCollection<PoemDetailCache> get poemDetailCaches => this.collection();
}

const PoemDetailCacheSchema = CollectionSchema(
  name: r'PoemDetailCache',
  id: -5415243049206832337,
  properties: {
    r'cachedAt': PropertySchema(
      id: 0,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'fullJson': PropertySchema(
      id: 1,
      name: r'fullJson',
      type: IsarType.string,
    ),
    r'poemId': PropertySchema(id: 2, name: r'poemId', type: IsarType.string),
  },

  estimateSize: _poemDetailCacheEstimateSize,
  serialize: _poemDetailCacheSerialize,
  deserialize: _poemDetailCacheDeserialize,
  deserializeProp: _poemDetailCacheDeserializeProp,
  idName: r'id',
  indexes: {
    r'poemId': IndexSchema(
      id: 2593119689657661897,
      name: r'poemId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'poemId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _poemDetailCacheGetId,
  getLinks: _poemDetailCacheGetLinks,
  attach: _poemDetailCacheAttach,
  version: '3.3.0-dev.1',
);

int _poemDetailCacheEstimateSize(
  PoemDetailCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fullJson.length * 3;
  bytesCount += 3 + object.poemId.length * 3;
  return bytesCount;
}

void _poemDetailCacheSerialize(
  PoemDetailCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.cachedAt);
  writer.writeString(offsets[1], object.fullJson);
  writer.writeString(offsets[2], object.poemId);
}

PoemDetailCache _poemDetailCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PoemDetailCache();
  object.cachedAt = reader.readDateTimeOrNull(offsets[0]);
  object.fullJson = reader.readString(offsets[1]);
  object.id = id;
  object.poemId = reader.readString(offsets[2]);
  return object;
}

P _poemDetailCacheDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _poemDetailCacheGetId(PoemDetailCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _poemDetailCacheGetLinks(PoemDetailCache object) {
  return [];
}

void _poemDetailCacheAttach(
  IsarCollection<dynamic> col,
  Id id,
  PoemDetailCache object,
) {
  object.id = id;
}

extension PoemDetailCacheByIndex on IsarCollection<PoemDetailCache> {
  Future<PoemDetailCache?> getByPoemId(String poemId) {
    return getByIndex(r'poemId', [poemId]);
  }

  PoemDetailCache? getByPoemIdSync(String poemId) {
    return getByIndexSync(r'poemId', [poemId]);
  }

  Future<bool> deleteByPoemId(String poemId) {
    return deleteByIndex(r'poemId', [poemId]);
  }

  bool deleteByPoemIdSync(String poemId) {
    return deleteByIndexSync(r'poemId', [poemId]);
  }

  Future<List<PoemDetailCache?>> getAllByPoemId(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'poemId', values);
  }

  List<PoemDetailCache?> getAllByPoemIdSync(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'poemId', values);
  }

  Future<int> deleteAllByPoemId(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'poemId', values);
  }

  int deleteAllByPoemIdSync(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'poemId', values);
  }

  Future<Id> putByPoemId(PoemDetailCache object) {
    return putByIndex(r'poemId', object);
  }

  Id putByPoemIdSync(PoemDetailCache object, {bool saveLinks = true}) {
    return putByIndexSync(r'poemId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPoemId(List<PoemDetailCache> objects) {
    return putAllByIndex(r'poemId', objects);
  }

  List<Id> putAllByPoemIdSync(
    List<PoemDetailCache> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'poemId', objects, saveLinks: saveLinks);
  }
}

extension PoemDetailCacheQueryWhereSort
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QWhere> {
  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PoemDetailCacheQueryWhere
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QWhereClause> {
  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterWhereClause>
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

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterWhereClause>
  poemIdEqualTo(String poemId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'poemId', value: [poemId]),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterWhereClause>
  poemIdNotEqualTo(String poemId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [],
                upper: [poemId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [poemId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [poemId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [],
                upper: [poemId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension PoemDetailCacheQueryFilter
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QFilterCondition> {
  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  cachedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cachedAt'),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  cachedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cachedAt'),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  cachedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedAt', value: value),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  cachedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  cachedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  cachedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fullJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fullJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fullJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fullJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fullJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fullJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fullJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fullJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fullJson', value: ''),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  fullJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fullJson', value: ''),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'poemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'poemId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'poemId', value: ''),
      );
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterFilterCondition>
  poemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'poemId', value: ''),
      );
    });
  }
}

extension PoemDetailCacheQueryObject
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QFilterCondition> {}

extension PoemDetailCacheQueryLinks
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QFilterCondition> {}

extension PoemDetailCacheQuerySortBy
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QSortBy> {
  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  sortByFullJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJson', Sort.asc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  sortByFullJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJson', Sort.desc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy> sortByPoemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.asc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  sortByPoemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.desc);
    });
  }
}

extension PoemDetailCacheQuerySortThenBy
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QSortThenBy> {
  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  thenByFullJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJson', Sort.asc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  thenByFullJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJson', Sort.desc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy> thenByPoemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.asc);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QAfterSortBy>
  thenByPoemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.desc);
    });
  }
}

extension PoemDetailCacheQueryWhereDistinct
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QDistinct> {
  QueryBuilder<PoemDetailCache, PoemDetailCache, QDistinct>
  distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QDistinct> distinctByFullJson({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PoemDetailCache, PoemDetailCache, QDistinct> distinctByPoemId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poemId', caseSensitive: caseSensitive);
    });
  }
}

extension PoemDetailCacheQueryProperty
    on QueryBuilder<PoemDetailCache, PoemDetailCache, QQueryProperty> {
  QueryBuilder<PoemDetailCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PoemDetailCache, DateTime?, QQueryOperations>
  cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<PoemDetailCache, String, QQueryOperations> fullJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullJson');
    });
  }

  QueryBuilder<PoemDetailCache, String, QQueryOperations> poemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poemId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteRecordCollection on Isar {
  IsarCollection<FavoriteRecord> get favoriteRecords => this.collection();
}

const FavoriteRecordSchema = CollectionSchema(
  name: r'FavoriteRecord',
  id: -8548526311285793424,
  properties: {
    r'authorName': PropertySchema(
      id: 0,
      name: r'authorName',
      type: IsarType.string,
    ),
    r'contentSnippet': PropertySchema(
      id: 1,
      name: r'contentSnippet',
      type: IsarType.string,
    ),
    r'favoritedAt': PropertySchema(
      id: 2,
      name: r'favoritedAt',
      type: IsarType.dateTime,
    ),
    r'isSynced': PropertySchema(id: 3, name: r'isSynced', type: IsarType.bool),
    r'poemId': PropertySchema(id: 4, name: r'poemId', type: IsarType.string),
    r'title': PropertySchema(id: 5, name: r'title', type: IsarType.string),
  },

  estimateSize: _favoriteRecordEstimateSize,
  serialize: _favoriteRecordSerialize,
  deserialize: _favoriteRecordDeserialize,
  deserializeProp: _favoriteRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'poemId': IndexSchema(
      id: 2593119689657661897,
      name: r'poemId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'poemId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _favoriteRecordGetId,
  getLinks: _favoriteRecordGetLinks,
  attach: _favoriteRecordAttach,
  version: '3.3.0-dev.1',
);

int _favoriteRecordEstimateSize(
  FavoriteRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.authorName.length * 3;
  bytesCount += 3 + object.contentSnippet.length * 3;
  bytesCount += 3 + object.poemId.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _favoriteRecordSerialize(
  FavoriteRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.authorName);
  writer.writeString(offsets[1], object.contentSnippet);
  writer.writeDateTime(offsets[2], object.favoritedAt);
  writer.writeBool(offsets[3], object.isSynced);
  writer.writeString(offsets[4], object.poemId);
  writer.writeString(offsets[5], object.title);
}

FavoriteRecord _favoriteRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavoriteRecord();
  object.authorName = reader.readString(offsets[0]);
  object.contentSnippet = reader.readString(offsets[1]);
  object.favoritedAt = reader.readDateTime(offsets[2]);
  object.id = id;
  object.isSynced = reader.readBool(offsets[3]);
  object.poemId = reader.readString(offsets[4]);
  object.title = reader.readString(offsets[5]);
  return object;
}

P _favoriteRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteRecordGetId(FavoriteRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favoriteRecordGetLinks(FavoriteRecord object) {
  return [];
}

void _favoriteRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  FavoriteRecord object,
) {
  object.id = id;
}

extension FavoriteRecordByIndex on IsarCollection<FavoriteRecord> {
  Future<FavoriteRecord?> getByPoemId(String poemId) {
    return getByIndex(r'poemId', [poemId]);
  }

  FavoriteRecord? getByPoemIdSync(String poemId) {
    return getByIndexSync(r'poemId', [poemId]);
  }

  Future<bool> deleteByPoemId(String poemId) {
    return deleteByIndex(r'poemId', [poemId]);
  }

  bool deleteByPoemIdSync(String poemId) {
    return deleteByIndexSync(r'poemId', [poemId]);
  }

  Future<List<FavoriteRecord?>> getAllByPoemId(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'poemId', values);
  }

  List<FavoriteRecord?> getAllByPoemIdSync(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'poemId', values);
  }

  Future<int> deleteAllByPoemId(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'poemId', values);
  }

  int deleteAllByPoemIdSync(List<String> poemIdValues) {
    final values = poemIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'poemId', values);
  }

  Future<Id> putByPoemId(FavoriteRecord object) {
    return putByIndex(r'poemId', object);
  }

  Id putByPoemIdSync(FavoriteRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'poemId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPoemId(List<FavoriteRecord> objects) {
    return putAllByIndex(r'poemId', objects);
  }

  List<Id> putAllByPoemIdSync(
    List<FavoriteRecord> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'poemId', objects, saveLinks: saveLinks);
  }
}

extension FavoriteRecordQueryWhereSort
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QWhere> {
  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FavoriteRecordQueryWhere
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QWhereClause> {
  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterWhereClause> poemIdEqualTo(
    String poemId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'poemId', value: [poemId]),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterWhereClause>
  poemIdNotEqualTo(String poemId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [],
                upper: [poemId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [poemId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [poemId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'poemId',
                lower: [],
                upper: [poemId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension FavoriteRecordQueryFilter
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QFilterCondition> {
  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'authorName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'authorName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'authorName', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  authorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'authorName', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'contentSnippet',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'contentSnippet',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'contentSnippet',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'contentSnippet', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  contentSnippetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'contentSnippet', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  favoritedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'favoritedAt', value: value),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  favoritedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'favoritedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  favoritedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'favoritedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  favoritedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'favoritedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isSynced', value: value),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'poemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'poemId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'poemId', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  poemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'poemId', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }
}

extension FavoriteRecordQueryObject
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QFilterCondition> {}

extension FavoriteRecordQueryLinks
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QFilterCondition> {}

extension FavoriteRecordQuerySortBy
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QSortBy> {
  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  sortByAuthorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  sortByAuthorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  sortByContentSnippet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentSnippet', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  sortByContentSnippetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentSnippet', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  sortByFavoritedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoritedAt', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  sortByFavoritedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoritedAt', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> sortByPoemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  sortByPoemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension FavoriteRecordQuerySortThenBy
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QSortThenBy> {
  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  thenByAuthorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  thenByAuthorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  thenByContentSnippet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentSnippet', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  thenByContentSnippetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentSnippet', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  thenByFavoritedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoritedAt', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  thenByFavoritedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoritedAt', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> thenByPoemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy>
  thenByPoemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.desc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension FavoriteRecordQueryWhereDistinct
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QDistinct> {
  QueryBuilder<FavoriteRecord, FavoriteRecord, QDistinct> distinctByAuthorName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QDistinct>
  distinctByContentSnippet({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'contentSnippet',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QDistinct>
  distinctByFavoritedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'favoritedAt');
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QDistinct> distinctByPoemId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poemId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavoriteRecord, FavoriteRecord, QDistinct> distinctByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension FavoriteRecordQueryProperty
    on QueryBuilder<FavoriteRecord, FavoriteRecord, QQueryProperty> {
  QueryBuilder<FavoriteRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavoriteRecord, String, QQueryOperations> authorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authorName');
    });
  }

  QueryBuilder<FavoriteRecord, String, QQueryOperations>
  contentSnippetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentSnippet');
    });
  }

  QueryBuilder<FavoriteRecord, DateTime, QQueryOperations>
  favoritedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favoritedAt');
    });
  }

  QueryBuilder<FavoriteRecord, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<FavoriteRecord, String, QQueryOperations> poemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poemId');
    });
  }

  QueryBuilder<FavoriteRecord, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReadingRecordCollection on Isar {
  IsarCollection<ReadingRecord> get readingRecords => this.collection();
}

const ReadingRecordSchema = CollectionSchema(
  name: r'ReadingRecord',
  id: 5106103573298585909,
  properties: {
    r'authorName': PropertySchema(
      id: 0,
      name: r'authorName',
      type: IsarType.string,
    ),
    r'poemId': PropertySchema(id: 1, name: r'poemId', type: IsarType.string),
    r'readAt': PropertySchema(id: 2, name: r'readAt', type: IsarType.dateTime),
    r'readCount': PropertySchema(
      id: 3,
      name: r'readCount',
      type: IsarType.long,
    ),
    r'title': PropertySchema(id: 4, name: r'title', type: IsarType.string),
  },

  estimateSize: _readingRecordEstimateSize,
  serialize: _readingRecordSerialize,
  deserialize: _readingRecordDeserialize,
  deserializeProp: _readingRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _readingRecordGetId,
  getLinks: _readingRecordGetLinks,
  attach: _readingRecordAttach,
  version: '3.3.0-dev.1',
);

int _readingRecordEstimateSize(
  ReadingRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.authorName.length * 3;
  bytesCount += 3 + object.poemId.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _readingRecordSerialize(
  ReadingRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.authorName);
  writer.writeString(offsets[1], object.poemId);
  writer.writeDateTime(offsets[2], object.readAt);
  writer.writeLong(offsets[3], object.readCount);
  writer.writeString(offsets[4], object.title);
}

ReadingRecord _readingRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReadingRecord();
  object.authorName = reader.readString(offsets[0]);
  object.id = id;
  object.poemId = reader.readString(offsets[1]);
  object.readAt = reader.readDateTime(offsets[2]);
  object.readCount = reader.readLong(offsets[3]);
  object.title = reader.readString(offsets[4]);
  return object;
}

P _readingRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _readingRecordGetId(ReadingRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _readingRecordGetLinks(ReadingRecord object) {
  return [];
}

void _readingRecordAttach(
  IsarCollection<dynamic> col,
  Id id,
  ReadingRecord object,
) {
  object.id = id;
}

extension ReadingRecordQueryWhereSort
    on QueryBuilder<ReadingRecord, ReadingRecord, QWhere> {
  QueryBuilder<ReadingRecord, ReadingRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReadingRecordQueryWhere
    on QueryBuilder<ReadingRecord, ReadingRecord, QWhereClause> {
  QueryBuilder<ReadingRecord, ReadingRecord, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ReadingRecordQueryFilter
    on QueryBuilder<ReadingRecord, ReadingRecord, QFilterCondition> {
  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'authorName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'authorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'authorName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'authorName', value: ''),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  authorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'authorName', value: ''),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'poemId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'poemId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'poemId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'poemId', value: ''),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  poemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'poemId', value: ''),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  readAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'readAt', value: value),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  readAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'readAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  readAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'readAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  readAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'readAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  readCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'readCount', value: value),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  readCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'readCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  readCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'readCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  readCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'readCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }
}

extension ReadingRecordQueryObject
    on QueryBuilder<ReadingRecord, ReadingRecord, QFilterCondition> {}

extension ReadingRecordQueryLinks
    on QueryBuilder<ReadingRecord, ReadingRecord, QFilterCondition> {}

extension ReadingRecordQuerySortBy
    on QueryBuilder<ReadingRecord, ReadingRecord, QSortBy> {
  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> sortByAuthorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy>
  sortByAuthorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> sortByPoemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> sortByPoemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> sortByReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readAt', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> sortByReadAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readAt', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> sortByReadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readCount', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy>
  sortByReadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readCount', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension ReadingRecordQuerySortThenBy
    on QueryBuilder<ReadingRecord, ReadingRecord, QSortThenBy> {
  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByAuthorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy>
  thenByAuthorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorName', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByPoemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByPoemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poemId', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readAt', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByReadAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readAt', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByReadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readCount', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy>
  thenByReadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readCount', Sort.desc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension ReadingRecordQueryWhereDistinct
    on QueryBuilder<ReadingRecord, ReadingRecord, QDistinct> {
  QueryBuilder<ReadingRecord, ReadingRecord, QDistinct> distinctByAuthorName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QDistinct> distinctByPoemId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poemId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QDistinct> distinctByReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readAt');
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QDistinct> distinctByReadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readCount');
    });
  }

  QueryBuilder<ReadingRecord, ReadingRecord, QDistinct> distinctByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension ReadingRecordQueryProperty
    on QueryBuilder<ReadingRecord, ReadingRecord, QQueryProperty> {
  QueryBuilder<ReadingRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReadingRecord, String, QQueryOperations> authorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authorName');
    });
  }

  QueryBuilder<ReadingRecord, String, QQueryOperations> poemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poemId');
    });
  }

  QueryBuilder<ReadingRecord, DateTime, QQueryOperations> readAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readAt');
    });
  }

  QueryBuilder<ReadingRecord, int, QQueryOperations> readCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readCount');
    });
  }

  QueryBuilder<ReadingRecord, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
