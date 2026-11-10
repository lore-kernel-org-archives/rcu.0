Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336863;
	b=auodraA/keaHAsM5lR73aesIBVitF+pP5IlLdQwC61YYV4qlYmxcGlPSkcR6uEjzYb6Y
	 leGgnKaB5g2z5WNwri2EPWIWyBhQzv3JmzUjtsyLZBcffr47ZAUiBDLVn0TeMPYjWHRpd
	 g9Kwwa/5Z/3N24CxcDnzLvS3rtEG8idOYX5Nio6tTJMFwCCukMJeaorpytxXpBiJVhQUg
	 xa/qB8aqZ+xH3gM7u266kpHCqfjR5GuHaeJzNrhTQx1ItGR+a6jcNlGlb38v6t0Jixspn
	 JOuZupZcz/4EjqYFGdle5Dlv0uadU+z8x1bKJDUHYai/LXkc+v0TA6CRbWB22PU79SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336863;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nDbl4gUxTNcd/3+M+YJSzWuFbUppBzQzgjX3N9VirY8=;
	b=iX9Bj+PRsrSwdIWRp8m2U5fRp80XLMq2XHjoS5vpOIKtZeCUhj8iihltMMfoxvRnjfnt
	 HWck0XJeFkUu82oqTmMHe1zW1VBvWBqAMk1You1rCro4NKWdg+tJBByXKBHYsAmdicdJF
	 sO2tkmVX/Xdr8UNISZZ3pifLKVMKXD6Morufc1EF0OlNQYPLYp7LhaipzeqoxQO4Q4DET
	 UlDdKUH7Bw+WP1eR9Tag70hqsV5KBs4hoTymN7K0iakHGEAchV3nuK2ty+maSnoPjctlJ
	 yYgRbaCeagH+X/n+5FoxkeiANoGx+nfJMWONNnbwHUQ9zzW6Pslxmx0JZAbEl7qjGmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3dpPRVt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3F606A323;
	Tue, 10 Nov 2026 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3dpPRVt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8D51F0089F;
	Tue, 10 Nov 2026 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336862;
	bh=nDbl4gUxTNcd/3+M+YJSzWuFbUppBzQzgjX3N9VirY8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=T3dpPRVtZPsPK7y3nPh5Kmn1H3KdxyosPsL1B8UEFq7jNCUDHQUbaGWyr7QYJmfCs
	 mQ4ztvcGhWNk9QlpsxptOAduOLSuSb3IB97kk1QEjN3ywKIxSPsWLUg+VTs7bDtHRr
	 Cx4TUvsGlZXjoBYJarnyg7KcVxn8HUlKb0jCjWKo76KBVSQtvGccH0VjxfkDjeVi7J
	 1VvTG1stfPRyWnbCq3jJ81QCp3DrjhBN/3Q+m7cJjWjfextIdIFGNvhqQ8RqLcDazf
	 X3BLqM99Lke0zoestAlOZ0Kyn50e61GhNwBGU+mnN3p/d5OUEWO/XjzzvWdzhTNre3
	 Vyw9t52MSe6cQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 91709CE0AD8; Tue, 10 Nov 2026 10:54:22 -0800 (PST)
Date: Tue, 10 Nov 2026 10:54:22 -0800
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
Message-ID: <30d1455d-db30-4528-ae23-80aed17feba2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
 <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
 <9667c08c-333e-4fe5-9812-c5ccaa183e36@efficios.com>
 <853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop>
 <597586c9-35ae-43bd-9b79-7abf62057838@efficios.com>
 <3cb75140-1d10-4de3-86e6-c9d70edd2da5@paulmck-laptop>
 <cf8bf913-1bf9-49d6-9749-8631cee1604f@efficios.com>
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
In-Reply-To: <cf8bf913-1bf9-49d6-9749-8631cee1604f@efficios.com>

On Tue, Nov 10, 2026 at 10:26:24AM -0500, Mathieu Desnoyers wrote:
> On 2026-11-09 20:34, Paul E. McKenney wrote:
> [...]
> > > Would you prefer to add these two variants on the SRCU side, or should
> > > I prototype them with the next version of this series?
> > 
> > Your choice!
> 
> I'll do it. Adapting atomic SRCU to these needs is much more
> maintainable than keeping my own copy of nearly the same mechanism.
> 
> > If you would like to do it, the trick is to make srcu_read_lock_atomic()
> > and srcu_read_unlock_atomic() invoke __srcu_read_lock_fast() and
> > __srcu_read_unlock_fast(), respectively, instead of __srcu_read_lock()
> > and __srcu_read_unlock(), again respectively.
> 
> I'll start by making every atomic reader NMI-safe this way, as you
> suggest. If David objects, we can still change it based on his
> feedback.
> 
> > Then there would need to be an srcu_read_lock_atomic_irqsafe() and
> > srcu_read_unlock_irqrestore(), which would (as you say), replace
> > preempt_disable() with local_irq_save() and preempt_enable()
> > with local_irq_restore().  There would be a flags argument that
> > as far as I know requires srcu_read_lock_atomic_irqsafe() and
> > srcu_read_unlock_irqrestore() be macros.  It would be good to share code
> > with srcu_read_lock_atomic() and srcu_read_unlock_atomic().
> 
> Agreed. I plan to name them srcu_read_lock_atomic_irqsave() and
> srcu_read_unlock_atomic_irqrestore(), as macros sharing code with the
> current pair.
> 
> > And kernel/rcu/rcutorture.c would need a bit of tweaking to test
> > this new interface, which should be discoverable by looking for
> > the code that tests srcu_read_{,un}lock_atomic().  Maybe just make
> > srcu_torture_read_lock() randomly decide between srcu_read_lock_atomic()
> > and srcu_read_lock_atomic_irqsave(), and have srcu_torture_read_unlock()
> > follow that decision.
> > 
> > One potentially tricky part here is that rcutorture is not set up to
> > pass a flags variable from a read-lock to the corresponding read-unlock.
> 
> I'll look at the rcutorture side as part of it.
> 
> A later version of rcu_txn will then use these readers, instead of its
> own per-CPU counters.

Sounds good, and looking forward to seeing what you come up with!

							Thanx, Paul
