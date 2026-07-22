Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37D3F9A10;
	Wed, 22 Jul 2026 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709163; cv=none; b=E8Du9AT4UckDI822/kdxulxIOA3QaS57+VF1n0XqOoXH3DHtMfORTP8IWXfou5VzaDEbiudIrCx4lUJTbMUWN3cxEMa5FOYjCtx12kV79gbO09yy/1LMZ/PbR5dlP0q/0jU6GJYbe5Z5FhALZJZ3Wn+B+Jpt7RS1PllHj33bC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709163; c=relaxed/simple;
	bh=QdFR6f52WU7kcE0NqQgKLhBmV5FepprBUdAKqo1Hhqk=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=cT2i4LHtBuvQM7kkvTT8NBBd4U2Lusf5MHVxi2dQWRttw74vSVZzb6OpQRBStOmuO5/SI18g6xqo9zct6zj2wRwRO2QJJ4B+Bv034peiABjw4JAz5jKEUPwvkcGtZGemYK7d5jV1Hx9/5a69sGo6p4iwCorAY6+f1fKk+o9LQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4h4nYp2q18z55y2H;
	Wed, 22 Jul 2026 16:32:30 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 66M8WOxP048119;
	Wed, 22 Jul 2026 16:32:24 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 22 Jul 2026 16:32:26 +0800 (CST)
X-Zmail-TransId: 2afc6a60801acda-ec081
X-Mailer: Zmail v1.0
Message-ID: <202607221632263010RKz3KaXP9NUQ9kGPYnU_@zte.com.cn>
In-Reply-To: <004d1215-a1da-448e-bf10-df637c7029f5@kernel.org>
References: 20260722112748588_IEr10bQdigv8c8bjw7Ck@zte.com.cn,004d1215-a1da-448e-bf10-df637c7029f5@kernel.org
Date: Wed, 22 Jul 2026 16:32:26 +0800 (CST)
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
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBzbGFiL2Zvci1uZXh0IHY0IDEvOF0gbW0vc2xhYiwgc2x1Yl9rdW5pdDogcmVnaXN0ZXIga3Byb2JlIHRvIHRyaWdnZXIgX25vbG9jayBBUElz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66M8WOxP048119
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 22 Jul 2026 16:32:30 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A60801E.001/4h4nYp2q18z55y2H

Harry wrote:
> On 7/22/26 12:27 PM, hu.shengming@zte.com.cn wrote:
> > Harry wrote:
> >> Since kmalloc_nolock() always fails in NMI and hardirq contexts on
> >> PREEMPT_RT, slub_kunit cannot properly test _nolock() APIs.
> >>
> >> Register a kprobe pre-handler to invoke kmalloc_nolock() and
> >> kfree_nolock() in the middle of the slab allocator. However, do not
> >> register the handler on UP kernels because that use case is not
> >> well supported [1] in the kernel.
> >>
> >> To attach the pre-handler while s->cpu_sheaves->lock or n->list_lock
> >> is held, add a wrapper function for lockdep_assert_held() that calls
> >> a no-op function slab_attach_kprobe_locked() on debug builds. The
> >> function is optimized away when neither CONFIG_PROVE_LOCKING nor
> >> CONFIG_DEBUG_VM is selected and register_kprobe() fails.
> >>
> >> The function calls barrier() to prevent the compiler from optimizing
> >> away its callsites. Otherwise, the compiler may consider the function
> >> does not have any side effect and remove callsites.
> >>
> >> Compared to using plain kprobe, this has two advantages: 1) it avoids
> >> hardcoding function names in the test, and 2) it can trigger those APIs
> >> in the middle of a function, where the lock is expected to be held as
> >> annotated with lockdep.
> >>
> >> While it was proposed [2] to use kunit function redirection to test
> >> this, it is currently infeasible as some lock helpers don't have
> >> symbols.
> >>
> >> Factor out the nested loop that calls kmalloc and friends to
> >> test_kmalloc_kfree(), and call them in
> >> test_kmalloc_kfree_nolock_{perf,kprobe}(), each being an independent
> >> test case. During the refactoring, drop alloc_fail handling as it
> >> doesn't provide much benefits.
> > 
> > Nice test addition!
> > 
> > Reviewed-by: Shengming Hu <hu.shengming@zte.com.cn>
> 
> Thanks a lot for reviewing, Shengming!
> 
> Just FYI, I'm going to adjust a nit pointed out by sashiko
> that kmalloc_obj(*objects[j], gfp) is wrong because objects is an array
> of void pointers. (which is fixed later in the series)

Indeed, Nice catch by sashiko. :)

> > Nit below:
> >> +static void test_kmalloc_kfree_nolock_perf(struct kunit *test)
> >> +{
> >> +    struct test_nolock_context ctx = { .test = test };
> >>  
> >> -    kunit_info(test, "callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
> >> -           ctx.callback_count, ctx.alloc_ok, ctx.alloc_fail);
> >> +    if (!enable_perf_events(&ctx))
> >> +        kunit_skip(test, "Failed to enable perf event, skipping");
> >>  
> >> -    if (alloc_fail)
> >> -        kunit_skip(test, "Allocation failed");
> >> +    test_kmalloc_kfree();
> >> +
> >> +    disable_perf_events(&ctx);
> >> +    KUNIT_EXPECT_EQ(test, 0, slab_errors);
> >> +}
> >> +#endif
> >> +
> > 
> > Maybe it would be worth checking that the perf event actually fired:
> > 
> >     KUNIT_EXPECT_GT(test, ctx.callback_count, 0);
> > 
> > Otherwise, the test could pass without the callback.
> 
> I'm not sure if that would be useful though.
> 
> Ideally we want to make sure every code path that handles
> allow_spin = false is tested, but it's tricky to measure that and
> also it's tricky to make sure those paths are properly tested
> (especially with perf events).
> 
> callback_count is not a good indicator to measure test coverage.
> 
> (I use GCOV to make sure we have reasonable coverage,
>  but it's hard to turn that into a test case...)

Thanks for the explanation.

I was considering it only as a basic sanity check, but agreed that
callback_count does not reflect the actual path coverage. I'm fine
with leaving it as is.

--
With Best Regards,
Shengming
