Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44B303A3E
	for <rcu@vger.kernel.org>; Tue,  9 Sep 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429760; cv=none; b=GDZHTAF/7nn/0zFQqO7GWcnVV9flOl2/xPtbk8zQF8nVcz4j05jPTALByO6X4jX3B1wS3eQSmr1THoeWAq3K4Vt8ddMqYFuuW0B3q5McftH5HWwh0t9J++r6mZ//3RWJ9XNgytoQmMpeLdMgIwYEH+OQ1D+E6rFDNxmpJl/pYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429760; c=relaxed/simple;
	bh=y6lQn3gd6ZC2UP/VV61XZ/hLy3wlHTcSEt1IO/E/Ffg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EqlmLeh4LvaQ7wNpmvDVa/phbNBjg0dcztWFEfoWzGwRJ4XCvL2JwQJXyE8UvfSlcm3K1vu8WQMTEz1WxCbFUwmmMjCu56JnLHmOtemTCnL2m2zWk60Som8vJeC5N7U2mn9wahSLWDJq5tEfKXBovKYaVqDrg4rUGJwZMwEP0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Lt1HffP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ysQTX0wS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BoJR84pS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4TVRPKxS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Lt1HffP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ysQTX0wS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BoJR84pS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4TVRPKxS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B11FE342F4;
	Tue,  9 Sep 2025 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5neFHt5JR3l5076bBzWdzlzRYQZvAlR+g6JdGulkKac=;
	b=0Lt1HffPqLEBVBYeBfuRjJPSDPTLCLbtu9E/oF2kDs6bjKm/j/BZvXM0tNujpe/LeFT+eE
	owwq4qqXV1S8uzA6Xq9C57CDXxGRRMj8BzeIZUqohHmRxhp5+R93kBln/3/GjdUefHBqJo
	3jySORdGoYvuwzCjqj1Mrxi2CuOxa/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5neFHt5JR3l5076bBzWdzlzRYQZvAlR+g6JdGulkKac=;
	b=ysQTX0wS9cC4FDYt1M45MyYH0umox5Fac7D2xmTW0YIbU6AqnC1fWYmvY78r9g15trg1AZ
	n9Z/QpuyBvTmWEAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5neFHt5JR3l5076bBzWdzlzRYQZvAlR+g6JdGulkKac=;
	b=BoJR84pSzM0rrtHZwTMd3UM4G8ceSWP45cJiO5MZFqijXfW0oSzpxfx17V7SSb2vBBHPxa
	3K9+mp1Ey/GB9mzLMve9FOeWVxI9lx+q+vJZpyidemQL8A9GIx1oVOmgl8ea+/MFNDplBj
	vc61aXrM+Zf8R+Lpy0buau/31d7rR0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5neFHt5JR3l5076bBzWdzlzRYQZvAlR+g6JdGulkKac=;
	b=4TVRPKxSRfEseKij5yKbBjGsnF4xFtUPQpn/yucYzjtTuHFxhIFpZbWyMs40JHeeYUHIPR
	DYGBe4BGLy4IveBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99A871388C;
	Tue,  9 Sep 2025 14:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZOw4Jfs/wGhpewAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 09 Sep 2025 14:55:55 +0000
Message-ID: <64e0795d-c285-47d4-8282-a31d10fe1c47@suse.cz>
Date: Tue, 9 Sep 2025 16:55:55 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/21] slab: add sheaf support for batching kfree_rcu()
 operations
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
 <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>
 <aL7FFpIMmXtzzSL1@pc638.lan> <6f8274da-a010-4bb3-b3d6-690481b5ace0@suse.cz>
 <aL_uhPtztx7Ef0T2@pc636> <838888f2-7a0f-49f0-9e33-592f13b14ad3@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <838888f2-7a0f-49f0-9e33-592f13b14ad3@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 9/9/25 12:20, Vlastimil Babka wrote:
> On 9/9/25 11:08, Uladzislau Rezki wrote:
>> On Mon, Sep 08, 2025 at 02:45:11PM +0200, Vlastimil Babka wrote:
>>> 
>>> Hm I could not find where that distinction is in the code, can you give a
>>> hint please. In __kfree_rcu_sheaf() I do only have a GFP_NOWAIT attempt.
>>> 
>> For PREEMPT_RT a regular spin-lock is an rt-mutex which can sleep. We
>> made kvfree_rcu() to make it possible to invoke it from non-sleep contexts:
> 
> Oh you mean it's not allocating even on !RT so there's no RT-specific code.
> 
>> CONFIG_PREEMPT_RT
>> 
>> preempt_disable() or something similar;
>>  kvfree_rcu();
>>   GFP_NOWAIT - lock rt-mutex
>> 
>> If GFP_NOWAIT semantic does not access any spin-locks then we are safe
>> or if it uses raw_spin_locks.
> 
> It does access spinlocks so it's not safe. Thanks, I didn't realize that
> aspect of kfree_rcu(). We'll need to solve this before making sheaves
> enabled everywhere. I don't think the vma or maple tree code would
> kfree_rcu() vma or maple_node in such a restricted context. But to be safe
> I'll just disable the kfree rcu sheaves for PREEMPT_RT for now.

So I came up with this fixup to avoid PREEMPT_RT troubles and make
kvfree_rcu_barrier() work.

----8<----
From 15a8db2ef716b5db547f2d86ab30d8774333fb04 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 9 Sep 2025 16:18:52 +0200
Subject: [PATCH] slub: fix issues with kfree_rcu sheaf handling

Fix two issues reported by Ulad:

- on PREEMPT_RT if kfree_rcu() comes from an atomic context, taking a
  spinlock on the barn or doing a GFP_NOWAIT allocation of a new sheaf
  might not be possible. For now just limit the usage of
  kfree_rcu_sheaf() to !PREEMPT_RT

- kvfree_rcu_barrier() must flush all rcu_free sheaves to deliver on its
  promise. The usage isn't limited to destroying of a single cache. Add
  flush_all_rcu_sheaves() to do that.

Reported-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |  1 +
 mm/slab_common.c |  4 ++-
 mm/slub.c        | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index f1866f2d9b21..e82e51c44bd0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -436,6 +436,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 }
 
 bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
+void flush_all_rcu_sheaves(void);
 
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2d806e025685..005a4319c06a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1973,7 +1973,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
-	if (kfree_rcu_sheaf(ptr))
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
 		return;
 
 	// Queue the object but don't yet schedule the batch.
@@ -2050,6 +2050,8 @@ void kvfree_rcu_barrier(void)
 	bool queued;
 	int i, cpu;
 
+	flush_all_rcu_sheaves();
+
 	/*
 	 * Firstly we detach objects and queue them over an RCU-batch
 	 * for all CPUs. Finally queued works are flushed for each CPU.
diff --git a/mm/slub.c b/mm/slub.c
index 9f9b7e1fa356..19cd8444ae5d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3895,6 +3895,80 @@ static void flush_all(struct kmem_cache *s)
 	cpus_read_unlock();
 }
 
+static void flush_rcu_sheaf(struct work_struct *w)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *rcu_free;
+	struct slub_flush_work *sfw;
+	struct kmem_cache *s;
+
+	sfw = container_of(w, struct slub_flush_work, work);
+	s = sfw->s;
+
+	local_lock(&s->cpu_sheaves->lock);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	rcu_free = pcs->rcu_free;
+	pcs->rcu_free = NULL;
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	if (rcu_free)
+		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+}
+
+
+/* needed for kvfree_rcu_barrier() */
+void flush_all_rcu_sheaves()
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slub_flush_work *sfw;
+	struct kmem_cache *s;
+	bool flushed = false;
+	unsigned int cpu;
+
+	cpus_read_lock();
+	mutex_lock(&slab_mutex);
+
+	list_for_each_entry(s, &slab_caches, list) {
+		if (!s->cpu_sheaves)
+			continue;
+
+		mutex_lock(&flush_lock);
+
+		for_each_online_cpu(cpu) {
+			sfw = &per_cpu(slub_flush, cpu);
+			pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+			if (!pcs->rcu_free || !pcs->rcu_free->size) {
+				sfw->skip = true;
+				continue;
+			}
+
+			INIT_WORK(&sfw->work, flush_rcu_sheaf);
+			sfw->skip = false;
+			sfw->s = s;
+			queue_work_on(cpu, flushwq, &sfw->work);
+			flushed = true;
+		}
+
+		for_each_online_cpu(cpu) {
+			sfw = &per_cpu(slub_flush, cpu);
+			if (sfw->skip)
+				continue;
+			flush_work(&sfw->work);
+		}
+
+		mutex_unlock(&flush_lock);
+	}
+
+	mutex_unlock(&slab_mutex);
+	cpus_read_unlock();
+
+	if (flushed)
+		rcu_barrier();
+}
+
 /*
  * Use the cpu notifier to insure that the cpu slabs are flushed when
  * necessary.
-- 
2.51.0


