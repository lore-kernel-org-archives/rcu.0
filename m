Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3226BD8A
	for <rcu@vger.kernel.org>; Wed, 26 Feb 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567494; cv=none; b=L+A5Htk4sLlTavG74JARLVipp8FlVlKBx+L7XUNUO2kkz/4p76kecQL2qMyz1X/+XaCwjMVuIQHlFzsgZEz3d35nlq527SHoF6k6Yzj0MtBiO6zEFe7M97QjHmDzVoh9Miz0o+ra/Z+zE9za1EGlC0n86frnuxJge1QGBI4oGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567494; c=relaxed/simple;
	bh=FYTq0J18TlOij80ZguLWv+5Ha4QBIlOo/uEcM3VQfKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL1s8Cr8+d4hrgMY9SpnheE9ZTTBC1RGzPozE+lUGp+jQx1ZiJbqq03+VgGpjQXcCgGMOPxApanb4th6ssMwQp5itYQswA6rRHoF9uKZW3DveKlDsXBtFfZJpN5au+3u7BThjuAHicqwGivN798O/c9nmHAyZ6yq/H/JXokX8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zqQI5+yM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=40ObUHLU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zqQI5+yM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=40ObUHLU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zqQI5+yM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="40ObUHLU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zqQI5+yM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="40ObUHLU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68A6221184;
	Wed, 26 Feb 2025 10:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740567490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvQMaogfR4p5vXml1R1gl73Lc4GXJegwVY6rJmvbNrQ=;
	b=zqQI5+yMO6yV3jxwiKP42S0fE0YF0JhLpTM+nLG6l1933VXSW+zLE2lfLXoRZfvJxeWuu4
	G3y8qKDjpgk2MiX8YP7+xy354Y+FKgQb5ewbL9NoYSjlf+35YjyS3AqA1PujhidnbV4mRU
	mi4dVNgoXqxqzP9CbBcvFCHyd+BqRLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740567490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvQMaogfR4p5vXml1R1gl73Lc4GXJegwVY6rJmvbNrQ=;
	b=40ObUHLUWyTtsyo7VM6q8v3Scind4/Ubjn28AvhTB1BWxzficxhr/BOj1Ak9F9rSwSj6UN
	+Dtsqe0OY/rifSBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zqQI5+yM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=40ObUHLU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740567490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvQMaogfR4p5vXml1R1gl73Lc4GXJegwVY6rJmvbNrQ=;
	b=zqQI5+yMO6yV3jxwiKP42S0fE0YF0JhLpTM+nLG6l1933VXSW+zLE2lfLXoRZfvJxeWuu4
	G3y8qKDjpgk2MiX8YP7+xy354Y+FKgQb5ewbL9NoYSjlf+35YjyS3AqA1PujhidnbV4mRU
	mi4dVNgoXqxqzP9CbBcvFCHyd+BqRLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740567490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvQMaogfR4p5vXml1R1gl73Lc4GXJegwVY6rJmvbNrQ=;
	b=40ObUHLUWyTtsyo7VM6q8v3Scind4/Ubjn28AvhTB1BWxzficxhr/BOj1Ak9F9rSwSj6UN
	+Dtsqe0OY/rifSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DA491377F;
	Wed, 26 Feb 2025 10:58:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HQrvDcLzvmdaeQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Feb 2025 10:58:10 +0000
Message-ID: <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>
Date: Wed, 26 Feb 2025 11:59:53 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
To: Uladzislau Rezki <urezki@gmail.com>, Keith Busch <keith.busch@gmail.com>
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
 <Z7xbrnP8kTQKYO6T@pc636> <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636> <Z74KHyGGMzkhx5f-@pc636>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <Z74KHyGGMzkhx5f-@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 68A6221184
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com,goodmis.org,efficios.com,inria.fr,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,googlegroups.com,lists.infradead.org,debian.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLctujmen6hjyrx8fu4drawbuj)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
>>
> WQ_MEM_RECLAIM-patch fixes this for me:

Sounds good, can you send a formal patch then?
Some nits below:

> <snip>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4030907b6b7d..1b5ed5512782 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
>  static int rcu_delay_page_cache_fill_msec = 5000;
>  module_param(rcu_delay_page_cache_fill_msec, int, 0444);
> 
> +static struct workqueue_struct *rcu_reclaim_wq;
> +
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (5 * HZ)
>  #define KFREE_N_BATCHES 2
> @@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>         if (delayed_work_pending(&krcp->monitor_work)) {
>                 delay_left = krcp->monitor_work.timer.expires - jiffies;
>                 if (delay < delay_left)
> -                       mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +                       mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>                 return;
>         }
> -       queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +       queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>  }
> 
>  static void
> @@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>                         // "free channels", the batch can handle. Break
>                         // the loop since it is done with this CPU thus
>                         // queuing an RCU work is _always_ success here.
> -                       queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> +                       queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
>                         WARN_ON_ONCE(!queued);
>                         break;
>                 }
> @@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>                         !atomic_xchg(&krcp->work_in_progress, 1)) {
>                 if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -                       queue_delayed_work(system_unbound_wq,
> +                       queue_delayed_work(rcu_reclaim_wq,
>                                 &krcp->page_cache_work,
>                                         msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>                 } else {
> @@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
>         int i, j;
>         struct shrinker *kfree_rcu_shrinker;
> 
> +       rcu_reclaim_wq = alloc_workqueue("rcu_reclaim",

Should we name it "kvfree_rcu_reclaim"? rcu_reclaim sounds too generic
as if it's part of rcu itself?

> +               WQ_UNBOUND | WQ_MEM_RECLAIM, 0);

Do we want WQ_SYSFS? Or maybe only when someone asks, with a use case?

Thanks,
Vlastimil

> +       WARN_ON(!rcu_reclaim_wq);
> +
>         /* Clamp it to [0:100] seconds interval. */
>         if (rcu_delay_page_cache_fill_msec < 0 ||
>                 rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
> <snip>
> 
> it passes:
> 
> <snip>
> [   15.972416] KTAP version 1
> [   15.972421] 1..1
> [   15.973467]     KTAP version 1
> [   15.973470]     # Subtest: slub_test
> [   15.973472]     # module: slub_kunit
> [   15.973474]     1..10
> [   15.974483]     ok 1 test_clobber_zone
> [   15.974927]     ok 2 test_next_pointer
> [   15.975308]     ok 3 test_first_word
> [   15.975672]     ok 4 test_clobber_50th_byte
> [   15.976035]     ok 5 test_clobber_redzone_free
> [   15.976128] stackdepot: allocating hash table of 1048576 entries via kvcalloc
> [   15.979505]     ok 6 test_kmalloc_redzone_access
> [   16.014408]     ok 7 test_kfree_rcu
> [   17.726602]     ok 8 test_kfree_rcu_wq_destroy
> [   17.750323]     ok 9 test_leak_destroy
> [   17.750883]     ok 10 test_krealloc_redzone_zeroing
> [   17.750887] # slub_test: pass:10 fail:0 skip:0 total:10
> [   17.750890] # Totals: pass:10 fail:0 skip:0 total:10
> [   17.750891] ok 1 slub_test
> <snip>
> 
> --
> Uladzislau Rezki

