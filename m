Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274481;
	b=mCTgEuZqEmT43TgjfRbPe/CrY5QcfquOWXTQCqa4tgSBdhmprSAZdqAY8lP4uTehu/f0
	 gdU5OZsL62YpFg1Pty3TouzG8S7Sqmx6qy68v/I3JLJ11nqgyLUz/yZCcIwQqZnp9Og/d
	 ew8AXCfJl/0gBiXiVMJPc0fpExeOAysjUToNr/QpvGChC6URFovMKUxmyoc1imYkBo8O/
	 0LKc/XR6D6JxoRENxq8v05w+dlRs4xOLDKdXQvq8O9fDb/ni8ZouI8enMEtwlWj41Dr52
	 WAyqaf4iBSDLXMGVKJq5BGGYbb8AMXtqx1k3vhl7QGcgH7WtHc7eHgtzcoj2U+GChEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274481;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7DLbqVwKut81UJQz2eVhLGMdnz2UGDrpeK5bP7AZPjM=;
	b=qMb3lkNZudkGQwdToEY0WSUhemZ8+DsksO+ekIGPVouZPQ3oLJHGW6sgO+hdo5eXMDtE
	 wUVrAhqfqlmp79XHsVF3XIXA9FZTAIO6R35MF7oxivRFb2EmDbaCL1M6m8w61BpyyCThv
	 SogZIws4QM/gAx+pEajqVH3q/BIfeBpNfVkBSqekZMnUwF79QybfcDGM0fSSID//I8mPN
	 IP3gN9WHzPXDpGrqx4sAM/Bx8UHRmLssJ30TW4FVxCtkcgeY7GKwyFQhRlIzUKSXBBizX
	 4LSzahbEndvO2TMC2WLeqOj01J0PFfDvt0p0IZJjB2hKH5484On/aa+NnRCatX8CoJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frbjRNm4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC3606A31C;
	Tue, 10 Nov 2026 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frbjRNm4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C8D1F0089F;
	Tue, 10 Nov 2026 01:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274480;
	bh=7DLbqVwKut81UJQz2eVhLGMdnz2UGDrpeK5bP7AZPjM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=frbjRNm4ypnIa8r11pCsYtVX8qqs79/UoQ8MKYE4b95DIDJuu9KNdum5qsfgOH9kU
	 /ClYy9NxMY6n+wGS7/bqu8/OVYVSJ0CleG4JRpSgFvTZ9kfUwfDLL+s3bwVcRaXwrg
	 I9UxgmAZNH7cZPt5kcBwK2Y9yziGvWrYzEz6LfOYD7meaIAQj1MhMZTJPJSy57Vbfl
	 aBtBbVnBllPkjjFGudNtLs/rczbQYF83HCLiByt6wYoBqzBIkA5SBigae8zai+AF6R
	 RSHv2ZdNPaZiRUBfl/om+5mLRcjJWZsOEWTc1S3BKudjh+P3X6oVOa80U24tvfeN8r
	 ASaB2BeQVX4rA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02C76CE0DDC; Mon,  9 Nov 2026 17:34:40 -0800 (PST)
Date: Mon, 9 Nov 2026 17:34:39 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	rcu@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
Message-ID: <3cb75140-1d10-4de3-86e6-c9d70edd2da5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
 <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
 <9667c08c-333e-4fe5-9812-c5ccaa183e36@efficios.com>
 <853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop>
 <597586c9-35ae-43bd-9b79-7abf62057838@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597586c9-35ae-43bd-9b79-7abf62057838@efficios.com>

On Mon, Nov 09, 2026 at 08:00:12PM -0500, Mathieu Desnoyers wrote:
> On 2026-11-09 19:25, Paul E. McKenney wrote:
> > On Tue, Oct 27, 2026 at 09:13:17PM -0400, Mathieu Desnoyers wrote:
> [...]
> >> So we'd keep using call_rcu to handle the steady-state reclaim of rcu
> txn,
> >> but use this specialized irqoff RCU domain for the empty slab case.
> >>
> >> Thoughts ?
> >
> > Atomic SRCU within interrupts-disabled regions seems to fit
> > this bill: synchronize_srcu_atomic(), srcu_read_lock_atomic(),
> > and srcu_read_unlock_atomic(), which interrupts disabled across
> > the latter two.  Maybe srcu_read_lock_atomic_irqsave() and
> > srcu_read_lock_atomic_irqrestore() if that helps.
> >
> > Or am I missing a turn in your requirements?
> 
> It fits well, thanks! It would replace the per-CPU counters I wrote
> for this domain. The steady state stays on call_rcu(), so the
> srcu_struct would only see synchronize_srcu_atomic(), never
> call_srcu(). I see two gaps between my requirements and your
> proposal:
> 
> First, NMI readers. rcu_txn_dereference() should work in any context,
> NMI included, as rcu_dereference() does. A tracer or a BPF program can
> walk an rcu_txn list from NMI. The atomic flavor uses
> __srcu_read_lock(). Its this_cpu_inc() is not NMI-safe on every
> architecture. And one srcu_struct cannot mix the atomic flavor with
> the nmisafe one.
>
> Could the atomic flavor count its readers as srcu_read_lock_nmisafe()
> does? Then a reader could also enter from NMI. The code I have for the
> next version keeps one counter per NMI nesting level for this. With
> SRCU, the sums of locks and unlocks handle the nesting already.

The other user that I know of is David Woodhouse, now CCed.

David, would you be OK with srcu_read_lock_atomic() using NMI-safe
counters, similar to __srcu_read_lock_fast()?

(Yes, I *could* make only your _irqsave() and _irqrestore() variants
NMI-safe, but then we have to enforce different srcu_struct structures
for _irqsave() and not.)

> Second, interrupts off. The wait for readers can run with interrupts
> disabled, for example in a list delete under a raw spinlock. The
> kerneldoc of synchronize_srcu_atomic() then requires the readers
> to disable interrupts too. So yes, the irqsave and irqrestore variants
> would help. The readers would use them instead of preemption off.
> 
> Would you prefer to add these two variants on the SRCU side, or should
> I prototype them with the next version of this series?

Your choice!

If you would like to do it, the trick is to make srcu_read_lock_atomic()
and srcu_read_unlock_atomic() invoke __srcu_read_lock_fast() and
__srcu_read_unlock_fast(), respectively, instead of __srcu_read_lock()
and __srcu_read_unlock(), again respectively.

Then there would need to be an srcu_read_lock_atomic_irqsafe() and
srcu_read_unlock_irqrestore(), which would (as you say), replace
preempt_disable() with local_irq_save() and preempt_enable()
with local_irq_restore().  There would be a flags argument that
as far as I know requires srcu_read_lock_atomic_irqsafe() and
srcu_read_unlock_irqrestore() be macros.  It would be good to share code
with srcu_read_lock_atomic() and srcu_read_unlock_atomic().

And kernel/rcu/rcutorture.c would need a bit of tweaking to test
this new interface, which should be discoverable by looking for
the code that tests srcu_read_{,un}lock_atomic().  Maybe just make
srcu_torture_read_lock() randomly decide between srcu_read_lock_atomic()
and srcu_read_lock_atomic_irqsave(), and have srcu_torture_read_unlock()
follow that decision.

One potentially tricky part here is that rcutorture is not set up to
pass a flags variable from a read-lock to the corresponding read-unlock.

							Thanx, Paul
