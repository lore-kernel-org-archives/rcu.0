Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9FE26A0FF
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492763; cv=none; b=BMUeaPqxxV8ctnti5aCdYY4vD2fuKOXseEFH9IaqiAKbS5rlRxi5Na9nGK0zJGdozcRtcmjfO9qym8CxBnHMrKnH3zk1b3TObJtg182AOUlSKFdlXMKYsGsPStl43uBDAMPa3rFg77J/WbMaryVe5Gc3wa6vMEH0Iha9mtiUBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492763; c=relaxed/simple;
	bh=hKH7CBCLD/34khaxDa5uTeR1nWX+L0rKmyCKLq6MsHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWzvlciMvU4Xi09nLVJTahw/Munh7IEXronR2i3O7FXPur1//e/JgqoZt6H73NCZP9b/TiCXOBtlmV5FN7tVgzFdYOE79a8oEqvNfTz6tWEWnfLDxbcVjcqOXFDZvk/ycy2qiAxpGOTfcyZORbMtooi/Cr0wyV2T0Bx94Lb0HOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lD8cUpUq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2DXEI07Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lD8cUpUq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2DXEI07Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lD8cUpUq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2DXEI07Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lD8cUpUq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2DXEI07Q"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CF861F45B;
	Tue, 25 Feb 2025 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740492760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJT945ZAVtCY93qXD8XatLgSRkcHkm4XIW7jbJlYEAA=;
	b=lD8cUpUqWqrQOv6vv/k1sbw+Okiy/Y/YwCLl0UZkiqQ91VyQYesKxg78GC+j38xxH52VtP
	Sw7lXKed1Y6nO2XsI3NN2wAMkItrNgxEfaG4i+BPECQI7XxZuzerrVGsVsPhWrQP+TqCLi
	mSXIBJOw8Mj29WdpW2erKPLPBLOznM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740492760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJT945ZAVtCY93qXD8XatLgSRkcHkm4XIW7jbJlYEAA=;
	b=2DXEI07Qfsu+ooyLuidw4LI94rCkZVV1BwqWo6JPhFsL+tQ09to3CVYUD6vrvarRuzzA9O
	S0JsCEajFogVAABg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lD8cUpUq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2DXEI07Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740492760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJT945ZAVtCY93qXD8XatLgSRkcHkm4XIW7jbJlYEAA=;
	b=lD8cUpUqWqrQOv6vv/k1sbw+Okiy/Y/YwCLl0UZkiqQ91VyQYesKxg78GC+j38xxH52VtP
	Sw7lXKed1Y6nO2XsI3NN2wAMkItrNgxEfaG4i+BPECQI7XxZuzerrVGsVsPhWrQP+TqCLi
	mSXIBJOw8Mj29WdpW2erKPLPBLOznM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740492760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJT945ZAVtCY93qXD8XatLgSRkcHkm4XIW7jbJlYEAA=;
	b=2DXEI07Qfsu+ooyLuidw4LI94rCkZVV1BwqWo6JPhFsL+tQ09to3CVYUD6vrvarRuzzA9O
	S0JsCEajFogVAABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4F2B13888;
	Tue, 25 Feb 2025 14:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OhamL9fPvWc8BAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 25 Feb 2025 14:12:39 +0000
Message-ID: <32b9d3c0-e22a-4960-a5da-a3f21c990a3a@suse.cz>
Date: Tue, 25 Feb 2025 15:12:39 +0100
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
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
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
 <Z7xbrnP8kTQKYO6T@pc636> <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73IBMdk5fnmYnN1@pc636>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z73IBMdk5fnmYnN1@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CF861F45B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com,goodmis.org,efficios.com,inria.fr,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,googlegroups.com,lists.infradead.org,debian.org];
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
	R_RATELIMIT(0.00)[to_ip_from(RLctujmen6hjyrx8fu4drawbuj)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/25/25 14:39, Uladzislau Rezki wrote:
> On Tue, Feb 25, 2025 at 10:57:38AM +0100, Vlastimil Babka wrote:
>> On 2/24/25 12:44, Uladzislau Rezki wrote:
>> > On Fri, Feb 21, 2025 at 06:28:49PM +0100, Vlastimil Babka wrote:
>> >> On 2/21/25 17:30, Keith Busch wrote:
>> >> >   ------------[ cut here ]------------
>> >> >   workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
>> >> 
>> >> Maybe instead kfree_rcu_work should be using a WQ_MEM_RECLAIM workqueue? It
>> >> is after all freeing memory. Ulad, what do you think?
>> >> 
>> > We reclaim memory, therefore WQ_MEM_RECLAIM seems what we need.
>> > AFAIR, there is an extra rescue worker, which can really help
>> > under a low memory condition in a way that we do a progress.
>> > 
>> > Do we have a reproducer of mentioned splat?
>> 
>> I tried to create a kunit test for it, but it doesn't trigger anything. Maybe
>> it's too simple, or racy, and thus we are not flushing any of the queues from
>> kvfree_rcu_barrier()?
>> 
> See some comments below. I will try to reproduce it today. But from the
> first glance it should trigger it.
> 
>> ----8<----
>> From 1e19ea78e7fe254034970f75e3b7cb705be50163 Mon Sep 17 00:00:00 2001
>> From: Vlastimil Babka <vbabka@suse.cz>
>> Date: Tue, 25 Feb 2025 10:51:28 +0100
>> Subject: [PATCH] add test for kmem_cache_destroy in a workqueue
>> 
>> ---
>>  lib/slub_kunit.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>> 
>> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
>> index f11691315c2f..5fe9775fba05 100644
>> --- a/lib/slub_kunit.c
>> +++ b/lib/slub_kunit.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/module.h>
>>  #include <linux/kernel.h>
>>  #include <linux/rcupdate.h>
>> +#include <linux/delay.h>
>>  #include "../mm/slab.h"
>>  
>>  static struct kunit_resource resource;
>> @@ -181,6 +182,52 @@ static void test_kfree_rcu(struct kunit *test)
>>  	KUNIT_EXPECT_EQ(test, 0, slab_errors);
>>  }
>>  
>> +struct cache_destroy_work {
>> +        struct work_struct work;
>> +        struct kmem_cache *s;
>> +};
>> +
>> +static void cache_destroy_workfn(struct work_struct *w)
>> +{
>> +	struct cache_destroy_work *cdw;
>> +
>> +	cdw = container_of(w, struct cache_destroy_work, work);
>> +
>> +	kmem_cache_destroy(cdw->s);
>> +}
>> +
>> +static void test_kfree_rcu_wq_destroy(struct kunit *test)
>> +{
>> +	struct test_kfree_rcu_struct *p;
>> +	struct cache_destroy_work cdw;
>> +	struct workqueue_struct *wq;
>> +	struct kmem_cache *s;
>> +
>> +	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
>> +		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
>> +
>> +	INIT_WORK_ONSTACK(&cdw.work, cache_destroy_workfn);
>> +	wq = alloc_workqueue("test_kfree_rcu_destroy_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
>>
> Maybe it is worth to add WQ_HIGHPRI also to be ahead?

I looked at what nvme_wq uses:

unsigned int wq_flags = WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS;

HIGHPRI wasn't there, and sysfs didn't seem important.


>> +	if (!wq)
>> +		kunit_skip(test, "failed to alloc wq");
>> +
>> +	s = test_kmem_cache_create("TestSlub_kfree_rcu_wq_destroy",
>> +				   sizeof(struct test_kfree_rcu_struct),
>> +				   SLAB_NO_MERGE);
>> +	p = kmem_cache_alloc(s, GFP_KERNEL);
>> +
>> +	kfree_rcu(p, rcu);
>> +
>> +	cdw.s = s;
>> +	queue_work(wq, &cdw.work);
>> +	msleep(1000);
> I am not sure it is needed. From the other hand it does nothing if
> i do not miss anything.

I've tried to add that in case it makes any difference (letting the
processing be done on its own instead of flushing immediately), but the
results was the same either way, no warning. AFAICS it also doesn't depend
on some debug CONFIG_ I could be missing, but maybe I'm wrong.

Hope you have more success :) Thanks.

>> +	flush_work(&cdw.work);
>> +
>> +	destroy_workqueue(wq);
>> +
>> +	KUNIT_EXPECT_EQ(test, 0, slab_errors);
>> +}
>> +
>>  static void test_leak_destroy(struct kunit *test)
>>  {
>>  	struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
>> @@ -254,6 +301,7 @@ static struct kunit_case test_cases[] = {
>>  	KUNIT_CASE(test_clobber_redzone_free),
>>  	KUNIT_CASE(test_kmalloc_redzone_access),
>>  	KUNIT_CASE(test_kfree_rcu),
>> +	KUNIT_CASE(test_kfree_rcu_wq_destroy),
>>  	KUNIT_CASE(test_leak_destroy),
>>  	KUNIT_CASE(test_krealloc_redzone_zeroing),
>>  	{}
>> -- 
>> 2.48.1
>> 
>> 
> 
> --
> Uladzislau Rezki

