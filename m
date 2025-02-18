Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE92676C5
	for <rcu@vger.kernel.org>; Tue, 18 Feb 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884680; cv=none; b=B4RDJ3pmqN4qZ8PkfmkvkBsGRWHYQfzTTu6SFdFzqcDY1/4N6kgwF6D4eHjZbXe7JzULs5QtNFgMOnfotTwKYx9NQUKX9ydbtsKTYTVLyw9TuFV3VKThNw+CIxa/g8yGml5etYRxONKaJHG40I4UExomej0ffBs35gdIRKMrQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884680; c=relaxed/simple;
	bh=QV3eVqEPCy030qiyHciW0DpoNdrPLV1WmQaUlDzSjtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjpL8xdrzflITuceohGcYEChTOxPxBMFtzMvS38UlH4Q/tzom3FTHroQtuvU0baKYvliQA4RMLLE5QnkN1TdqEsOqnU0CH7og2T58iYYQix3D5va5PCLwRuiBmtaEjahj8bsf9AHvr4ErGglftR+2moxEJFSQFXu9RZDlAo40Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj+lelfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj+lelfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F41DC4CEE6;
	Tue, 18 Feb 2025 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739884679;
	bh=QV3eVqEPCy030qiyHciW0DpoNdrPLV1WmQaUlDzSjtc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yj+lelfKj665JQerf0zOtH1qyEFq2H8pCkF2G/A0GYyVPN3Ldqd2Ln8akdw3qd4Bp
	 0A0tIROsjCi9C/3ESfMvoc+GpRmAH9If8Kl897Wx37kZSFK1UMJbgtDXmZT6/Uz6vV
	 1qy8w0kdBdDFs/e4USDaReY/Ft5z29GBu/ceanC+E7jy+5vXhuzO066BhoArLtRhyD
	 6E3gB0TuPM1xFLCbwiSyu++xRD2zlDSfvWezbYLWzvAvlVsho2IT2z3+bYM/npc8Ah
	 pVHTtdfzDAEnZh+YyMx9cyfymz5URoE4cpjAJon4zvBIG2hzfRApSa+Uux2pSWOwzZ
	 E0SmMU7TG+8bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1BA6BCE0E28; Tue, 18 Feb 2025 05:17:59 -0800 (PST)
Date: Tue, 18 Feb 2025 05:17:59 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org
Subject: Re: The rdp->gpwrap behavior
Message-ID: <b613df84-a176-4333-8c7b-2f3a75c7fdaa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213183033.GA2635051@joelnvbox>
 <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
 <009ef653-f41e-4101-886e-d9a4ce4d6e32@nvidia.com>
 <d1ebe3a6-42d9-489e-8df2-9dc8c2635a61@paulmck-laptop>
 <03416b20-789a-464e-8c2a-f9a96eec4b68@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03416b20-789a-464e-8c2a-f9a96eec4b68@nvidia.com>

On Sun, Feb 16, 2025 at 07:23:48AM -0500, Joel Fernandes wrote:
> On 2/15/2025 5:28 AM, Paul E. McKenney wrote:
> > On Fri, Feb 14, 2025 at 01:03:40PM -0500, Joel Fernandes wrote:
> >>>> Following up about our gpwrap discussions, I did some tracing of rdp->gpwrap
> >>>> with just boot testing.
> >>>>
> >>>> I actually never see it set because rdp->gp_seq and rnp->gp_seq are usually
> >>>> very close.
> >>>>
> >>>> Example trace:
> >>>>
> >>>> # rnp->gp_seq starts with -1200 on boot and then right around the wrap:
> >>>>
> >>>> 178.096329: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap before: 0
> >>>> 178.096330: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap after: 0
> >>>> 178.100327: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap before: 0
> >>>> 178.100328: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap after: 0
> >>>>
> >>>> The wrap "before" and "after" are the value of gpwrap before and after
> >>>> calling rcu_gpnum_ovf().
> >>>>
> >>>> Closer look at the _ovf() shows it should be only set if rdp->gp_seq and
> >>>> rnp->gp_seq are quite a distance apart (say if the CPU was idle for too long
> >>>> and many GPs have passed. This can happen both with/without wrap. So imminent
> >>>> wrapping seems not necessary for ->gpwrap to be even set AFAICS.
> >>>>
> >>>> I think the problem is ULONG_CMP_LT is not really "<" so even after wrap, it
> >>>> can false. i.e if rdp->gpseq + ULONG/4 wraps, it could still return false.
> >>>
> >>> Exactly, and all of that is in fact the intended behavior.
> >>
> >> Ah I think I get it now, so the wrap isn't really about the counter wrapping
> >> causing an issue, but about the design of the ULONG_CMP APIs which are designed
> >> for comparisons that wrap around. Due to this design, there is a side effect
> >> that the numbers being compared have to be at a distance that is less than half
> >> the number wheel. Otherwise the comparisons of numbers yields incorrect results.
> >> Is that accurate to say?  IOW, ->gpwrap == true means, don't compare the numbers
> >> anymore till we sort these huge deltas out.
> > 
> > But "incorrect" is such a harsh and judgmental word.  ;-)
> > 
> > Somewhat more seriously, ULONG_CMP_{GE,LT}() are defined to return the
> > sign (or its complement) of differences between a pair of 32-bit or 64-bit
> > numbers, as sizeof(unsigned long) dictates.  This is, mathematically,
> > how you do signed differences.  The result coming out negative isn't
> > incorrect, but instead the expected result given the numbers in question.
> > 
> > Current RCU use cases might interpret a negative result as "no one did
> > it for us yet", as in rcu_barrier(), "this CPU has not completed the
> > current grace period", as in __note_gp_changes(), and so on.
> > 
> > Now, these can get a false-positive/-negative result.  In the case of
> > rcu_barrier(), we get a needless rcu_barrier() computation.  In the case
> > of __note_gp_changes(), the false negative is OK, but a false positive
> > from wrapping all the way around, could be fatal for a CPU that was idle
> > for a long time (hence ->gpwrap).  And so on.
> 
> Understood and agreed! I guess what I was getting at was that ->gpwrap can be
> true and false-negatives start getting reported well before a full wrap /
> false-positive situation arises, I believe. And a false-negative may not be
> desirable in all scenarios. In my other patch, I posted a scenario where I was
> concerned about missed wakeups on a false-negative situation.
> 
> In srcutree.c
> 		swait_event_interruptible_exclusive(
> 			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
> 			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
> 			!READ_ONCE(my_rdp->nocb_gp_sleep));
> 
> But I shamelessly admit I don't understand this code well enough to say if this
> is an issue :/.

This looks like RCU NOCB code rather than SRCU code?  Could you please
tell me what function this code lives in?  The closest match I see is
in nocb_gp_wait()?

> I agree depending on usecase, false-negative is a non-issue. But I am not sure
> if false-negatives in all usecases is non-fatal.

Agreed, which is exactly why this fatality (or lack thereof) must be
evaluated on a use-case-by-use-case basis.

> >>>> >From a testing POV, the example shows it is not set even when around when a
> >>>> wrap actually happened.  So may be, we are not testing gpwrap much, or at
> >>>> all, with rcutorture?
> >>>
> >>> True enough, and that would be well worth fixing.
> >>>
> >>> One simple (and maybe too simple) fix is to add a Kconfig option to
> >>> kernel/rcu/Kconfig.debug that makes rcu_gpnum_ovf() use something like
> >>> (32 << RCU_SEQ_CTR_SHIFT).  This, or some similar value, should cause
> >>> rcutorture's stuttering and/or shuffling to trigger setting of ->gpwrap
> >>> within a few minutes.
> 
> Since minutes was too long for me :-D, I am trying just a count of 4, and I do
> see 15 total wraps in just 2 minutes, on 36 CPU system.

Very good, and thank you for taking this on!

> I am trying this same patch now for 10 minute run on all scenarios:
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/next&id=984c47eeb7728829901b33462baae2771af80ea0
> Will try longer runs after.

A good prototype!

> Are you interested in an rcutorture patch where we force this? Would this be a
> default setting where we always run it, or do we want to set it only under
> torture command line options? Do we default to say a high value like 32, but
> still provide an option to lower it to say 4, like I am doing?

Something like this would be good, but only under options.  (In order to
more easily debug something that only happens with hyperactive ->gpwrap
setting.)  For example, defined with yet another "rcutree." module_param()
that is also recorded in kernel-parameters.txt.  And printed out at boot,
perhaps in the rcu_bootup_announce_oddness() function.

We need a default setting that causes it to happen (very roughly) every
ten minutes on a given CPU, or perhaps better, every minute or so across
the system, by scaling the default by the number of CPUs.  After all,
we want to test both the ->gpwrap path *and* the non-->gpwrap path.

Then that parameter's value would of course take the place of the
hard-coded "4" in your new ULONG_CMP_LT() call in rcu_gpnum_ovf().

For example, the "pr_alert("%s%s total_gpwrap_count...);" works well
for prototyping, but for production needs to take its place elsewhere,
most likely later in that same series of pr_cont() invocations.

The get_gp_wrap_count() should sum up the per-CPU ->gpwrap_count fields,
right?  Ah, but you are calling it from a per-CPU loop anyway, so either
way should be fine.  But either way, get_gp_wrap_count() does need a
header comment saying why.  Trust me, it won't necessarily be obvious
five years from now.  ;-)

And that "atomic_inc(&rdp->gpwrap_count)" could be this_cpu_inc(), or
even "WRITE_ONCE(..., ... + 1)", given that we are not worried about
losing counts once in awhile.

I *think* that it is OK to have the tree.[ch] and rcutorture.c portions
in the same patch, but whoever is pushing this to mainline might well ask
for it to be split if we happen to end up with merge conflicts.  Or maybe
just get more practice handling merge conflicts, but it is their call.

							Thanx, Paul

> >>> And I would not be surprised if doing this located bugs.
> >>
> >> Ok cool! So I will work on this next then. I am curious to see how often it
> >> triggers both with/without such a change.
> > 
> > If you can make it trigger without this change, you are far more patient
> > than I am.  ;-)
> > 
> >>>> But before that, I am feeling it is not behaving correctly. I'd expect it to
> >>>> be set even if rnp and rdp values are close but we are actually about to
> >>>> wrap.  So most likely I am missing something.
> >>>
> >>> If I understand correctly, you would like ->gpwrap to be set
> >>> unconditionally at various points in the cycle, for example, at zero,
> >>> ULONG_MAX/4, ULONG_MAX/2, and 3*ULONG_MAX/4.  But this could easily
> >>> have the effect of discarding each CPU's quiescent states that showed
> >>> up before the first call to rcu_watching_snap_recheck(), even if that
> >>> CPU was active.  Our users might not consider this to be a friendly act.
> 
> Got it, thanks.
> 
> >>
> >> Got it.
> >>
> >>> In contrast, the current setup only discards quiescent states for CPUs
> >>> that just came back from idle prior to call to rcu_watching_snap_save().
> >>
> >> Do you mean the check of ->gpwrap in rcu_report_qs_rdp() which returns early?
> > 
> > Well, it also resets the CPU to collect quiescent states for the current
> > grace period, but yes, it does return early.
> 
> Got it, makes sense!
> 
> thanks,
> 
>  - Joel
> 
