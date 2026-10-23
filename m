Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779756;
	b=wCq7roSjntbye0zMji3bXD9sNapXP4qMQyzvAKP2vr3d4NF15da0suOBWztD8lIY8t9h
	 mQjzaGEzWG3l0N0XAkKWD5PJEVQby5VCwIGSLM0lkl3ELyAuF9P8cuLq9B1dnE5FprI7g
	 yaCCpCwc60jvXV3I9Y9/HsT4vBM++QC3O1UGpjNCyn1OMvw24GNVObUCZvnGA58Tw31G3
	 4XAe1kPG6foM6+g9w4vfOTPhIpy0aI9wY4qmTgVWPEcjQho/vSM1anB1iKUSMbdVPvjmS
	 C2ejxD6qTSaqvB3IL37ifwatszsJ+7koKmNQF5cC72+ycTPmvapEptrHM8tLCt39ktg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779756;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8fNDUJmW+BqiGz1BXZNGCbbtDikGNmxpdsyN7sK/sCA=;
	b=YJ2OOoAhG6oPX1AMhQ/GhhEVSYiUL6hGcOlZ/9+Y9NNN6KSfO8YOeGXJ4KlrBMik9uYo
	 DsMJG7Pz6OMPrVc3gdK5maOHDEZyMWSzmTmr7QBXDEVNx2Qyasp8vb5eJImtc47ckEn+D
	 OUWjI8xaWP1rCmFoeV8hJfd8lfqlTwlW3x9YHtsfBLZNGMCnKDhwgCvmynP/61N+NnMiK
	 dkFxwBmd61HWXN7wub57dKsgAHIF40karHnvK02NJRFe+mY+xiF1oKpqojIDz2U3ajrn2
	 7NBsC2sB9VO8o87WHHO/ZAgiknLp4/mTF2Ew1jShL1lIbhFKL/a+SZL8GU0or8DS1tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeZAsJ44;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A970606A322;
	Fri, 23 Oct 2026 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeZAsJ44
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6361F01825;
	Fri, 23 Oct 2026 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779755;
	bh=8fNDUJmW+BqiGz1BXZNGCbbtDikGNmxpdsyN7sK/sCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EeZAsJ44WMwEbGTdY400Waqq18i7SJ+8+oje7d3M9uY5aVibaGKuvr0PpgwPT2eXC
	 nIxxEjjDHKBHIluPWWAbYall4+G/fzMmLiPoNAH4Db0BPdfOCSm+8klOIigeph2d37
	 b1s3kCOSvNYT2y/dEM2ddqOUrghhXT2mRTuhFp9vy0PXc1X9DEJTGfoQvFGDvEuy+R
	 CEwX/HY8clKgEzCFS/3bX9h7aFC9LOtgjVsPCMh8bMTGbKViqFbNpGtV/bJZ/es6O/
	 P0Uerrqf4sZGMx4gzu8b02xTL/Nj0vuvFmIUuN/BUBT9LPKpRX9rP5rgaSoSZACT9V
	 vehic5XJrQG4g==
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
Subject: Re: [RFC PATCH 05/12] rcu_txn: Add an hlist edited through transactions
Date: Fri, 23 Oct 2026 11:22:13 -0700
Message-ID: <20261023182218.479327-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-6-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com> <20261016133319.433617-6-mathieu.desnoyers@efficios.com>
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

On Fri, Oct 16, 2026 at 09:33:12AM -0400, Mathieu Desnoyers wrote:
[...]

> + *   - Every node an operation is anchored on must still be in the list as the
> + *     transaction leaves it.  A single-writer delete leaves no deletion mark:
> + *     nothing in a deleted anchor distinguishes it from a live one.

[...]

> +static inline void rcu_txn_hlist_del_rcu(struct rcu_txn_hlist_node *elem)
> +{
> +	struct rcu_txn_hlist_node __rcu **ppv = __rcu_txn_hlist_pprev(elem);
> +	struct rcu_txn_hlist_node *next = __rcu_txn_hlist_load(&elem->next);
> +
> +	rcu_assign_pointer(*ppv, next);
> +	if (next)
> +		RCU_INIT_POINTER(next->pprev, ppv);
> +}

hlist_del_rcu() poisons pprev, so a double delete faults straight away.
Here pprev keeps pointing at the old slot, so a second del_rcu() quietly
overwrites whatever that slot holds now with the node's stale ->next.
For example, 1 -> 2 -> 3, del_rcu(2), add_behind_rcu(4, 1), del_rcu(2)
leaves 1 -> 3 with node 4 gone, and nothing warns, even with
CONFIG_DEBUG_RCU_TXN.  Had 3 been deleted and freed in between, the
second delete would link it back in and write to it.

dcache relies on d_unhashed(), i.e. a NULL pprev, which __d_drop() sets.
Could the _rcu delete and replace clear pprev the way
hlist_del_init_rcu() does, and could there be an
rcu_txn_hlist_unhashed()?  For the _prepare forms, del_prepare and
replace_prepare could record pprev -> NULL through
__rcu_txn_hlist_record_pprev().  That costs at most one record, though a
lone delete or replace of a bucket's last node would no longer be a
one-record commit.

Thanks,
Puranjay
