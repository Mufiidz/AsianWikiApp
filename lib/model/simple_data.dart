class SimpleData {
  final String title;
  final String content;

  SimpleData({this.title = '', this.content = ''});

  SimpleData.nullableContent({
    required this.title,
    String? content,
    String? defaultValue,
  }) : content = (content == null || content.trim().isEmpty)
           ? (defaultValue ?? '-')
           : content;

  @override
  String toString() =>
      'SimpleData(title: $title, content: $content)';
}
