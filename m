Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270326;
	b=cmBRaJrLbK+NEmABl8QqBjrTcW2dg69UrMrj3IpcRyiNjV8IcotBpqdO8BS1FDYvSiVz
	 Wuf3ts3WdCmBj65eueVGxReog6i6JVtjA2pajGWu0l5+q9fwdqX3F75OrD01QjcjJJQC3
	 xPza9LUZCgG3TBnRLsVmBrmGyJczuzoqo7G5mBZukAhE2KlLDzxp0vPB3gfaNkWojuuE9
	 lPxSliG5QP/wLUhs1MUkQ/fHHOXqb44o77hoEb9gIQeuEoce7dwS9Chh9Wm2FAj03r8oR
	 Amjomt3RrD43sT1f2ewn5YYk5qHOET7v34+1k+LxYun/4oBlm1FpMkYwthBlW9k5c7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270326;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=y0ysK1auGuUFCu9qoQQNCcNfYLTUBeRUgxBC82QBKzs=;
	b=I8Ul/eiimtJDfd167EX1Cn1PPzjzJx3L/jtqVq6MlwLil+HLDgeZt8kuaqzx4GNWjCaB
	 H7Zc66ASLNVvhKlRkYzqn4HNBnv43STBp4DfjJAJiFiD/xqIfJIWuaa2Md9nsnwcu837c
	 Mnwsuw2MdwgiFoADZAC3rAwYwIrwdOnIdaCnQJkucr2RtJq0ctW1mt3NcwDVFR+5Gp2S6
	 H7A0jT0hY0gpsBlmX7UEymmKESLf0qYF8DoMkAxlgxQMnKyynvX+ZtjlaFjJZmDTT7j+F
	 viXrqMqch0Fo9udQEnAmFWJ4FhVi6isI8zC2ip4TewQeQOvaJMBiWLa7d7eiNPsQoSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYayyrAB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19B606A31C;
	Tue, 10 Nov 2026 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYayyrAB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705041F0089F;
	Tue, 10 Nov 2026 00:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794270325;
	bh=y0ysK1auGuUFCu9qoQQNCcNfYLTUBeRUgxBC82QBKzs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=FYayyrABreZyKrfs5GnxwDNXAG6qEw7pfhFJR/5gPW0GhgmDjj6jkJVO4NZYTIJWp
	 dzyLuZYJzkHl+PkcF5M9FvSUwnxY65rqvV5qaOF3kscSm75aWr4CBaarqzNzss+Ipw
	 wW8fS7kI3UsOS4lztVPhDKZincfA0wV/epcwZpMnY36BlmDeTemmfGSrwaCy9Rm/Az
	 GHfDohxthV30BPgMZC8z1FOsa0zh4mD1mR/EmzCnFfpY2ahqs5w4yN6wYtaZepBNNN
	 fbWvON2zKFVHWrN6ux78MLeswKm4g9nBFjAy84iLuIFi9OqR0LUo1zX78yoXQKOoJm
	 shyzjLe2pS5MQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 298EFCE0C97; Mon,  9 Nov 2026 16:25:25 -0800 (PST)
Date: Mon, 9 Nov 2026 16:25:25 -0800
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
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
Message-ID: <853d8469-94a4-4b33-a0d5-d6d2138fe3ef@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
 <20261023181940.457424-1-puranjay@kernel.org>
 <f785237c-ee5e-4ad3-8ee9-79474f5f45c8@efficios.com>
 <9667c08c-333e-4fe5-9812-c5ccaa183e36@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9667c08c-333e-4fe5-9812-c5ccaa183e36@efficios.com>

On Tue, Oct 27, 2026 at 09:13:17PM -0400, Mathieu Desnoyers wrote:
> On 2026-10-27 15:57, Mathieu Desnoyers wrote:
> [...]
> > 
> > E) Use a preallocated per-cpu rcu-txn slab, synchronize txn descriptor reclaim with
> >     RCU (steady state) and hazard pointers (OOM)
> > 
> > This is basically just pushing idea (D) further to remove the need for sleepable callers.
> > We surround the rcu txn proxy pointer resolve with both a RCU read-side critical section
> > and a hazard pointer slab address guard, thus protecting the use of the txn descriptor
> > with two types of critical sections. The resolve would run with interrupts disabled.
> > The "resolve" path of txn proxy is not a fast path, so we don't mind the extra overhead
> > too much.
> > 
> > On the "remove" side, we typically have plenty of preallocated rcu-txn from the slab.
> > In the common case, we keep using RCU deferral to free the rcu-txn in batches. This
> > would implement a custom per-cpu pending list to enable the following "stealing"
> > scheme.
> > 
> > In the rare cases where a user empties the slab, we move to a more aggressive
> > mechanism based on synchronize_hazptr: we "steal" the batched in-flight RCU txn
> > reclaims so we can fast-track their reclaim after a hazptr synchronize. This would
> > all be using busy-wait and the only contexts we'd wait against have irqs disabled.
> > 
> > The motivation for handling the steady-state with RCU is throughput (no synchronize_hazptr
> > on the typical "remove" case). Hazard pointers then handle the OOM corner case without
> > requiring sleepable callers.
> 
> Well it turns out that this approach has potential, but the hazard pointer
> machinery is way overkill for this. We can replace my use of hazptr above by
> a very simple RCU domain with the following characteristics:
> 
> - All RCU txn proxy resolves are RCU readers running with irqoff, protected by a
>   per-cpu counter (incremented on read lock and again on unlock),
> - There is at most one reader per cpu at any time,
> - We use a synchronize RCU on that domain on OOM for the pending slab reclaim
>   "steal" to do reclaim synchronously. This domain's synchronize RCU waits for
>   each CPU until it observes either an even counter or a counter transition.
> - We disable preemption across rcu txn (e.g. list insert, remove).
> 
> So we'd keep using call_rcu to handle the steady-state reclaim of rcu txn,
> but use this specialized irqoff RCU domain for the empty slab case.
> 
> Thoughts ?

Atomic SRCU within interrupts-disabled regions seems to fit
this bill: synchronize_srcu_atomic(), srcu_read_lock_atomic(),
and srcu_read_unlock_atomic(), which interrupts disabled across
the latter two.  Maybe srcu_read_lock_atomic_irqsave() and
srcu_read_lock_atomic_irqrestore() if that helps.

Or am I missing a turn in your requirements?

							Thanx, Paul
