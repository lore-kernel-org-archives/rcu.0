Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C463209F22;
	Wed, 12 Feb 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356984; cv=none; b=KgToNYQSSeNIr+mAMKwVf+L8TuznrLT5PvtSMAJZ0pCuAI4hqWNkHQmfDe3jOluSZI8lQsolJdoMpvnyJVu8uZUl8v9m2/z+e26OCrFO5LgNb87BrmcH+yOlvCIpSrQ9VbD+JbZQ6Fp48tmVY6Z2fpmnl0WHEKLvJA018CwJiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356984; c=relaxed/simple;
	bh=MZ9NlZLMHZ4XSxzfy1mUEo6JbMYrV7+8qzdH5KrrJ3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpqqGXNhqPRwj0LZZCTMKLDYZg4TkTKbLXqX1BlEx+ZD23OtGDF54cDNVZ1dceRMXRBAoAhnnZkhM+mBlsy3Ensma36ZQRLsC6WMlk484Mu2zHPh9LIPP1dHKekCaK7OZoPgZNnRSdb2Fv3DpfiThk0Y40J+5dWCMDfQlP/YksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+hYzz88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+hYzz88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07B9C4CEDF;
	Wed, 12 Feb 2025 10:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739356983;
	bh=MZ9NlZLMHZ4XSxzfy1mUEo6JbMYrV7+8qzdH5KrrJ3U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T+hYzz88SKUIDBv1wYqlSKjnSaI4/34jomwND8R5aHAQU4wW/bVoS3UHCcDteyoWS
	 MwrezTde9mKoxuiI76Bz923mGxAP4SvLbHmoNLipC+8A9Zhuj/hx95/5bGdWsKiPnF
	 bXU0S+z8cnrU3KpmKWqovMjRW9gpeJQHJPje8k+3z5W7lwfee94AxeOepnckO26dMd
	 zRu5XSDu57yvS+WubF07HtVBaoRbmR5ppEPLI5xS4nGYK/Hl6R/0TCvCbArrR7pFMN
	 97r5wLBT7OqaU159Oc/Z5TU1oZeoi9KNSWtxwnzv1MLNkv9uwR3VKhxJ/184nQqAaU
	 osfNWzi7I+dfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BB6A9CE0546; Wed, 12 Feb 2025 02:42:57 -0800 (PST)
Date: Wed, 12 Feb 2025 02:42:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <7f460007-1564-460e-98e4-3d463e7f14ac@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YReLoj+fofM9=fT-G0rz-E0z7vcwg_ANrbfCrPOX99tYA@mail.gmail.com>
 <CAEXW_YQaC+TYnXZca2MBcJQgf2EWD+pBp-Dih+b647RtpJ+LNQ@mail.gmail.com>
 <83f5a3ff-8f89-4994-844f-b7eb9e80b16d@paulmck-laptop>
 <CAEXW_YTiX2taVbg3keCR4RuxSdfpVA0fVPpCcDWXjF7rH7Kkdw@mail.gmail.com>
 <CAEXW_YTduDBJY2CbkStWc3-4MP06+bJVFmEbgvfayB6BQyyksw@mail.gmail.com>
 <76ea9e49-c8d9-4ddf-8dd5-65ba4096e242@paulmck-laptop>
 <CAEXW_YSxGb3ph-bBiWsOJS-C2XvW9FUuwtoM1eFVxPomMKUd5A@mail.gmail.com>
 <CAEXW_YS4wD1WJm3fGukyf_rUTZoe9Rmbs2rphLntmo2NbYG--A@mail.gmail.com>
 <CAEXW_YQkpiQeGat1WhUgMgd3qDWSTBnD6ivc-vdhUHK-6yaUAQ@mail.gmail.com>
 <b9510edf-47ed-4eeb-9259-259445a1fe82@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9510edf-47ed-4eeb-9259-259445a1fe82@paulmck-laptop>

On Wed, Feb 12, 2025 at 02:14:19AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 10, 2025 at 08:22:24PM -0500, Joel Fernandes wrote:
> > On Mon, Feb 10, 2025 at 7:28 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > On Mon, Jan 27, 2025 at 1:45 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > On Mon, Jan 27, 2025 at 11:49 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > On Sun, Jan 26, 2025 at 09:58:11PM -0500, Joel Fernandes wrote:
> > > > > > On Sun, Jan 26, 2025 at 9:55 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > On Sun, Jan 26, 2025 at 9:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > On Sun, Jan 26, 2025 at 08:22:23PM -0500, Joel Fernandes wrote:
> > > > > > > > > On Sun, Jan 26, 2025 at 8:13 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > > > > Hi, Paul and Frederic,
> > > > > > > > > >
> > > > > > > > > > [...]
> > > > > > > > > > > > > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbecker wrote:
> > > > > > > > > > > > > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a écrit :
> > > > > > > > > > > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > > > > > > > > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > > > > > > > > > > > > --- a/kernel/rcu/rcu.h
> > > > > > > > > > > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > > > > > > > > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> > > > > > > > > > > > > > >  {
> > > > > > > > > > > > > > >         unsigned long cur_s = READ_ONCE(*sp);
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > > > > > > > > +       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > > > > > > >
> > > > > > > > > > [...]
> > > > > > > > > > > > > > The way I understand it is that rcu_state.gp_seq might be seen started while
> > > > > > > > > > > > > > root_rnp->gp_seq is not. So rcu_seq_snap() on the started rcu_state.gp_seq
> > > > > > > > > > > > > > may return maximum 2 full GPs ahead of root_rnp->gp_seq. And therefore it takes below
> > > > > > > > > > > > > > 2 GPs to safely deduce we wrapped around.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Exactly!
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK + 1))) ?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Quite possibly.  I freely admit that I allowed a bit of slop because
> > > > > > > > > > > > > time was of the essence (holidays and all that) and also it does not
> > > > > > > > > > > > > hurt much to lose a couple of counts out of a 2^32 cycle, to say nothing
> > > > > > > > > > > > > of the common-case 2^64 cycle.  It would not hurt to be exact, but it
> > > > > > > > > > > > > would be necessary to convince ourselves that we were not off by one in
> > > > > > > > > > > > > the wrong direction.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I would be happy to see a patch, as long as it was sufficiently
> > > > > > > > > > > > > convincing.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm not so much concerned about being exact but rather about making
> > > > > > > > > > > > sure we still understand what we did within one year. We can leave one
> > > > > > > > > > > > more grace period than what we expect out of paranoia but, the most
> > > > > > > > > > > > important is that we comment about what we expect and why. Let me
> > > > > > > > > > > > prepare a patch for that.
> > > > > > > > > > >
> > > > > > > > > > > Even better!
> > > > > > > > > >
> > > > > > > > > > Do we really have users who could pass such a huge delta wrapped
> > > > > > > > > > around value to poll() i.e > ULONG_MAX/2 ?  For 32-bit, that would be
> > > > > > > > > > 2 billion count since the get() (500 million GPs on 32-bit?). I am
> > > > > > > > > > curious if such a scenario should be a WARN() because also: If more
> > > > > > > > > > than ULONG_MAX/2 values are possible after get(), then a full or
> > > > > > > > > > multiple ULONG_MAX wraparound is also possible. This means then both
> > > > > > > > > > rcu_seq_done() and rcu_seq_done_exact() become unreliable anyway for
> > > > > > > > > > such stale get() values.
> > > > > > > > > >
> > > > > > > > > > I do agree with both your points on the side effect of the patch to
> > > > > > > > > > rcu_seq_done_exact(), but I am not fully convinced myself about
> > > > > > > > > > utility of rcu_seq_done_exact() versus the rcu_seq_done() but I could
> > > > > > > > > > be missing something.
> > > > > > > > >
> > > > > > > > > I want to modify my comment on reliability. rcu_seq_done_exact() is
> > > > > > > > > certainly more "reliable" than rcu_seq_done() for wraparound delta  >
> > > > > > > > > ULONG_MAX/2. Still with such a huge wrap around it is not fail proof
> > > > > > > > > if it lands within the "3 Grace period" window, so if it is not super
> > > > > > > > > reliable and if the user should not rely on it, then I wonder if it is
> > > > > > > > > better to not do it and instead warn the user they are playing with
> > > > > > > > > fire. But a counter-argument might be, landing within the 3 GP window
> > > > > > > > > is quite low probability...
> > > > > > > >
> > > > > > > > It is also a harmless false negative.  And another poll within a few
> > > > > > > > hundred milliseconds will set things straight.  In contrast, if we
> > > > > > > > used rcu_seq_done(), it would be a good long time before we got out of
> > > > > > > > false-negative territory.
> > > > > > >
> > > > > > > True!
> > > > > > >
> > > > > > > > On a 32-bit system, if there was an expedited grace period every 10
> > > > > > > > microseconds (just barely possible on small systems), then a 32-bit
> > > > > > > > counter would wrap in about 12 hours.  So there would be a six-hour
> > > > > > > > false-negative zone.
> > > > > > > >
> > > > > > > > So an expedited grace period every 10 microseconds combined with
> > > > > > > > a six-hour polling delay is unlikely, but not out of the realm of
> > > > > > > > possibility.
> > > > > > >
> > > > > > > Assuming that every 10 microsecond of the entire 6 hours is used for
> > > > > > > an expedited GP, but I agree with your point.
> > > > > > >
> > > > > > > > Please feel free to nominate a comment.
> > > > > > >
> > > > > > > Ok thanks, I'll see what Frederic comes up with and can take it from there.
> > > > > >
> > > > > > I forgot to ask is the reason for keeping rcu_seq_done_exact() to have
> > > > > > more complexity only when needed, or does it make sense to rename
> > > > > > rcu_seq_done_exact() as rcu_seq_done_done() and get rid of the old
> > > > > > rcu_seq_done()?
> > > > >
> > > > > We might well be able to use the rcu_seq_done_exact() algorithm for
> > > > > all the uses, but that will require very careful review and testing.
> > > > > Please keep in mind that there are quite a few uses, that the benefit
> > > > > is small, and I was lazy.  ;-)
> > > > >
> > > > > The difference with the polling APIs is that a user might well
> > > > > legitimately hang onto a cookie for six hours, for example, by having
> > > > > used it to tag a data structure in a block cache or similar.
> > > >
> > > > Thanks for clarification. I will work on a patch along these lines and
> > > > see if it is worth doing.
> > >
> > > Here I think there is a real issue:
> > >
> > > poll_state_synchronize_srcu() uses rcu_seq_done()
> > >
> > >     if (cookie != SRCU_GET_STATE_COMPLETED &&
> > >         !rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
> > >         return false;
> > >
> > > where as poll_state_synchronize_rcu() uses rcu_seq_done_exact()
> > >
> > > bool poll_state_synchronize_rcu(unsigned long oldstate)
> > > {
> > >     if (oldstate == RCU_GET_STATE_COMPLETED ||
> > >         rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
> > >
> > > I believe rcu_seq_done_exact() makes more sense for polling API, as
> > > there is a higher chance that there is a significant delay between the
> > > get_state..() and poll_state..() calls.
> > >
> > > I think I am pretty convinced now looking at all the call sites that
> > > rcu_seq_done_exact() should be used everywhere. I am vetting more
> > > callsites, but that's what I'm leaning towards. I think
> > > rcu_seq_done_exact() makes the code more robust to false-negatives
> > > (duration during which a false-negative is in effect)...
> 
> I don't recall anything needing the large region of false negativity,
> but there is much that I do not remember.  ;-)
> 
> > I was wondering if this can go wonky a little bit (not bug, just
> > optimization issue):
> > 
> > __note_gp_changes() sees rdp->gpwrap is set.
> > 
> > rnp->gp_seq had overflown and so now < rdp->gp_seq when the
> > rcu_advance_cbs() is called.
> 
> The rdp->gpwrap is set quite some time before overflow, and it is set
> by the grace-period kthread.  Which in theory prevents it from advancing
> while setting ->gpwrap.
> 
> > rcu_advance_cbs() uses the rnp->gp_seq to do the advancing.
> > 
> > All the CBs that could be advanced don't move because their gp_seq is
> > > rnp->gp_seq due to the overflow.
> 
> That would require a long delay in rcu_advance_cbs(), and isn't this delay
> (from the viewpoint of the "clock" embodied by the grace-period sequence
> number) prevented by the fact that the leaf rcu_node structure's ->lock
> is held?
> 
> > It is probably a slight delay in CB execution and not that big a deal.
> > I am not saying this is an issue but something I observed when reading
> > code.
> > 
> > I also got to go audit rcu_seq_completed_gp() to see the implications
> > of the ULONG_CMP_LT in it...
> 
> Wouldn't we want this comparison to work the same way as that of
> rcu_seq_done()?  As in, if we change rcu_seq_done(), shouldn't we
> also change rcu_seq_completed_gp()?  (Not necessarily in the same
> patch, but at the same time.)

We also have uses of ULONG_CMP_*() in rcu_seq_started(), rcu_seq_new_gp(),
rcu_seq_diff(), rcu_segcblist_advance(), rcu_segcblist_accelerate(),
poll_state_synchronize_srcu(), srcu_gp_is_expedited(), srcu_gp_start(),
srcu_gp_end(), srcu_funnel_exp_start(), srcu_funnel_gp_start(),
srcu_should_expedite(), srcu_gp_start_if_needed(), srcu_advance_state(),
srcu_reschedule(), rcu_gpnum_ovf(), rcu_start_this_gp(),
rcu_future_gp_cleanup(), rcu_accelerate_cbs_unlocked(),
__note_gp_changes() (as you noted), rcu_gp_cleanup(),
exp_funnel_lock(), rcu_exp_wait_wake(), show_rcu_gp_kthreads(), and
rcu_check_gp_start_stall().

For other similar issues, there is rcu_torture_reader_do_mbchk(),
->srcu_idx in srcu_drive_gp() and friends, rcu_nocb_try_bypass(),
and nocb_gp_wait().

There is also a ULONG_CMP_LT() that should now be time_before()
in rcu_torture_stall_one().  There is a ULONG_CMP_GE() that should
be time_after() in print_other_cpu_stall(), print_cpu_stall(), and
print_other_cpu_stall().  The check_cpu_stall() function has both.

One could argue that the diagnostic output wants ULONG_MAX/2 of false
negative.  But what makes the most sense?  Can we get rid of both
ULONG_CMP_GE() and ULONG_CMP_LT()?

							Thane, Paul
