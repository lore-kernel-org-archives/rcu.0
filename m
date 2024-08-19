Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD35188003
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086803; cv=none; b=td87MiAeJrH7cc6IQ+z9jgaxMUQWwhVVjzRZMmcHRpBjaNo4g/1sO+Y9nsphttuHtFxxb059oar5iU7gkKz/v4H+rP+TPLZwd5i7Wx+akesj4w2hFfMXmhUmI4dJwQeBym5TQb1HhCrjHywnK/E1orHinBe8qkK9vGfjh3UDF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086803; c=relaxed/simple;
	bh=HJygEozCAQAugP8axaFg0EcySSuczbsYBwqbZA+luE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/nN0KxKKbTc+r1n/XYhxLa36VijfN0X8BYoEu+ODjNtzpx/r459Uz8ASttCedvaWhJDaOzE+ZEpGHSzDw45qzNWlAxU7it3BcKwH17yU8BXsk0ijnlColPDF1KzKOgjraaG+1XJhnUFKZIF3ptKqgLT8jnxmKRDCesMYL4R1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=idVe6wCb; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="idVe6wCb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxPK2yTxxO+FhA913E4EqA+z/NJBIYNTAEkI9NrVujE=;
	b=idVe6wCbLc1IoZX4I3vg+EG8eVLKb8M5bocWepqVUmaokK0MSK5GZfe8kXwFO2YCMi8JFz
	3Ifw/7NcMvR2v0kdKRiRi3HclJC07alG1764eHOQZem/RtvHQFFikcrhE2a9vvtsrMu5qd
	z+CJ3XAL8jIk7B/MA+uvihVoAzt2NMc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] bcachefs: Rip out freelists from btree key cache
Date: Mon, 19 Aug 2024 12:59:33 -0400
Message-ID: <20240819165939.745801-8-kent.overstreet@linux.dev>
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

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_key_cache.c       | 368 +++++-----------------------
 fs/bcachefs/btree_key_cache_types.h |  14 --
 fs/bcachefs/btree_types.h           |   4 +-
 3 files changed, 57 insertions(+), 329 deletions(-)

diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index 027e0a7d4765..b304a18eaea4 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -80,130 +80,39 @@ static bool bkey_cached_lock_for_evict(struct bkey_cached *ck)
 	return true;
 }
 
-static void bkey_cached_evict(struct btree_key_cache *c,
+static bool bkey_cached_evict(struct btree_key_cache *c,
 			      struct bkey_cached *ck)
 {
-	BUG_ON(rhashtable_remove_fast(&c->table, &ck->hash,
-				      bch2_btree_key_cache_params));
-	memset(&ck->key, ~0, sizeof(ck->key));
-
-	atomic_long_dec(&c->nr_keys);
-}
-
-static void bkey_cached_free(struct btree_key_cache *bc,
-			     struct bkey_cached *ck)
-{
-	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
-
-	BUG_ON(test_bit(BKEY_CACHED_DIRTY, &ck->flags));
-
-	ck->btree_trans_barrier_seq =
-		start_poll_synchronize_srcu(&c->btree_trans_barrier);
-
-	if (ck->c.lock.readers) {
-		list_move_tail(&ck->list, &bc->freed_pcpu);
-		bc->nr_freed_pcpu++;
-	} else {
-		list_move_tail(&ck->list, &bc->freed_nonpcpu);
-		bc->nr_freed_nonpcpu++;
+	bool ret = !rhashtable_remove_fast(&c->table, &ck->hash,
+				      bch2_btree_key_cache_params);
+	if (ret) {
+		memset(&ck->key, ~0, sizeof(ck->key));
+		atomic_long_dec(&c->nr_keys);
 	}
-	atomic_long_inc(&bc->nr_freed);
-
-	kfree(ck->k);
-	ck->k		= NULL;
-	ck->u64s	= 0;
 
-	six_unlock_write(&ck->c.lock);
-	six_unlock_intent(&ck->c.lock);
+	return ret;
 }
 
-#ifdef __KERNEL__
-static void __bkey_cached_move_to_freelist_ordered(struct btree_key_cache *bc,
-						   struct bkey_cached *ck)
+static void __bkey_cached_free(struct rcu_head *rcu)
 {
-	struct bkey_cached *pos;
-
-	bc->nr_freed_nonpcpu++;
+	struct bkey_cached *ck = container_of(rcu, struct bkey_cached, rcu);
 
-	list_for_each_entry_reverse(pos, &bc->freed_nonpcpu, list) {
-		if (ULONG_CMP_GE(ck->btree_trans_barrier_seq,
-				 pos->btree_trans_barrier_seq)) {
-			list_move(&ck->list, &pos->list);
-			return;
-		}
-	}
-
-	list_move(&ck->list, &bc->freed_nonpcpu);
+	kmem_cache_free(bch2_key_cache, ck);
 }
-#endif
-
-static void bkey_cached_move_to_freelist(struct btree_key_cache *bc,
-					 struct bkey_cached *ck)
-{
-	BUG_ON(test_bit(BKEY_CACHED_DIRTY, &ck->flags));
-
-	if (!ck->c.lock.readers) {
-#ifdef __KERNEL__
-		struct btree_key_cache_freelist *f;
-		bool freed = false;
-
-		preempt_disable();
-		f = this_cpu_ptr(bc->pcpu_freed);
 
-		if (f->nr < ARRAY_SIZE(f->objs)) {
-			f->objs[f->nr++] = ck;
-			freed = true;
-		}
-		preempt_enable();
-
-		if (!freed) {
-			mutex_lock(&bc->lock);
-			preempt_disable();
-			f = this_cpu_ptr(bc->pcpu_freed);
-
-			while (f->nr > ARRAY_SIZE(f->objs) / 2) {
-				struct bkey_cached *ck2 = f->objs[--f->nr];
-
-				__bkey_cached_move_to_freelist_ordered(bc, ck2);
-			}
-			preempt_enable();
-
-			__bkey_cached_move_to_freelist_ordered(bc, ck);
-			mutex_unlock(&bc->lock);
-		}
-#else
-		mutex_lock(&bc->lock);
-		list_move_tail(&ck->list, &bc->freed_nonpcpu);
-		bc->nr_freed_nonpcpu++;
-		mutex_unlock(&bc->lock);
-#endif
-	} else {
-		mutex_lock(&bc->lock);
-		list_move_tail(&ck->list, &bc->freed_pcpu);
-		bc->nr_freed_pcpu++;
-		mutex_unlock(&bc->lock);
-	}
-}
-
-static void bkey_cached_free_fast(struct btree_key_cache *bc,
-				  struct bkey_cached *ck)
+static void bkey_cached_free(struct btree_key_cache *bc,
+			     struct bkey_cached *ck)
 {
 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
 
-	ck->btree_trans_barrier_seq =
-		start_poll_synchronize_srcu(&c->btree_trans_barrier);
-
-	list_del_init(&ck->list);
-	atomic_long_inc(&bc->nr_freed);
-
 	kfree(ck->k);
 	ck->k		= NULL;
 	ck->u64s	= 0;
 
-	bkey_cached_move_to_freelist(bc, ck);
-
 	six_unlock_write(&ck->c.lock);
 	six_unlock_intent(&ck->c.lock);
+
+	call_srcu(&c->btree_trans_barrier, &ck->rcu, __bkey_cached_free);
 }
 
 static struct bkey_cached *__bkey_cached_alloc(unsigned key_u64s, gfp_t gfp)
@@ -223,78 +132,10 @@ static struct bkey_cached *__bkey_cached_alloc(unsigned key_u64s, gfp_t gfp)
 static struct bkey_cached *
 bkey_cached_alloc(struct btree_trans *trans, struct btree_path *path, unsigned key_u64s)
 {
-	struct bch_fs *c = trans->c;
-	struct btree_key_cache *bc = &c->btree_key_cache;
-	struct bkey_cached *ck = NULL;
 	bool pcpu_readers = btree_uses_pcpu_readers(path->btree_id);
 	int ret;
 
-	if (!pcpu_readers) {
-#ifdef __KERNEL__
-		struct btree_key_cache_freelist *f;
-
-		preempt_disable();
-		f = this_cpu_ptr(bc->pcpu_freed);
-		if (f->nr)
-			ck = f->objs[--f->nr];
-		preempt_enable();
-
-		if (!ck) {
-			mutex_lock(&bc->lock);
-			preempt_disable();
-			f = this_cpu_ptr(bc->pcpu_freed);
-
-			while (!list_empty(&bc->freed_nonpcpu) &&
-			       f->nr < ARRAY_SIZE(f->objs) / 2) {
-				ck = list_last_entry(&bc->freed_nonpcpu, struct bkey_cached, list);
-				list_del_init(&ck->list);
-				bc->nr_freed_nonpcpu--;
-				f->objs[f->nr++] = ck;
-			}
-
-			ck = f->nr ? f->objs[--f->nr] : NULL;
-			preempt_enable();
-			mutex_unlock(&bc->lock);
-		}
-#else
-		mutex_lock(&bc->lock);
-		if (!list_empty(&bc->freed_nonpcpu)) {
-			ck = list_last_entry(&bc->freed_nonpcpu, struct bkey_cached, list);
-			list_del_init(&ck->list);
-			bc->nr_freed_nonpcpu--;
-		}
-		mutex_unlock(&bc->lock);
-#endif
-	} else {
-		mutex_lock(&bc->lock);
-		if (!list_empty(&bc->freed_pcpu)) {
-			ck = list_last_entry(&bc->freed_pcpu, struct bkey_cached, list);
-			list_del_init(&ck->list);
-			bc->nr_freed_pcpu--;
-		}
-		mutex_unlock(&bc->lock);
-	}
-
-	if (ck) {
-		ret = btree_node_lock_nopath(trans, &ck->c, SIX_LOCK_intent, _THIS_IP_);
-		if (unlikely(ret)) {
-			bkey_cached_move_to_freelist(bc, ck);
-			return ERR_PTR(ret);
-		}
-
-		btree_path_cached_set(trans, path, ck, BTREE_NODE_INTENT_LOCKED);
-
-		ret = bch2_btree_node_lock_write(trans, path, &ck->c);
-		if (unlikely(ret)) {
-			btree_node_unlock(trans, path, 0);
-			bkey_cached_move_to_freelist(bc, ck);
-			return ERR_PTR(ret);
-		}
-
-		return ck;
-	}
-
-	ck = allocate_dropping_locks(trans, ret,
+	struct bkey_cached *ck = allocate_dropping_locks(trans, ret,
 				     __bkey_cached_alloc(key_u64s, _gfp));
 	if (ret) {
 		if (ck)
@@ -306,7 +147,6 @@ bkey_cached_alloc(struct btree_trans *trans, struct btree_path *path, unsigned k
 	if (!ck)
 		return NULL;
 
-	INIT_LIST_HEAD(&ck->list);
 	bch2_btree_lock_init(&ck->c, pcpu_readers ? SIX_LOCK_INIT_PCPU : 0);
 
 	ck->c.cached = true;
@@ -323,21 +163,21 @@ bkey_cached_reuse(struct btree_key_cache *c)
 	struct bkey_cached *ck;
 	unsigned i;
 
-	mutex_lock(&c->lock);
 	rcu_read_lock();
 	tbl = rht_dereference_rcu(c->table.tbl, &c->table);
 	for (i = 0; i < tbl->size; i++)
 		rht_for_each_entry_rcu(ck, pos, tbl, i, hash) {
 			if (!test_bit(BKEY_CACHED_DIRTY, &ck->flags) &&
 			    bkey_cached_lock_for_evict(ck)) {
-				bkey_cached_evict(c, ck);
-				goto out;
+				if (bkey_cached_evict(c, ck))
+					goto out;
+				six_unlock_write(&ck->c.lock);
+				six_unlock_intent(&ck->c.lock);
 			}
 		}
 	ck = NULL;
 out:
 	rcu_read_unlock();
-	mutex_unlock(&c->lock);
 	return ck;
 }
 
@@ -416,7 +256,7 @@ static int btree_key_cache_create(struct btree_trans *trans, struct btree_path *
 	path->uptodate = BTREE_ITER_UPTODATE;
 	return 0;
 err:
-	bkey_cached_free_fast(bc, ck);
+	bkey_cached_free(bc, ck);
 	mark_btree_node_locked_noreset(path, 0, BTREE_NODE_UNLOCKED);
 
 	return ret;
@@ -612,8 +452,12 @@ static int btree_key_cache_flush_pos(struct btree_trans *trans,
 		}
 
 		mark_btree_node_locked_noreset(path, 0, BTREE_NODE_UNLOCKED);
-		bkey_cached_evict(&c->btree_key_cache, ck);
-		bkey_cached_free_fast(&c->btree_key_cache, ck);
+		if (bkey_cached_evict(&c->btree_key_cache, ck)) {
+			bkey_cached_free(&c->btree_key_cache, ck);
+		} else {
+			six_unlock_write(&ck->c.lock);
+			six_unlock_intent(&ck->c.lock);
+		}
 	}
 out:
 	bch2_trans_iter_exit(trans, &b_iter);
@@ -723,7 +567,7 @@ void bch2_btree_key_cache_drop(struct btree_trans *trans,
 	}
 
 	bkey_cached_evict(bc, ck);
-	bkey_cached_free_fast(bc, ck);
+	bkey_cached_free(bc, ck);
 
 	mark_btree_node_locked(trans, path, 0, BTREE_NODE_UNLOCKED);
 	btree_path_set_dirty(path, BTREE_ITER_NEED_TRAVERSE);
@@ -735,60 +579,27 @@ static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
 	struct bch_fs *c = shrink->private_data;
 	struct btree_key_cache *bc = &c->btree_key_cache;
 	struct bucket_table *tbl;
-	struct bkey_cached *ck, *t;
+	struct bkey_cached *ck;
 	size_t scanned = 0, freed = 0, nr = sc->nr_to_scan;
-	unsigned start, flags;
+	unsigned iter, start;
 	int srcu_idx;
 
-	mutex_lock(&bc->lock);
-	bc->requested_to_free += sc->nr_to_scan;
-
 	srcu_idx = srcu_read_lock(&c->btree_trans_barrier);
-	flags = memalloc_nofs_save();
-
-	/*
-	 * Newest freed entries are at the end of the list - once we hit one
-	 * that's too new to be freed, we can bail out:
-	 */
-	list_for_each_entry_safe(ck, t, &bc->freed_nonpcpu, list) {
-		if (!poll_state_synchronize_srcu(&c->btree_trans_barrier,
-						 ck->btree_trans_barrier_seq))
-			break;
-
-		list_del(&ck->list);
-		six_lock_exit(&ck->c.lock);
-		kmem_cache_free(bch2_key_cache, ck);
-		atomic_long_dec(&bc->nr_freed);
-		bc->nr_freed_nonpcpu--;
-		bc->freed++;
-	}
-
-	list_for_each_entry_safe(ck, t, &bc->freed_pcpu, list) {
-		if (!poll_state_synchronize_srcu(&c->btree_trans_barrier,
-						 ck->btree_trans_barrier_seq))
-			break;
-
-		list_del(&ck->list);
-		six_lock_exit(&ck->c.lock);
-		kmem_cache_free(bch2_key_cache, ck);
-		atomic_long_dec(&bc->nr_freed);
-		bc->nr_freed_pcpu--;
-		bc->freed++;
-	}
-
 	rcu_read_lock();
+
 	tbl = rht_dereference_rcu(bc->table.tbl, &bc->table);
-	if (bc->shrink_iter >= tbl->size)
-		bc->shrink_iter = 0;
-	start = bc->shrink_iter;
+	iter = bc->shrink_iter;
+	if (iter >= tbl->size)
+		iter = 0;
+	start = iter;
 
 	do {
 		struct rhash_head *pos, *next;
 
-		pos = rht_ptr_rcu(rht_bucket(tbl, bc->shrink_iter));
+		pos = rht_ptr_rcu(rht_bucket(tbl, iter));
 
 		while (!rht_is_a_nulls(pos)) {
-			next = rht_dereference_bucket_rcu(pos->next, tbl, bc->shrink_iter);
+			next = rht_dereference_bucket_rcu(pos->next, tbl, iter);
 			ck = container_of(pos, struct bkey_cached, hash);
 
 			if (test_bit(BKEY_CACHED_DIRTY, &ck->flags)) {
@@ -798,29 +609,31 @@ static unsigned long bch2_btree_key_cache_scan(struct shrinker *shrink,
 				bc->skipped_accessed++;
 			} else if (!bkey_cached_lock_for_evict(ck)) {
 				bc->skipped_lock_fail++;
-			} else {
-				bkey_cached_evict(bc, ck);
+			} else if (bkey_cached_evict(bc, ck)) {
 				bkey_cached_free(bc, ck);
-				bc->moved_to_freelist++;
+				bc->freed++;
 				freed++;
+			} else {
+				six_unlock_write(&ck->c.lock);
+				six_unlock_intent(&ck->c.lock);
 			}
 
 			scanned++;
 			if (scanned >= nr)
-				break;
+				goto out;
 
 			pos = next;
 		}
 
-		bc->shrink_iter++;
-		if (bc->shrink_iter >= tbl->size)
-			bc->shrink_iter = 0;
-	} while (scanned < nr && bc->shrink_iter != start);
+		iter++;
+		if (iter >= tbl->size)
+			iter = 0;
+	} while (scanned < nr && iter != start);
+out:
+	bc->shrink_iter = iter;
 
 	rcu_read_unlock();
-	memalloc_nofs_restore(flags);
 	srcu_read_unlock(&c->btree_trans_barrier, srcu_idx);
-	mutex_unlock(&bc->lock);
 
 	return freed;
 }
@@ -848,18 +661,13 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
 {
 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
 	struct bucket_table *tbl;
-	struct bkey_cached *ck, *n;
+	struct bkey_cached *ck;
 	struct rhash_head *pos;
 	LIST_HEAD(items);
 	unsigned i;
-#ifdef __KERNEL__
-	int cpu;
-#endif
 
 	shrinker_free(bc->shrink);
 
-	mutex_lock(&bc->lock);
-
 	/*
 	 * The loop is needed to guard against racing with rehash:
 	 */
@@ -868,44 +676,15 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
 		tbl = rht_dereference_rcu(bc->table.tbl, &bc->table);
 		if (tbl)
 			for (i = 0; i < tbl->size; i++)
-				rht_for_each_entry_rcu(ck, pos, tbl, i, hash) {
-					bkey_cached_evict(bc, ck);
-					list_add(&ck->list, &items);
+				while (pos = rht_ptr_rcu(rht_bucket(tbl, i)),
+							 !rht_is_a_nulls(pos)) {
+					ck = container_of(pos, struct bkey_cached, hash);
+					BUG_ON(!bkey_cached_evict(bc, ck));
+					kmem_cache_free(bch2_key_cache, ck);
 				}
 		rcu_read_unlock();
 	}
 
-#ifdef __KERNEL__
-	if (bc->pcpu_freed) {
-		for_each_possible_cpu(cpu) {
-			struct btree_key_cache_freelist *f =
-				per_cpu_ptr(bc->pcpu_freed, cpu);
-
-			for (i = 0; i < f->nr; i++) {
-				ck = f->objs[i];
-				list_add(&ck->list, &items);
-			}
-		}
-	}
-#endif
-
-	BUG_ON(list_count_nodes(&bc->freed_pcpu) != bc->nr_freed_pcpu);
-	BUG_ON(list_count_nodes(&bc->freed_nonpcpu) != bc->nr_freed_nonpcpu);
-
-	list_splice(&bc->freed_pcpu,	&items);
-	list_splice(&bc->freed_nonpcpu,	&items);
-
-	mutex_unlock(&bc->lock);
-
-	list_for_each_entry_safe(ck, n, &items, list) {
-		cond_resched();
-
-		list_del(&ck->list);
-		kfree(ck->k);
-		six_lock_exit(&ck->c.lock);
-		kmem_cache_free(bch2_key_cache, ck);
-	}
-
 	if (atomic_long_read(&bc->nr_dirty) &&
 	    !bch2_journal_error(&c->journal) &&
 	    test_bit(BCH_FS_was_rw, &c->flags))
@@ -918,15 +697,10 @@ void bch2_fs_btree_key_cache_exit(struct btree_key_cache *bc)
 
 	if (bc->table_init_done)
 		rhashtable_destroy(&bc->table);
-
-	free_percpu(bc->pcpu_freed);
 }
 
 void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
 {
-	mutex_init(&c->lock);
-	INIT_LIST_HEAD(&c->freed_pcpu);
-	INIT_LIST_HEAD(&c->freed_nonpcpu);
 }
 
 static void bch2_btree_key_cache_shrinker_to_text(struct seq_buf *s, struct shrinker *shrink)
@@ -946,12 +720,6 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
 	struct shrinker *shrink;
 
-#ifdef __KERNEL__
-	bc->pcpu_freed = alloc_percpu(struct btree_key_cache_freelist);
-	if (!bc->pcpu_freed)
-		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
-#endif
-
 	if (rhashtable_init(&bc->table, &bch2_btree_key_cache_params))
 		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
 
@@ -973,45 +741,19 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 
 void bch2_btree_key_cache_to_text(struct printbuf *out, struct btree_key_cache *bc)
 {
-	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
-
 	printbuf_tabstop_push(out, 24);
 	printbuf_tabstop_push(out, 12);
 
-	unsigned flags = memalloc_nofs_save();
-	mutex_lock(&bc->lock);
 	prt_printf(out, "keys:\t%lu\r\n",		atomic_long_read(&bc->nr_keys));
 	prt_printf(out, "dirty:\t%lu\r\n",		atomic_long_read(&bc->nr_dirty));
-	prt_printf(out, "freelist:\t%lu\r\n",		atomic_long_read(&bc->nr_freed));
-	prt_printf(out, "nonpcpu freelist:\t%zu\r\n",	bc->nr_freed_nonpcpu);
-	prt_printf(out, "pcpu freelist:\t%zu\r\n",	bc->nr_freed_pcpu);
+	prt_printf(out, "table size:\t%u\r\n",		bc->table.tbl->size);
 
 	prt_printf(out, "\nshrinker:\n");
 	prt_printf(out, "requested_to_free:\t%lu\r\n",	bc->requested_to_free);
 	prt_printf(out, "freed:\t%lu\r\n",		bc->freed);
-	prt_printf(out, "moved_to_freelist:\t%lu\r\n",	bc->moved_to_freelist);
 	prt_printf(out, "skipped_dirty:\t%lu\r\n",	bc->skipped_dirty);
 	prt_printf(out, "skipped_accessed:\t%lu\r\n",	bc->skipped_accessed);
 	prt_printf(out, "skipped_lock_fail:\t%lu\r\n",	bc->skipped_lock_fail);
-
-	prt_printf(out, "srcu seq:\t%lu\r\n",		get_state_synchronize_srcu(&c->btree_trans_barrier));
-
-	struct bkey_cached *ck;
-	unsigned iter = 0;
-	list_for_each_entry(ck, &bc->freed_nonpcpu, list) {
-		prt_printf(out, "freed_nonpcpu:\t%lu\r\n", ck->btree_trans_barrier_seq);
-		if (++iter > 10)
-			break;
-	}
-
-	iter = 0;
-	list_for_each_entry(ck, &bc->freed_pcpu, list) {
-		prt_printf(out, "freed_pcpu:\t%lu\r\n", ck->btree_trans_barrier_seq);
-		if (++iter > 10)
-			break;
-	}
-	mutex_unlock(&bc->lock);
-	memalloc_flags_restore(flags);
 }
 
 void bch2_btree_key_cache_exit(void)
diff --git a/fs/bcachefs/btree_key_cache_types.h b/fs/bcachefs/btree_key_cache_types.h
index 237e8bb3ac40..e026c65f54e1 100644
--- a/fs/bcachefs/btree_key_cache_types.h
+++ b/fs/bcachefs/btree_key_cache_types.h
@@ -2,33 +2,19 @@
 #ifndef _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
 #define _BCACHEFS_BTREE_KEY_CACHE_TYPES_H
 
-struct btree_key_cache_freelist {
-	struct bkey_cached	*objs[16];
-	unsigned		nr;
-};
-
 struct btree_key_cache {
-	struct mutex		lock;
 	struct rhashtable	table;
 	bool			table_init_done;
 
-	struct list_head	freed_pcpu;
-	size_t			nr_freed_pcpu;
-	struct list_head	freed_nonpcpu;
-	size_t			nr_freed_nonpcpu;
-
 	struct shrinker		*shrink;
 	unsigned		shrink_iter;
-	struct btree_key_cache_freelist __percpu *pcpu_freed;
 
-	atomic_long_t		nr_freed;
 	atomic_long_t		nr_keys;
 	atomic_long_t		nr_dirty;
 
 	/* shrinker stats */
 	unsigned long		requested_to_free;
 	unsigned long		freed;
-	unsigned long		moved_to_freelist;
 	unsigned long		skipped_dirty;
 	unsigned long		skipped_accessed;
 	unsigned long		skipped_lock_fail;
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 5f760906e366..e8190f4e45ac 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -386,17 +386,17 @@ struct bkey_cached {
 	struct btree_bkey_cached_common c;
 
 	unsigned long		flags;
-	unsigned long		btree_trans_barrier_seq;
 	u16			u64s;
 	struct bkey_cached_key	key;
 
 	struct rhash_head	hash;
-	struct list_head	list;
 
 	struct journal_entry_pin journal;
 	u64			seq;
 
 	struct bkey_i		*k;
+
+	struct rcu_head		rcu;
 };
 
 static inline struct bpos btree_node_pos(struct btree_bkey_cached_common *b)
-- 
2.45.2

