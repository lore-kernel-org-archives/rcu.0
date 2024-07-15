Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494913AA45;
	Mon, 15 Jul 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075383; cv=none; b=OSx2b9t1LYwxDHbXTD70HBTIk2MuPH3TpLvpYVlzMFVyhGY+4ssMI1VTkUJRFH8jYFtGlCOSa0iPSi50eiuib8FDkQeWSQFltikphrqlAkq7nnD9r1spKik90p1VuHJFGDgG6YUb07LHC3+f+yGaOpgOIHN1r2qkvmUVk0mMjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075383; c=relaxed/simple;
	bh=VnXsY+DQHks8brFpPpbxnaJ/NtT/5YPnbPpZsFtJrEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGIBB12E3B99ooJsRT2L1keSMGmQPQrbCCrWXBCuXztaL1vhnyMkZS127nfGGUaNuzgRX0CJZFBArPpdaRJ1O1qP2dhSA6jx/vXrMeH5ngpoGzLfUQEoLsRMLl8QU5NRt6iFOYibVVe5P8aUXyGh8Bex5m40YK2BXKWIbApRsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSGyH+m5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kAIi0fhY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSGyH+m5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kAIi0fhY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSGyH+m5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kAIi0fhY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSGyH+m5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kAIi0fhY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF0BC1F849;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGLdjgoDRMwVFM9fTSoQ/YTustjDFDN8l8I6qmGg0KM=;
	b=hSGyH+m5FYyRHvKzXhLIpQGye0mEwLbM3RqIof47AS3U2ab1U27QYUbjQLDHoBm5COD+rq
	Ceso8rzC8jfjximaXlOSp7oRoim+/TN/R0Uq/5a8xFXCECpuSwariIoyRIXR2Ph34PPzs1
	QVSlCwrPIzslLN7yLti+5OJPxWO/dfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGLdjgoDRMwVFM9fTSoQ/YTustjDFDN8l8I6qmGg0KM=;
	b=kAIi0fhYDpGbjURluCU3wBE0Tgnqg89fNVrOr5lDUl5eiKjVINACSfe8OycWeAGYyY3d+5
	yNQIKHir85e7KmAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hSGyH+m5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kAIi0fhY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGLdjgoDRMwVFM9fTSoQ/YTustjDFDN8l8I6qmGg0KM=;
	b=hSGyH+m5FYyRHvKzXhLIpQGye0mEwLbM3RqIof47AS3U2ab1U27QYUbjQLDHoBm5COD+rq
	Ceso8rzC8jfjximaXlOSp7oRoim+/TN/R0Uq/5a8xFXCECpuSwariIoyRIXR2Ph34PPzs1
	QVSlCwrPIzslLN7yLti+5OJPxWO/dfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGLdjgoDRMwVFM9fTSoQ/YTustjDFDN8l8I6qmGg0KM=;
	b=kAIi0fhYDpGbjURluCU3wBE0Tgnqg89fNVrOr5lDUl5eiKjVINACSfe8OycWeAGYyY3d+5
	yNQIKHir85e7KmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEB9713A63;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QGIrMrKGlWbvUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Jul 2024 20:29:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Jul 2024 22:29:29 +0200
Subject: [PATCH RFC 3/6] mm, slab: unlink sysfs and debugfs immediately
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-slab-kfree_rcu-destroy-v1-3-46b2984c2205@suse.cz>
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.0
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,suse.cz];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLsm9p66qmnckghmjmpccdnq6s)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: EF0BC1F849

kmem_cache_destroy() includes removing the associated sysfs and debugfs
directories. Currently this might not happen immediately when:

- the cache is SLAB_TYPESAFE_BY_RCU and the cleanup is delayed,
  including the directores removal
- __kmem_cache_shutdown() fails due to outstanding objects - the
  directories remain indefinitely

When a cache is recreated with the same name, such as due to module
unload followed by a load, the directories will fail to be recreated for
the new instance of the cache due to the old directories being present.

We also want to add another possibility of delayed cleanup due to
kfree_rcu() in flight so let's fix this first and have the directories
removed immediately in kmem_cache_destroy() and regardless of
__kmem_cache_shutdown() success.

This should not make debugging harder if __kmem_cache_shutdown() fails,
because a detailed report of outstanding objects is printed into dmesg
already due to the failure.

Note the record in /proc/slabinfo will remain until the cleanup is
finished (or indefinitely if __kmem_cache_shutdown() fails) but that
does not prevent a new record to be added for a new cache instance.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 65 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3ba205bda95d..2eef5ad37fa7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -492,14 +492,10 @@ EXPORT_SYMBOL(kmem_buckets_create);
  * once or there will be a use-after-free problem. The actual deletion
  * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
  * protection. So they are now done without holding those locks.
- *
- * Note that there will be a slight delay in the deletion of sysfs files
- * if kmem_cache_release() is called indrectly from a work function.
  */
 static void kmem_cache_release(struct kmem_cache *s)
 {
 	if (slab_state >= FULL) {
-		sysfs_slab_unlink(s);
 		sysfs_slab_release(s);
 	} else {
 		slab_kmem_cache_release(s);
@@ -536,33 +532,11 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 	rcu_barrier();
 
 	list_for_each_entry_safe(s, s2, &to_destroy, list) {
-		debugfs_slab_release(s);
 		kfence_shutdown_cache(s);
 		kmem_cache_release(s);
 	}
 }
 
-static int shutdown_cache(struct kmem_cache *s)
-{
-	/* free asan quarantined objects */
-	kasan_cache_shutdown(s);
-
-	if (__kmem_cache_shutdown(s) != 0)
-		return -EBUSY;
-
-	list_del(&s->list);
-
-	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
-		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
-		schedule_work(&slab_caches_to_rcu_destroy_work);
-	} else {
-		kfence_shutdown_cache(s);
-		debugfs_slab_release(s);
-	}
-
-	return 0;
-}
-
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
@@ -572,8 +546,8 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 
 void kmem_cache_destroy(struct kmem_cache *s)
 {
-	int err = -EBUSY;
 	bool rcu_set;
+	int err;
 
 	if (unlikely(!s) || !kasan_check_byte(s))
 		return;
@@ -581,20 +555,45 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
+	s->refcount--;
+	if (s->refcount) {
+		mutex_unlock(&slab_mutex);
+		cpus_read_unlock();
+		return;
+	}
+
 	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
 
-	s->refcount--;
-	if (s->refcount)
-		goto out_unlock;
+	/* free asan quarantined objects */
+	kasan_cache_shutdown(s);
 
-	err = shutdown_cache(s);
+	err = __kmem_cache_shutdown(s);
 	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
 	     __func__, s->name, (void *)_RET_IP_);
-out_unlock:
+
+	if (!err)
+		list_del(&s->list);
+
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
-	if (!err && !rcu_set)
+
+	if (slab_state >= FULL) {
+		sysfs_slab_unlink(s);
+	}
+	debugfs_slab_release(s);
+
+	if (err)
+		return;
+
+	if (rcu_set) {
+		mutex_lock(&slab_mutex);
+		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
+		schedule_work(&slab_caches_to_rcu_destroy_work);
+		mutex_unlock(&slab_mutex);
+	} else {
+		kfence_shutdown_cache(s);
 		kmem_cache_release(s);
+	}
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 

-- 
2.45.2

