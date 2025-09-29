---
marp: true
theme: default
paginate: true
---

# Week 1 Progress Report

**Sprint 1:** Milestone 09/15 - 09/26

---

## Feature #2

**Users are able to select a manga/manwha/manhua series and select a chapter to read**

---

### Requirement #1

- Show details of a series ✅

### Requirement #2

- List of chapters when you press a series and able to select to read ✅

### Requirement #3

- Select a chapter to read and view pages ❌

---

## Progress Metrics

**Lines of Code (LoC):**

lib/data/model/manga/manga_chapters_response.dart | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
lib/data/repositories/mangadex_repository.dart | 2 ++
lib/data/repositories/mangadex_repository_fake.dart | 7 ++++++
lib/data/repositories/mangadex_repository_real.dart | 18 ++++++++++++++--
lib/data/services/mangadex_api_service.dart | 9 +++++++-
lib/main.dart | 6 +++++-

---

lib/view/detail_screen.dart | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
lib/view/home_screen.dart | 55 +++++++++++++++++++++++++++++++++++------------
lib/view_models/detail_view_model.dart | 28 ++++++++++++++++++++++++
pubspec.lock | 8 +++++++
pubspec.yaml | 1 +
11 files changed, 282 insertions(+), 18 deletions(-)

---

**Requirements Completed / Total:** 2 / 3

**Burn-down Rate:** 66.67% completed, 33.33% remaining
