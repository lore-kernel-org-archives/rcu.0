Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779745;
	b=i86OLESOl51kl+OG2AvzQF4dm03JRIfuFHx0tcsvukAbbsICPVBdfVmY7DaIJg3r8Ino
	 bnq1Mtv9clv8X/AMd+KImTspuXZ7u0RJljDwUipRPRZL9g4SUCJ0R5DjjKtoEiVNXOvTX
	 +/QxCqxwc1E7Le8VV/5LVU6KtCw47VvxTzqmmEn8y5vXFZKHS7lYgywpYWVG6Dzhul5re
	 65eqtZTHaBonukqRCni3UwL24sEx36CauHBC5G3EZxv0DdePS4Y4jQS9iCSB/hjdVOaNS
	 vnhq+sxES3pENkGkDV8nTygEl2spu7MSQBIsppz6J6gM+M+EnyQeGm9QGp4jK0KrVrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779745;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qLBEA3IgI4XTPumsnhBQHTB1cXAT03yZyuWvtNNcbL0=;
	b=e8YdQA46lDpqHRUPbCTHbF6yx1fzfqY8YHBL0jsCnbJG5feLkbjDJO9s2lUi8ZBM3XEd
	 yse+Cu8xmUx21gp01tQhcDS2T9v9VDQslXiNk0ELKNJQzyXx9PlGinmvMXqgR9GCBmN9L
	 7w9D+5Jv8Txc8GYKJFNpJDCuSBVCEDU1+bMwozlPoUmEo4GZvydEA0zafooCvqZe1E0da
	 nPBbMUNvMwwQw+G/Rh50ISuQtLTbOOrOXqgd/nHyIF3wfXiSnP4mCN7BeQilQ0tLYhcy9
	 nUSxIJi2hd/LmGxOJzJwA/YJEAtC7NpYeDhaL6ZO3FJvhWOzIoZRvw8cTf+LN7sJ5Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6OKWuLe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE49606A31B;
	Fri, 23 Oct 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6OKWuLe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855651F01825;
	Fri, 23 Oct 2026 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779744;
	bh=qLBEA3IgI4XTPumsnhBQHTB1cXAT03yZyuWvtNNcbL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F6OKWuLeBlKvKRXtL7qNr6Lo8UeR/Oy8YvRHqKs19fOH8KA3KTkXtDvr3xU5l8ABu
	 zAnvL51bkxhhIx/pmQA7iwQcqoAeXBFWCm2JlvSn+zlDUcB0Q+U8aaenzj3+MnbVgW
	 cdG5zqVZJFZqoeLrMECAZn4gaLbg08JmD7TzehDcDhTVYcL/csbVU7Tgn7ytxkYfRP
	 0ew9DeruXpu/wqTWbXPeZErEkk1E6/DaFAHuYOk+xOqMLWiV9h03I9KmyyZ6PNWwaV
	 FZ0ZD9qw8W3T6Ch3qc9IDe95YvBitWk7DQQhcG9Jcc+ZcilyNqt/GE5BqgknXxJ+yw
	 fZx2f4el9uqUQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org,
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
	Lorenzo Stoakes <ljs@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH 01/12] rcu_txn: Add single-writer RCU pseudo-transactions
Date: Fri, 23 Oct 2026 11:22:10 -0700
Message-ID: <20261023182218.479327-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-2-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com> <20261016133319.433617-2-mathieu.desnoyers@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 09:33:08AM -0400, Mathieu Desnoyers wrote:
[...]

> The records and the selector live in one descriptor, allocated with the
> gfp_t given to rcu_txn_init() and freed with kfree_rcu() after a commit
> that installed proxies.  A descriptor that installed none, after a
> commit of one record or a cancel, owes no grace period: it is freed with
> kfree() or, on PREEMPT_RT, with kfree_rcu(): rcu_txn_commit() and
> rcu_txn_cancel() may then be called under a raw or a bit spinlock on
> every kernel, as a hash table with hlist_bl buckets does.  An allocation

This isn't quite true on !PREEMPT_RT.  As far as lockdep is concerned,
kfree() can't be called under a raw_spinlock_t on any kernel: once the
per-CPU sheaf is full, SLUB takes barn->lock, a spinlock_t, and
PROVE_RAW_LOCK_NESTING flags that whether or not PREEMPT_RT is set.
kfree_rcu() gets away with it because mm/slub.c annotates its sheaf
path for exactly this case (kfree_rcu_sheaf_map); kfree() has no such
annotation.

[...]

> +/*
> + * Free a descriptor that installed no proxy, which owes no grace period.
> + * commit() and cancel() may run under a raw or a bit spinlock, where
> + * PREEMPT_RT does not allow kfree().  It does allow kfree_rcu().
> + */
> +void __rcu_txn_free_desc(struct rcu_txn_desc *desc)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		kfree_rcu(desc, rcu_head);
> +	else
> +		kfree(desc);

A single commit rarely trips it, since barn->lock is only taken once the
sheaf is full, and lockdep skips the wait-context check for the fast
path's trylock.  4096 reserved one-record commits under one raw spinlock
do trip it.  This is the series as posted, on arm64 with
PROVE_LOCKING and PROVE_RAW_LOCK_NESTING:

[ BUG: Invalid wait context ]
kunit_try_catch/44 is trying to lock:
ffff000001804318 (&barn->lock){....}-{3:3}, at: __pcs_replace_full_main+0x4b4/0x514
locks held by kunit_try_catch/44: 2, last CPU#1:
 #0: ffff80008080c120 (exp_raw_lock){....}-{2:2}, at: exp_bulk+0x1cc/0x2fc
 #1: ffff00003fda37a0 ((local_lock_t *)&pcs->lock){+.+.}-{3:3}, at: local_trylock_acquire+0x14/0x8c
[...]
Call trace:
 _raw_spin_lock_irqsave+0x60/0x88
 __pcs_replace_full_main+0x4b4/0x514
 kfree+0x400/0x43c
 __rcu_txn_free_desc+0x10/0x1c
 rcu_txn_commit+0x54/0x11c
 exp_bulk+0x250/0x2fc
 rcu_txn_test_exp_bulk_commit_raw+0x14/0x20

Cancels give the same splat, and so does a loop doing one commit per
raw-lock section once the sheaf fills up.

Using kfree_rcu() unconditionally fixes it, and the rest of the suite
still passes (against the top of the series):

--- a/lib/rcu_txn.c
+++ b/lib/rcu_txn.c
@@ -73,9 +73,6 @@ static struct rcu_txn_desc *rcu_txn_desc_alloc(unsigned int cap, gfp_t gfp)
  */
 void __rcu_txn_free_desc(struct rcu_txn_desc *desc)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		kfree_rcu(desc, rcu_head);
-	else
-		kfree(desc);
+	kfree_rcu(desc, rcu_head);
 }
 EXPORT_SYMBOL_GPL(__rcu_txn_free_desc);

The cost is a grace period of delay before freeing descriptors that
never installed a proxy.  I'd take that over a wait-type override
around the !PREEMPT_RT kfree(), since it also removes the RT/!RT split.

This makes a few comments stale: the kerneldoc of rcu_txn_cancel(),
the comment above __rcu_txn_free_desc(), the two "no proxy: free now"
comments, the comment above rcu_txn_test_single_record() in patch 2
and the one above rcu_txn_test_commit_atomic() in patch 10, plus the
commit messages of patches 1 and 10.  On the other hand, the "Readers
and reclaim" comment, which says commit reclaims with kfree_rcu(), and
the raw spinlock paragraph in rcu_txn.rst only become true with it.

Thanks,
Puranjay
