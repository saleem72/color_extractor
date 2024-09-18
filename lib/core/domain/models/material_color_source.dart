// ignore_for_file: public_member_api_docs, sort_constructors_first
//

enum MaterialColorSourceType { hex, json }

class MaterialColorSource {
  final MaterialColorSourceType type;
  final String value;
  const MaterialColorSource({
    required this.type,
    required this.value,
  });
}
