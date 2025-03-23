Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15915E90;
	Sun, 23 Mar 2025 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742767521; cv=none; b=oj14tGHtnbEKm4WZJSKIJr1NYJWGtk/tQRZSzPqSaZ+jHHYehbEqSJLE3cPllEA+mZpeaJa1eWjKcM7p5d3QZNs1/oP339DPu1tkie3jx4eacZbOJQoHUOpav0wp5sxY4MKBCflIloU50M5DBXrCl+xRoyhyAj5d1KVsT3vHo/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742767521; c=relaxed/simple;
	bh=YhybzgPl2Cq/DacbVvF0iAzZ6kKcmY0Aiyj6Ah//UxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1Xw7DcMJBqgNWzJKZe2IiLMMbhd+TMDTiZv5DPlD7ZhFq9s7XbZXXYJfHMkm5omScECcn3b+vkjy7wN4ExDLv3AQmYkw50rJu8g4WQVYmaQrOktK0itiFMEuLWisah1+u/IM3XRiNZzgV17EBCD2i2b4hZfp/yynneQwPKtCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrSxcL1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrSxcL1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CE5C4CEE2;
	Sun, 23 Mar 2025 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742767519;
	bh=YhybzgPl2Cq/DacbVvF0iAzZ6kKcmY0Aiyj6Ah//UxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrSxcL1Ay3iHpOlC0ggiiDzHJhscV3ZIbPRbl2zOOJ2yNvBA362GDUegHoF7Y9Ujk
	 OAaa8x6kkDqjSBI3i/9RsS+17fT8y1nod1C+1Zt3nqVAteR2VWYd0SQLq+9IZLsA6K
	 CnMO/wOB9x+DdPrZy7V6b8fzgOyBslMvrerwej797+Ky/lrMqNTeNcHIVvIO06XyUp
	 oWoPdw9C7d5zI2kPfVEv6kYPPXYyfkAoYw2FSxi4Pm+18KxmWnb4FsjfhUDqHN2RdQ
	 uYusCTHgLf5ZBe/Zuv/PEfSZe2ptZA5MF45evvr2YCVUMTmzCh//8QnW0iW7YhaQrc
	 hirJuGNxbiBcA==
Date: Sun, 23 Mar 2025 23:05:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Message-ID: <Z-CFnKELSqFotela@pavilion.home>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-2-frederic@kernel.org>
 <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
 <20250319193831.GA3791727@joelnvbox>
 <Z9wjBT3RQDUrFdbE@p200300d06f3e9880e1f174d4afcc9316.dip0.t-ipconnect.de>
 <3c7f1032-f2ba-4fc6-91c0-a07fce1b9c3c@nvidia.com>
 <Z96P_K0kt-FumSjz@pavilion.home>
 <a2b9d79f-5406-422c-aa79-f0fd1862d4ab@nvidia.com>
 <42297734-44af-42f9-8544-f3b25e35d3ef@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42297734-44af-42f9-8544-f3b25e35d3ef@nvidia.com>

Le Sat, Mar 22, 2025 at 03:40:53PM +0100, Joel Fernandes a écrit :
> 
> 
> On 3/22/2025 3:20 PM, Joel Fernandes wrote:
> > 
> > On 3/22/2025 11:25 AM, Frederic Weisbecker wrote:
> >> Le Sat, Mar 22, 2025 at 03:06:08AM +0100, Joel Fernandes a écrit :
> >>> Insomnia kicked in, so 3 am reply here (Zurich local time) ;-):
> >>>
> >>> On 3/20/2025 3:15 PM, Frederic Weisbecker wrote:
> >>>> Le Wed, Mar 19, 2025 at 03:38:31PM -0400, Joel Fernandes a écrit :
> >>>>> On Tue, Mar 18, 2025 at 11:37:38AM -0700, Paul E. McKenney wrote:
> >>>>>> On Tue, Mar 18, 2025 at 02:56:18PM +0100, Frederic Weisbecker wrote:
> >>>>>>> The numbers used in rcu_seq_done_exact() lack some explanation behind
> >>>>>>> their magic. Especially after the commit:
> >>>>>>>
> >>>>>>>     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
> >>>>>>>
> >>>>>>> which reported a subtle issue where a new GP sequence snapshot was taken
> >>>>>>> on the root node state while a grace period had already been started and
> >>>>>>> reflected on the global state sequence but not yet on the root node
> >>>>>>> sequence, making a polling user waiting on a wrong already started grace
> >>>>>>> period that would ignore freshly online CPUs.
> >>>>>>>
> >>>>>>> The fix involved taking the snaphot on the global state sequence and
> >>>>>>> waiting on the root node sequence. And since a grace period is first
> >>>>>>> started on the global state and only afterward reflected on the root
> >>>>>>> node, a snapshot taken on the global state sequence might be two full
> >>>>>>> grace periods ahead of the root node as in the following example:
> >>>>>>>
> >>>>>>> rnp->gp_seq = rcu_state.gp_seq = 0
> >>>>>>>
> >>>>>>>     CPU 0                                           CPU 1
> >>>>>>>     -----                                           -----
> >>>>>>>     // rcu_state.gp_seq = 1
> >>>>>>>     rcu_seq_start(&rcu_state.gp_seq)
> >>>>>>>                                                     // snap = 8
> >>>>>>>                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
> >>>>>>>                                                     // Two full GP differences
> >>>>>>>                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
> >>>>>>>     // rnp->gp_seq = 1
> >>>>>>>     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> >>>>>>>
> >>>>>>> Add a comment about those expectations and to clarify the magic within
> >>>>>>> the relevant function.
> >>>>>>>
> >>>>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> >>>>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> >>>>>>
> >>>>>> But it would of course be good to get reviews from the others.
> >>>>> I actually don't agree that the magic in the rcu_seq_done_exact() function about the
> >>>>> ~2 GPs is related to the lag between rcu_state.gp_seq and root rnp->gp_seq,
> >>>>> because the small lag can just as well survive with the rcu_seq_done()
> >>>>> function in the above sequence right?
> >>>>>
> >>>>> The rcu_seq_done_exact() function on the other hand is more about not being
> >>>>> stuck in the ULONG_MAX/2 guard band, but to actually get to that, you need a
> >>>>> wrap around to happen and the delta between "rnp->gp_seq" and "snap" to be at
> >>>>> least ULONG_MAX/2 AFAIU.
> >>>>>
> >>>>> So the only time this magic will matter is if you have a huge delta between
> >>>>> what is being compared, not just 2 GPs.
> >>>> You're right, and perhaps I should have made it more specific that my comment
> >>>> only explains the magic "3" number here, in that if it were "2" instead, there
> >>>> could be accidents with 2 full GPs difference (which is possible) spuriously
> >>>> accounted as a wrap around.
> >>> Ahh, so I guess I get it now and we are both right. The complete picture is - We
> >>> are trying to handle the case of "very large wrap" around but as a part of that,
> >>> we don't want to create false-positives for this "snap" case.
> >>>
> >>> A "snap" can be atmost  (2 * RCU_SEQ_STATE_MASK + 1) away from a gp_seq.
> >>>
> >>> That's within "2 GPs" worth of counts (about 8 counts)
> >>>
> >>> Taking some numbers:
> >>>
> >>> cur_s	s	delta (s - cur_s)
> >>> 0	4	4
> >>> 1	8	7
> >>> 2	8	6
> >>> 3	8	5
> >>> 4	8	4
> >>> 5	12	7
> >>>
> >>> The maximum delta of a snap from actual gp_seq can be (2 * RCU_SEQ_STATE_MASK +
> >>> 1) which in this case is 7.
> >>>
> >>> So we adjust the comparison by adding the  ULONG_CMP_LT(cur_s, s - (2 *
> >>> RCU_SEQ_STATE_MASK + 1)). i.e.
> >> 3, right?
> > Just to be absolutely sure, are you talking about the value of RCU_SEQ_STATE_MASK ?
> > 
> > That is indeed 3 (RCU_SEQ_STATE_MASK).
> > 
> > But if we're talking about number of GPs, my understanding is a count of 4 is
> > one GP worth. Per the above table, the delta between gp_seq and is snap is
> > always a count of 7 (hence less than 2 GPs).
> > 
> > Agreed?
> > 
> > If RCU_SEQ_STATE_MASK was 0x1 instead of 0x11, that is a single bit (or a count
> > of 2 instead of 4, for a GP), then the table would be:
> > 
> >  cur_s	s (snap)	delta (s - cur_s)
> >  0	2		2
> >  1	4		3
> >  2	4		2
> >  3	6		3
> >  4	6		2
> >  5	8		3
> > 
> > So delta is always <= 3,  Or more generally: <= (RCU_SEQ_STATE_MASK * 2) + 1
> 
> Oh man, I am wondering if we are on to a bug here:
> 
> From your example:
> 
>     CPU 0                                           CPU 1
>     -----                                           -----
>     // rcu_state.gp_seq = 1
>     rcu_seq_start(&rcu_state.gp_seq)
>                                       // snap = 8
>                                       snap = rcu_seq_snap(&rcu_state.gp_seq)
>                                       // Two full GP
>                                       rcu_seq_done_exact(&rnp->gp_seq, snap)
> 
> 
> Here, the
> ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> 
> Will be
> ULONG_CMP_LT(0, 8 - (2 * RCU_SEQ_STATE_MASK + 1));
> 
>  = ULONG_CMP_LT(0, 8 - 7)
> 
>  = TRUE.
> 
> Which means rcu_seq_done_exact() will return a false positive saying the GP has
> completed even though it has not.
> 
> I think rcu_seq_done_exact() is off by one and should be doing:
> 
> ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 2));
> 
> ?

But it's ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1) now since:

    85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")

That's 10 so we are good.

However that magic value is arbitrary and doesn't mean much. It should be
like you said. Or rather for clarity:

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 7acf1f36dd6c..e53f0b687a83 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -57,6 +57,10 @@
 /* Low-order bit definition for polled grace-period APIs. */
 #define RCU_GET_STATE_COMPLETED	0x1
 
+/* A complete grace period count */
+#define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
+
+
 extern int sysctl_sched_rt_runtime;
 
 /*
@@ -169,7 +173,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
 	unsigned long cur_s = READ_ONCE(*sp);
 
-	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
+	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_GP));
 }
 
 /*

