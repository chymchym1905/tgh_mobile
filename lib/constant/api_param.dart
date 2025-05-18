enum SortBy {
  createdAt('created_at'),
  updatedAt('updated_at'),
  time('time'),
  damageDealt('damage_dealt'),
  rank('rank'),
  name('name');

  const SortBy(this.value);
  final String value;
}

enum SortDir {
  asc('asc'),
  desc('desc');

  const SortDir(this.value);
  final String value;
}
