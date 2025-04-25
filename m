Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE042367B2
	for <rcu@vger.kernel.org>; Fri, 25 Apr 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569695; cv=none; b=S9rgbuOWmu2vMMgfJsjy2Sq2OQtyC3nsXwwdho+tzL/YPDJu/l6vLWFSDdL9EyiN0dsjSuk2RHc2J+34uVwkJ5y6lU+v56/30SA4gtVMlmjPQbAhyb0DOETcixfN+VQC9iBeJMQFqTxBQ3CHodTR8iBNWuRuf+tWOHEgTcaKQ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569695; c=relaxed/simple;
	bh=70Aj8YqVfOxDRc8d07wRD2AHMTnve40q19hodhZWMcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2ojAoXlsqx7Q7R/QrcIcylpLFS6JTGDaBtoHI4cacJBthPmHr7gXCnB3CP4qCjnQvJw4zREQ80scWU/edARJD7HzCaPuDky22x7HIi45PpBtfzq1v0nSk5rPVcqfisdS9PDeZOcRso1dop7J5AS9BO2bF6+0mbUpo2gvObdVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EC771F393;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5746513A8B;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OJcHFYlHC2htfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Apr 2025 08:27:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 25 Apr 2025 10:27:29 +0200
Subject: [PATCH v4 9/9] mm, slub: skip percpu sheaves for remote object
 freeing
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-slub-percpu-caches-v4-9-8a636982b4a4@suse.cz>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6EC771F393
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Since we don't control the NUMA locality of objects in percpu sheaves,
allocations with node restrictions bypass them. Allocations without
restrictions may however still expect to get local objects with high
probability, and the introduction of sheaves can decrease it due to
freed object from a remote node ending up in percpu sheaves.

The fraction of such remote frees seems low (5% on an 8-node machine)
but it can be expected that some cache or workload specific corner cases
exist. We can either conclude that this is not a problem due to the low
fraction, or we can make remote frees bypass percpu sheaves and go
directly to their slabs. This will make the remote frees more expensive,
but if if's only a small fraction, most frees will still benefit from
the lower overhead of percpu sheaves.

This patch thus makes remote object freeing bypass percpu sheaves,
including bulk freeing, and kfree_rcu() via the rcu_free sheaf. However
it's not intended to be 100% guarantee that percpu sheaves will only
contain local objects. The refill from slabs does not provide that
guarantee in the first place, and there might be cpu migrations
happening when we need to unlock the local_lock. Avoiding all that could
be possible but complicated so we can leave it for later investigation
whether it would be worth it. It can be expected that the more selective
freeing will itself prevent accumulation of remote objects in percpu
sheaves so any such violations would have only short-term effects.

Another possible optimization to investigate is whether it would be
beneficial for node-restricted or strict_numa allocations to attempt to
obtain an object from percpu sheaves if the node or mempolicy (i.e.
MPOL_LOCAL) happens to want the local node of the allocating cpu. Right
now such allocations bypass sheaves, but they could probably look first
whether the first available object in percpu sheaves is local, and with
high probability succeed - and only bypass the sheaves in cases it's
not local.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c |  7 +++++--
 mm/slub.c        | 43 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 6c3b90f03cb79b57f426824450f576a977d85c53..af4e225372fa2d1e7d0f55a90b5335a29a36d2ea 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1623,8 +1623,11 @@ static bool kfree_rcu_sheaf(void *obj)
 
 	slab = folio_slab(folio);
 	s = slab->slab_cache;
-	if (s->cpu_sheaves)
-		return __kfree_rcu_sheaf(s, obj);
+	if (s->cpu_sheaves) {
+		if (likely(!IS_ENABLED(CONFIG_NUMA) ||
+			   slab_nid(slab) == numa_node_id()))
+			return __kfree_rcu_sheaf(s, obj);
+	}
 
 	return false;
 }
diff --git a/mm/slub.c b/mm/slub.c
index cc273cc45f632e16644355831132cdc391219cec..2bf83e2b85b23f4db2b311edaded4bef6b7d01de 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -455,6 +455,7 @@ struct slab_sheaf {
 	};
 	struct kmem_cache *cache;
 	unsigned int size;
+	int node; /* only used for rcu_sheaf */
 	void *objects[];
 };
 
@@ -5649,7 +5650,7 @@ static void rcu_free_sheaf(struct rcu_head *head)
 	 */
 	__rcu_free_sheaf_prepare(s, sheaf);
 
-	barn = get_node(s, numa_mem_id())->barn;
+	barn = get_node(s, sheaf->node)->barn;
 
 	/* due to slab_free_hook() */
 	if (unlikely(sheaf->size == 0))
@@ -5724,10 +5725,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 
 	rcu_sheaf->objects[rcu_sheaf->size++] = obj;
 
-	if (likely(rcu_sheaf->size < s->sheaf_capacity))
+	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
 		rcu_sheaf = NULL;
-	else
+	} else {
 		pcs->rcu_free = NULL;
+		rcu_sheaf->node = numa_node_id();
+	}
 
 	local_unlock(&s->cpu_sheaves->lock);
 
@@ -5753,9 +5756,13 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	struct slab_sheaf *main, *empty;
 	unsigned int batch, i = 0;
 	bool init;
+	void *remote_objects[PCS_BATCH_MAX];
+	unsigned int remote_nr = 0;
+	int node = numa_node_id();
 
 	init = slab_want_init_on_free(s);
 
+next_remote_batch:
 	while (i < size) {
 		struct slab *slab = virt_to_slab(p[i]);
 
@@ -5765,7 +5772,15 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		if (unlikely(!slab_free_hook(s, p[i], init, false))) {
 			p[i] = p[--size];
 			if (!size)
-				return;
+				goto flush_remote;
+			continue;
+		}
+
+		if (unlikely(IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) != node)) {
+			remote_objects[remote_nr] = p[i];
+			p[i] = p[--size];
+			if (++remote_nr >= PCS_BATCH_MAX)
+				goto flush_remote;
 			continue;
 		}
 
@@ -5833,6 +5848,15 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	 */
 fallback:
 	__kmem_cache_free_bulk(s, size, p);
+
+flush_remote:
+	if (remote_nr) {
+		__kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
+		if (i < size) {
+			remote_nr = 0;
+			goto next_remote_batch;
+		}
+	}
 }
 
 #ifndef CONFIG_SLUB_TINY
@@ -5924,8 +5948,15 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		return;
 
-	if (!s->cpu_sheaves || !free_to_pcs(s, object))
-		do_slab_free(s, slab, object, object, 1, addr);
+	if (s->cpu_sheaves) {
+		if (likely(!IS_ENABLED(CONFIG_NUMA) ||
+			   slab_nid(slab) == numa_node_id())) {
+			free_to_pcs(s, object);
+			return;
+		}
+	}
+
+	do_slab_free(s, slab, object, object, 1, addr);
 }
 
 #ifdef CONFIG_MEMCG

-- 
2.49.0

