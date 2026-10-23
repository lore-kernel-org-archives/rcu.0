Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779767;
	b=cyA1VdgZ9UD8IkSv6CO2y/gZGB82iWsnkYBzDq0GvXEu41Y0uRKmC/Id0LXfNrh84niZ
	 zr2GxwoWFQn69Mki/5OdHBRx933yJegzP7lCkmunFyov6Zo9P7qJ3ep9GRasHCmdExR5j
	 Mdor07owsU/cobp+HKwqkk7/qxcNvIq6L0Ag8E3iApy7q2+1xFTfV+3Ou/bSuFUuHLlvD
	 Y0y/mQ/MGV+Ehly2KDuLqLL9fuMs6Dtm2BJDc1RIZca+MttE8zcteLs1+0xjFS8LHChY6
	 nTCiDjES8nJzkferVmpG9bUWbwXOIaEnn9pUypZUfLwb8qgqSS4I+4HbEhJwAyn3Pyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lJY9ZhGrvJNDaz8g4A3YC4KMVFIsobuybhRgdKYZ8EU=;
	b=qRNV8aJrvnltcnpiOEJulTClmDUqjIcW1qgu9J/qyMwXiup9Q3a9dd8ItBSJUSyvDmUe
	 B9/gADLzNvQr21JV1BlQR0ErMD5FpUa1VlLPgal/hQagB8MhJoLSvQB0/BP8C5wnuKWTL
	 y4VfyZrKsXpiHvVIifhSL3WZVZtInq2Svet1PzoidTdyqsZdYA1FHnJYp1y9nR3sQeT0Y
	 6K/w2azJHTxennEdp6gicFBaINUp29432VfiSLXRarb1+fagPOS+LcPM9BqXqzwC/s3tf
	 B0WtT7gXleWvtd+6BtLLUtAdfXoLE5BB/l/280gAbZ35I8ZLjRqBru16irpCVypdb0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ0wrNft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C20606A31F;
	Fri, 23 Oct 2026 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ0wrNft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60E21F01828;
	Fri, 23 Oct 2026 18:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779767;
	bh=lJY9ZhGrvJNDaz8g4A3YC4KMVFIsobuybhRgdKYZ8EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQ0wrNftnvstPMduKFRvp/lGW2Ka3l+YI1rkhSe9uzIC6mSdoBgux8RHXKrfy/UIT
	 7okeDyBDyhnxcI3eiKKRtlQ9o83FHV4f1RJhUG/WMUdkW/GEyAqoAKGgvKSSq/jRjh
	 XObWVDtRnN4bai2z/x1hFawU6A0COcbQ5ti5MNMtXB+LIY8LdfQExKIyp8R1C++hb3
	 E3WUEuTCmrbmDigNcuUNnLPUD6NDb++bWDQS7q+Pf5KXYcQNuGT7Ew9q9VRlyl9MQ2
	 q10lU4A29SOuvfC/jHr94J+mImkzi7hxnPiHfqDtovj0h8flvN1hOXRq0eS1tZdpIn
	 5QypKYBdXZk/w==
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
Subject: Re: [RFC PATCH 10/12] rcu_txn: Test a commit from atomic context
Date: Fri, 23 Oct 2026 11:22:16 -0700
Message-ID: <20261023182218.479327-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-11-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com> <20261016133319.433617-11-mathieu.desnoyers@efficios.com>
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

On Fri, Oct 16, 2026 at 09:33:17AM -0400, Mathieu Desnoyers wrote:
[...]

> The test is only meaningful on a PREEMPT_RT kernel with lockdep,
> PROVE_RAW_LOCK_NESTING and DEBUG_ATOMIC_SLEEP.  It passes there, and
> fails as expected when a spinlock_t is taken under the bit spinlock.
>
> The last two cases release a descriptor that installed no proxy, which
> has to be kfree_rcu() on PREEMPT_RT.  They would pass with a kfree() as
> well: a kfree() under a bit spinlock on PREEMPT_RT was reported by
> neither lockdep nor the might_sleep() checks when tried.

This matters on !PREEMPT_RT too: there, a one-record commit or a cancel
under a raw spinlock calls kfree(), which lockdep can flag (see my reply
to patch 1).  The test can't catch that as written.

[...]

> +	/* One record. */
> +	rcu_txn_init(&txn, GFP_KERNEL);
> +	KUNIT_ASSERT_TRUE(test, rcu_txn_reserve(&txn, 2));
> +	hlist_bl_lock(&bucket);
> +	rcu_txn_record(&txn, &s1, T(20), T(40), TAG);
> +	err = rcu_txn_commit(&txn);
> +	hlist_bl_unlock(&bucket);

On !PREEMPT_RT, this case and the cancel after it are the two that reach
kfree(), and they only run under the bit spinlock, which lockdep doesn't
track.  The raw spinlock case only commits two records, which go through
kfree_rcu().  Even under a raw spinlock, a single call rarely trips it,
because lockdep only sees barn->lock once the per-CPU sheaf is full.
Running the one-record and cancel cases under raw_spin_lock_irqsave() in
a loop would catch it.  That is probably also why the kfree() you tried
on PREEMPT_RT went unreported, though I haven't checked RT.

[...]

> +/* Did the kernel report something since @tainted and @locks were sampled? */
> +static void expect_no_report(struct kunit *test, bool tainted, int locks)
> +{
> +	KUNIT_EXPECT_EQ(test, test_taint(TAINT_WARN), tainted);
> +	KUNIT_EXPECT_EQ(test, debug_locks, locks);
> +}

These compare against the state at the start of the test, so if
lockdep is already off, or TAINT_WARN already set, the matching check
can't fail.  I ran into that: once one of my raw-spinlock cases
splatted, the two bulk cases after it passed even though each splats
when run alone.  A kunit_skip() when PROVE_RAW_LOCK_NESTING is off, or
debug_locks is already 0, or TAINT_WARN is already set, would make that
visible.

Thanks,
Puranjay
