Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FF2EEE7E;
	Tue,  8 Sep 2026 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907991; cv=none; b=r5akfhRYicJM3vTYtG/ePv73wp6QV8AzhCDF3J1FpnZOz9ycqPi0gi47V6RdrPsAKxdGej4bkiJVSvz8hCc7xGRihZNyNkUdQ68REiQYS38uydglG933MB5jYqb/bbfMTo0c1acJPLawJ2UaSAeY3zm35OkTIClBf8XAA8Eg+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907991; c=relaxed/simple;
	bh=DISlVCss88ZicVbynktng/BLrfT3gPYPLHKgzz0nRPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX+dvYNO2JUTLrzmcAVvGupikGdnL1czFbF9V9/bSuYTELVYysb22Ds7COthDeLSU3Tnhlf85DsJopuNKmW6kBX+8fEW0gpsuivRb7LmgQcOGCpRsDkKdfcUunx5sd28b9KsciUT4cZWb/eT3j+ZEo7VcZIik7kq3AWhKcmLUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqrK/NYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqrK/NYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031491F00A3A;
	Tue,  8 Sep 2026 22:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907990;
	bh=9wWdGP1udDEeod5fBcAORq96Hru0DiWoOt99Itk2KqQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=iqrK/NYOO9u2/PbshlXCNOJLbv1QGM8a7NL91AVwtv66Cq6jMAY6I8LVmelIzfe85
	 LbuGH8Kn3buuGeKTO24LECSiL6XUfzflG0GrvDFJWKoIv6AmoNueBKYKTgkAf0jpkJ
	 sSenKjivuov8q7M1nthEPJlFC62lZE8P4X+tgQezlH+Bv9rDJjZSSIGGg04AAB0He4
	 lHOPN6D97xDp3k8TArGatLp7AtwXXninP/E81J6yQguVBylprAAWbxV0W1b50U273l
	 mAWciUNSnmP9lXuKMa8JBvKcZpdR+wMfrcI9ht+9q2V1dHLunIfpGbWkig4etWT/yK
	 xVsOl2KWvlimQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BF774CE0F83; Tue,  8 Sep 2026 15:53:09 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:53:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, jiangshanlai@gmail.com,
	josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] srcutree: Add reader-free fastpath to
 synchronize_srcu_atomic()
Message-ID: <8889e3f6-4cba-4d6c-97f8-85cdff367b0a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-4-kunwu.chan@linux.dev>
 <b7bc58aa-4b8a-4eaa-a7e8-8d338f34d14a@paulmck-laptop>
 <0d4af6318ac67486858be1df8d436147b444a2d2.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d4af6318ac67486858be1df8d436147b444a2d2.camel@infradead.org>

On Tue, Sep 08, 2026 at 11:26:06PM +0100, David Woodhouse wrote:
> On Tue, 2026-09-08 at 13:29 -0700, Paul E. McKenney wrote:
> > On Mon, Sep 07, 2026 at 03:58:19PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > 
> > > synchronize_srcu_atomic() is restricted to srcu_read_lock_atomic() and
> > > srcu_read_unlock_atomic(), whose read-side critical sections disable
> > > preemption.  In the common case where there are no readers at all, the
> > > grace period therefore need not do the index flip.  Add a fastpath
> > > that sums both ranks of the per-CPU ->srcu_ctrs[] counters and, if the
> > > lock counts match the unlock counts on both ranks, ends the grace
> > > period immediately, skipping the srcu_advance_state() scans, mirroring
> > > the similar Tiny SRCU fastpath.
> > > 
> > > Correctness requires the counter-sum proof to follow the grace-period
> > > anchor written by srcu_gp_start(); placing it before the anchor could
> > > let this grace period miss a pre-existing reader and return without
> > > waiting for it.  The smp_mb() between the unlock and lock sums pairs
> > > with the smp_mb() in __srcu_read_lock().  The grace period is ended
> > > manually under ->lock and ->srcu_atomic_gp_flag.
> > > 
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > Adding David Woodhouse on CC.
> > 
> > David, does this provide appropriate performance in your use case?
> 
> Compared with the early bail that I had before, there's a *slight*
> shift into the higher-latency buckets as expected, but definitely not
> enough that I care. We're doing this whole thing to eliminate the
> multi-millisecond p100 latencies that happen when we invoke the
> workqueue, and the differences we're looking at in the table below are
> *well* below what we care about:
> 
> 
>   ┌─────────────┬───────────────────┬───────────────────┬───────┐
>   │   bucket    │  try-first (#10)  │    Kunwu (#11)    │   Δ   │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [0,1µs)     │ 5,338,474 (60.8%) │ 4,953,657 (56.8%) │ −7%   │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [1,2)       │ 1,077,998         │ 1,087,133         │ ≈     │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [2,4)       │ 803,244           │ 790,489           │ ≈     │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [4,8)       │ 811,708           │ 880,673           │ +8%   │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [8,16)      │ 366,183           │ 597,443           │ +63%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [16,32)     │ 338,731           │ 361,243           │ +7%   │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [32,64)     │ 14,290            │ 28,823            │ ×2.0  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [64,128)    │ 2,549             │ 3,655             │ +43%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [128,256)   │ 555               │ 783               │ +41%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [256,512)   │ 456               │ 625               │ +37%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ [512µs+)    │ 13                │ 8                 │ ≈     │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ max         │ 1.07ms            │ 1.56ms            │ +46%  │
>   ├─────────────┼───────────────────┼───────────────────┼───────┤
>   │ total walks │ 8,777,514         │ 8,723,453         │ −0.6% │
>   └─────────────┴───────────────────┴───────────────────┴───────┘
> 
>   (192-CPU PREEMPT_RT host, 12 concurrent gfn_to_pfn_cache invalidation
>   reproducers, 300-second windows; each "walk" is one invalidation drain
>   which includes the synchronize_srcu_atomic() call. #10/#11 are just
>   local build numbers.)

Thank you very much!!!

I am interpreting this to mean that Kunwu's current approach does what
you need, so that we can keep current get_state_synchronize_srcu()
and poll_state_synchronize_srcu() semantics.

							Thanx, Paul
