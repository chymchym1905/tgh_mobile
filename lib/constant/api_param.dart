enum SortBy {
  createdAt('created_at'),
  updatedAt('updated_at'),
  time('time');

  const SortBy(this.value);
  final String value;
}

enum SortDir {
  asc('asc'),
  desc('desc');

  const SortDir(this.value);
  final String value;
}
