Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779760;
	b=5N3pTRTubqHY+z3tA+fuU1Za7+oWM8zBqUCRY1bUhCc+bWrWjB4+dwb8pMYF5d8ANVMv
	 Q+jVEYIV3hVTihQK4vRCVRtoREC0+UUHOi7WnShK8UjA+WKdmUOw0wU+SgW0PMu1M0Hyz
	 2ItTXCHulGZ1nKBbBRC9zFSrdvAEjIwV0Xh/kLoCwfx62L48Mcm0Z0GcvdUCf+SNr8xGx
	 AKPYAc9moc3YbYhMFhJaA0JYNBX+1ShmNESkF0JSXw1KWdQQRuligubqiOpwaCwwr1Zwf
	 58RoRcObEfOqnueQ2HOaOHavFytUfOg045Pi4dy7swh7PfKlkiUQgAy1723jx1+m7kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779760;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6SXiqpe6w+67sdJ4QQlvuBS0/A18+RKyVDMsnp0My1M=;
	b=4mgaCGUJANWhrmPKdLil6lisQICzTrE5iuGREURy5zPfrKYoPAgJXwFunBMFxv54XSxu
	 EBa8I6zr3gTMKyfEfmR9IRiQMlEp50TCIrDziNq9T5T8wu3BG2/qt22+ChBG+kKq2Rvsi
	 1cqnTuDQs1JncXm3VIQhLjWFu0MhOgerOzoOq4t7zVwiRtfZCk2gbOK+8JiFwe586XWM+
	 YCefrGsaOVsYebZ1fs3lTPnUu37GKCsRHLWpBHCNqRarAAP8db7sweupzOxSEYjYIayOu
	 2mqWzOfThJBwx6L2e1Nx9gdCoXl74YQ5vpVQY/lpq/CI6lDh4KpNwhwWzKj0s30jN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JfrI/I1h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC8606A321;
	Fri, 23 Oct 2026 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JfrI/I1h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0921F031E3;
	Fri, 23 Oct 2026 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779759;
	bh=6SXiqpe6w+67sdJ4QQlvuBS0/A18+RKyVDMsnp0My1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JfrI/I1hiCPjwlVIUvTxEjlxrkLABrRPIHYoOchnn0aSskGeUWJpuXk4tqbVbkVcl
	 Qr56q7u8NKQBBU3wrQ/2i4ccgcNzffHPsNu9Hjdo0P1PxJKatXS7yh+AxEHSJhOxDp
	 AZmoqscU7qELqiTOvw9yGW8xf4X50Fdhv9nJYUST72jIvVsEmmI8ZwPUTYYdrepUN/
	 dEUWa0LGkZcGOE8ov++OWjsNp3D/X7x8wihj02aZfp0UvRUNkk9apz/KqPFdqpJClD
	 Jv7lXDzcF1Ff2iBmTeJEtA3cxWMP0feznijqS7RI3Zz3vnWVhktschyCEvBmxYlXWk
	 HKAgIS/7JiyTg==
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
Subject: Re: [RFC PATCH 06/12] rcu_txn: Add a doubly-linked list coherent in both directions
Date: Fri, 23 Oct 2026 11:22:14 -0700
Message-ID: <20261023182218.479327-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-7-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com> <20261016133319.433617-7-mathieu.desnoyers@efficios.com>
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

On Fri, Oct 16, 2026 at 09:33:13AM -0400, Mathieu Desnoyers wrote:
[...]

> +/*
> + * rcu_txn_list: a circular doubly-linked list whose forward and backward
> + * chains stay mutually coherent under concurrent RCU readers.  A reader may
> + * iterate in either direction, or reverse direction mid-traversal, and never
> + * observe the two directions disagree.
> + *

This overstates it a bit: a reader can read P->next == N and then, once
an insertion of E between them commits, read N->prev == E.  The commit
message puts it accurately ("never finds the new value of an edge and
then the old value of the other"), so I'd use that wording here too.

[...]

> + * See rcu_txn_list_add_after_prepare().  Six edges switch together: the two
> + * that unlink @elem, the two that link it after @pos, and @elem's own next and
> + * prev, so that a reader standing on @elem leaves it by its old neighbours
> + * until the commit and by its new ones from then on.  The add forms cannot

That has a consequence for iterators, which should be documented: a
reader standing on the moved node can skip or revisit nodes that never
moved.  With H -> A -> B -> C, a reader on A when A moves after C steps
straight to H and never sees B or C, and a reader on C when C moves to
the front walks A and B again.  I checked both with sequential KUnit
cases.  LRU second chances are exactly this pattern.

[...]

> +/* Move @elem to the head of the list (just after @head). */
> +static inline int rcu_txn_list_move_rcu(struct rcu_txn_list_node *elem,
> +					struct rcu_txn_list_head *head,
> +					gfp_t gfp)
> +{
> +	return rcu_txn_list_move_after_rcu(elem, &head->node, gfp);
> +}

This looks like list_move(), whose kerneldoc is literally "delete from
one list and add as another's head", and nothing here says @head has to
be @elem's own list.  If it isn't, a reader standing on @elem follows
its new ->next into the other list and never gets back to its own
head, so rcu_txn_list_for_each_entry_rcu() never terminates and treats
the other list's head as an entry.  Either document on every move form
that the destination must be in the same list, or give readers a way
to detect it, like hlist_nulls does.

Thanks,
Puranjay
