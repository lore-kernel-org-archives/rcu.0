Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359223EA82
	for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766110012; cv=none; b=NmiqETgzlPmoMbLWu+5EAXt23W9qwlJ3zhE09LABfMWRSsSRhz4ljrVb3sUq44/3nSfZoBDhGSFJc9z769YlrUdn5XrPP/3Wjvm19dfUOymmTTBQthhzxgrvkbYmSA7cVangqIWkXkktRiDQcc2QjnFKDwbsO5Mdvc8JVHRPBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766110012; c=relaxed/simple;
	bh=is9YxCrTIYETTKLl2H7AGTPR3Ds83Cfd0CZETLRxHhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEpesMLCQgu6BiDhsE9xf180eJZMV7NcDl/EzdgfXvfRRF/gCIk6f1TFVXZ1iNvkp4jCqKdl2+DEjG76bb92Ja3WVJe7DqDVkyQ8HbGltVQxHuPhcw7oW66Lata2mPVTE/8CtZAEArGfl7D5DXypV0kLWe5DzS8Znu7bWtgoJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMbg3ZN4; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMbg3ZN4"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3ec5df386acso1005073fac.1
        for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 18:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766110008; x=1766714808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8X/mpvTeafKM3nH85dScPT9I6f8OgbfxSkwYBazOi0=;
        b=cMbg3ZN4iRUDoyRuCbxbBYUk/Q12IZomMsSoMhfthFw1vwsQdPN8sdL5PGrdpJCBi5
         QrPuPbbAATdV9dJaYWRiovNaEMymuBtduH27XeZRkQWezcym35nq552V5AOjGXZqhV1p
         /o2exAbW9kYS/M09/3j4khg519f2fwht4jASbUkYlgDXhjJwxOeWCCklXEcJBbhasv3e
         WVLkABYr2wrvn+WeO59N67C4Lp7gf33O8VOARodKpBH2M5Wcex0I9Hit+p8Rf/XgdsRy
         UVaTJMvYPkoKA6HfVS4xztGEuC8x+XZAxbH2ndRrMlST/cluSfwu7rc/KQtpJhqh5xVa
         P66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766110008; x=1766714808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l8X/mpvTeafKM3nH85dScPT9I6f8OgbfxSkwYBazOi0=;
        b=XjYSb8c/zsDbveDLKcRuzWqN1HN1l1bN50h2YwdPcnj6enTCQSb8xXL7/dp+ZRN0mi
         0ddUEmIZ7WsM4rh4vsnjN1DayRMaAKA5A9/hg2lozcnXqiTOFKiyGfq9OiGAJ2lOCO+U
         ufp5fWA+46rXanGyAPfzBvyvpfQDiOnm58ZcycCpw7eXjzVsmwxau/3eTf4LJYTzlXzC
         LBXjtn9Pyjqeaoh+EI1yt5QaReMVkc/ln50tOxjGBlMskX1brYyO1uXND4OWcDbRCeEP
         tulOIMtN+YIduDBVk+pDVZocR7zk5aE/uuzU8o8wNtG3FEn63/USauI8UXDIbCX6cCPZ
         ruLA==
X-Forwarded-Encrypted: i=1; AJvYcCWLzeynXgU/2cPhzVYas+YZLscsg/sA0A98vFpwfoWOzObReZ1MbBxghrZ/671ye7uhUpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxomyPCcNvC0PXfao7F69LkrrZwdf2zvU+jfwceaRaUeq+ilcQd
	HpEQE46/xOXf8iuJAtD+RTpP+zq6+nd2UVkspGydzFzztIk0egl0VEfIYfUTifj4XQE=
X-Gm-Gg: AY/fxX6ec55FCGTI8ejxbTbG0/Reu70M+jNCijcUUGIKb14/dOHYLMf+UsxPMtlV//V
	vOUJyNoKu9k/ItMKilLDjbRMgJRtQJZKgLWr5QSB8QiXPw/PiXwe8AarI5jlUdUVuQaknD4qFAV
	bMyPMHFl7uSQgwYFuA5Rj4yeATzaUuSFK5UPvHTr+/q0G0+JSQ8asFLCOdfB2rntsuMJ3QQcm1N
	itIXWJ3o3L88vIpJ6i2vrRUo0quuCTB686TRVtfBW/Da/3Byi6TISF/e9X4xZ73G5GNEdyBGcuU
	FS0chL28sp93MRnrwxtnIxeR/ijRUQT3FIdv6SJh9occZ8hL5c3kkL7FKLYHGQjn3a5MbsQ3U9u
	qjMK1v/iEz0nXUUEE5kfoojDxojPsn2VmTPnJ/yDriQNpmnb7QM3JGWm9SPPHu5xtZBdeehkKbb
	mtAJUPXtbhCkWsjcdOqdMSFB6sQGrzn4kFB/rz87ZiL+k2Z3kY8AQYAHZimopUJBql8rOFFqguG
	lD+KCFeh4BMnOQ=
X-Google-Smtp-Source: AGHT+IFPk9sbtY0UjBkjpQV6F8R4ziD5cSSxeHmFqbLe73zBnLmXKITpnuraJGxLeqMdGtMo3KFVAQ==
X-Received: by 2002:a05:620a:31a3:b0:8b2:271e:a560 with SMTP id af79cd13be357-8c08ff218ebmr212306185a.72.1766103947460;
        Thu, 18 Dec 2025 16:25:47 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09689153asm61478885a.17.2025.12.18.16.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:25:47 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25E38F4007E;
	Thu, 18 Dec 2025 19:25:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 19:25:46 -0500
X-ME-Sender: <xms:iptEacwmTiy5gQQDNHuqeFNw1UMehNPtLtPloS2FK4zw_T7IuP0pEQ>
    <xme:iptEadbipso_0Eka7yXzgAi6XJaz-jPcJN-iFI_ptZl04YyVa32BWqYUVfkO2a-kK
    yeiDB9dIixeZUAo6UnQfl7MFBX4daeiTxJROZxPbMCrsTMK_4ZdeQ>
X-ME-Received: <xmr:iptEaezAk4hsYhJKhx6Bo4jiyentomcKy0hFx6cJFcHUVAVZkAxuKKDtwos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnheptdetvdfgueetkedutdegudegfeekffevgeetleehvdektedvteeggfegtdevtdeh
    necuffhomhgrihhnpegvfhhfihgtihhoshdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
    ohepfeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghthhhivghurdguvg
    hsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehjohgvlhesjhho
    vghlfhgvrhhnrghnuggvshdrohhrghdprhgtphhtthhopehprghulhhmtghksehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepghhrvghg
    khhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghighgvrg
    hshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopeifihhllheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:iptEabitpgOdV036twsKZU0Fycl6cCkXbK3vjIo9wd515Tt2oE3SAA>
    <xmx:iptEaVoCS1HUuq-KUwu_2zsbMjT78TRhDzSL8FhFhZFtj5MppTtBuA>
    <xmx:iptEaSduPQd_Dp2na-hNNi9IVyVg2TOBkNp-qUAeD-G8wjy8CxuDfA>
    <xmx:iptEaQe9OnalWj9VorkrxBoBwI_xfWdXjz_dytDxw6x-9WH21ksy5A>
    <xmx:iptEaQd-Mnv1xhGkxUloFwEZrVKuaPvqUfZB7mcrRZgFvzSolvJbzRgh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 19:25:45 -0500 (EST)
Date: Fri, 19 Dec 2025 09:25:42 +0900
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,	linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,	rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
Message-ID: <aUSbhiMgluudbVEG@tardis-2.local>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
 <aUO9KRaP0FXpm_l9@tardis-2.local>
 <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>
 <aURihbmjsKi8m7MO@tardis-2.local>
 <42607ed5-f543-41bd-94da-aa0ee7ec71cd@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42607ed5-f543-41bd-94da-aa0ee7ec71cd@efficios.com>

On Thu, Dec 18, 2025 at 06:36:00PM -0500, Mathieu Desnoyers wrote:
> On 2025-12-18 15:22, Boqun Feng wrote:
> [...]
> > > > Could you utilize this[1] to see a
> > > > comparison of the reader-side performance against RCU/SRCU?
> > > 
> > > Good point ! Let's see.
> > > 
> > > On a AMD 2x EPYC 9654 96-Core Processor with 192 cores,
> > > hyperthreading disabled,
> > > CONFIG_PREEMPT=y,
> > > CONFIG_PREEMPT_RCU=y,
> > > CONFIG_PREEMPT_HAZPTR=y.
> > > 
> > > scale_type                 ns
> > > -----------------------
> > > hazptr-smp-mb             13.1   <- this implementation
> > > hazptr-barrier            11.5   <- replace smp_mb() on acquire with barrier(), requires IPIs on synchronize.
> > > hazptr-smp-mb-hlist       12.7   <- replace per-task hp context and per-cpu overflow lists by hlist.
> > > rcu                       17.0
> > > srcu                      20.0
> > > srcu-fast                  1.5
> > > rcu-tasks                  0.0
> > > rcu-trace                  1.7
> > > refcnt                  1148.0
> > > rwlock                  1190.0
> > > rwsem                   4199.3
> > > lock                   41070.6
> > > lock-irq               46176.3
> > > acqrel                     1.1
> > > 
> > > So only srcu-fast, rcu-tasks, rcu-trace and a plain acqrel
> > > appear to beat hazptr read-side performance.
> > > 
> > 
> > Could you also see the reader-side performance impact when the percpu
> > hazard pointer slots are used up? I.e. the worst case.
> 
> I've modified the code to populate "(void *)1UL" in the 7 first slots
> at bootup, here is the result:
> 
> hazptr-smp-mb-7-fail    16.3 ns
> 
> So we go from 13.1 ns to 16.3 ns when all but one slots are used.
> 
> And if we pre-populate the 8 slots for each cpu, and thus force
> fallback to overflow list:
> 
> hazptr-smp-mb-8-fail    67.1 ns
> 

Thank you! So involving locking seems to hurt performance more than
per-CPU/per-task operations. This may suggest that enabling
PREEMPT_HAZPTR by default has an acceptable performance.

> > 
> > > [...]
> > > 
> > > > > +/*
> > > > > + * Perform piecewise iteration on overflow list waiting until "addr" is
> > > > > + * not present. Raw spinlock is released and taken between each list
> > > > > + * item and busy loop iteration. The overflow list generation is checked
> > > > > + * each time the lock is taken to validate that the list has not changed
> > > > > + * before resuming iteration or busy wait. If the generation has
> > > > > + * changed, retry the entire list traversal.
> > > > > + */
> > > > > +static
> > > > > +void hazptr_synchronize_overflow_list(struct overflow_list *overflow_list, void *addr)
> > > > > +{
> > > > > +	struct hazptr_backup_slot *backup_slot;
> > > > > +	uint64_t snapshot_gen;
> > > > > +
> > > > > +	raw_spin_lock(&overflow_list->lock);
> > > > > +retry:
> > > > > +	snapshot_gen = overflow_list->gen;
> > > > > +	list_for_each_entry(backup_slot, &overflow_list->head, node) {
> > > > > +		/* Busy-wait if node is found. */
> > > > > +		while (smp_load_acquire(&backup_slot->slot.addr) == addr) { /* Load B */
> > > > > +			raw_spin_unlock(&overflow_list->lock);
> > > > > +			cpu_relax();
> > > > 
> > > > I think we should prioritize the scan thread solution [2] instead of
> > > > busy waiting hazrd pointer updaters, because when we have multiple
> > > > hazard pointer usages we would want to consolidate the scans from
> > > > updater side.
> > > 
> > > I agree that batching scans with a worker thread is a logical next step.
> > > 
> > > > If so, the whole ->gen can be avoided.
> > > 
> > > How would it allow removing the generation trick without causing long
> > > raw spinlock latencies ?
> > > 
> > 
> > Because we won't need to busy-wait for the readers to go away, we can
> > check whether they are still there in the next scan.
> > 
> > so:
> > 
> > 	list_for_each_entry(backup_slot, &overflow_list->head, node) {
> > 		/* Busy-wait if node is found. */
> > 		if (smp_load_acquire(&backup_slot->slot.addr) == addr) { /* Load B */
> > 			<mark addr as unable to free and move on>
> 
> But then you still iterate on a possibly large list of overflow nodes,
> with a raw spinlock held. That raw spinlock is taken by the scheduler
> on context switch. This can cause very long scheduler latency.
> 

That's fair.

> So breaking up the iteration into pieces is not just to handle
> busy-waiting, but also to make sure we don't increase the
> system latency by holding a raw spinlock (taken with rq lock
> held) for more than the little time needed to iterate to the next
> node.
> 

I agree that it helps reduce the latency, but I feel like with a scan
thread in the picture (and we don't need to busy-wait), we should use
a forward-progress-guaranteed way in the updater side scan, which means
we may need to explore other solutions for the latency (e.g.
fine-grained locking hashlist for the overflow list) than the generation
counter.

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
