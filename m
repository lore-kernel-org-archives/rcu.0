Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779748;
	b=i3nXejwUkgpQ1dYFbFOpsjxJmHQEbGsj+cxUqr28AgHvA/+TonD+sI/kKjrvdev18Wkh
	 tGUKANPJa//zdeAvlpiCmt0iuGwa3k88ZNv0DhYrW3Clt5kJpl43Gz13P1KRtG6Covdry
	 ZZ7OnfpV2XWe4spSeTb2EoJXLy71dJoCP0AbwkQhEfcqyV/ZZfb9+eYwCW4N3YzYstqo+
	 RVURuc4StqTuk8qjVADMOo0rwPOSLs3zuVFGqYUfXuOL37FBLXpioiRihBdNfWJ78JYBh
	 caTlL4dJCqMkYxBn8ZsXzfpDaEEYx1myR6Hy32H7KIsja0dg+Viduk/hDBOD/AzjI7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779748;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lsntJsiTyy3OriNg+ZEE32mxY1k96gDWsFX7uwnPOFw=;
	b=O89lJaSMGJJj6FMbFJoELismV6N+vKDx1VBttCbMOCN38CF4ROGL2f+AHUwx9Z5JE/Rd
	 uJhW8i0BQx00eWQBGjTs8GvtWQYTvxy5UZsGi+Z5U9hXfJUHdlRFEj+uw8JQD9Q6mOcMY
	 7zsR/5ORLFPBqHhWZHThaIFFxS50GO2HwyW3gWTH9U5DDYl3CWWXeFZvvZFPU9Uol0bza
	 DC0doqMrKIyFKRyqcYsAQzALf4YcvapCf8qPU5tK8ew7C9vTksF2I7oGJETsQ+aODiqIV
	 qg+3mYYtbIVA899sRzC1lQNBN3komHZk9901Pve91JGQq5Ft2lL4V0PDxzxFft1FjWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpTCKLrO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531FD606A320;
	Fri, 23 Oct 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpTCKLrO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1EB1F01828;
	Fri, 23 Oct 2026 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779748;
	bh=lsntJsiTyy3OriNg+ZEE32mxY1k96gDWsFX7uwnPOFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpTCKLrON0TCyBcBH8zDOtasq4INs+K52fZy0lKF9yZ6eJouDVTIwjC0fe0NMu1M7
	 Zy8bEFSfdWYbinrQDO28Iy7RXI9uQbRxBNgZtIc9qwkm9nyYWmg/p9MQlJ3CTMGQ8l
	 PaiuddZbwh3piMahX76h5pyt+cdn+3wSOiOpLAC2MF9jIPF5W2q3kojaqw8jWdvl1y
	 yU5sXNHbhcMrO/J7IF0N5KII/YsWWpF8xQXh5IixyVRiTSktqlrXx7E1BTVwvtIFKm
	 HNYqL2DRkiBKu/1VIriEP6HfqpzWIZkSyG03Wv30STAayhI5dCnn7sCu4IUOAHSDgH
	 x7yC6UWq7YUwg==
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
Subject: Re: [RFC PATCH 03/12] rcu_txn: Skip the record lookup with a Bloom filter
Date: Fri, 23 Oct 2026 11:22:11 -0700
Message-ID: <20261023182218.479327-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-4-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com> <20261016133319.433617-4-mathieu.desnoyers@efficios.com>
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

On Fri, Oct 16, 2026 at 09:33:10AM -0400, Mathieu Desnoyers wrote:
[...]

>  	/* A consumed handle has no record left: it reads committed values. */
>  	WARN_ON_ONCE(t->state == RCU_TXN_DONE);
>  	if (!t->disjoint) {
> -		r = __rcu_txn_scan(t, slot);
> +		r = __rcu_txn_find_ryw(t, slot);
>  		if (r)
>  			return r->ptr[1];	/* our own pending write */

This patch adds t->bloom_live, but __rcu_txn_done() never clears it.  So
on a committed or cancelled handle that had armed its filter,
rcu_txn_load() warns about the DONE state and then dereferences the
now-NULL t->desc in __rcu_txn_bloom().  Recording 16 slots through
rcu_txn_load() and rcu_txn_record_chain(), committing, and then calling
rcu_txn_load() again gives:

    # rcu_txn_test_exp_consumed_bloom: after commit: desc 0000000000000000 bloom_live 1
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
[...]
pc : rcu_txn_load.constprop.0+0xfc/0x284

Patch 7 says misuse of a handle warns in every build, so this should
only warn.  Clearing the flag in __rcu_txn_done() does that:

--- a/include/linux/rcu_txn.h
+++ b/include/linux/rcu_txn.h
@@ -615,5 +615,6 @@ static inline void __rcu_txn_done(struct rcu_txn *t)
 	t->desc = NULL;
 	t->records = NULL;
 	t->nr = 0;
+	t->bloom_live = false;
 	t->state = RCU_TXN_DONE;
 }

[...]

> -	size = kmalloc_size_roundup(struct_size(desc, records, cap));
> +	size = struct_size(desc, records, cap);
> +	if (cap >= RCU_TXN_BLOOM_MIN)
> +		size = size_add(size, RCU_TXN_BLOOM_SLOTS *
> +				      sizeof(struct rcu_txn_record));

The room for the filter costs more than the filter itself.  ksize()
after rcu_txn_reserve(n) on arm64, against what patch 1 alone gives:

  n        this series           patch 1
  6, 7     512 bytes, cap 7      512 bytes, cap 10
  8..10    1024 bytes, cap 17    512 bytes, cap 10

So transactions of 8 to 10 records now take 1024 bytes, even on a
handle declared disjoint that never arms the filter, and an unreserved
handle gets there on its fifth record.

[...]

> +	for (i = 0; i < 64; i++)
> +		rcu_txn_bloom_set(bloom, &bloom_slots[i]);
> +	for (i = 64; i-- > 0; )
> +		rcu_txn_bloom_set(rebuilt, &bloom_slots[i]);
> +	KUNIT_EXPECT_MEMEQ(test, bloom, rebuilt, sizeof(bloom));

This can't fail, since OR doesn't care about order, and it doesn't
exercise __rcu_txn_bloom_arm(); rcu_txn_test_bloom_arming() already
does.  I'd drop it.

Thanks,
Puranjay
