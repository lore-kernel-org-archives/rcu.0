Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A0263F2F
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477462; cv=none; b=SiUOco9jHKRuYDb5kzLyaDh/bAtUDfeWsr1nQfuLergV2Ir1US/6S58qVH6oCeGlMtdd24UiDTywE4J1kYDOQE+YRBosB2FSbU8ykb+WuB1DSkEM82NFfRgfp7C87sgXSerJxKW2eBVkF+0t9yV0ZQ/iaTc/8u25XdPyLqXHg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477462; c=relaxed/simple;
	bh=JZSyL+rrCkUYWY5RA2jjMg5ye5zHgVlnc5NGsYPTQH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IN/tXI9A15Xm1Q2rHSQZG2iJamyXXcA2Tb3uWpK6uzb3Wgn361yVYEHdufRsiQGDXuLPP83nxxFhrf+UUYX11p16u5lCJW7AkAc5v75TVhRAA4EOKQsa3jx6BVsW0RO051xBMoCExy/MycsKS5j8v0/Ur4DzRoZwh1YiBXsk2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yUnW2gK3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YQq3rPAr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yUnW2gK3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YQq3rPAr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yUnW2gK3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YQq3rPAr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yUnW2gK3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YQq3rPAr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 856AF21171;
	Tue, 25 Feb 2025 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740477458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Um4Edc6A4+2zOBvDHaEzY8GwjZotkCtNM20WMP8p17U=;
	b=yUnW2gK3Y0/C99QaYPcj0x8PLNlbL7OcFWUjk1YIOWChWMNQ28Bw/yMHhrDFpoxS8U1r2R
	vzCl1Z5uzIEgaFTRg4mc+nm8ij9LotJM9lYpIneLERU0q3a6xo/DcJCIAoXp5mdJmfyspG
	h3QGvZZ0QLPnhF4RQruc/1XkZO9Ryds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740477458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Um4Edc6A4+2zOBvDHaEzY8GwjZotkCtNM20WMP8p17U=;
	b=YQq3rPArRuPUNI5lJx+kNjrzQFMmPWsweH3R7KKbaFih9Hgvd/AfhwsXFCDYccFu6a3u5d
	KFCIBl5eT5T/4gAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yUnW2gK3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YQq3rPAr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740477458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Um4Edc6A4+2zOBvDHaEzY8GwjZotkCtNM20WMP8p17U=;
	b=yUnW2gK3Y0/C99QaYPcj0x8PLNlbL7OcFWUjk1YIOWChWMNQ28Bw/yMHhrDFpoxS8U1r2R
	vzCl1Z5uzIEgaFTRg4mc+nm8ij9LotJM9lYpIneLERU0q3a6xo/DcJCIAoXp5mdJmfyspG
	h3QGvZZ0QLPnhF4RQruc/1XkZO9Ryds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740477458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Um4Edc6A4+2zOBvDHaEzY8GwjZotkCtNM20WMP8p17U=;
	b=YQq3rPArRuPUNI5lJx+kNjrzQFMmPWsweH3R7KKbaFih9Hgvd/AfhwsXFCDYccFu6a3u5d
	KFCIBl5eT5T/4gAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C88513888;
	Tue, 25 Feb 2025 09:57:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tq1cEhKUvWdnHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 25 Feb 2025 09:57:38 +0000
Message-ID: <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
Date: Tue, 25 Feb 2025 10:57:38 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>, Keith Busch <kbusch@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>,
 linux-nvme@lists.infradead.org, leitao@debian.org
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp> <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z7xbrnP8kTQKYO6T@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 856AF21171
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com,goodmis.org,efficios.com,inria.fr,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,googlegroups.com,lists.infradead.org,debian.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLctujmen6hjyrx8fu4drawbuj)];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/24/25 12:44, Uladzislau Rezki wrote:
> On Fri, Feb 21, 2025 at 06:28:49PM +0100, Vlastimil Babka wrote:
>> On 2/21/25 17:30, Keith Busch wrote:
>> > On Wed, Aug 07, 2024 at 12:31:19PM +0200, Vlastimil Babka wrote:
>> >> We would like to replace call_rcu() users with kfree_rcu() where the
>> >> existing callback is just a kmem_cache_free(). However this causes
>> >> issues when the cache can be destroyed (such as due to module unload).
>> >> 
>> >> Currently such modules should be issuing rcu_barrier() before
>> >> kmem_cache_destroy() to have their call_rcu() callbacks processed first.
>> >> This barrier is however not sufficient for kfree_rcu() in flight due
>> >> to the batching introduced by a35d16905efc ("rcu: Add basic support for
>> >> kfree_rcu() batching").
>> >> 
>> >> This is not a problem for kmalloc caches which are never destroyed, but
>> >> since removing SLOB, kfree_rcu() is allowed also for any other cache,
>> >> that might be destroyed.
>> >> 
>> >> In order not to complicate the API, put the responsibility for handling
>> >> outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the newly
>> >> introduced kvfree_rcu_barrier() to wait before destroying the cache.
>> >> This is similar to how we issue rcu_barrier() for SLAB_TYPESAFE_BY_RCU
>> >> caches, but has to be done earlier, as the latter only needs to wait for
>> >> the empty slab pages to finish freeing, and not objects from the slab.
>> >> 
>> >> Users of call_rcu() with arbitrary callbacks should still issue
>> >> rcu_barrier() before destroying the cache and unloading the module, as
>> >> kvfree_rcu_barrier() is not a superset of rcu_barrier() and the
>> >> callbacks may be invoking module code or performing other actions that
>> >> are necessary for a successful unload.
>> >> 
>> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> >> ---
>> >>  mm/slab_common.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >> 
>> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> >> index c40227d5fa07..1a2873293f5d 100644
>> >> --- a/mm/slab_common.c
>> >> +++ b/mm/slab_common.c
>> >> @@ -508,6 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
>> >>  	if (unlikely(!s) || !kasan_check_byte(s))
>> >>  		return;
>> >>  
>> >> +	/* in-flight kfree_rcu()'s may include objects from our cache */
>> >> +	kvfree_rcu_barrier();
>> >> +
>> >>  	cpus_read_lock();
>> >>  	mutex_lock(&slab_mutex);
>> > 
>> > This patch appears to be triggering a new warning in certain conditions
>> > when tearing down an nvme namespace's block device. Stack trace is at
>> > the end.
>> > 
>> > The warning indicates that this shouldn't be called from a
>> > WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
>> > and tearing down block devices, so this is a memory reclaim use AIUI.
>> > I'm a bit confused why we can't tear down a disk from within a memory
>> > reclaim workqueue. Is the recommended solution to simply remove the WQ
>> > flag when creating the workqueue?
>> 
>> I think it's reasonable to expect a memory reclaim related action would
>> destroy a kmem cache. Mateusz's suggestion would work around the issue, but
>> then we could get another surprising warning elsewhere. Also making the
>> kmem_cache destroys async can be tricky when a recreation happens
>> immediately under the same name (implications with sysfs/debugfs etc). We
>> managed to make the destroying synchronous as part of this series and it
>> would be great to keep it that way.
>> 
>> >   ------------[ cut here ]------------
>> >   workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
>> 
>> Maybe instead kfree_rcu_work should be using a WQ_MEM_RECLAIM workqueue? It
>> is after all freeing memory. Ulad, what do you think?
>> 
> We reclaim memory, therefore WQ_MEM_RECLAIM seems what we need.
> AFAIR, there is an extra rescue worker, which can really help
> under a low memory condition in a way that we do a progress.
> 
> Do we have a reproducer of mentioned splat?

I tried to create a kunit test for it, but it doesn't trigger anything. Maybe
it's too simple, or racy, and thus we are not flushing any of the queues from
kvfree_rcu_barrier()?

----8<----
From 1e19ea78e7fe254034970f75e3b7cb705be50163 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 25 Feb 2025 10:51:28 +0100
Subject: [PATCH] add test for kmem_cache_destroy in a workqueue

---
 lib/slub_kunit.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index f11691315c2f..5fe9775fba05 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 #include "../mm/slab.h"
 
 static struct kunit_resource resource;
@@ -181,6 +182,52 @@ static void test_kfree_rcu(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, slab_errors);
 }
 
+struct cache_destroy_work {
+        struct work_struct work;
+        struct kmem_cache *s;
+};
+
+static void cache_destroy_workfn(struct work_struct *w)
+{
+	struct cache_destroy_work *cdw;
+
+	cdw = container_of(w, struct cache_destroy_work, work);
+
+	kmem_cache_destroy(cdw->s);
+}
+
+static void test_kfree_rcu_wq_destroy(struct kunit *test)
+{
+	struct test_kfree_rcu_struct *p;
+	struct cache_destroy_work cdw;
+	struct workqueue_struct *wq;
+	struct kmem_cache *s;
+
+	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
+		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
+
+	INIT_WORK_ONSTACK(&cdw.work, cache_destroy_workfn);
+	wq = alloc_workqueue("test_kfree_rcu_destroy_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	if (!wq)
+		kunit_skip(test, "failed to alloc wq");
+
+	s = test_kmem_cache_create("TestSlub_kfree_rcu_wq_destroy",
+				   sizeof(struct test_kfree_rcu_struct),
+				   SLAB_NO_MERGE);
+	p = kmem_cache_alloc(s, GFP_KERNEL);
+
+	kfree_rcu(p, rcu);
+
+	cdw.s = s;
+	queue_work(wq, &cdw.work);
+	msleep(1000);
+	flush_work(&cdw.work);
+
+	destroy_workqueue(wq);
+
+	KUNIT_EXPECT_EQ(test, 0, slab_errors);
+}
+
 static void test_leak_destroy(struct kunit *test)
 {
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
@@ -254,6 +301,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_clobber_redzone_free),
 	KUNIT_CASE(test_kmalloc_redzone_access),
 	KUNIT_CASE(test_kfree_rcu),
+	KUNIT_CASE(test_kfree_rcu_wq_destroy),
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
 	{}
-- 
2.48.1


