Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08B346AF6
	for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074356; cv=none; b=mUhovxRG43O8q3iGlJfWB+vGc5MhdRBVhc1KZ+rKNd0IY2y3EoRlhdQx4fbbJPbDoGMgw6Xozs9WaVo3fNZ74uJXxXhujXP87P2EymB1mdvjQitf0jIuBTU4bVZRSiUVFTp7R1Vp4dYZJYAAh3k0UlsFuj3JrlqTSDnuUfiWWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074356; c=relaxed/simple;
	bh=hILVjo4AUez19jo2pE3nhHEemYOjjDlMPLwgmLQmJjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzUa9S8pABik+f7qVtR6NMYgfJqcAnluBgsicK429mtHkrH9qB9vOa9ykiFwY/QIRmrpXRKaiSuhMR+vNJ9khFbYtcVqFDNyHby1ZF6M5A1UfC+4XBpgkATzKc6MczR+TH3xtBr9t+7A/X0ML/29TvcjgP3HgdTno5w0+JaKSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+qK1H+P; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+qK1H+P"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-431048c4068so507855f8f.1
        for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 08:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766074353; x=1766679153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWV/1Pvi/LREO51Q4j2bYTzBTPFXYl3JU+RoWaS0a6Q=;
        b=O+qK1H+PubwCyxIvRMd0jbBNETk5kQv4obd4IYfU/8F5wjf3f49JK6VHTKyHUe5MQW
         YzFjYxaHtvyeXHl1to9gyREC5fr52SwUg62o2Qf8FIMw5JJK1p2fCF61qCGJYyXj0Bzu
         n4xQsCWPeHFi7hgvTt32p6rF/Nt9FE9Rw6szs+FOSenC8lt1C6jVyTge5oAB2rmLEwSQ
         HaBTvFPf5OvvHdOPCQuND9s7XYYb6jkq/bHCCorHy8ANypEjBbiE1PV8OYyTJYov/mf0
         1RZC7JkXBDSgGvhZkIb2H1aZkw4X+rdmjCscVPxfOk1DMHbi4HhHXamNORzwnSLzDvbE
         erQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766074353; x=1766679153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWV/1Pvi/LREO51Q4j2bYTzBTPFXYl3JU+RoWaS0a6Q=;
        b=umKGBQPVChP4FODMxgqdlEIz68resULPRvZsJIZLtd+Br0IAiwnF7V0x0q6j845l6n
         xaHuiEfjNpQq1IRQ+xL88xmEiDon+g35FshrCd6zJ9fVIywPL2iV4XBkVxY8/Np+Cke+
         pRKVrXevomiJ4d2csMeQi02ioU3qOP3Lql/AAbMOl539Dvz7KCwpuXxPg3IjkucWKEnl
         2ZP548x5BWr6p/fv74rTO9shhdJ6rizG0DU02XDmDRahylrV6qxHdAFefb3iP6jvlMgl
         xy/j5wGkUjWA4peZjlvyCe8v3RFgfNsC6zo/HPWJXRlT4QDNXahIZ8Egdt10MHi90x10
         JXCg==
X-Forwarded-Encrypted: i=1; AJvYcCX8jbUwV4WrpYP+9PxKSLg3S572eOP6B10yNj8f4HktbpaepYpvwgDDzn0T6OrZBM/lXeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qqlbuSNtDByBsC2AWJxsxEQCDuBabl7qxtH2/hIiFY9zdvvb
	cVK1J+ldugdENH0N+MDnapPkIVx2lxgt9yg0HC/rRFfdMnEE1L/gdDvM
X-Gm-Gg: AY/fxX4lgCtqj7HTJIS0Cjhwyzq1C3QqRsqqfCp6Aom9Em/ZoarI5YMVJd6PDcHzRHq
	ruu65Rif8QkL91KshPrYbHoMj/NyqhkkQyeJCgWYVWn+unEFxakvZvH2x/d7n72xu106nhFRzvC
	sJKcCia/eeBp5lMfyJrl4x5vG+9RwMsVkQXH+rQXeZUMHR1uOwT8zchLIEEA/MNNBfm7S6pPFA7
	U52KLXLMHf5WNxm5vjNjB/jKSEWbGvSiJ+tS3vIFXBHU/C7h722d6SfRKd3q8fkv/En0U4VkbuN
	iHhe8PWV6WrSyu04hWI186LrrMbYR8ITqvsHucZb5yRUabc+Z8U3KsBm7JzC7igX0+IT9bpQUFx
	4vwMdZFpo/UV6Uo4Ulen65ZXzF5rm2FIQA1QeM5w7ymVbgjkYTEAFVycjAwbApzIdpu9YoB2/ar
	L9chHHmltNoTyTSYwSs2254QurWb6UnXVNmc13/Wl8Cw7eCkSY3hB9
X-Google-Smtp-Source: AGHT+IF9IwYAhi8+6w3+wxW3M7gEiPdh7t/1OgDyx7SiDKnto2Pyh4pbz29WYRXhF76RKtErZ/OMCg==
X-Received: by 2002:a05:6000:18a8:b0:431:de5:93c7 with SMTP id ffacd0b85a97d-4324479535emr4292777f8f.2.1766074352470;
        Thu, 18 Dec 2025 08:12:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449986f1sm5781954f8f.29.2025.12.18.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:12:32 -0800 (PST)
Date: Thu, 18 Dec 2025 16:12:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, Nicholas
 Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, John Stultz
 <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil
 Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik
 <mjguzik@gmail.com>, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev, Nikita Popov
 <github@npopov.com>, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v4 1/4] compiler.h: Introduce ptr_eq() to preserve
 address dependency
Message-ID: <20251218161229.767dafbf@pumpkin>
In-Reply-To: <20251218142736.464b7a4a.gary@garyguo.net>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
	<20251218014531.3793471-2-mathieu.desnoyers@efficios.com>
	<20251218090313.33923750@pumpkin>
	<20251218142736.464b7a4a.gary@garyguo.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 14:27:36 +0000
Gary Guo <gary@garyguo.net> wrote:

> On Thu, 18 Dec 2025 09:03:13 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > On Wed, 17 Dec 2025 20:45:28 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > index 5b45ea7dff3e..c5ca3b54c112 100644
> > > --- a/include/linux/compiler.h
> > > +++ b/include/linux/compiler.h
> > > @@ -163,6 +163,69 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > >  	__asm__ ("" : "=r" (var) : "0" (var))
> > >  #endif
> > >  
> > > +/*
> > > + * Compare two addresses while preserving the address dependencies for
> > > + * later use of the address. It should be used when comparing an address
> > > + * returned by rcu_dereference().
> > > + *
> > > + * This is needed to prevent the compiler CSE and SSA GVN optimizations
> > > + * from using @a (or @b) in places where the source refers to @b (or @a)
> > > + * based on the fact that after the comparison, the two are known to be
> > > + * equal, which does not preserve address dependencies and allows the
> > > + * following misordering speculations:
> > > + *
> > > + * - If @b is a constant, the compiler can issue the loads which depend
> > > + *   on @a before loading @a.
> > > + * - If @b is a register populated by a prior load, weakly-ordered
> > > + *   CPUs can speculate loads which depend on @a before loading @a.
> > > + *
> > > + * The same logic applies with @a and @b swapped.
> > > + *
> > > + * Return value: true if pointers are equal, false otherwise.
> > > + *
> > > + * The compiler barrier() is ineffective at fixing this issue. It does
> > > + * not prevent the compiler CSE from losing the address dependency:
> > > + *
> > > + * int fct_2_volatile_barriers(void)
> > > + * {
> > > + *     int *a, *b;
> > > + *
> > > + *     do {
> > > + *         a = READ_ONCE(p);
> > > + *         asm volatile ("" : : : "memory");
> > > + *         b = READ_ONCE(p);
> > > + *     } while (a != b);
> > > + *     asm volatile ("" : : : "memory");  <-- barrier()
> > > + *     return *b;
> > > + * }
> > > + *
> > > + * With gcc 14.2 (arm64):
> > > + *
> > > + * fct_2_volatile_barriers:
> > > + *         adrp    x0, .LANCHOR0
> > > + *         add     x0, x0, :lo12:.LANCHOR0
> > > + * .L2:
> > > + *         ldr     x1, [x0]  <-- x1 populated by first load.
> > > + *         ldr     x2, [x0]
> > > + *         cmp     x1, x2
> > > + *         bne     .L2
> > > + *         ldr     w0, [x1]  <-- x1 is used for access which should depend on b.
> > > + *         ret
> > > + *
> > > + * On weakly-ordered architectures, this lets CPU speculation use the
> > > + * result from the first load to speculate "ldr w0, [x1]" before
> > > + * "ldr x2, [x0]".
> > > + * Based on the RCU documentation, the control dependency does not
> > > + * prevent the CPU from speculating loads.    
> > 
> > I'm not sure that example (of something that doesn't work) is really necessary.
> > The simple example of, given:
> > 	return a == b ? *a : 0;
> > the generated code might speculatively dereference 'b' (not a) before returning
> > zero when the pointers are different.  
> 
> I'm not sure I understand what you're saying.
> 
> `b` cannot be speculatively dereferenced by the compiler in code-path
> where pointers are different, as the compiler cannot ascertain that it is
> valid.

The 'validity' doesn't matter for speculative execution.

> The speculative execution on the processor side *does not* matter here as
> it needs to honour address dependency (unless you're Alpha, which is why we
> add a `mb()` in each `READ_ONCE`).

There isn't an 'address dependency', that is the problem.
The issue is that 'a == b ? *a : 0' and 'a == b ? *b : 0' always evaluate
to the same value and the compiler will (effectively) substitute one for the
other.
But sometimes you really do care which pointer is speculatively dereferenced
when the they are different.
Memory barriers can only enforce the order of the reads of 'a', 'b' and '*a',
they won't change whether the generated code contains '*a' or '*b'.

	David


> 
> Best,
> Gary
> 
> 
> 

