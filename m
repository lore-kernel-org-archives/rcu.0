Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92F39A4A4;
	Fri, 24 Jul 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902269; cv=none; b=PNRQFs6hfTuVHSITtwRIQUd2r8+DxINa9xXLH/KRjZ3ys1YksAWHCb4EKnm/RBq9KUmNkkBjkOmAM095lx/kE45fNBta9H6ekQ46Igo9nD6adcm7VnIuWeiRS1goJKOvZFiKVCHdqsDKdhiLKcBEIY5VLmunIAComk26KGHYgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902269; c=relaxed/simple;
	bh=XOaLbpqbkvkvf58Svza2s93jDWznKiKjptvg/9j1Qhs=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=KKJWcEYUaqnjxZXfdghh5m5StJiOaKzfFTt0E30zZOsBaRf7Dsrl/PGPTqN+xhocl1v86NaLK1vAXp/mDrpXyjgyFzyrG/SjIa717CHtfbPLd5gOWePQRmj+mKhCwD3gcgn3fZFS2gPv/pK4VORb00+ReI/ZZwWsZZcaf9QuW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h68zN50w9z57DCg;
	Fri, 24 Jul 2026 22:10:56 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 66OEAgtq042932;
	Fri, 24 Jul 2026 22:10:42 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 24 Jul 2026 22:10:45 +0800 (CST)
X-Zmail-TransId: 2af96a637265cff-29079
X-Mailer: Zmail v1.0
Message-ID: <20260724221045574FnnXVxYyUtRhSz3-sGtLr@zte.com.cn>
In-Reply-To: <07adab0f-12cc-4f48-bf23-4aaef67ab405@kernel.org>
References: 20260723182727858gUQJ4TgRU2b6v1kdgpkfV@zte.com.cn,07adab0f-12cc-4f48-bf23-4aaef67ab405@kernel.org
Date: Fri, 24 Jul 2026 22:10:45 +0800 (CST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <harry@kernel.org>
Cc: <vbabka@kernel.org>, <akpm@linux-foundation.org>, <hao.li@linux.dev>,
        <cl@gentwo.org>, <rientjes@google.com>, <roman.gushchin@linux.dev>,
        <ast@kernel.org>, <andrii@kernel.org>, <puranjay@kernel.org>,
        <ameryhung@gmail.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
        <rostedt@goodmis.org>, <paulmck@kernel.org>, <frederic@kernel.org>,
        <neeraj.upadhyay@kernel.org>, <joelagnelf@nvidia.com>,
        <josh@joshtriplett.org>, <boqun@kernel.org>, <urezki@gmail.com>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <qiang.zhang@linux.dev>, <pfalcato@suse.de>, <surenb@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBzbGFiL2Zvci1uZXh0IHY0IDQvOF0gbW0vc2xhYjogZXh0ZW5kIGRlZmVycmVkIGZyZWUgbWVjaGFuaXNtIHRvIGhhbmRsZSByY3Ugc2hlYXZlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66OEAgtq042932
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 24 Jul 2026 22:10:56 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A637270.000/4h68zN50w9z57DCg

Harry wrote:
> On 7/23/26 7:27 PM, hu.shengming@zte.com.cn wrote:
> > Harry wrote:
> >> __kfree_rcu_sheaf() cannot invoke call_rcu() when spinning is not
> >> allowed and IRQs are disabled. To relax the limitation, extend the
> >> deferred free fallback so that a full rcu sheaf can be submitted to
> >> call_rcu() via the existing IRQ work.
> >>
> >> Since the deferred mechanism does more than deferred freeing of objects,
> >> rename the struct to deferred_percpu_work and adjust names accordingly.
> >>
> >> When a sheaf is queued on an IRQ work, it is detached from
> >> pcs->rcu_free but call_rcu() is not invoked until the irq_work runs.
> >> To keep the kvfree_rcu barrier's promise, call irq_work_sync() on each
> >> CPU before calling rcu_barrier().
> >>
> >> In the meantime, remove the TODO item as apparently there is no simple
> >> and effective way to achieve that. This is because, unlike sheaves,
> >> kfree_rcu() batches objects from different caches together.
> >>
> >> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> >> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> >> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> >> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> >> ---
> >>  mm/slab.h        |  2 +-
> >>  mm/slab_common.c |  7 ++---
> >>  mm/slub.c        | 85 +++++++++++++++++++++++++++++++++-----------------------
> >>  3 files changed, 53 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index e07b4e6d6679..9c9ae1384f47 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -551,7 +551,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >>      }
> >>  
> >>      /* Wait for deferred work from kmalloc/kfree_nolock() */
> >> -    defer_free_barrier();
> >> +    deferred_work_barrier();
> >>  
> >>      cpus_read_lock();
> >>      mutex_lock(&slab_mutex);
> > 
> > Hi Harry,
> 
> Hi Shengming,
> 
> > I noticed that your fix in [1] serializes defer_free_barrier() to
> > avoid concurrent irq_work_sync() waiters.
> 
> Right.
> 
> > However, this patch still calls the renamed deferred_work_barrier()
> > outside that serialization scope, including the new call sites in
> > kvfree_rcu_barrier_on_cache() and flush_all_rcu_sheaves().
> 
> Good point!
> 
> I didn't _fix_ that as part of this patch since that would be confusing
> and the fix didn't land the mainline or slab yet.

Thanks for the clarification!

> > Is this series expected to depend on [1], with these call sites
> > moved under the same serialization? Or am I missing something?
> 
> I was thinking of rebasing the fixes as there won't be much conflicts,
> nobody except for sashiko complained about this, and we're not going to
> backport them anyway.

Rebasing the fixes sounds good to me.

--
With Best Regards,
Shengming
