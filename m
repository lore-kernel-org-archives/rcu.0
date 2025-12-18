Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18912D0618
	for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096593; cv=none; b=aHqN2c4rHk4utxmFmcroc2EtpOobG2M7FV12vUDPJyQ5bvWRxP+pFAYNLC+65iBr9XAH8T+qQES63t7q8JPKdU6bIv26jBrE/aK6Z9mGnxo18KL7iXnOedUFcek46fXh1q5e2cwaBZzPNVMcUW39NfKKzR004SuhgtR5Jrv9n9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096593; c=relaxed/simple;
	bh=/eLfiFUuH9yvahCPVcjPkezg5kYE43CsIOzLJ1Q0GsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP9Wj9/LaYGW2cMjT7FbdFLzLfOUhls/QxAKZf0wVD3KBTnBIN7a5dNtLl9yGgadsXzQrDPNm+GohjWMtA9sMgmL20mERLxo0xB8iFGhNnxsZybAuQCce8c0I0GerdYz7CekIGJUy0+5wkZxDTk7lNNnoiXCV0seQYqYBoes20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2y2tSJ8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2y2tSJ8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f30233d8aso15463635ad.0
        for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 14:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766096591; x=1766701391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8rgecbz9Q7Jzp6eajm21hLSWx7IeyY0MrZP+QvLVqg=;
        b=O2y2tSJ8C7ZkLQjFAkJLUJYZYd3l0204qGy0PdXbqMdCh8e6aDPu1x/hriTfSa/6E4
         P1c1eeFetyyy3/M2GiCxXefhLZbyUvK2u8lrKZSBfuW7MoLwSzMxAcm4fIlpU0+r6EQb
         JkCvc2O/f6KQtndbmcJtt4qlClN3/ub/rZUu4f4mMyGL/Dig7ASO9wA/g3ThBPPBdkPN
         SWByOUPpug7hoNjLYWi3ljuzOgVD3omfZ13oZ54lqsc2+IlUWYdKPLr9hPcpeV7xOat8
         nngV7UoJHkGvAV43YlK2YFrHtwdfeY1tmXblQvmyOTXIz8vGVVe3TSzRk4KqqAHKQWID
         AUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766096591; x=1766701391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8rgecbz9Q7Jzp6eajm21hLSWx7IeyY0MrZP+QvLVqg=;
        b=u23el5eC7usl87aWJILplrwKl2hSwLCbwKp+wkEZCNgFnCTvxWrwsCmmq0P6rcd5Ty
         pvUiF5CONfEK10G54RziglPWj4hMSiisWA9D9Qh9+8h3IZwuhhnAdPB+1or+8boRyceg
         R+4lA00XpbQHrcU95wDqgxYQ0yx4gClK0Io+tYy70FtiKRTosE9wE10GOIRKUwx6KHnn
         pKd+hjgOfHFmhVe8FoHvVAJQj74i/mksocDrxzqXuqDfv0U3hPnP6PUNVB7IzJk3SPpi
         uQMLIzlhIUvTcPw1JFEipitVMRjbGTQMwf4cQgsw93QBJEdeiBnHggBt1a7s6Z2TZIHg
         i0hw==
X-Forwarded-Encrypted: i=1; AJvYcCUBqTbOCGsTD04pxIPNnOZzREwLSOzKAuuw2uI+KUuNqoRMkoeshow69SPqhJtD4gddEYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFOW9ppCkGgOAXxZ1zxe4E2OJAbDhB9no2fxDGEHc95NWvO9S
	Lf3ZRTj0zeloUymdxFGNJTE9XcgqMPHqFWNswbLyBMfQqcUbP4y0nJSjoHlZ+mLBPXA=
X-Gm-Gg: AY/fxX5nBY92Jlj7h2XJK6a8Rkyb2mgeyfZIy6eIjrIaQEKpfFce3nUjpFXpgKOJqoT
	Ng++gL7QmqQelR9AN6y+z/s7YPavxFN8E3psBq/S1EGxrbf78HOiDWFWM/bS1uXMzUydX49QAWY
	z8vx8oC5ZhIJt+ZQvJfGk4Kcq2c3rDoEtUkh+trhJV7VJDc/w1T4bMVRTg4URcy83m0vJwb09vh
	1/EhLhoBKVgssT0YF2LtD738uesHPricW0nKC7ON8MBalhG384tacYAmASUKUsRwwmUyAil79Dd
	pEK0hYPSYizBouJwsH417NmMf3KwDMHXN+pIvAcWUC37a0GkV5ihsLdOBFUP2UZ3XHprKQoZdiI
	WIpK0OXZNxG6bmHfrb86WPy9QaEvnqhfmGgX9u5I0ymUTzs9Vb/z3cwURujemsV3k2UoRcHDXUw
	i7BEclweTEU4aubZ3G7XZm0p0EhDDbfI+Age9vSz8JxVs0GvHNELVYf77Gi81SXKhQDNf9pXSX+
	K/A4tvA5TKw4kM=
X-Google-Smtp-Source: AGHT+IEspr+mA8yBfzyu92XEiMHrHEfySL5XUdcBH3qNwt/XL6ga6kYNOb/BEKUmPIRMr7Vo9NJQvA==
X-Received: by 2002:a05:622a:1801:b0:4f0:2b7d:5e05 with SMTP id d75a77b69052e-4f4abdc5894mr6756991cf.73.1766089353934;
        Thu, 18 Dec 2025 12:22:33 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d973a7f17sm3470116d6.22.2025.12.18.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:22:33 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6CAEFF40068;
	Thu, 18 Dec 2025 15:22:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 15:22:32 -0500
X-ME-Sender: <xms:iGJEaTXC7Mbzq2VSxQnniDwb0KXl8rx5O8vsG465qQfLHhdNSZdoLw>
    <xme:iGJEaZH-9Zcpv5hnLU3pV4LhmPg9-pPVGbsYVvnaglo0r3e9p15WL18nuEXd9AQ1J
    OTqM5u5b5LgFyvYLHhR-VD0NFHPy9gs-5L3cb6GLJhRjnxreyUGGA>
X-ME-Received: <xmr:iGJEabe_lCyjfDp07p_7ZwF5QdisUDkwZxJhmKbV5l1RBsbTZaoiNqWOavJd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegieefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnheptddtudegueevgefhgfeuffetffeuheekgedtffefhefhjeffhffgfeeggeetgefh
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
X-ME-Proxy: <xmx:iGJEabnyuKxJGLEnl3scEcV1Wr2sOT-vA5J2RYUGjX6RJN1qIORUpw>
    <xmx:iGJEaQEQN4GdKTlX4_1v-2RuuKtYr-H51p_MjcfnG3FsOmRfLIpdsg>
    <xmx:iGJEaW9xXmliOc7FtXTAYnwZkx0ObVMah_X-__4eArWyRu5ecw4ZXw>
    <xmx:iGJEaRiYrFqs_GGsbrm8ibaxbhwj1OlS_MFhn4aj6bNPGtNjuBwxLg>
    <xmx:iGJEaaQeaoS5QqiZYn8gsAq0HZwfSVU4BK7sqnOpSpF3J5k8G5qP5m-->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 15:22:31 -0500 (EST)
Date: Fri, 19 Dec 2025 05:22:29 +0900
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
Message-ID: <aURihbmjsKi8m7MO@tardis-2.local>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
 <aUO9KRaP0FXpm_l9@tardis-2.local>
 <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>

On Thu, Dec 18, 2025 at 12:35:18PM -0500, Mathieu Desnoyers wrote:
> On 2025-12-18 03:36, Boqun Feng wrote:
> > On Wed, Dec 17, 2025 at 08:45:30PM -0500, Mathieu Desnoyers wrote:
> [...]
> > > +static inline
> > > +void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
> > > +{
> > > +	struct hazptr_slot *slot = NULL;
> > > +	void *addr, *addr2;
> > > +
> > > +	/*
> > > +	 * Load @addr_p to know which address should be protected.
> > > +	 */
> > > +	addr = READ_ONCE(*addr_p);
> > > +	for (;;) {
> > > +		if (!addr)
> > > +			return NULL;
> > > +		guard(preempt)();
> > > +		if (likely(!hazptr_slot_is_backup(ctx, slot))) {
> > > +			slot = hazptr_get_free_percpu_slot();
> > 
> > I need to continue share my concerns about this "allocating slot while
> > protecting" pattern. Here realistically, we will go over a few of the
> > per-CPU hazard pointer slots *every time* instead of directly using a
> > pre-allocated hazard pointer slot.
> 
> No, that's not the expected fast-path with CONFIG_PREEMPT_HAZPTR=y
> (introduced in patch 4/4).
> 

I see, I was missing the patch #4, will take a look and reply
accordingly.

> With PREEMPT_HAZPTR, using more than one hazard pointer per CPU will
> only happen if there are nested hazard pointer users, which can happen
> due to:
> 
> - Holding a hazard pointer across function calls, where another hazard
>   pointer is used.
> - Using hazard pointers from interrupt handlers (note: my current code
>   only does preempt disable, not irq disable, this is something I'd need
>   to change if we wish to acquire/release hazard pointers from interrupt
>   handlers). But even that should be a rare event.
> 
> So the fast-path has an initial state where there are no hazard pointers
> in use on the CPU, which means hazptr_acquire() finds its empty slot at
> index 0.
> 
> > Could you utilize this[1] to see a
> > comparison of the reader-side performance against RCU/SRCU?
> 
> Good point ! Let's see.
> 
> On a AMD 2x EPYC 9654 96-Core Processor with 192 cores,
> hyperthreading disabled,
> CONFIG_PREEMPT=y,
> CONFIG_PREEMPT_RCU=y,
> CONFIG_PREEMPT_HAZPTR=y.
> 
> scale_type                 ns
> -----------------------
> hazptr-smp-mb             13.1   <- this implementation
> hazptr-barrier            11.5   <- replace smp_mb() on acquire with barrier(), requires IPIs on synchronize.
> hazptr-smp-mb-hlist       12.7   <- replace per-task hp context and per-cpu overflow lists by hlist.
> rcu                       17.0
> srcu                      20.0
> srcu-fast                  1.5
> rcu-tasks                  0.0
> rcu-trace                  1.7
> refcnt                  1148.0
> rwlock                  1190.0
> rwsem                   4199.3
> lock                   41070.6
> lock-irq               46176.3
> acqrel                     1.1
> 
> So only srcu-fast, rcu-tasks, rcu-trace and a plain acqrel
> appear to beat hazptr read-side performance.
> 

Could you also see the reader-side performance impact when the percpu
hazard pointer slots are used up? I.e. the worst case.

> [...]
> 
> > > +/*
> > > + * Perform piecewise iteration on overflow list waiting until "addr" is
> > > + * not present. Raw spinlock is released and taken between each list
> > > + * item and busy loop iteration. The overflow list generation is checked
> > > + * each time the lock is taken to validate that the list has not changed
> > > + * before resuming iteration or busy wait. If the generation has
> > > + * changed, retry the entire list traversal.
> > > + */
> > > +static
> > > +void hazptr_synchronize_overflow_list(struct overflow_list *overflow_list, void *addr)
> > > +{
> > > +	struct hazptr_backup_slot *backup_slot;
> > > +	uint64_t snapshot_gen;
> > > +
> > > +	raw_spin_lock(&overflow_list->lock);
> > > +retry:
> > > +	snapshot_gen = overflow_list->gen;
> > > +	list_for_each_entry(backup_slot, &overflow_list->head, node) {
> > > +		/* Busy-wait if node is found. */
> > > +		while (smp_load_acquire(&backup_slot->slot.addr) == addr) { /* Load B */
> > > +			raw_spin_unlock(&overflow_list->lock);
> > > +			cpu_relax();
> > 
> > I think we should prioritize the scan thread solution [2] instead of
> > busy waiting hazrd pointer updaters, because when we have multiple
> > hazard pointer usages we would want to consolidate the scans from
> > updater side.
> 
> I agree that batching scans with a worker thread is a logical next step.
> 
> > If so, the whole ->gen can be avoided.
> 
> How would it allow removing the generation trick without causing long
> raw spinlock latencies ?
> 

Because we won't need to busy-wait for the readers to go away, we can
check whether they are still there in the next scan.

so:

	list_for_each_entry(backup_slot, &overflow_list->head, node) {
		/* Busy-wait if node is found. */
		if (smp_load_acquire(&backup_slot->slot.addr) == addr) { /* Load B */
			<mark addr as unable to free and move on>
		
> > 
> > However this ->gen idea does seem ot resolve another issue for me, I'm
> > trying to make shazptr critical section preemptive by using a per-task
> > backup slot (if you recall, this is your idea from the hallway
> > discussions we had during LPC 2024),
> 
> I honestly did not remember. It's been a whole year! ;-)
> 
> > and currently I could not make it
> > work because the following sequeue:
> > 
> > 1. CPU 0 already has one pointer protected.
> > 
> > 2. CPU 1 begins the updater scan, and it scans the list of preempted
> >     hazard pointer readers, no reader.
> > 
> > 3. CPU 0 does a context switch, it stores the current hazard pointer
> >     value to the current task's ->hazard_slot (let's say the task is task
> >     A), and add it to the list of preempted hazard pointer readers.
> > 
> > 4. CPU 0 clears its percpu hazptr_slots for the next task (B).
> > 
> > 5. CPU 1 continues the updater scan, and it scans the percpu slot of
> >     CPU 0, and finds no reader.
> > 
> > in this situation, updater will miss a reader. But if we add a
> > generation snapshotting at step 2 and generation increment at step 3, I
> > think it'll work.
> > 
> > IMO, if we make this work, it's better than the current backup slot
> > mechanism IMO, because we only need to acquire the lock if context
> > switch happens.
> 
> With PREEMPT_HAZPTR we also only need to acquire the per-cpu overflow
> list raw spinlock on context switch (preemption or blocking). The only

Indeed, pre-allocating the slot on the stack to save the percpu slot
when context switch seems easier and quite smart ;-) Let me take a look.

Regards,
Boqun

> other case requiring it is hazptr nested usage (more than 8 active
> hazptr) on a thread context + nested irqs.
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
