Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9041D364C;
	Wed,  7 Aug 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026704; cv=none; b=WZVWkM4pHTNZZtc5l8heeZYggnMsjT5ll9+JBW4CsjhTY3xJvCy0wg9jM71CYwozNDOcbV1f+VsKqzgq3D/+4qg9a1etg6JqCca50cN1eaFCRN9QsVDEHSXHyiQi2c87OWNY9k4s4uOmfy0vgoKlN4/Oc4eOjdmQDyLDIzCHKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026704; c=relaxed/simple;
	bh=IKzNm6IhIvGRZL206iBD5aH9mRPWOtJEttlogjtjEAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXdge/Q/F4NqMM/qlYluJPi1Cr3OtpRuZncfaA3LmC96L8zfodKlT5ANH/byi60HyNkG0M7BLjEKrHwcT7e0ynLJjnBcJ+HMH/5hoCwINrnPq2d9c5jxCkjTun7i1uPzIaHScJnFkIMhjjysVhQR1TZKvI/79WLyn1AcgD1KE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YwEVT8Zy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nRFhcHRO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UlFErIrL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ljOrAaOB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YwEVT8Zy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nRFhcHRO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UlFErIrL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ljOrAaOB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E65B621B51;
	Wed,  7 Aug 2024 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R4VEs0s4uyTtqaeQIxLvgBnoD49RLjNoURIedFN5O4=;
	b=YwEVT8ZywArwGZA+nX+2r6ZqSUHyB34SZZ+gcNuyQbXQNjl7UorcCTTahscphEP4uM0uRl
	0sq+avJB8JMUV0MKExx6ltEUFA8zrnUKKme7E+G5hUk6yLUXfaa9hFzX7fbBCCJTehhJ1Q
	NHHX0xxgKe6yBpJQGGVjA6srVHlQ2w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R4VEs0s4uyTtqaeQIxLvgBnoD49RLjNoURIedFN5O4=;
	b=nRFhcHROYA7mPEx9T9wJ3K/ieeUPGDvJc0Ur2giQhqT6GxIAjw4g9c+Cxl2BIQxqdDJCxW
	bc7vpKTTnDX3OcDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UlFErIrL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ljOrAaOB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R4VEs0s4uyTtqaeQIxLvgBnoD49RLjNoURIedFN5O4=;
	b=UlFErIrLpnllen+2sGfZKyfqLpuG/tXTzEN7tHbxb13lhuPvv1jnjXxKgzGK/2QZvhAtyp
	Ozf+yqRz4R/g2sq7kLK6V4lguB4Gd4FSGiXinAgl2nxUD1UxGD/iazj78yt48yJP+7d5VS
	iw/5YJggf7GKVaBqXozLjSX+19GkJTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R4VEs0s4uyTtqaeQIxLvgBnoD49RLjNoURIedFN5O4=;
	b=ljOrAaOBHnj/XoxD6FsSLvTyJgxcUxrXrtisHPcjUxCiZpfBZmOM/o33djb00n3ZY4EbCj
	7j07+ZnY+3912vCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC82F13B05;
	Wed,  7 Aug 2024 10:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELi5LQVNs2YsHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Aug 2024 10:31:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 07 Aug 2024 12:31:15 +0200
Subject: [PATCH v2 2/7] mm, slab: unlink slabinfo, sysfs and debugfs
 immediately
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-slab-kfree_rcu-destroy-v2-2-ea79102f428c@suse.cz>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
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
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,google.com,googlegroups.com,suse.cz];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLsm9p66qmnckghmjmpccdnq6s)];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: E65B621B51

kmem_cache_destroy() includes removing the associated sysfs and debugfs
directories, and the cache from the list of caches that appears in
/proc/slabinfo. Currently this might not happen immediately when:

- the cache is SLAB_TYPESAFE_BY_RCU and the cleanup is delayed,
  including the directores removal
- __kmem_cache_shutdown() fails due to outstanding objects - the
  directories remain indefinitely

When a cache is recreated with the same name, such as due to module
unload followed by a load, the directories will fail to be recreated for
the new instance of the cache due to the old directories being present.
The cache will also appear twice in /proc/slabinfo.

While we want to convert the SLAB_TYPESAFE_BY_RCU cleanup to be
synchronous again, the second point remains. So let's fix this first and
have the directories and slabinfo removed immediately in
kmem_cache_destroy() and regardless of __kmem_cache_shutdown() success.

This should not make debugging harder if __kmem_cache_shutdown() fails,
because a detailed report of outstanding objects is printed into dmesg
already due to the failure.

Also simplify kmem_cache_release() sysfs handling by using
__is_defined(SLAB_SUPPORTS_SYSFS).

Note the resulting code in kmem_cache_destroy() is a bit ugly but will
be further simplified - this is in order to make small bisectable steps.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 57 ++++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index b76d65d7fe33..db61df3b4282 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -484,31 +484,19 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 }
 EXPORT_SYMBOL(kmem_buckets_create);
 
-#ifdef SLAB_SUPPORTS_SYSFS
 /*
  * For a given kmem_cache, kmem_cache_destroy() should only be called
  * once or there will be a use-after-free problem. The actual deletion
  * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
  * protection. So they are now done without holding those locks.
- *
- * Note that there will be a slight delay in the deletion of sysfs files
- * if kmem_cache_release() is called indrectly from a work function.
  */
 static void kmem_cache_release(struct kmem_cache *s)
 {
-	if (slab_state >= FULL) {
-		sysfs_slab_unlink(s);
+	if (__is_defined(SLAB_SUPPORTS_SYSFS) && slab_state >= FULL)
 		sysfs_slab_release(s);
-	} else {
+	else
 		slab_kmem_cache_release(s);
-	}
 }
-#else
-static void kmem_cache_release(struct kmem_cache *s)
-{
-	slab_kmem_cache_release(s);
-}
-#endif
 
 static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 {
@@ -534,7 +522,6 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 	rcu_barrier();
 
 	list_for_each_entry_safe(s, s2, &to_destroy, list) {
-		debugfs_slab_release(s);
 		kfence_shutdown_cache(s);
 		kmem_cache_release(s);
 	}
@@ -549,8 +536,8 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 
 void kmem_cache_destroy(struct kmem_cache *s)
 {
-	int err = -EBUSY;
 	bool rcu_set;
+	int err;
 
 	if (unlikely(!s) || !kasan_check_byte(s))
 		return;
@@ -558,11 +545,14 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
-	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
-
 	s->refcount--;
-	if (s->refcount)
-		goto out_unlock;
+	if (s->refcount) {
+		mutex_unlock(&slab_mutex);
+		cpus_read_unlock();
+		return;
+	}
+
+	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
 
 	/* free asan quarantined objects */
 	kasan_cache_shutdown(s);
@@ -571,24 +561,29 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
 	     __func__, s->name, (void *)_RET_IP_);
 
-	if (err)
-		goto out_unlock;
-
 	list_del(&s->list);
 
-	if (rcu_set) {
-		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
-		schedule_work(&slab_caches_to_rcu_destroy_work);
-	} else {
+	if (!err && !rcu_set)
 		kfence_shutdown_cache(s);
-		debugfs_slab_release(s);
-	}
 
-out_unlock:
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
-	if (!err && !rcu_set)
+
+	if (slab_state >= FULL)
+		sysfs_slab_unlink(s);
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
 		kmem_cache_release(s);
+	}
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 

-- 
2.46.0

