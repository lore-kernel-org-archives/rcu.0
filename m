Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C051B4C2E;
	Fri, 27 Sep 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478664; cv=none; b=kaoB43N+pRYtQeqs2Zte9hPcFVI7vtX9BkrQVVBMiru27HfuugZ5A/kLQZJNR2PB/Mq2dgvebmfXpf+/DKFRUEQPn7wnWTJvcKmMb+sJTrpSnKJ5akafMRK1utiSD5St17YEQ4ZfKW15aeH7o62fBpnif5hODAhZd63nStRacfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478664; c=relaxed/simple;
	bh=740AN4G7rVFUt0rTKnr9lrFhTyrHEmKAmF186MUOJas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFD/Uc2RxlukNxW4qESQSqb1oFd6glJ8RAwedXHJr4Wnd9sY68oF1ghNIUnXbgQeAGrEyS2RVmcbSlraHmZaOfXRH1hQ77jhXjFnZ7/2n54eAq8jqgX7fNBR5M57cd1ccXzBG75Q5jmZYaKyOzaXFLGFLct+jYtrCgRaaq4CdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2kpdPcd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2kpdPcd"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ab8e5f96so184883685a.1;
        Fri, 27 Sep 2024 16:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727478662; x=1728083462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpoTAtzsVeeK1uuREm1KOA1rviE8CgrfOlB6HO554Gk=;
        b=h2kpdPcddem2RTl68FqsVmyOeqx1i2pLIk1Kf0nds/J8xKCTkcPRzDpsbG1dAFXxci
         Wxdx0qquTirjZNtf0CJodYgkqJ+9l9UxhHvbDPBAkmifJuJgP1BBmAip+SD2PGuMMwK5
         1kOEj/ONBX2LFIKAi/ldJ8g8mOjGaRJ7bw99ToxNWlPCNhwT4Uo5RSK0JwhdoLvQqmI2
         FQLntAF0Khbmzf99uPhr7Q1YjUaX0A/2o0Rr0CgyGN4jHKF0lMA/nZLHaRS9D4Sl71vS
         x1PAUD5Ttd1ohGbKUw3VIdCC9n1YjyFlUhOJKCNkSxbH8LKUDGCrX8iP8LYvEDH6/TJB
         Ux9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727478662; x=1728083462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpoTAtzsVeeK1uuREm1KOA1rviE8CgrfOlB6HO554Gk=;
        b=fiyTo8Clm4V/bt+dI4BOKgECM4KBxkEHx5uc2WgjF4CfpCeAzt12aU2nJdn3ZfWWeE
         YjBpAMP4grJ1eXRIOJBa6J44qy8qAQwbOEawIm7vfX9X6ChnDGkoLoJ+I3z35mFf5YHi
         3/ld0H/VlgW98F28GZcTR6ufdTn22EiJLOiv19Sl2vUUnH+AwnTQqQOW+gt/LsBWyO9w
         3GGGX4gmoB9RKpl0QDgwgeWl2mGQiZY3/hISy8HyfTJEfc0KaR6357sX3vhKd0hFEZM/
         Cdc9wD7VCIrss9I62hrqjsiTXlcWUbxHsA/6Nw8oU9RrMv8IsupdJDXCzaC9uGpy3e3A
         mNPg==
X-Forwarded-Encrypted: i=1; AJvYcCV0+TEnqWa1k8mSXxiLea+OgIY+OotZjv0TG4jWjey9fzJeMWwWA2z5gp31lVhhRMXHkngz@vger.kernel.org, AJvYcCWRb+vzLnwiyEqE2jePiCnRSrDLHOkx1jNJXBCICPKtmfdroyOGdm4MPrWUURT7WJSC7yUHvZsglEkkBlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cj28VT9aoGyftAaLssYDcV2YLm/qHVZBSmR1eBXMSdBAYBv+
	W+R22Z/fPT8b6Cki8mK1nwksKtd15Udra1bvrmZQ1i5rSqyQRUhF
X-Google-Smtp-Source: AGHT+IFBDTW5qDL4IO8+urSC0PfeHvBtwa+yXuuYMnvjq5EwYU75Ii6opIDkOZR/QjLSpzSZoio8og==
X-Received: by 2002:a05:620a:414d:b0:7ab:3311:f0e with SMTP id af79cd13be357-7ae378562bfmr670455385a.33.1727478661811;
        Fri, 27 Sep 2024 16:11:01 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d773asm136809785a.35.2024.09.27.16.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 16:11:01 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7372A120006A;
	Fri, 27 Sep 2024 19:11:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Sep 2024 19:11:00 -0400
X-ME-Sender: <xms:hDv3ZkGbPqBxZMPVPpTfzsAQwg4Cbk3vG1ZHTBMD2wIHW-DYJcG6fA>
    <xme:hDv3ZtWcBkBwg5os3IIZZDW8agEQHrzpRAXgvEsJcnf31CSUvFsBdeb9_l3evLu4e
    0FOdThkW6XrFU2VUA>
X-ME-Received: <xmr:hDv3ZuJ8dHV_dBwXtGz_JLSpg2nbWyxPgOWBHsUwxmfDn0AP4DD2miN46DQ5gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddutddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidq
    fhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhig
    fhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghighgvrghshieslhhinhhuth
    hrohhnihigrdguvgdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrh
    iisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghn
    ugdrhhgrrhhvrghrugdrvgguuh
X-ME-Proxy: <xmx:hDv3ZmGkBwyCCO7_Q-3bDZzo7OaXqYKme-YmfhE3w33Edo2g1imhUg>
    <xmx:hDv3ZqXnn-DJ9xdJOhPvA5oBEvMetPzoG2j4Dh3RVyeSPqmJFQyQzw>
    <xmx:hDv3ZpN7NnF4R2jhMVMPF9yoCq7K20PWG89QlsYEFXewOWAE0kGnGw>
    <xmx:hDv3Zh1BWv_8Cvz4V_E5YZ-x-F1StINAaeUB87SIcpBkXMYQJONh-w>
    <xmx:hDv3ZjWUWgW2IxZocQuDaOvz6fGT0CXGe_BOmdHaYx-AP4peg6w6_yIK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 19:10:59 -0400 (EDT)
Date: Fri, 27 Sep 2024 16:10:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,	Mateusz Guzik <mjguzik@gmail.com>,
 rcu@vger.kernel.org,	linux-mm@kvack.org, lkmm@lists.linux.dev,
	Gary Guo <gary@garyguo.net>
Subject: Re: [RFC PATCH] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <Zvc7UQ3hsqF4dxtJ@boqun-archlinux>
References: <20240927203334.976821-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927203334.976821-1-mathieu.desnoyers@efficios.com>

[Cc Gary]

On Fri, Sep 27, 2024 at 04:33:34PM -0400, Mathieu Desnoyers wrote:
> Compiler CSE and SSA GVN optimizations can cause the address dependency
> of addresses returned by rcu_dereference to be lost when comparing those
> pointers with either constants or previously loaded pointers.
> 
> Introduce ptr_eq() to compare two addresses while preserving the address
> dependencies for later use of the address. It should be used when
> comparing an address returned by rcu_dereference().
> 
> This is needed to prevent the compiler CSE and SSA GVN optimizations
> from replacing the registers holding @a or @b based on their
> equality, which does not preserve address dependencies and allows the
> following misordering speculations:
> 
> - If @b is a constant, the compiler can issue the loads which depend
>   on @a before loading @a.
> - If @b is a register populated by a prior load, weakly-ordered
>   CPUs can speculate loads which depend on @a before loading @a.
> 
> The same logic applies with @a and @b swapped.
> 
> The compiler barrier() is ineffective at fixing this issue.
> It does not prevent the compiler CSE from losing the address dependency:
> 
> int fct_2_volatile_barriers(void)
> {
>     int *a, *b;
> 
>     do {
>         a = READ_ONCE(p);
>         asm volatile ("" : : : "memory");
>         b = READ_ONCE(p);
>     } while (a != b);
>     asm volatile ("" : : : "memory");  <----- barrier()
>     return *b;
> }
> 
> With gcc 14.2 (arm64):
> 
> fct_2_volatile_barriers:
>         adrp    x0, .LANCHOR0
>         add     x0, x0, :lo12:.LANCHOR0
> .L2:
>         ldr     x1, [x0]    <------ x1 populated by first load.
>         ldr     x2, [x0]
>         cmp     x1, x2
>         bne     .L2
>         ldr     w0, [x1]    <------ x1 is used for access which should depend on b.
>         ret
> 
> On weakly-ordered architectures, this lets CPU speculation use the
> result from the first load to speculate "ldr w0, [x1]" before
> "ldr x2, [x0]".
> Based on the RCU documentation, the control dependency does not prevent
> the CPU from speculating loads.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> ---
>  include/linux/compiler.h | 62 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 2df665fa2964..f26705c267e8 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -186,6 +186,68 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  	__asm__ ("" : "=r" (var) : "0" (var))
>  #endif
>  
> +/*
> + * Compare two addresses while preserving the address dependencies for
> + * later use of the address. It should be used when comparing an address
> + * returned by rcu_dereference().
> + *
> + * This is needed to prevent the compiler CSE and SSA GVN optimizations
> + * from replacing the registers holding @a or @b based on their
> + * equality, which does not preserve address dependencies and allows the
> + * following misordering speculations:
> + *
> + * - If @b is a constant, the compiler can issue the loads which depend
> + *   on @a before loading @a.
> + * - If @b is a register populated by a prior load, weakly-ordered
> + *   CPUs can speculate loads which depend on @a before loading @a.
> + *
> + * The same logic applies with @a and @b swapped.
> + *
> + * Return value: true if pointers are equal, false otherwise.
> + *
> + * The compiler barrier() is ineffective at fixing this issue. It does
> + * not prevent the compiler CSE from losing the address dependency:
> + *
> + * int fct_2_volatile_barriers(void)
> + * {
> + *     int *a, *b;
> + *
> + *     do {
> + *         a = READ_ONCE(p);
> + *         asm volatile ("" : : : "memory");
> + *         b = READ_ONCE(p);
> + *     } while (a != b);
> + *     asm volatile ("" : : : "memory");  <-- barrier()
> + *     return *b;
> + * }
> + *
> + * With gcc 14.2 (arm64):
> + *
> + * fct_2_volatile_barriers:
> + *         adrp    x0, .LANCHOR0
> + *         add     x0, x0, :lo12:.LANCHOR0
> + * .L2:
> + *         ldr     x1, [x0]  <-- x1 populated by first load.
> + *         ldr     x2, [x0]
> + *         cmp     x1, x2
> + *         bne     .L2
> + *         ldr     w0, [x1]  <-- x1 is used for access which should depend on b.
> + *         ret
> + *
> + * On weakly-ordered architectures, this lets CPU speculation use the
> + * result from the first load to speculate "ldr w0, [x1]" before
> + * "ldr x2, [x0]".
> + * Based on the RCU documentation, the control dependency does not
> + * prevent the CPU from speculating loads.
> + */
> +static __always_inline
> +int ptr_eq(const volatile void *a, const volatile void *b)
> +{
> +	OPTIMIZER_HIDE_VAR(a);
> +	OPTIMIZER_HIDE_VAR(b);
> +	return a == b;
> +}
> +

This is better than what I proposed, thank you!

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Could you also make some documentation changes at the "Be very careful
about comparing pointers obtained from..." paragraph in
Documentation/RCU/rcu_dereference.rst? Since 'ptr_eq' is a good tool in
those cases mentioned there. Thanks.

Regards,
Boqun

>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>  
>  /**
> -- 
> 2.39.2
> 
