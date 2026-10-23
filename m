Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779771;
	b=nF9NSJLvIK4usSZFhduXgh2Hj2YPHh/nTSuQ36UcG2ZnNt52tQRwuUfY89eZ9OaTZ6LS
	 UupmWEvNaw2cjiqH//k3GUBwB5Wtw+LQrQq17TJYZqJDvg06LZgqeeRIPXQjO1riBiDKS
	 SD5CiqNS40TW+/tV3BK3wr8t5B1uSry6FQ+1Y4nQcT5TlMT7vr/+KgP4wGeHKzp7HEFx0
	 F0ND2RgqjIMPrh+OzyI2dJ48QtW0MagJco4dTyIw/QvdBx28MmgQ0jBFQyATAfsjy1KFk
	 pMKKY3P9OgKpft+j9K6/JQ60P9W2FHxonD4jzjUuKXHgplOAB69Sn72YfLWFFGD/kbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zNgvRqEwNDdSIYPf4jbzPDLOK2oWn7WXDcf5UXvEQ+4=;
	b=LnxVTg0pFdhvuLdgCaS2PfcEC+t5FqV7kSw4ufLYxfyMznWn9KK0f2Vh3BD0334UNm2p
	 msCjA//RtDa559awkq2NuwUdMUjHKXPCprU+fsjnvJiilQVupBBTFZGAbSWhaUn6QKkGq
	 Dy+o+tnTEvtSDazbK8x+xtqbnCdX+PzRwpl61tjju1L5BlMPL01EecLKt2/bqfBgW85c7
	 Jw+PW9tqcRj+9yjwGpeojZZx6c+JLaBufEWOBX65N+pggk0fBFoI502TpFXlyKXsCoddn
	 9Wb3/Gn4RLPjPnVDGVrknvDBM27+6ZnsHIqHissUrLIITKVDS5bdpmew+F860eVfiVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQjzQfD7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D45606A31A;
	Fri, 23 Oct 2026 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQjzQfD7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21611F031E2;
	Fri, 23 Oct 2026 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779770;
	bh=zNgvRqEwNDdSIYPf4jbzPDLOK2oWn7WXDcf5UXvEQ+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQjzQfD7AMVcx+96y/2v8XoWsgktFFTVb1OWHrf3CoTeqD64COap/MzBUUbxq5gaS
	 efev38Ue/psZMZIuGkcXTerWQS2lxxJXvt62Zcq4Z7SpFQ3b68UU8BWOG3EfDg05bJ
	 SKH3fKSQ6HrGiMB2IwcS4OxIaqeDDdQBPkeUi5MIoZOmwU/Iybds8X8xesSMTsOFFg
	 3Br5W3Me9pSJenqtRjHiDumS8hSX6GIgCJ2xEOEWgWnYwTzr1xnfH+Ot7A25+MkKdO
	 jybiXiAprrDIp3RFW9RXUClz/+Bs99UL+ARo+tKRtUltbD8Wq3+2YeNBprwdik6jat
	 LS+ZCdStUeLyw==
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
Subject: Re: [RFC PATCH 12/12] samples: Add a cache on RCU pseudo-transactions with a lock per node
Date: Fri, 23 Oct 2026 11:22:17 -0700
Message-ID: <20261023182218.479327-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016133319.433617-13-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com> <20261016133319.433617-13-mathieu.desnoyers@efficios.com>
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

On Fri, Oct 16, 2026 at 09:33:19AM -0400, Mathieu Desnoyers wrote:
[...]

> +		rcu_read_lock();
> +		e = lru_entry(rcu_txn_list_prev_rcu(&cache_lru.head.node));
> +		if (!e) {
> +			rcu_read_unlock();
> +			rcu_txn_cancel(&txn);
> +			break;
> +		}
> +		if (chances < CACHE_CHANCES && READ_ONCE(e->referenced)) {
> +			WRITE_ONCE(e->referenced, false);
> +			cache_move_front(&txn, e);
> +			chances++;
> +		} else {
> +			evicted = __cache_unlink(&txn, e->key, e, NULL);

I think there's an eviction race here.  cache_lock_entry() re-plans
from e's current links, but doesn't check that e is still the tail.  If
W1 gives e a second chance (clears referenced, moves it to the front)
while W2 has already read e as the tail, W2 then sees referenced
cleared, locks e at the front and evicts the entry W1 just saved.  Only
the policy suffers.  Checking p->next == &cache_lru.head.node for
evictions would close it, but then cache_lock_entry() has to return
false when the check fails rather than retry, or the writer spins until
e is back at the tail.

[...]

> +	atomic_long_inc(&nr_lost);		/* another writer was first */
> +	kfree(new);

Nit: an allocation failure in cache_unlink() or cache_link() also ends
up here, so it's counted as a lost race as well as a failure.

Two more small things, which apply to the mutex sample in patch 11 as
well: a bad lookup (nr_bad) prints the same "the hash table and the list
disagree" as a cache_check() failure, and a kthread_run() failure is
skipped silently, so a run in which no thread started reports no error.

Thanks,
Puranjay
