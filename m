Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92517552;
	Fri,  9 Aug 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215772; cv=none; b=jMT+NZRu92wI8nZ5aOspzxmD1EIzTV8zmvpzLR9zQNd8lNHyaeDsvhWoqRkhBNcm8uIJhm2l9oX//f1XKwUILlGoRFKZdId9CABIBfcto1HHn/Er/9NUapYgfJvqwz3J/mbA0c7PtBFqo/mQ4laqBz0lIcelj/kXXM8BrWm95YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215772; c=relaxed/simple;
	bh=SfbfoKGh1o87NkMuFlVDHbXK2eG99rNri0gCCkPN/qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmGs2Vo3ZDArcpj4cUGpnxNKZGZGFOtsO2LtPcKbxXjeBpHbJMi7b06dGYt9dKxJ00ohgNevQ79JULFUSHMw2SuSF7v9vvaXO+6MXJ8AjeqITZMITrLnyxg0MwAUIjbIe8/Bls/ih4YdQQg4chlimvYcWQQ6RKFaXSm9hkFTyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kady5WHm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=trrxkWzm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q2Vn5zKZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JwW7fFYa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kady5WHm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="trrxkWzm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q2Vn5zKZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JwW7fFYa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87C1A1FF8F;
	Fri,  9 Aug 2024 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723215768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m6ODK5n8Ww4+d1x9prn8X3lC5bnbKDRJfsW7yKouSrs=;
	b=kady5WHmwOZaRZT/UYfShHdxIuYNj7wSlnCtvh7t12iffakwexzmLi9qcz4k7/HWz14fGe
	+momoW4JcNFbhkTcv7feHike7c5X154Vz3NmK6vMqrYiFXb6gLNCrHFKwU3OJ+xEjjmUar
	oHVh+gkuJEdM+pGfJ8F9fCmSzRD6v14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723215768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m6ODK5n8Ww4+d1x9prn8X3lC5bnbKDRJfsW7yKouSrs=;
	b=trrxkWzm/wy/++Pvf5b3e6EpGBWPxGKge55iEyKhZXUw56yv4V42iLbacW5Rp/odpvviQp
	MpqTbsrD3DiEqbAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723215767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m6ODK5n8Ww4+d1x9prn8X3lC5bnbKDRJfsW7yKouSrs=;
	b=q2Vn5zKZ6nLDVEhq4Hq01HPqcRPaXt8lnspZxGFumKBtp4iXUJYoUIyzyuSCeNTee2ffc6
	gwgFijUq62nxK5sRW3/gSgTYZFF+1WvnRRBsgNPOU3hBQWVsGQqE9gD7JIOtxBFD4Wi8Ra
	mlcfeL6wa0iO9KGvvf4pyCVQ/IjxZzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723215767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m6ODK5n8Ww4+d1x9prn8X3lC5bnbKDRJfsW7yKouSrs=;
	b=JwW7fFYagAG1R2f8Bv3+ew7sBpSKdmazRtEjiwcrpdktc5AmFCH9qRnwj9yzuZBIvA8LTS
	oQfq+L16ow5UAUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74B311379A;
	Fri,  9 Aug 2024 15:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1lL2GpUvtmZ9HQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Aug 2024 15:02:45 +0000
Message-ID: <54d62d5a-16e3-4ea9-83c6-8801ee99855e@suse.cz>
Date: Fri, 9 Aug 2024 17:02:44 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [-next conflict imminent] Re: [PATCH v2 0/7] mm, slub: handle pending
 kfree_rcu() in kmem_cache_destroy()
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
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
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.21 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com,canb.auug.org.au];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,google.com,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: 0.21

On 8/7/24 12:31, Vlastimil Babka wrote:
> Also in git:
> https://git.kernel.org/vbabka/l/slab-kfree_rcu-destroy-v2r2

I've added this to slab/for-next, there will be some conflicts and here's my
resulting git show or the merge commit I tried over today's next.

It might look a bit different with tomorrow's next as mm will have v7 of the
conflicting series from Jann:

https://lore.kernel.org/all/1ca6275f-a2fc-4bad-81dc-6257d4f8d750@suse.cz/

(also I did resolve it in the way I suggested to move Jann's block before
taking slab_mutex() but unless that happens in mm-unstable it would probably be more
correct to keep where he did)

---8<---
commit 444486f2b7b0325ba026e0ad129eba3f54c18301
Merge: 61c01d2e181a 63eac6bdcf9f
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Fri Aug 9 16:49:03 2024 +0200

    Merge branch 'slab/for-6.12/rcu_barriers' into HEAD

diff --cc include/linux/rcutree.h
index 7dbde2b6f714,58e7db80f3a8..90a684f94776
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@@ -35,9 -35,10 +35,10 @@@ static inline void rcu_virt_note_contex
  
  void synchronize_rcu_expedited(void);
  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
+ void kvfree_rcu_barrier(void);
  
  void rcu_barrier(void);
 -void rcu_momentary_dyntick_idle(void);
 +void rcu_momentary_eqs(void);
  void kfree_rcu_scheduler_running(void);
  bool rcu_gp_might_be_stalled(void);
  
diff --cc kernel/rcu/tree.c
index 930846f06bee,ebcfed9b570e..4606fa361b06
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@@ -3614,7 -3631,7 +3611,7 @@@ kvfree_rcu_queue_batch(struct kfree_rcu
  			// be that the work is in the pending state when
  			// channels have been detached following by each
  			// other.
- 			queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
 -			queued = queue_rcu_work(system_wq, &krwp->rcu_work);
++			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
  		}
  	}
  
diff --cc mm/slab_common.c
index fc7b1250d929,1a2873293f5d..82f287c21954
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@@ -511,67 -487,40 +505,52 @@@ EXPORT_SYMBOL(kmem_buckets_create)
   */
  static void kmem_cache_release(struct kmem_cache *s)
  {
- 	if (slab_state >= FULL) {
- 		sysfs_slab_unlink(s);
+ 	kfence_shutdown_cache(s);
+ 	if (__is_defined(SLAB_SUPPORTS_SYSFS) && slab_state >= FULL)
  		sysfs_slab_release(s);
- 	} else {
+ 	else
  		slab_kmem_cache_release(s);
- 	}
  }
- #else
- static void kmem_cache_release(struct kmem_cache *s)
+ 
+ void slab_kmem_cache_release(struct kmem_cache *s)
  {
- 	slab_kmem_cache_release(s);
+ 	__kmem_cache_release(s);
+ 	kfree_const(s->name);
+ 	kmem_cache_free(kmem_cache, s);
  }
- #endif
  
- static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
+ void kmem_cache_destroy(struct kmem_cache *s)
  {
- 	LIST_HEAD(to_destroy);
- 	struct kmem_cache *s, *s2;
- 
- 	/*
- 	 * On destruction, SLAB_TYPESAFE_BY_RCU kmem_caches are put on the
- 	 * @slab_caches_to_rcu_destroy list.  The slab pages are freed
- 	 * through RCU and the associated kmem_cache are dereferenced
- 	 * while freeing the pages, so the kmem_caches should be freed only
- 	 * after the pending RCU operations are finished.  As rcu_barrier()
- 	 * is a pretty slow operation, we batch all pending destructions
- 	 * asynchronously.
- 	 */
- 	mutex_lock(&slab_mutex);
- 	list_splice_init(&slab_caches_to_rcu_destroy, &to_destroy);
- 	mutex_unlock(&slab_mutex);
+ 	int err;
  
- 	if (list_empty(&to_destroy))
+ 	if (unlikely(!s) || !kasan_check_byte(s))
  		return;
  
- 	rcu_barrier();
+ 	/* in-flight kfree_rcu()'s may include objects from our cache */
+ 	kvfree_rcu_barrier();
  
- 	list_for_each_entry_safe(s, s2, &to_destroy, list) {
- 		debugfs_slab_release(s);
- 		kfence_shutdown_cache(s);
- 		kmem_cache_release(s);
- 	}
- }
- 
- static int shutdown_cache(struct kmem_cache *s)
- {
 +	if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
 +	    (s->flags & SLAB_TYPESAFE_BY_RCU)) {
 +		/*
 +		 * Under CONFIG_SLUB_RCU_DEBUG, when objects in a
 +		 * SLAB_TYPESAFE_BY_RCU slab are freed, SLUB will internally
 +		 * defer their freeing with call_rcu().
 +		 * Wait for such call_rcu() invocations here before actually
 +		 * destroying the cache.
 +		 */
 +		rcu_barrier();
 +	}
 +
+ 	cpus_read_lock();
+ 	mutex_lock(&slab_mutex);
+ 
+ 	s->refcount--;
+ 	if (s->refcount) {
+ 		mutex_unlock(&slab_mutex);
+ 		cpus_read_unlock();
+ 		return;
+ 	}
+ 
  	/* free asan quarantined objects */
  	kasan_cache_shutdown(s);
  

