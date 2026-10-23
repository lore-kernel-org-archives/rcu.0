Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779763;
	b=NcI7+on27WeKedxizoTKBo1SV0S7F0FEvBjiIyQnjBBxdkPvi5zeXOwXPETCu4THRjRp
	 6wf2sRx2Nb+TXN+gbQvxmZhzdPzSGcAiOxlzvDJm6cWAD8rcIicXUwbVWRZri5d6cHdYh
	 R4Kv+iFyCzlUA3v8KPaUQCXsCvtk1XV9BH2jlyD9+MuVnB5RNGk0+dSK7RMnCgEAcDP+d
	 +/7s5li6eMCt3LNWXq8ewNgmY1owN/f1M7DppOzgyV7MwHqaaW0lz/V8HB8nZVoZD3VDS
	 WsESIULnM5GRI02kvNu/qWmX5wz0aEmwaAzdBV6OVTRhBSLyJBHbvqtwAGBB8+NKe4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779763;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yYq10eYq/2sDfCrmy2T/D5Xx4pO5Ls6Vz/IH1WaR3gI=;
	b=VS8Ob9SOCxqdxLvK2tiHQv6n8C7R3wNuqsadiylZBZmjcVBAnaHp0+iiXiM2PARX+HD/
	 2gQRBYC0SvgkQNB0clN3/pkrX3SILqi0WqXGACn55oEQNW5rxH5oTMT5uu+HvT8EjiNiI
	 lGDcF1YtvbRbACCFbJxP5bhNbKulnu1WWn/Q/F0cr4u2DzC/sgrHmE2gniZJb2IMqaMEB
	 0nin1cga1f2MU6Mn0PLY5YLEZl8k7zKWYaJG3M/l5R1UIXr69yYykBa91DXW3YY/GkJuZ
	 DH6Jv0Dl/4gOkg9CPk/fUxNsmMj5oowl1kZ5F04btLTMpuKWMAytOfq11E6i33m2Uqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFRaPYt8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE63606A320;
	Fri, 23 Oct 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFRaPYt8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166C21F031E8;
	Fri, 23 Oct 2026 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779763;
	bh=yYq10eYq/2sDfCrmy2T/D5Xx4pO5Ls6Vz/IH1WaR3gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFRaPYt8MZsyIUMP3op10Mh/0o9j3kQI4fwxEc1FUrKdE4HORbaf9twRyEVmDUCbx
	 zSbEMp5Z7siIgbPFmZkgIDyerXBALDXU2sF7KPvSZmk311xCvOqJ3cWHPFn9FWvTyG
	 6/KuL7PTNKNmOvyAXS/5CYD5UwiKINvqXmj0A3dnQLgBiWskhuC6YWIOFE4jbEw1qP
	 d2l7E7ByKfJiHziUNGrEJqkRwDSmeo/RSrYPMET5BlZtSxsFedLoynRwaoKl/Lxqcq
	 MpySb419LvJ/jJfkZngEtxQQE1QtzhyHuM/q51CFY502JLTTtGm32F06+6Fq/69jSa
	 Uzk5d2GS8271Q==
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
Subject: Re: [RFC PATCH 09/12] rcu_txn: Test a list writer against concurrent readers
Date: Fri, 23 Oct 2026 11:22:15 -0700
Message-ID: <20261023182218.479327-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-10-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com> <20261016133319.433617-10-mathieu.desnoyers@efficios.com>
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

On Fri, Oct 16, 2026 at 09:33:16AM -0400, Mathieu Desnoyers wrote:
[...]

> +			/*
> +			 * Invariant (2).  Skipped for the first step, whose
> +			 * predecessor is the head.
> +			 */
> +			if (insert_only && prev_key) {
> +				struct rcu_txn_list_node *back =
> +						rcu_txn_list_prev_rcu(p);
> +
> +				r->cross_checks++;
> +				if (back != &head->node &&
> +				    container_of(back, struct cn,
> +						 node)->key < prev_key)
> +					r->cross_violations++;
> +			}

In an insert-only phase, once a reader has stepped from A to p, A stays
before p, so p's prev can only be A or a node inserted between them,
never the head.  The back != &head->node exemption can therefore only
hide failures, and it hides exactly the tear this check is for when the
insertion is at the front: head->next == E, E->next == F, then
F->prev == head.  prev_key already skips the first step, so I'd count
back == &head->node as a violation.

[...]

> +	for (i = 0; i < CONC_READERS; i++) {
> +		readers[i].conc = c;
> +		readers[i].task = kthread_run(conc_reader_fn, &readers[i],
> +					      "rcu_txn_reader/%d", i);
> +		if (IS_ERR(readers[i].task)) {
> +			readers[i].task = NULL;
> +			ok = false;
> +		}
> +	}

If the writer oopses, KUnit fails the test and frees c and the readers
array while these threads are still walking the list.  Registering the
stop with kunit_add_action_or_reset(), and calling
kunit_release_action() where they're stopped now, would avoid the
use-after-free.

[...]

> +	for (key = 1; key <= CONC_KEY_MAX; key++)
> +		if (c->live[key])
> +			conc_del(c, key);

A failed conc_del() here leaks the node without anyone noticing.  The
readers are already stopped at this point, so the leftovers could just
be kfree()d.

Thanks,
Puranjay
