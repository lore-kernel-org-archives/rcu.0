Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779672;
	b=pQq2/6bNI//xNcVoi4Jein/uGBs0pY9tm0JqGyV464Gh67bRgGMWULOhrAeobY310hKw
	 6zvJEJpMDrRlzGxljKlskdnKbAVjW3ET2PACN0Kw0uhzsoxQ46NcsTcWqQ5G5zjdDLyaH
	 bo4SuaNjMxByw8w8OYE/ViSwyHpRxZWPkVHaKggnTWnyqKmPnDOtc9UwiS4pWgJXtY4q4
	 nyrD8jj3O2ugEpuzCXEkabAevO8xR/iD7zaLcF95JyId2jz96Bii5YPL5VvuCcx/aaLJY
	 EYcwMpQeQ7mSnXnCidt8H0AEz2Y/N+ug0iH10tH7QPNMh95S2stNglggHJKNjA4tboA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779672;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=niTs1UmncCqilvwQIDlJJH9SDdjUGf2VRQ6M6+17bCo=;
	b=TESUValG84vgae0cSHNPf5y2+w9vcSAFBShYpl7VNG8sFdyg0UhLtIBbNr9VW4a+xFfH
	 /x+6XR1JTIaAEeekl0nnXAE/+EK75/Kh4hbJpKLXDunUr7djiqxe0GdSbNx8vWBrzDy7U
	 U5v+iCZUx7UneQgUZzKP//ieF5R2tRyQ2jYe4VxspwCK6Ijp7yOaU9bP8e53ELZ/PL3lj
	 ZM9yAgz7a91XvvIBTZHaRVSr+3DHur+oXIqisgf7Kxo002hVuK914Q+cDGdW58HV6BLhz
	 NPfPgVFPkog1hhOwKXQpGva5EWU894sdd2tyYZoUofieLSYFDJQ/yZlOx+4vyAry71w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YbELc/1y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42A606A31A;
	Fri, 23 Oct 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbELc/1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261831F01825;
	Fri, 23 Oct 2026 18:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779672;
	bh=niTs1UmncCqilvwQIDlJJH9SDdjUGf2VRQ6M6+17bCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YbELc/1ygpM9brsyBNml03IWTMVN9/UUrjR/FDEhcdzmgqPBeeNLkK9E66whpIwfZ
	 QQ8dX+9tETQq3t1Gl6tiCuqCho8LdbDAwfWXhjqC3HhTMo5g/iAFKJrsu0cntLdZtg
	 mFhSolt5UcDKXJ/7b3fH6BxzH+ldZfPB/fkkeXyXIc9w20EOOWv1tVv5xszgO7pFp2
	 xCH1AAgWNlKGBdcgvsJqAdje7uWJGSR+ZqbsbccWZSmoagDwDX1C0g0bv8YUaEpqte
	 qKHl76cIBUE3vokTJOOyeIhDhyRSBE0Uls3eKryTkYpM7SxxB3zb3g1ZBhTUzO3f7M
	 DUKL6vnZhG4BA==
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
Subject: Re: [RFC PATCH 00/12] RCU pseudo-transactions
Date: Fri, 23 Oct 2026 11:19:39 -0700
Message-ID: <20261023181940.457424-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
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

Hi Mathieu,

On Fri, Oct 16, 2026 at 09:33:07AM -0400, Mathieu Desnoyers wrote:
> I'd specifically like feedback on:
>
> - Where this should live (kernel/rcu/, lib/?),
>
> - Naming and API shape (descriptor + records),
>
> - Whether the Bloom filter threshold should be a config knob,
>
> - Subsystems where this could apply.

I went through the series and ran the KUnit suite on arm64 (QEMU/KVM)
with PROVE_LOCKING, PROVE_RAW_LOCK_NESTING and DEBUG_RCU_TXN.  All 59
cases pass, and herd7 agrees with all 21 litmus tests.  The
install/flip/settle ordering and the descriptor lifetime look right to
me.

I found two bugs, details in the replies to the patches:

 - patch 1: a one-record commit or a cancel frees the descriptor with
   kfree() on !PREEMPT_RT, which lockdep can flag as an invalid wait
   context under a raw spinlock;

 - patch 3: rcu_txn_load() on a consumed handle with an armed Bloom
   filter dereferences a NULL descriptor.

Moves in patch 6 can also make a reader skip or revisit nodes, or loop
in another list instead of terminating if the node moves there.  In
patch 5, deleting a node twice can silently corrupt the bucket.

On your questions:

Location: either works for me, but CONFIG_RCU_TXN is in lib/Kconfig and
CONFIG_DEBUG_RCU_TXN in kernel/rcu/Kconfig.debug; I'd keep them
together.

Naming: no strong opinion.

Bloom filter knob: I wouldn't add one.  Outside the KUnit tests, the
only transactions that reach eight records are the mutex sample's
evicting insertions, which reserve 32 records anyway.  Meanwhile the
room reserved for the filter pushes descriptors of 8 to 10 records from
512 to 1024 bytes.  I'd drop patch 3 until something needs it.

API shape: every rcu_txn_list add, delete and replace allocates a
descriptor and frees it with kfree_rcu(), so all of them can fail with
-ENOMEM, delete included.  That is hard to use on teardown paths, and
reserving first only moves the failure.  Since a descriptor can be
reused a grace period after its commit, have you considered a small
cache of them, tagged with start_poll_synchronize_rcu() and checked with
poll_state_synchronize_rcu()?  Separately, a one-record transaction
never installs a proxy but still allocates a descriptor, 256 bytes
unless reserved smaller; keeping the first record inline in struct
rcu_txn would avoid that.

Subsystems: in dcache the hash buckets are hlist_bl, with bit 0 of the
head as the lock, and d_unhashed() tests for a NULL pprev.
rcu_txn_hlist hard-codes bit 0 as its tag and has no unhashed state, so
I'm curious how your userspace port deals with both.  Also, the only
in-tree user of list_bidir_prev_rcu(), kernel/nstree.c, walks either way
but never forward and then back in one walk, so a user that needs that
guarantee would help make the case for patch 6.

I can send my KUnit reproducers as patches if they're useful.

Thanks,
Puranjay
