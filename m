Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1904188CB6
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086802; cv=none; b=M2wZfq2lYzUhtqBi6fLKikdP119FiHugP2THx/SGnPHp/EUbvPBDQYfNz+NEjrhlvbNUrp8JEAs6hfr8dGQgF4w2hCS31JMsSPV+yZgLEli3GIAAyYvKjYd5oEA3o4LM9sfxFWzq8GLtUnK2cx2hkggMLKDQKZ7tIYTUHjgALus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086802; c=relaxed/simple;
	bh=hshneq25YhxNX2ZTRe1MT/dC1eJyXv/jImukK3S+ap4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FboO0EncYNaDLhB5Kiajc1LLWG2EfronaTnX6+Knt5+OYtGAekhI1vP+IEgd1b4zI28S7BVT7SH5jZfB5WHMz/++R57jY4zaLSEhAv/rHkOyqcf/Q4ks4RMvj3b2WgUjtQf0zewSQKGa/CRk6sDsTLs5nUA4AGZJ/UN+s4t8gRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cbyyLQOb; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cbyyLQOb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXI9/kQJEVzTEQpkt4qkI1rm65cgsEszWrxB2EItc5A=;
	b=cbyyLQOb+yu5eHgX/sCI1Cdt6TycrO7fkpItUet3s8V7Z+dgYpBuvReZW1faGTVSvFkMP9
	j9EdKw+3cx789Ur0pNQRZDv/1NWMbnOJWAQu/AIWeJUmgeA/beT3x35Ed47C8MA/CN7CvL
	Ob6/D6iJIc1EhRIvLHX1BRkHrX2xSVU=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] bcachefs: key cache can now allocate from pending
Date: Mon, 19 Aug 2024 12:59:34 -0400
Message-ID: <20240819165939.745801-9-kent.overstreet@linux.dev>
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

btree_trans objects can hold the btree_trans_barrier srcu read lock for
an extended amount of time (they shouldn't, but it's difficult to
guarantee).

the srcu barrier blocks memory reclaim, so to avoid too many stranded
key cache items, this uses the new pending_rcu_items to allocate from
pending items - like we did before, but now without a global lock on the
key cache.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_key_cache.c       | 58 ++++++++++++++++++++++-------
 fs/bcachefs/btree_key_cache_types.h |  6 +++
 fs/bcachefs/btree_types.h           |  1 -
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index b304a18eaea4..d69b513e57f1 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -93,18 +93,18 @@ static bool bkey_cached_evict(struct btree_key_cache *c,
 	return ret;
 }
 
-static void __bkey_cached_free(struct rcu_head *rcu)
+static void __bkey_cached_free(struct rcu_pending *pending, struct rcu_head *rcu)
 {
+	struct bch_fs *c = container_of(pending->srcu, struct bch_fs, btree_trans_barrier);
 	struct bkey_cached *ck = container_of(rcu, struct bkey_cached, rcu);
 
+	this_cpu_dec(*c->btree_key_cache.nr_pending);
 	kmem_cache_free(bch2_key_cache, ck);
 }
 
 static void bkey_cached_free(struct btree_key_cache *bc,
 			     struct bkey_cached *ck)
 {
-	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
-
 	kfree(ck->k);
 	ck->k		= NULL;
 	ck->u64s	= 0;
@@ -112,7 +112,9 @@ static void bkey_cached_free(struct btree_key_cache *bc,
 	six_unlock_write(&ck->c.lock);
 	six_unlock_intent(&ck->c.lock);
 
-	call_srcu(&c->btree_trans_barrier, &ck->rcu, __bkey_cached_free);
+	bool pcpu_readers = ck->c.lock.readers != NULL;
+	rcu_pending_enqueue(&bc->pending[pcpu_readers], &ck->rcu);
+	this_cpu_inc(*bc->nr_pending);
 }
 
 static struct bkey_cached *__bkey_cached_alloc(unsigned key_u64s, gfp_t gfp)
@@ -132,10 +134,18 @@ static struct bkey_cached *__bkey_cached_alloc(unsigned key_u64s, gfp_t gfp)
 static struct bkey_cached *
 bkey_cached_alloc(struct btree_trans *trans, struct btree_path *path, unsigned key_u64s)
 {
+	struct bch_fs *c = trans->c;
+	struct btree_key_cache *bc = &c->btree_key_cache;
 	bool pcpu_readers = btree_uses_pcpu_readers(path->btree_id);
 	int ret;
 
-	struct bkey_cached *ck = allocate_dropping_locks(trans, ret,
+	struct bkey_cached *ck = container_of_or_null(
+				rcu_pending_dequeue(&bc->pending[pcpu_readers]),
+				struct bkey_cached, rcu);
+	if (ck)
+		goto lock;
+
+	ck = allocate_dropping_locks(trans, ret,
 				     __bkey_cached_alloc(key_u64s, _gfp));
 	if (ret) {
 		if (ck)
@@ -144,14 +154,19 @@ bkey_cached_alloc(struct btree_trans *trans, struct btree_path *path, unsigned k
 		return ERR_PTR(ret);
 	}
 
-	if (!ck)
-		return NULL;
-
-	bch2_btree_lock_init(&ck->c, pcpu_readers ? SIX_LOCK_INIT_PCPU : 0);
+	if (ck) {
+		bch2_btree_lock_init(&ck->c, pcpu_readers ? SIX_LOCK_INIT_PCPU : 0);
+		ck->c.cached = true;
+		goto lock;
+	}
 
-	ck->c.cached = true;
-	BUG_ON(!six_trylock_intent(&ck->c.lock));
-	BUG_ON(!six_trylock_write(&ck->c.lock));
+	ck = container_of_or_null(rcu_pending_dequeue_from_all(&bc->pending[pcpu_readers]),
+				  struct bkey_cached, rcu);
+	if (ck)
+		goto lock;
+lock:
+	six_lock_intent(&ck->c.lock, NULL, NULL);
+	six_lock_write(&ck->c.lock, NULL, NULL);
 	return ck;
 }
 
@@ -697,6 +712,11 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
 
 	if (bc->table_init_done)
 		rhashtable_destroy(&bc->table);
+
+	free_percpu(bc->nr_pending);
+
+	rcu_pending_exit(&bc->pending[0]);
+	rcu_pending_exit(&bc->pending[1]);
 }
 
 void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
@@ -720,6 +740,14 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
 	struct shrinker *shrink;
 
+	if (rcu_pending_init(&bc->pending[0], &c->btree_trans_barrier, __bkey_cached_free) ||
+	    rcu_pending_init(&bc->pending[1], &c->btree_trans_barrier, __bkey_cached_free))
+		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
+
+	bc->nr_pending = alloc_percpu(size_t);
+	if (!bc->nr_pending)
+		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
+
 	if (rhashtable_init(&bc->table, &bch2_btree_key_cache_params))
 		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
 
@@ -747,13 +775,15 @@ void bch2_btree_key_cache_to_text(struct printbuf *out, struct btree_key_cache *
 	prt_printf(out, "keys:\t%lu\r\n",		atomic_long_read(&bc->nr_keys));
 	prt_printf(out, "dirty:\t%lu\r\n",		atomic_long_read(&bc->nr_dirty));
 	prt_printf(out, "table size:\t%u\r\n",		bc->table.tbl->size);
-
-	prt_printf(out, "\nshrinker:\n");
+	prt_newline(out);
+	prt_printf(out, "shrinker:\n");
 	prt_printf(out, "requested_to_free:\t%lu\r\n",	bc->requested_to_free);
 	prt_printf(out, "freed:\t%lu\r\n",		bc->freed);
 	prt_printf(out, "skipped_dirty:\t%lu\r\n",	bc->skipped_dirty);
 	prt_printf(out, "skipped_accessed:\t%lu\r\n",	bc->skipped_accessed);
 	prt_printf(out, "skipped_lock_fail:\t%lu\r\n",	bc->skipped_lock_fail);
+	prt_newline(out);
+	prt_printf(out, "pending:\t%lu\r\n",		per_cpu_sum(bc->nr_pending));
 }
 
 void bch2_btree_key_cache_exit(void)
diff --git a/fs/bcachefs/btree_key_cache_types.h b/fs/bcachefs/btree_key_cache_types.h
index e026c65f54e1..739f97022d81 100644
--- a/fs/bcachefs/btree_key_cache_types.h
+++ b/fs/bcachefs/btree_key_cache_types.h
@@ -2,6 +2,8 @@
 #ifndef _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
 #define _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
 
+#include <linux/rcu_pending.h>
+
 struct btree_key_cache {
 	struct rhashtable	table;
 	bool			table_init_done;
@@ -9,6 +11,10 @@ struct btree_key_cache {
 	struct shrinker		*shrink;
 	unsigned		shrink_iter;
 
+	/* 0: non pcpu reader locks, 1: pcpu reader locks */
+	struct rcu_pending	pending[2];
+	size_t __percpu		*nr_pending;
+
 	atomic_long_t		nr_keys;
 	atomic_long_t		nr_dirty;
 
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index e8190f4e45ac..ee4bcac44beb 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -395,7 +395,6 @@ struct bkey_cached {
 	u64			seq;
 
 	struct bkey_i		*k;
-
 	struct rcu_head		rcu;
 };
 
-- 
2.45.2

