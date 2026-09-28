Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82243ACF1B;
	Mon, 28 Sep 2026 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586779; cv=none; b=lnf1vnZgXFTZ0XRLPmic4kqDbGD4CBS+2aHTsKT87rxmqSNlRHATdshvceVkNE+y2Me9/zzP3zNb8WXlOMkyZEDHwAg6HXRn8lgNG9JRCYEOwNYERvn4sGkGb0wUp1H3ji35jCSJvrGUWb5/anVUsvsg7RMJZieBXi87NtVta6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586779; c=relaxed/simple;
	bh=c57izg75QAWyOBl5UwvDPhdaLwwtNHvPq8zxqPf09Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2hu5yfGk7pN266PQrRrA0BbUusB2K0eV/Z+BjCjp1aQIcBrLwDbqXewgVF7VjJx01M1xZb3XZMHjUnfmCGjskfudrEaWEGhECkXenXBQE4acnv7Xz+UigyWfzzqEqd9BEaYzDEbNH/0q9sFNVQa+SOld4DQ6FeJxyQUB7IyMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODZKUMvJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODZKUMvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F1D1F000FF;
	Mon, 28 Sep 2026 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790586777;
	bh=eG/m83l3qvTaPESBlgW7RcyCXZL/bq7tq2mxEzSlp3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ODZKUMvJtg62Htw8mTPf/bLQH+oR3YsMrqyeaeXAwyF4kXylgVvUfNA8YBE+hwdvO
	 qtGiuzdPXbDqxfZUceRVKOsgDcY6pogRQuo04Nqvrjw/K3gt4JY3mzwH8mwhZ/lrIk
	 Fl6SCYMv4awzKK6hTWOBAMdOEJpgMbxSHvxmBXRWiF6TlSL2+qViSGA15sG+uPzUcY
	 9RXB8lxtGGeNOm6nPjpNsI6GsQLVi2j3tgtN32ALkM38WL7COHCl8K7S8TP5LB1nHp
	 cYbMcZMT0fzXAcapl0S9rB12L1iEijAZpxsmbwsx/mAbWmeHbuF7c7XLPriuZnNy2D
	 +smJTio3z2GMA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 30FBDF40066;
	Mon, 28 Sep 2026 05:12:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 05:12:56 -0400
X-ME-Sender: <xms:mC-6aqIPdMgQ0TAsFNi8UNSD3MoLTpARqV2WhlIvhIdCYjwxlCjecg>
    <xme:mC-6auIxhmVI2y50vZ1iy1h6E2jFbJJOdBBjQC0JYiU5kOptEA5i4dZz7yJ97uX54
    1TRxP7U0DdVw73VAvmD9WLhGuOqaWSXHf97mXkjNdE_h8NYYdW9LS4>
X-ME-Received: <xmr:mC-6as6ZD0ZRPYkEV9VUVKEBXQnqLvb1BcXwF43VXS7CV9zkoY_ZZJDi-kZj>
X-ME-Proxy-Cause: dmFkZTFe2DG0LfcHJ45L5JHeQC+Gs0GkPMl5tD69Ih0nM2ssS4ZEwFT9CUC6paJ05gsVYq
    DTeHVsArLWVrUtyf4oydkVA7f81PM7nRatVWBGS2PhxMlbq/AfjWiirnXWZ0bNtScbN6SB
    uJSO2dk0CHQ/ZemHOQps+icJ5pwhtwT2byAkVqhToALeH8FQXrC3S0eIa/OUKmJtVhr1/z
    HRM7hCeGKLfp1Jkimen5SJ1k55kctKNlLR7rDkFG1Wo1AxjZKVgBpVeQa9cgCJKRvMUZ6W
    GjEn84T1J9lDsTy08vG8oTRAaUVRS2gJJ9dd/1ysyPbvBBTSdpJvCEciUxh6zM2x9wcddA
    9uv+PSsjNWuvxLkYuI0rhd5TjcPlspLPpzf3VOREPtSXqa5aI3FsNjr8NLuc22/5LF9YFm
    PGZnPtDNRA2LQhiE7xvNjMzzn+ny9I8IEymY3aFafCbZVH1tZY4wSlK8stjEJMI58F2UnX
    rvWUuMeGQlhIBYfi4otuCZcI4XeMBMdx25uJbtnfVQlnHucvhYDKZzbfW0oTFY9PANUs9w
    kzMyFmM4JsU5Hx/BePeI5qHkgP6tDx9h/JbIGrT2c5XSkhw91PEswRDkxrCs2Op3+A4y1t
    YOxnlpSq4lhlkaCsF4pNOhwLXBcZR4rtKa3k4Yycgf3R7OxTkffZetLjsx6A
X-ME-Proxy: <xmx:mC-6agdxb3kaFNzzIYO5jcJIEEsmw9C5mK8R1SnWZzInP0GsrN4VFA>
    <xmx:mC-6avE-kZ-WS-jQAbCLfUogMYr6NGZdn6TSSulJlt4z6RCgRVhydA>
    <xmx:mC-6ahQIHYGhQgbtZ2CuaytrO5FcXEmY_aBSwhoUQs8UGZ8mnxvTNg>
    <xmx:mC-6alaYjlp5HihU56yAQzh03nbpyx-8dTZjXoSDvBinz9bw42Qe2g>
    <xmx:mC-6as3WfcCDQAKsOkjLoXL0jOSkh16ioJNuh4Ao7AUxIJTawTyk0tbY>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:12:55 -0400 (EDT)
Date: Mon, 28 Sep 2026 11:12:54 +0200
From: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
Message-ID: <arovltfvFzv2FFjO@MacBook-0RXW5>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
 <DLQGJZK4LIAO.3TAY3HZ6PR76Z@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLQGJZK4LIAO.3TAY3HZ6PR76Z@garyguo.net>

On Sun, Sep 27, 2026 at 11:39:00PM +0100, Gary Guo wrote:
> On Sun Sep 27, 2026 at 6:15 PM BST, Mathieu Desnoyers wrote:
> > On 2026-09-27 12:40, Boqun Feng wrote:
> >
> >> I want to point out this is not true for the lockdep use case, because
> >> the we need to protect a hash list deletion there, and we use the
> >> address of the hash bucket there. It's proven fine in practice because
> >> the readers are rare (we only call the reader is_dynamic_key() in
> >> register_lock_class(), that is every time you have a new lock class to
> >> register).
> >> 
> >> Maybe what we want to say here is that "if the users guarantee no steady
> >> flow of the same hazard pointer value, we guarantee forward progress".
> >> Thoughts?
> >
> > AFAIU, your approach to protect lockdep linked lists is to use the
> > address of the hash bucket to protect the traversal. As this address is 
> > invariant (global array item address), that address should be fine
> > to fulfill hazptr requirements, but it has downsides: rather than
> > protecting the specific nodes being retired, the whole hash chain is
> > protected. This means that, as you point out, many readers retiring
> > nodes from a given bucket (except the first node) could end up holding a
> > continuous stream of hazptr for a given hazptr value, preventing
> > progress of hazptr synchronize.
> >
> > It's also coarser: per-bucket rather than per-node.
> >
> > Am I missing something here ?
> >
> > One honest question: is this pattern something we expect to
> > see often ? If so, then we may want to introduce a notion of
> > hazptr protection "period" flip (similar to some RCU implementations),
> > where we tag the low bit of the slot pointer (0 vs 1), and alternate
> > between the two periods in synchronize. This would prevent a steady-flow
> > of same-value readers from preventing synchronize forward progress.
> 
> Slightly off topic, but I have a use-case in mind (in case you're not already
> aware) where the address is fixed like the lockdep class, but it does not suffer
> the forward progress guarantee.
> 
> I have been wanting to use hazptr for revocable for quite a while (I think I
> chatted with Boqun about this last LPC). For the revocable use case, the
> protected pointer is fixed, however there is an additional boolean flag to
> determine if the resource been revoked or not.
> 
> Something like this:
> 
>     void *revocable_try_access(struct revocable *rev) {
>         struct hazptr_ctx ctx = {};
>         if (READ_ONCE(rev->revoked))
>             return NULL;
>         // note the & cancels out with the * in acquire, so the address is fixed.
>         hazptr_acquire(&ctx, &rev);
>         if (READ_ONCE(rev->revoked))
>             return NULL;
>         return rev->res;
>     }
> 
>     void revocable_revoke(struct revocable *rev) {
>         WRITE_ONCE(rev->revoked, true);
>         hazptr_synchronize(&rev);
>     }
> 
> So while the address is fixed, we have a different field to do the unpublishing
> part.
> 
> For some context, the current Rust revocable implementation uses RCU, but this
> is limiting the case where it can be used. The current C revocable series in
> https://lore.kernel.org/all/20260912123529.7951-1-tzungbi@kernel.org/ uses SRCU.
> 
> I think this use case is a good one for hazptr, in fact, I have encouraged Alvin
> Sun to try it out and you can see an implementation (Rust) in here:
> https://lore.kernel.org/rust-for-linux/20260326-b4-tyr-debugfs-v1-6-074badd18716@linux.dev/
> Although, over the course of the year, we have been reducing the amount of
> revocable usage and shifting to represent things with lifetime..
> 

Paul asked me for the Rust usage a few days ago, and since we moved to
a lifetime based approach [1], which is better IMO, I don't think
switching to hazptr will should observable difference here, especially
for a real workload improvement. It's still worth trying to see how
hazptr in Rust would work for this, but it's less a sufficient condition
to merge hazptr from my understanding. Of course I could be wrong.

[1]: https://lore.kernel.org/rust-for-linux/20260517000149.3226762-1-dakr@kernel.org/

Regards,
Boqun

Regards,
Boqun

> Best,
> Gary
