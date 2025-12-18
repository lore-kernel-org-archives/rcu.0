Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00922A1E1
	for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096206; cv=none; b=AuTjjVh6oGqSIODDsFLUyqnwSFkNCClHGolRpm38Hdy3rym7b+xQxwoes3EObAc4OJ5uIbr6DWk5PDxeLI10VYtjNBUe38R5e/UKZ+jSfbVTS8Nv+SC9TgXPbqzGD23oD1SbSKB2hhAMzU6LfuPtmOi5AAgIEwq/p1sNnVT2EMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096206; c=relaxed/simple;
	bh=0xd5VQJphUdTkSt449psxow9J9WCcxUvSivv8VMNdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGBJz/TefY86yuiAO3cZ93Lx7YzKeFCNFxAgz8PC4njLEHZ95PU9PUtJaegnMess/roklgkFyWfaea38u/Jak+dfmoE2h6V+uPSvaIDdoDx7DeIagL3ftiY3+j9ZieJQS0E+l0eTulqwDCK6UdohIlRcX1WhH2qMKCEHn2j6CEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEaxzYGb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEaxzYGb"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88888d80590so14731896d6.3
        for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 14:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766096202; x=1766701002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sXHinIvqqn4NKYj3YLqEcLxxqdNblij/w/+MvNbYRQ=;
        b=PEaxzYGbB2hvC1O6TovmlaRJjq3RyJPYJS7TFbM1kCZM7cA3Msg/eu4VqVybqfT3rw
         bHsoh63pAhnnGcFzrBZHVJEG6qZs5CIE3DQReUEr7KWrroP7s2X0qpC1/1ucz2at38vb
         H7GVd1BSGhYGzM5cScVJt9NhAs/J+XiW/H8jfSSeBSdHpFnN/3qbjVsPHllW2Ai73teA
         xKKdPaQjpPtd6aAr/19IseFmM3zA2qWVPFS1c962pnG+iUXNZzWPtPc7BEAEb3VjL97r
         +qCNjlDW3GHDlkCQrrgZC0lWts0CGUkCT1cjZJpCOeXiz20Wdi/X/sbitDGl3xc0lUPs
         1VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766096202; x=1766701002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sXHinIvqqn4NKYj3YLqEcLxxqdNblij/w/+MvNbYRQ=;
        b=r5r+ttRHQ2W4wEBHU6RK7omYiUdch5UwBaryPBcNoVtnIgR5jIYapv9RfgzwqHQaG4
         MbpZ2uQciry62YBWKEjAU90V8/G5xftQ6Bfs0amzmslER/mCUSLuLmedzR8HXUwebOoK
         Im899Vb5t0AZRSxd5kg+w/Jk3x2puF2kue4wtaziFES/7d1cSrOSrIKdInpQ3MoXugHS
         e/QpIOVJozXqVJmS2074AJIc8hL+zpxymw8o+EMC+FS8BArme8olT6s3S6OrbMTyEY33
         uVKYcphimPtgLmOgk5E+HYv1kgwa55QIlrX5rbIWDxUOXo9yEFC6Lv+RmjeTfW/XI7uT
         5JTg==
X-Forwarded-Encrypted: i=1; AJvYcCVWwhjKg55vPQav3uMO+gK3eM/9LQS2Cl+OjJgGwtBMQpfaW1GSY9KGOZ3KjE0ZT6p4UjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkaPHrcxvb03SErLgMF4gbgPiGW4Kt9xQk4cH38rOCzDSdeJN
	RmBeTlvdgjA6IK9q6Z9r9NtARipPOya8B0NG5lLMoo/iqKJRLX43npAS
X-Gm-Gg: AY/fxX6ANOo29gUIX2oreHmZ2Ud3uPbdr1jyG5qKLomLCbp6L4iMxorIxPdGN8bfHE7
	XVZPCbzfVSJ2n1U1jU42ngrqELFVXUQw/IRnsfL1TZkl0PefcB27GV6IkOhejGR59dw53nd9kjp
	BxnRBwmQW9TFW+jdMS4HPTyGnB5tgU5YoBRo1/mN20PNYA0quEvqvDewyKDJ/AlADPmCm9ENo4Z
	JijhcoGupHrOrq6vdifh4Y4kjrKCakHj/Wpr/jaPNBhJrEUOPUEQROdW7APTfPZ6ikUveMx5GAM
	lxC/EhxCs0Ta82zhtjgYJekWSstgbRnevl6vNKE1zBhIopx+pwRGT8olVUg2Fk1K+PFHabYgj1U
	UAYM7hHF8WlHHUBGYdCI5psUacIQPnoNb0bO5zj9jUyU4ppVBz+4xGikx4GsXu6OndKkFecGxcc
	EtaAt1qKb6slD2vszsHAYe9AtCuvrQRLzFbJWUR3lVgCKxd6wqUtqdXrevDobnCHGmSp0C1Orjw
	xH+u+N/7/CttT4=
X-Google-Smtp-Source: AGHT+IH9dlus8CLBnccpPwM7k0azGKuifjOTEiDe/F0ZElbIptxHmkvJntfFb5aH3wD+BBl6lym7+A==
X-Received: by 2002:ad4:55e6:0:b0:888:58e9:fda1 with SMTP id 6a1803df08f44-88d851fd95cmr13819516d6.14.1766096202075;
        Thu, 18 Dec 2025 14:16:42 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aeef5sm5249626d6.27.2025.12.18.14.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:16:41 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id AA726F4006D;
	Thu, 18 Dec 2025 17:16:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 17:16:40 -0500
X-ME-Sender: <xms:SH1EaZcr4nosz5Z_u80KXr3YTuBVa1KzutlGezTRHSDZs3vGJkkjOA>
    <xme:SH1EaUVPH7FAjWPnxjlkT6SOQdM1MN3G4pmjPM7rEFGVXaj797cdyQ5pHlryNlzxO
    VVPAdSNKmeWi9A_l2pblsDmpQTl9iH-oyauJMf2dWNjj8KWqT1ByQ>
X-ME-Received: <xmr:SH1EaS-mmRPmfNgvg_LETVK0X3GxPc8Ju8gr-cxm8qbpQU35_qsy-_unMKTt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegieeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeeffedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpd
    hrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthht
    ohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhpihhgghhi
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurd
    gruhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpth
    htohepfihilhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SH1EaT995_TeAJ4-63c4V7xKFasqvDak3J-igt9puhk5brWv5ylc_A>
    <xmx:SH1EadWoyqZsWXiMN5K-uDQ0qYQ1TUjy-3UEAJTDVukr5CuxkvA59g>
    <xmx:SH1EaYbSjUFJ67X-225Ef0HegXoCvjFb2nSB95hz5Zynp6lYavMa3A>
    <xmx:SH1EaXrTNm6EN-1Jchzt4W1vY9_BIcCtY-RjJ8xXdv0SKAXGMxtvYw>
    <xmx:SH1Eaf5et_nD7VWPecEOioNTVhm-onsV73utDC78UeHLz4tMAvn8XfBk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 17:16:39 -0500 (EST)
Date: Fri, 19 Dec 2025 07:16:37 +0900
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
Subject: Re: [RFC PATCH v4 4/4] hazptr: Migrate per-CPU slots to backup slot
 on context switch
Message-ID: <aUR9RfVChdcDncwX@tardis-2.local>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-5-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218014531.3793471-5-mathieu.desnoyers@efficios.com>

On Wed, Dec 17, 2025 at 08:45:31PM -0500, Mathieu Desnoyers wrote:
> Integrate with the scheduler to migrate per-CPU slots to the backup slot
> on context switch. This ensures that the per-CPU slots won't be used by
> blocked or preempted tasks holding on hazard pointers for a long time.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> ---
>  include/linux/hazptr.h | 63 ++++++++++++++++++++++++++++++++++++++++--
>  include/linux/sched.h  |  4 +++
>  init/init_task.c       |  3 ++
>  kernel/Kconfig.preempt | 10 +++++++
>  kernel/fork.c          |  3 ++
>  kernel/sched/core.c    |  2 ++
>  6 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> index 70c066ddb0f5..10ac53a42a7a 100644
> --- a/include/linux/hazptr.h
> +++ b/include/linux/hazptr.h
> @@ -24,6 +24,7 @@
>  #include <linux/percpu.h>
>  #include <linux/types.h>
>  #include <linux/cleanup.h>
> +#include <linux/sched.h>
>  
>  /* 8 slots (each sizeof(void *)) fit in a single cache line. */
>  #define NR_HAZPTR_PERCPU_SLOTS	8
> @@ -46,6 +47,9 @@ struct hazptr_ctx {
>  	struct hazptr_slot *slot;
>  	/* Backup slot in case all per-CPU slots are used. */
>  	struct hazptr_backup_slot backup_slot;
> +#ifdef CONFIG_PREEMPT_HAZPTR

I would suggest we make CONFIG_PREEMPT_HAZPTR always enabled hence no
need for a config, do we have the measurement of the additional cost?

> +	struct list_head preempt_node;
> +#endif
>  };
>  
>  struct hazptr_percpu_slots {
> @@ -98,6 +102,50 @@ bool hazptr_slot_is_backup(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
>  	return slot == &ctx->backup_slot.slot;
>  }
>  
> +#ifdef CONFIG_PREEMPT_HAZPTR
> +static inline
> +void hazptr_chain_task_ctx(struct hazptr_ctx *ctx)
> +{
> +	list_add(&ctx->preempt_node, &current->hazptr_ctx_list);
> +}
> +
> +static inline
> +void hazptr_unchain_task_ctx(struct hazptr_ctx *ctx)
> +{
> +	list_del(&ctx->preempt_node);
> +}
> +

I think you need to add interrupt disabling for chain/unchain because of
the potential readers in interrupt and then you can avoid the preempt
disabling in hazptr_release() I think. Let's aim for supporting readers
in interrupt handler, because at least lockdep needs that.

Regards,
Boqun

> +static inline
> +void hazptr_note_context_switch(void)
> +{
> +	struct hazptr_ctx *ctx;
> +
> +	list_for_each_entry(ctx, &current->hazptr_ctx_list, preempt_node) {
> +		struct hazptr_slot *slot;
> +
> +		if (hazptr_slot_is_backup(ctx, ctx->slot))
> +			continue;
> +		slot = hazptr_chain_backup_slot(ctx);
> +		/*
> +		 * Move hazard pointer from per-CPU slot to backup slot.
> +		 * This requires hazard pointer synchronize to iterate
> +		 * on per-CPU slots with load-acquire before iterating
> +		 * on the overflow list.
> +		 */
> +		WRITE_ONCE(slot->addr, ctx->slot->addr);
> +		/*
> +		 * store-release orders store to backup slot addr before
> +		 * store to per-CPU slot addr.
> +		 */
> +		smp_store_release(&ctx->slot->addr, NULL);
> +	}
> +}
> +#else
> +static inline void hazptr_chain_task_ctx(struct hazptr_ctx *ctx) { }
> +static inline void hazptr_unchain_task_ctx(struct hazptr_ctx *ctx) { }
> +static inline void hazptr_note_context_switch(void) { }
> +#endif
> +
>  /*
>   * hazptr_acquire: Load pointer at address and protect with hazard pointer.
>   *
> @@ -114,6 +162,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
>  	struct hazptr_slot *slot = NULL;
>  	void *addr, *addr2;
>  
> +	ctx->slot = NULL;
>  	/*
>  	 * Load @addr_p to know which address should be protected.
>  	 */
> @@ -121,7 +170,9 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
>  	for (;;) {
>  		if (!addr)
>  			return NULL;
> +
>  		guard(preempt)();
> +		hazptr_chain_task_ctx(ctx);
>  		if (likely(!hazptr_slot_is_backup(ctx, slot))) {
>  			slot = hazptr_get_free_percpu_slot();
>  			/*
> @@ -140,8 +191,11 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
>  		 * Re-load @addr_p after storing it to the hazard pointer slot.
>  		 */
>  		addr2 = READ_ONCE(*addr_p);	/* Load A */
> -		if (likely(ptr_eq(addr2, addr)))
> +		if (likely(ptr_eq(addr2, addr))) {
> +			ctx->slot = slot;
> +			/* Success. Break loop, enable preemption and return. */
>  			break;
> +		}
>  		/*
>  		 * If @addr_p content has changed since the first load,
>  		 * release the hazard pointer and try again.
> @@ -150,11 +204,14 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
>  		if (!addr2) {
>  			if (hazptr_slot_is_backup(ctx, slot))
>  				hazptr_unchain_backup_slot(ctx);
> +			hazptr_unchain_task_ctx(ctx);
> +			/* Loaded NULL. Enable preemption and return NULL. */
>  			return NULL;
>  		}
>  		addr = addr2;
> +		hazptr_unchain_task_ctx(ctx);
> +		/* Enable preemption and retry. */
>  	}
> -	ctx->slot = slot;
>  	/*
>  	 * Use addr2 loaded from the second READ_ONCE() to preserve
>  	 * address dependency ordering.
> @@ -170,11 +227,13 @@ void hazptr_release(struct hazptr_ctx *ctx, void *addr)
>  
>  	if (!addr)
>  		return;
> +	guard(preempt)();
>  	slot = ctx->slot;
>  	WARN_ON_ONCE(slot->addr != addr);
>  	smp_store_release(&slot->addr, NULL);
>  	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
>  		hazptr_unchain_backup_slot(ctx);
> +	hazptr_unchain_task_ctx(ctx);
>  }
[...]
