Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654BEEA9;
	Thu, 27 Mar 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095389; cv=none; b=SUTniq2lW3S+XDH5aeZFHb71LhPeulJllOnTEKQRuu3fR4xWDDZpRLJ9JhuaTZUFdv/x2cHBjolzJ9QgwA7PmHe6gFa/biNE2CmQLR+U9HFWZNM1UAEy8tVO01Q+fQ4YhkY11+fGnOR0y5+mQKG/qSPH9ohZc/rH2d4azHYa/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095389; c=relaxed/simple;
	bh=Pq+zALyw588VAt6NtNfDCmcZbC+k3NO3/ZEZKdgCxP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txXV2Eng+T6IDfuo9asWcPbc4+juFJt79IISqXOQGdABzauI7diF0ue3wcADiIu6gL99zXmVs58j1YURUYof6KKV9ip3wYW0keB/6EQ46QU2VWcsNrPdAd8bXPmoDQyNxyXo9Yzk+EWB/UNk/Sp3Fzi2uRNLDaOFc+gU22nSXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEQLxS/n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEQLxS/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89D5C4CEDD;
	Thu, 27 Mar 2025 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743095388;
	bh=Pq+zALyw588VAt6NtNfDCmcZbC+k3NO3/ZEZKdgCxP0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AEQLxS/nHAYxmhnzSTZ6R6cbRmvi6tfES+hBEoaUASwXWZSknMl/YIjxQNDVcs2sT
	 Iw9DV3acGeL9GIte9UFmG46+P0nALeF7Ehj0ZUKQOa66erH/56BBkAM7WLH4CXcLfF
	 4CXZ7D9MgJnuwLf6NxD/ZJBkNY6JbEAVJoYpgcNyNzIKRe7ZkbsTaR3wmCZnkaVndx
	 YQNinf7Z12puhAtV+b1ryQjjJ4dXCmhFLJcxua/HtWSd/MKzGicPj9K6SuXc3QA5Aa
	 RMo9toQMucqcy+4EfUVfu8agUwvNX+QMYqggD2oOz630hqQsTuybdpK1Cc7JXQ3wQM
	 3lstQiFr0glIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59A4DCE0A70; Thu, 27 Mar 2025 10:09:48 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:09:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu: Replace magic number with meaningful constant
 in rcu_seq_done_exact()
Message-ID: <e47e5611-36de-4d12-9c07-57aa2a885299@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
 <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
 <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDDD275D-1017-4189-9A8A-578021A33B4A@nvidia.com>

On Wed, Mar 26, 2025 at 10:42:52PM +0000, Joel Fernandes wrote:
> 
> 
> > On Mar 26, 2025, at 6:33 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Mon, Mar 24, 2025 at 01:01:53PM -0400, Joel Fernandes wrote:
> >> The rcu_seq_done_exact() function checks if a grace period has completed by
> >> comparing sequence numbers. It includes a guard band to handle sequence number
> >> wraparound, which was previously expressed using the magic number calculation
> >> '3 * RCU_SEQ_STATE_MASK + 1'.
> >> 
> >> This magic number is not immediately obvious in terms of what it represents.
> >> 
> >> Instead, the reason we need this tiny guardband is because of the lag between
> >> the setting of rcu_state.gp_seq_polled and root rnp's gp_seq in rcu_gp_init().
> >> 
> >> This guardband needs to be at least 2 GPs worth of counts, to avoid recognizing
> >> the newly started GP as completed immediately, due to the following sequence
> >> which arises due to the delay between update of rcu_state.gp_seq_polled and
> >> root rnp's gp_seq:
> >> 
> >> rnp->gp_seq = rcu_state.gp_seq = 0
> >> 
> >>    CPU 0                                           CPU 1
> >>    -----                                           -----
> >>    // rcu_state.gp_seq = 1
> >>    rcu_seq_start(&rcu_state.gp_seq)
> >>                                                    // snap = 8
> >>                                                    snap = rcu_seq_snap(&rcu_state.gp_seq)
> >>                                                    // Two full GP differences
> >>                                                    rcu_seq_done_exact(&rnp->gp_seq, snap)
> >>    // rnp->gp_seq = 1
> >>    WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> >> 
> >> This can happen due to get_state_synchronize_rcu_full() sampling
> >> rcu_state.gp_seq_polled, however the poll_state_synchronize_rcu_full()
> >> sampling the root rnp's gp_seq. The delay between the update of the 2
> >> counters occurs in rcu_gp_init() during which the counters briefly go
> >> out of sync.
> >> 
> >> Make the guardband explictly 2 GPs. This improves code readability and
> >> maintainability by making the intent clearer as well.
> >> 
> >> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > One concern is that a small error anywhere in the code could cause this
> > minimal guard band to be too small.  This is not a problem for some
> > use cases (rcu_barrier() just does an extra operation, and normal grace
> > periods are protected from forever-idle CPUs by ->gpwrap), but could be
> > an issue on 32-bit systems for user of polled RCU grace periods.
> 
> Could you provide more details of the usecase (sequence of steps) causing an issue for 32 bit polled RCU users? I am not able to see how this patch can affect them.
> 
> > 
> > In contrast, making the guard band a bit longer than it needs to be
> > has little or no downside.
> 
> Making it 3 GP instead of 2 should be ok with me as long as we document it but at least it will not be a magic number based on an equation. I feel we should not put random magic numbers which is more dangerous since it is hard to explain (and hence debug — just my 2 cents).

Apologies, I was getting ahead of us on this one.

That third (and maybe also a fourth) grace period becomes important if
we start getting memory contention on rcu_state.gp_seq, in which case
we would want the polled grace periods to look at the leaf rcu_node
structure's gp_seq, which would introduce extra slop.

For now, for this patch, assuming you guys promise to remember this
should such memory contention prove problematic:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> Thanks.
> 
> > 
> >                            Thanx, Paul
> > 
> >> ---
> >> kernel/rcu/rcu.h | 5 ++++-
> >> 1 file changed, 4 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> >> index eed2951a4962..5e1ee570bb27 100644
> >> --- a/kernel/rcu/rcu.h
> >> +++ b/kernel/rcu/rcu.h
> >> @@ -57,6 +57,9 @@
> >> /* Low-order bit definition for polled grace-period APIs. */
> >> #define RCU_GET_STATE_COMPLETED    0x1
> >> 
> >> +/* A complete grace period count */
> >> +#define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
> >> +
> >> extern int sysctl_sched_rt_runtime;
> >> 
> >> /*
> >> @@ -162,7 +165,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> >> {
> >>    unsigned long cur_s = READ_ONCE(*sp);
> >> 
> >> -    return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> >> +    return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_GP));
> >> }
> >> 
> >> /*
> >> --
> >> 2.43.0
> >> 
