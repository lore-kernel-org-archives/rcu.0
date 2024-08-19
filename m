Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF417B4ED
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086799; cv=none; b=p/MK6nz1e7R95VEnv1+WfhGPzIcRy0meMPWCv2FqW9vBkg8I5RkB3fmeWU1WWq4PuBdzv/J0lMvYeIQhTZ+cfSw23LIFCXDJldGudGGj2/XkaKRRNg52u6ex0NKheKWCg5zSRfolbg8oAi1NJ8/wmPGyG4B/Ijg+Xw36LuwwGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086799; c=relaxed/simple;
	bh=hty32R4L4oq9YCI1gK4swv/ji2VUIzu1l6Kn3oNHgyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIcoF8bTeGUrqJ41EUGTfZZrz20stYVcHdkMoVBp3A6MB4TWxhHqzrWvEeNCz2ZEhlAuVgN24/VXSYEf2ES3mLklraJyasPbtRgHDYGvuhLQbd0yrKPhRh2qzmilWG50Lm+K+qHAE1TW6pn4lyqf2m324IF4q1DEhz+1GzppQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qz2GP0q/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qz2GP0q/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lywcIqfNsWDxhJBF9WCXkyi4G8HNrqY3Y3RBFpRahlI=;
	b=Qz2GP0q/j2+zH/rFYItmnXiweOzXlDJyfX/TXYk/GoZDnwtiki1nN9Bvq9WvZOhL3sUDkO
	cpTVGkewQQaflfqiPO90FfzFl/8tJhL503y4qFor6i7+kFbggtVnagv9mdvTqjvNuRaHXw
	l8pDlcRffOzWn73TbF3aeJjoq33DN2E=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] darray: lift from bcachefs
Date: Mon, 19 Aug 2024 12:59:29 -0400
Message-ID: <20240819165939.745801-4-kent.overstreet@linux.dev>
In-Reply-To: <20240819165939.745801-1-kent.overstreet@linux.dev>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

dynamic arrays - inspired from CCAN darrays, basically c++ stl vectors.

Used by thread_with_stdio, which is also being lifted from bcachefs for
xfs.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 MAINTAINERS                             |  7 +++
 fs/bcachefs/Makefile                    |  1 -
 fs/bcachefs/btree_node_scan_types.h     |  2 +-
 fs/bcachefs/btree_types.h               |  2 +-
 fs/bcachefs/btree_update.c              |  2 +
 fs/bcachefs/btree_write_buffer_types.h  |  2 +-
 fs/bcachefs/disk_accounting_types.h     |  2 +-
 fs/bcachefs/fsck.c                      |  2 +-
 fs/bcachefs/journal_io.h                |  2 +-
 fs/bcachefs/journal_sb.c                |  2 +-
 fs/bcachefs/sb-downgrade.c              |  3 +-
 fs/bcachefs/sb-errors_types.h           |  2 +-
 fs/bcachefs/sb-members.h                |  2 +-
 fs/bcachefs/subvolume.h                 |  1 -
 fs/bcachefs/subvolume_types.h           |  2 +-
 fs/bcachefs/thread_with_file_types.h    |  2 +-
 fs/bcachefs/util.h                      | 29 +-----------
 {fs/bcachefs => include/linux}/darray.h | 59 ++++++++++++++++---------
 include/linux/darray_types.h            | 22 +++++++++
 lib/Makefile                            |  2 +-
 {fs/bcachefs => lib}/darray.c           | 12 ++++-
 21 files changed, 96 insertions(+), 64 deletions(-)
 rename {fs/bcachefs => include/linux}/darray.h (66%)
 create mode 100644 include/linux/darray_types.h
 rename {fs/bcachefs => lib}/darray.c (57%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..08a66234380e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6142,6 +6142,13 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DARRAY
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-bcachefs@vger.kernel.org
+S:	Maintained
+F:	include/linux/darray.h
+F:	include/linux/darray_types.h
+
 DATA ACCESS MONITOR
 M:	SeongJae Park <sj@kernel.org>
 L:	damon@lists.linux.dev
diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 0ab533a2b03b..3d477690b71e 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -28,7 +28,6 @@ bcachefs-y		:=	\
 	checksum.o		\
 	clock.o			\
 	compress.o		\
-	darray.o		\
 	data_update.o		\
 	debug.o			\
 	dirent.o		\
diff --git a/fs/bcachefs/btree_node_scan_types.h b/fs/bcachefs/btree_node_scan_types.h
index b6c36c45d0be..069573d48134 100644
--- a/fs/bcachefs/btree_node_scan_types.h
+++ b/fs/bcachefs/btree_node_scan_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_BTREE_NODE_SCAN_TYPES_H
 #define _BCACHEFS_BTREE_NODE_SCAN_TYPES_H
 
-#include "darray.h"
+#include <linux/darray.h>
 
 struct found_btree_node {
 	bool			range_updated:1;
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index b256b2a20a4f..5f760906e366 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -2,13 +2,13 @@
 #ifndef _BCACHEFS_BTREE_TYPES_H
 #define _BCACHEFS_BTREE_TYPES_H
 
+#include <linux/darray_types.h>
 #include <linux/list.h>
 #include <linux/rhashtable.h>
 
 #include "bbpos_types.h"
 #include "btree_key_cache_types.h"
 #include "buckets_types.h"
-#include "darray.h"
 #include "errcode.h"
 #include "journal_types.h"
 #include "replicas_types.h"
diff --git a/fs/bcachefs/btree_update.c b/fs/bcachefs/btree_update.c
index 514df618548e..2289c26b5208 100644
--- a/fs/bcachefs/btree_update.c
+++ b/fs/bcachefs/btree_update.c
@@ -14,6 +14,8 @@
 #include "snapshot.h"
 #include "trace.h"
 
+#include <linux/darray.h>
+
 static inline int btree_insert_entry_cmp(const struct btree_insert_entry *l,
 					 const struct btree_insert_entry *r)
 {
diff --git a/fs/bcachefs/btree_write_buffer_types.h b/fs/bcachefs/btree_write_buffer_types.h
index e9e76e20f43b..d39d163c6ea9 100644
--- a/fs/bcachefs/btree_write_buffer_types.h
+++ b/fs/bcachefs/btree_write_buffer_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H
 #define _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 #include "journal_types.h"
 
 #define BTREE_WRITE_BUFERED_VAL_U64s_MAX	4
diff --git a/fs/bcachefs/disk_accounting_types.h b/fs/bcachefs/disk_accounting_types.h
index 1687a45177a7..42de8c284d1f 100644
--- a/fs/bcachefs/disk_accounting_types.h
+++ b/fs/bcachefs/disk_accounting_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_DISK_ACCOUNTING_TYPES_H
 #define _BCACHEFS_DISK_ACCOUNTING_TYPES_H
 
-#include "darray.h"
+#include <linux/darray.h>
 
 struct accounting_mem_entry {
 	struct bpos				pos;
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index 9138944c5ae6..2d37316ca721 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -5,7 +5,6 @@
 #include "btree_cache.h"
 #include "btree_update.h"
 #include "buckets.h"
-#include "darray.h"
 #include "dirent.h"
 #include "error.h"
 #include "fs-common.h"
@@ -18,6 +17,7 @@
 #include "xattr.h"
 
 #include <linux/bsearch.h>
+#include <linux/darray.h>
 #include <linux/dcache.h> /* struct qstr */
 
 /*
diff --git a/fs/bcachefs/journal_io.h b/fs/bcachefs/journal_io.h
index 2ca9cde30ea8..2b8f458cf13c 100644
--- a/fs/bcachefs/journal_io.h
+++ b/fs/bcachefs/journal_io.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_JOURNAL_IO_H
 #define _BCACHEFS_JOURNAL_IO_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 void bch2_journal_pos_from_member_info_set(struct bch_fs *);
 void bch2_journal_pos_from_member_info_resume(struct bch_fs *);
diff --git a/fs/bcachefs/journal_sb.c b/fs/bcachefs/journal_sb.c
index db80e506e3ab..9db57f6f1035 100644
--- a/fs/bcachefs/journal_sb.c
+++ b/fs/bcachefs/journal_sb.c
@@ -2,8 +2,8 @@
 
 #include "bcachefs.h"
 #include "journal_sb.h"
-#include "darray.h"
 
+#include <linux/darray.h>
 #include <linux/sort.h>
 
 /* BCH_SB_FIELD_journal: */
diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
index 650a1f77ca40..b42f8f42b71a 100644
--- a/fs/bcachefs/sb-downgrade.c
+++ b/fs/bcachefs/sb-downgrade.c
@@ -6,12 +6,13 @@
  */
 
 #include "bcachefs.h"
-#include "darray.h"
 #include "recovery_passes.h"
 #include "sb-downgrade.h"
 #include "sb-errors.h"
 #include "super-io.h"
 
+#include <linux/darray.h>
+
 #define RECOVERY_PASS_ALL_FSCK		BIT_ULL(63)
 
 /*
diff --git a/fs/bcachefs/sb-errors_types.h b/fs/bcachefs/sb-errors_types.h
index 40325239c3b0..3b28871d23ed 100644
--- a/fs/bcachefs/sb-errors_types.h
+++ b/fs/bcachefs/sb-errors_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SB_ERRORS_TYPES_H
 #define _BCACHEFS_SB_ERRORS_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 struct bch_sb_error_entry_cpu {
 	u64			id:16,
diff --git a/fs/bcachefs/sb-members.h b/fs/bcachefs/sb-members.h
index f307f2857603..2c2f883e8d83 100644
--- a/fs/bcachefs/sb-members.h
+++ b/fs/bcachefs/sb-members.h
@@ -2,8 +2,8 @@
 #ifndef _BCACHEFS_SB_MEMBERS_H
 #define _BCACHEFS_SB_MEMBERS_H
 
-#include "darray.h"
 #include "bkey_types.h"
+#include <linux/darray.h>
 
 extern char * const bch2_member_error_strs[];
 
diff --git a/fs/bcachefs/subvolume.h b/fs/bcachefs/subvolume.h
index e62f876541fe..52daf4303605 100644
--- a/fs/bcachefs/subvolume.h
+++ b/fs/bcachefs/subvolume.h
@@ -2,7 +2,6 @@
 #ifndef _BCACHEFS_SUBVOLUME_H
 #define _BCACHEFS_SUBVOLUME_H
 
-#include "darray.h"
 #include "subvolume_types.h"
 
 enum bch_validate_flags;
diff --git a/fs/bcachefs/subvolume_types.h b/fs/bcachefs/subvolume_types.h
index f2ec4277c2a5..a0c0d5909e9b 100644
--- a/fs/bcachefs/subvolume_types.h
+++ b/fs/bcachefs/subvolume_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_SUBVOLUME_TYPES_H
 #define _BCACHEFS_SUBVOLUME_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 typedef DARRAY(u32) snapshot_id_list;
 
diff --git a/fs/bcachefs/thread_with_file_types.h b/fs/bcachefs/thread_with_file_types.h
index f4d484d44f63..254b8493ec4b 100644
--- a/fs/bcachefs/thread_with_file_types.h
+++ b/fs/bcachefs/thread_with_file_types.h
@@ -2,7 +2,7 @@
 #ifndef _BCACHEFS_THREAD_WITH_FILE_TYPES_H
 #define _BCACHEFS_THREAD_WITH_FILE_TYPES_H
 
-#include "darray.h"
+#include <linux/darray_types.h>
 
 struct stdio_buf {
 	spinlock_t		lock;
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index fb02c1c36004..742d7d9f365f 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -5,23 +5,22 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/closure.h>
+#include <linux/darray.h>
 #include <linux/errno.h>
 #include <linux/freezer.h>
 #include <linux/kernel.h>
 #include <linux/min_heap.h>
-#include <linux/sched/clock.h>
 #include <linux/llist.h>
 #include <linux/log2.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/ratelimit.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 
 #include "mean_and_variance.h"
-
-#include "darray.h"
 #include "time_stats.h"
 
 struct closure;
@@ -513,30 +512,6 @@ static inline void memset_u64s_tail(void *s, int c, unsigned bytes)
 	memset(s + bytes, c, rem);
 }
 
-/* just the memmove, doesn't update @_nr */
-#define __array_insert_item(_array, _nr, _pos)				\
-	memmove(&(_array)[(_pos) + 1],					\
-		&(_array)[(_pos)],					\
-		sizeof((_array)[0]) * ((_nr) - (_pos)))
-
-#define array_insert_item(_array, _nr, _pos, _new_item)			\
-do {									\
-	__array_insert_item(_array, _nr, _pos);				\
-	(_nr)++;							\
-	(_array)[(_pos)] = (_new_item);					\
-} while (0)
-
-#define array_remove_items(_array, _nr, _pos, _nr_to_remove)		\
-do {									\
-	(_nr) -= (_nr_to_remove);					\
-	memmove(&(_array)[(_pos)],					\
-		&(_array)[(_pos) + (_nr_to_remove)],			\
-		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
-} while (0)
-
-#define array_remove_item(_array, _nr, _pos)				\
-	array_remove_items(_array, _nr, _pos, 1)
-
 static inline void __move_gap(void *array, size_t element_size,
 			      size_t nr, size_t size,
 			      size_t old_gap, size_t new_gap)
diff --git a/fs/bcachefs/darray.h b/include/linux/darray.h
similarity index 66%
rename from fs/bcachefs/darray.h
rename to include/linux/darray.h
index 4b340d13caac..ff167eb795f2 100644
--- a/fs/bcachefs/darray.h
+++ b/include/linux/darray.h
@@ -1,34 +1,26 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _BCACHEFS_DARRAY_H
-#define _BCACHEFS_DARRAY_H
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
+#ifndef _LINUX_DARRAY_H
+#define _LINUX_DARRAY_H
 
 /*
- * Dynamic arrays:
+ * Dynamic arrays
  *
  * Inspired by CCAN's darray
  */
 
+#include <linux/darray_types.h>
 #include <linux/slab.h>
 
-#define DARRAY_PREALLOCATED(_type, _nr)					\
-struct {								\
-	size_t nr, size;						\
-	_type *data;							\
-	_type preallocated[_nr];					\
-}
-
-#define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
-
-typedef DARRAY(char)	darray_char;
-typedef DARRAY(char *) darray_str;
-
-int __bch2_darray_resize(darray_char *, size_t, size_t, gfp_t);
+int __darray_resize_slowpath(darray_char *, size_t, size_t, gfp_t);
 
 static inline int __darray_resize(darray_char *d, size_t element_size,
 				  size_t new_size, gfp_t gfp)
 {
 	return unlikely(new_size > d->size)
-		? __bch2_darray_resize(d, element_size, new_size, gfp)
+		? __darray_resize_slowpath(d, element_size, new_size, gfp)
 		: 0;
 }
 
@@ -69,6 +61,28 @@ static inline int __darray_make_room(darray_char *d, size_t t_size, size_t more,
 #define darray_first(_d)	((_d).data[0])
 #define darray_last(_d)		((_d).data[(_d).nr - 1])
 
+/* Insert/remove items into the middle of a darray: */
+
+#define array_insert_item(_array, _nr, _pos, _new_item)			\
+do {									\
+	memmove(&(_array)[(_pos) + 1],					\
+		&(_array)[(_pos)],					\
+		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
+	(_nr)++;							\
+	(_array)[(_pos)] = (_new_item);					\
+} while (0)
+
+#define array_remove_items(_array, _nr, _pos, _nr_to_remove)		\
+do {									\
+	(_nr) -= (_nr_to_remove);					\
+	memmove(&(_array)[(_pos)],					\
+		&(_array)[(_pos) + (_nr_to_remove)],			\
+		sizeof((_array)[0]) * ((_nr) - (_pos)));		\
+} while (0)
+
+#define array_remove_item(_array, _nr, _pos)				\
+	array_remove_items(_array, _nr, _pos, 1)
+
 #define darray_insert_item(_d, pos, _item)				\
 ({									\
 	size_t _pos = (pos);						\
@@ -79,10 +93,15 @@ static inline int __darray_make_room(darray_char *d, size_t t_size, size_t more,
 	_ret;								\
 })
 
+#define darray_remove_items(_d, _pos, _nr_to_remove)			\
+	array_remove_items((_d)->data, (_d)->nr, (_pos) - (_d)->data, _nr_to_remove)
+
 #define darray_remove_item(_d, _pos)					\
-	array_remove_item((_d)->data, (_d)->nr, (_pos) - (_d)->data)
+	darray_remove_items(_d, _pos, 1)
+
+/* Iteration: */
 
-#define __darray_for_each(_d, _i)						\
+#define __darray_for_each(_d, _i)					\
 	for ((_i) = (_d).data; _i < (_d).data + (_d).nr; _i++)
 
 #define darray_for_each(_d, _i)						\
@@ -106,4 +125,4 @@ do {									\
 	darray_init(_d);						\
 } while (0)
 
-#endif /* _BCACHEFS_DARRAY_H */
+#endif /* _LINUX_DARRAY_H */
diff --git a/include/linux/darray_types.h b/include/linux/darray_types.h
new file mode 100644
index 000000000000..a400a0c3600d
--- /dev/null
+++ b/include/linux/darray_types.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
+#ifndef _LINUX_DARRAY_TYpES_H
+#define _LINUX_DARRAY_TYpES_H
+
+#include <linux/types.h>
+
+#define DARRAY_PREALLOCATED(_type, _nr)					\
+struct {								\
+	size_t nr, size;						\
+	_type *data;							\
+	_type preallocated[_nr];					\
+}
+
+#define DARRAY(_type) DARRAY_PREALLOCATED(_type, 0)
+
+typedef DARRAY(char)	darray_char;
+typedef DARRAY(char *)	darray_str;
+
+#endif /* _LINUX_DARRAY_TYpES_H */
diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc..87f4310c6076 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -48,7 +48,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o bitmap-str.o
+	 generic-radix-tree.o bitmap-str.o darray.o
 obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-y += string_helpers.o
 obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
diff --git a/fs/bcachefs/darray.c b/lib/darray.c
similarity index 57%
rename from fs/bcachefs/darray.c
rename to lib/darray.c
index b7d223f85873..b6868db7f956 100644
--- a/fs/bcachefs/darray.c
+++ b/lib/darray.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) 2022-2024 Kent Overstreet <kent.overstreet@linux.dev>
+ */
 
+#include <linux/darray.h>
 #include <linux/log2.h>
+#include <linux/module.h>
 #include <linux/slab.h>
-#include "darray.h"
 
-int __bch2_darray_resize(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
+int __darray_resize_slowpath(darray_char *d, size_t element_size, size_t new_size, gfp_t gfp)
 {
 	if (new_size > d->size) {
 		new_size = roundup_pow_of_two(new_size);
@@ -23,3 +27,7 @@ int __bch2_darray_resize(darray_char *d, size_t element_size, size_t new_size, g
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__darray_resize_slowpath);
+
+MODULE_AUTHOR("Kent Overstreet");
+MODULE_LICENSE("GPL");
-- 
2.45.2

