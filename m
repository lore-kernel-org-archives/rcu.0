Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98949F133;
	Fri, 11 Sep 2026 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141874; cv=none; b=AT0bHEZH/U9C5UC6Z1gCDkajgX4rgkBR8h1FrF1BAa2Hr++vsmGU6nGoZJ9RnN/XyVy6gEUPsVTQZTBNKvhckclzwzFsHxvCyyJkDnnz22DMeWmwCo9c7SRKp58XuznIebhS9CuTUhTNEtU92rURcl26KiGAb4UczHTf6xjx2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141874; c=relaxed/simple;
	bh=5GqXCRQPg02XvaO+WCvWjNFBP1Vc/HK91BiNOPEF2tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu8bs2mLzH1Iy9WCE3EDZbOtGA4Sazd/hLGzcRGqAuAxsl8yV4Bu4Fpyk8Ok/3PXXunbznTVQg91RJLOr6rpQNp3BlXRsWujy+EJXBs0tToDNpksJvs0o3c+aB270iIMD54pbFmsOeAW63SPD8uh8wn29Hm2piShVq4t8CVRnXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN8OrhYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN8OrhYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F2A1F00893;
	Fri, 11 Sep 2026 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789141872;
	bh=w7nkNDNXqHHm15vNCtuumvyo5jG8awmkb4dbuf4iER0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=SN8OrhYp18ssR4Tf17ijCf3C9rJ458BcdQTrBevoz3ltbu9RoxWswg19Am1zLxeMq
	 cpETjvLNvAVopMRAnGVWLUpvW8hVvc1ABHLDwM7bvFGOVauzkVoYRdVpvaymp5FNkd
	 j3ZwIYN03wAvry6pxMebXvuNLYBZZrpj33ga1rFl9zeYB1L+bMmmCOS2X3bz3lyDYE
	 ywBIZ867xf/VFmSojr3MD470JNNFOjyEVOTV9gHAp+Y+ZnmIiGWapq4HUwi4s9y4CU
	 q6vcR8nv18KNbhYBADvkddHPsruTIpUhfZcZVsDSaX0g2DJZmXv6Pra+CAzYzRgewo
	 QGM1uH1yD4gnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1BF07CE1902; Fri, 11 Sep 2026 08:51:12 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:51:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] litmus: Add SRCU fastpath anchor-before-scan test
Message-ID: <e5b02d91-feb6-4dd7-b67e-8faaa662a610@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <35d6d803-41d9-48d6-a8d0-b8d0f6f67efd@paulmck-laptop>
 <20260909030253.2430897-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909030253.2430897-1-kunwu.chan@gmail.com>

On Wed, Sep 09, 2026 at 11:02:51AM +0800, Kunwu Chan wrote:
> On Tue, 8 Sep 2026 16:58:31 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Mon, Sep 07, 2026 at 03:58:17PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@gmail.com>
> > > 
> > > synchronize_srcu_atomic() may end its grace period immediately when
> > > its scan of the per-CPU lock counters finds no readers.  Correctness
> > > requires the grace-period anchor written by srcu_gp_start() to precede
> > > the smp_mb() ordering the lock scan.  This ordering ensures that any
> > > reader whose lock increment is missed by the scan cannot have
> > > incremented its lock counter before the grace-period anchor, and
> > > therefore cannot be a pre-existing reader of this grace period.
> > > 
> > > This litmus test models the key ordering between the grace-period
> > > anchor and the lock counter scan, where "seq" models the
> > > grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> > > ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> > > smp_mb() and the lock scan.  P1 models the reader-side counter
> > > increment, with the smp_mb() of __srcu_read_lock() following the
> > > increment.  P2 models an observer that sees the reader's increment
> > > before seeing the anchor.
> > > 
> > > The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> > > SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> > > which permits this outcome.
> > > 
> > > Tested with herd7 7.58 using linux-kernel.cfg.
> > > 
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > Litmus tests!  Very nice!!!  
> > 
> > Could you please put both of these in Documentation/litmus-tests, in a
> > new "srcu" subdirectory?
> > 
> > One thing for your consideration is use of the "filter" clause for the
> > first term of your "exists" clause.  Not a big deal at all for this small
> > of a litmus test, but the idea is that this litmus test only cares about
> > the 0:r2=0 case:  If that condition does not hold, then P0() and P1()
> > aren't the beginning and end of a valid SRCU read-side critical section.
> > 
> > Use of the "filter" allows herd7 to abandon a given execution early,
> > so it is a big deal for larger litmus tests.
> > 
> > Again, what you have is fine (or will be when moved to the other
> > directory), just pointing out the additional feature.
> > 
> > If you would like to see a use case, please see:
> > 
> > Documentation/litmus-tests/locking/RM-fixed.litmus
> 
> Thanks, Paul.
> I’ll move both tests to Documentation/litmus-tests/srcu/ and use a "filter" 
> clause for the first test as suggested.
> 
> I’ll send the two litmus tests as a separate follow-up series, so this won’t 
> hold up the current atomic SRCU series.

That sounds good, thank you!

> I’d also like to continue maintaining the SRCU litmus tests as they evolve. 
> If you think a MAINTAINERS entry for the SRCU litmus tests would be appropriate, 
> I’d be happy to prepare that as well.

Why don't we take a longer-term approach and work to get you up to speed
for maintainership of SRCU, rather than just for a couple of litmus tests?

							Thanx, Paul

> Thanks,
> KunWu
> 
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  .../SRCU-fastpath-anchor-before-scan.litmus   | 56 +++++++++++++++++++
> > >  1 file changed, 56 insertions(+)
> > >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> > > 
> > > diff --git a/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> > > new file mode 100644
> > > index 000000000000..8200a75e15ef
> > > --- /dev/null
> > > +++ b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> > > @@ -0,0 +1,56 @@
> > > +C SRCU-fastpath-anchor-before-scan
> > > +
> > > +(*
> > > + * Result: Never
> > > + *
> > > + * The synchronize_srcu_atomic() fastpath may end its grace period
> > > + * immediately when its scan of the per-CPU lock counters finds no
> > > + * readers.  Correctness requires the grace-period anchor written by
> > > + * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
> > > + * This ordering ensures that any reader whose lock increment is missed
> > > + * by the scan cannot have incremented its lock counter before the
> > > + * grace-period anchor, and therefore cannot be a pre-existing reader
> > > + * of this grace period.
> > > + *
> > > + * This litmus test models the key ordering between the grace-period
> > > + * anchor and the lock counter scan, where "seq" models the
> > > + * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> > > + * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> > > + * smp_mb() and the lock scan.  P1 models the reader-side counter
> > > + * increment, with the smp_mb() of __srcu_read_lock() following the
> > > + * increment.  P2 models an observer that sees the reader's increment
> > > + * before seeing the anchor.
> > > + *
> > > + * The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> > > + * SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> > > + * which permits this outcome.
> > > + *)
> > > +
> > > +{}
> > > +
> > > +P0(int *seq, int *ctr)
> > > +{
> > > +	int r2;
> > > +
> > > +	WRITE_ONCE(*seq, 1);
> > > +	smp_mb();
> > > +	r2 = READ_ONCE(*ctr);
> > > +}
> > > +
> > > +P1(int *ctr)
> > > +{
> > > +	WRITE_ONCE(*ctr, 1);
> > > +	smp_mb();
> > > +}
> > > +
> > > +P2(int *seq, int *ctr)
> > > +{
> > > +	int r3;
> > > +	int r4;
> > > +
> > > +	r3 = READ_ONCE(*ctr);
> > > +	smp_mb();
> > > +	r4 = READ_ONCE(*seq);
> > > +}
> > > +
> > > +exists (0:r2 = 0 /\ 2:r3 = 1 /\ 2:r4 = 0)
> > > -- 
> > > 2.43.0
> > > 
> > 
> 
> Sent using hkml (https://github.com/sjp38/hackermail)
