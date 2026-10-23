Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779752;
	b=GMlFRA1Y9tRNSGVMj97XorIbzwzFNel/9bzzZSBOQbQp4Qymnzh0gU5LAgyvBrJlF8Vs
	 wBurDvQhjiWJmjwlVAi/6rux2TyA4XQdmgrVZVLTrRlAcboXxSV7DT5jNeYy/6WzH17IL
	 2AYbxUaSfbb0tdL1v1BqTbAIj6eaGlXOgmm2S/MQ4mOVvPd45WRVhEJuF5lbdtlhslHBM
	 M5pTIKdy8s1aE7FCrC5FAj2GRICltaGsxKe0fefZB+sq5xvhTf8pP9zk5Il+yPW3jXugL
	 wRIHkLvDbewUBzro7I6e6Z5Uz/bYY68RdfivUqz/Eg3xTiu0cQYk4jEWMUW9rUx1ISQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779752;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ux8gxm/hxbCvtY7jdFuUJx87hpOn03D8mRXv9n3JWCY=;
	b=EulUCN7rLycjBkjLfPmuo9W3RLyOraoGZ6HS30icUCMG+kQ5gzx6nxg3sFMOrA8kihfA
	 nfITKPxur0HnBgPsiJhRpCK8p2+334chKdW1ILBLGH0VI1qGGqpW24Npd2JJTyovs2bi5
	 XbM3ld8tFBuP8T6VECZSA/jMMmfYDj7a8isr8hChqaHqvyysyy6ykrNkqWsp1OrwW3N1G
	 wOtyh142HrBc3TY7OSd2ETE6dTOUh7Nzx6HZWkSgkWI/rNbq0nB2qWE8DC8DMdwOzSUdn
	 wQnUjLoOkPLZ6DLdEUb1R+u1jprhWb5mfI9t0hhP1EqbNJJIe9oJ0ZKJnGU/sCYzEYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs9OrPq2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A1606A31A;
	Fri, 23 Oct 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs9OrPq2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB69B1F01825;
	Fri, 23 Oct 2026 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779752;
	bh=ux8gxm/hxbCvtY7jdFuUJx87hpOn03D8mRXv9n3JWCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vs9OrPq2oETYyq5xseqQeXyIhroI29AKaUP7j3arF+VVUb5WiBov9P0RKHbix/5c0
	 eV/Sm00XpELM+IEu8GRuCJKWWdP4UA8bAUnAP9n/kac9U8iBDBAZAVaIyWtCTN00l2
	 dVkK3XWPddPisYYTpseZIp4lJcaYecihYULEEAcGwPfe0/6bemeTbhpB7hpuEZZ/AL
	 JLxDM4pHpmtHbl1/K8I+raleVd0oxir+TcC4TBKV7TMDCRAxRseprnXrGWe+ivbmxr
	 GSwI7qhYAACptVMQOEWRFdgGrJTCn3ZEcoabPt/N0PzuBu6LylxkCEYlKTHtt1rTCt
	 DheUevjFpL+hA==
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
Subject: Re: [RFC PATCH 04/12] rcu_txn: Add CONFIG_DEBUG_RCU_TXN
Date: Fri, 23 Oct 2026 11:22:12 -0700
Message-ID: <20261023182218.479327-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-5-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com> <20261016133319.433617-5-mathieu.desnoyers@efficios.com>
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

On Fri, Oct 16, 2026 at 09:33:11AM -0400, Mathieu Desnoyers wrote:
[...]

> @@ -261,6 +291,7 @@ static inline bool rcu_txn_is_proxy(const void *v, unsigned long tag)
>   */
>  static inline struct rcu_txn_record *__rcu_txn_untag(void *v, unsigned long tag)
>  {
> +	RCU_TXN_WARN_ON(!rcu_txn_is_proxy(v, tag));
>  	return (struct rcu_txn_record *)((unsigned long)v - tag);
>  }

This can never fire: the only caller, rcu_txn_resolve(), has just
checked rcu_txn_is_proxy(v, tag).  I'd drop it.

[...]

> +	RCU_TXN_WARN_ON(__rcu_txn_holds_proxy(old_ptr, tag));
> +	RCU_TXN_WARN_ON(__rcu_txn_holds_proxy(new_ptr, tag));

[...]

> @@ -715,6 +893,9 @@ static inline bool __rcu_txn_chain(struct rcu_txn *t, void __rcu **slot,
>  	r = __rcu_txn_find_ryw(t, slot);
>  	if (!r)
>  		return rcu_txn_record(t, slot, old_ptr, new_ptr, tag);
> +	RCU_TXN_WARN_ON(r->tag != tag);
> +	/* The caller must have read its own write. */
> +	RCU_TXN_WARN_ON(r->ptr[1] != old_ptr);
>  	r->ptr[1] = new_ptr;		/* committed old preserved */
>  	return true;
>  }

The append path checks new_ptr for the tag, but the chain path doesn't.
With CONFIG_DEBUG_RCU_TXN, chaining a tagged value onto an
already-recorded slot of a non-disjoint handle and committing gives no
warning, and leaves the tagged value in the slot, where every later
reader treats it as a proxy.  Passing the same slot, value and tag
through the append path warns once:

    # rcu_txn_test_exp_chain_tagged: append path: 1 warnings
    # rcu_txn_test_exp_chain_tagged: chain path + commit: 0 warnings, slot now 0000000000000301 (tagged: 1)

The same check in the chain path catches it:

--- a/include/linux/rcu_txn.h
+++ b/include/linux/rcu_txn.h
@@ -905,6 +905,7 @@ static inline bool __rcu_txn_chain(struct rcu_txn *t, void __rcu **slot,
 	RCU_TXN_WARN_ON(r->tag != tag);
 	/* The caller must have read its own write. */
 	RCU_TXN_WARN_ON(r->ptr[1] != old_ptr);
+	RCU_TXN_WARN_ON(__rcu_txn_holds_proxy(new_ptr, tag));
 	r->ptr[1] = new_ptr;		/* committed old preserved */
 	return true;
 }

Thanks,
Puranjay
