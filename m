Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F51A23BA
	for <rcu@vger.kernel.org>; Sat, 15 Feb 2025 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615341; cv=none; b=DWhGPdxJXPDyMyRZLJz8NsHRozUVa9GpQRkPHFQRbyfv9MeCj7+dBfiglnVYTGuD3FWyFY8cOBqhcmRQoJ69+lmL2ij/VLm0eFYjaZfd4ecjMBpfuTzLzLXiNOc0F3wUWMBANJDfnQfWYT+H1o/WqT+t7D9xPBLr/gH4XIxrAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615341; c=relaxed/simple;
	bh=SYoLYYHRLMDBJaURS8NJiTG+9B1+Rz9BwrhY3jwrFds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNz51r5I24811o91w6JFZhsQ5f6cO+J1T4N71n11HirHHaY2rU1Y5dL2Q6cGjXtp8Xy1uQ3URutHg8dbY1BvReWz4ERbge2drJIqlpruzUNj5LfGOypa5bb1GtgFa2DmmwFxqGdRPvuH7geRitTTWE8pRYivXjs+HR6uFhTO0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di6yrWqQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di6yrWqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C37C4CEDF;
	Sat, 15 Feb 2025 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739615341;
	bh=SYoLYYHRLMDBJaURS8NJiTG+9B1+Rz9BwrhY3jwrFds=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Di6yrWqQ2ZMjsVVrnkzdy3EX80cyoylUXJ/pBuICfFXDbMjYKm7d9gTP+eCXxGtaY
	 WEX1y8hNCBNXaLJJlL1scZnymtU3nMBNgTo37529qbFqBs4d3FfLxhEb0Y2wZ6hQwG
	 xqTcHmdxMpSWX77bnI6erdlbHGXHw68I2T2tPKG8X4XvPQlA9C/FbXcZBLpj6VMr1K
	 1O1oeY5zNpxPgkvDFdVM8X15zhNcJXaC9w3VrRxH+WaFryKTaN5bXPnQP8nW95vjDi
	 oy3tmksWlAjquF2QzkQiOtTZSwsH7MHPPgfKpzf6TlklsJuuRTT+Zpt8bbEpBkmBb7
	 CJlb7v4Js7rxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A2B14CE092A; Sat, 15 Feb 2025 02:28:58 -0800 (PST)
Date: Sat, 15 Feb 2025 02:28:58 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org
Subject: Re: The rdp->gpwrap behavior
Message-ID: <d1ebe3a6-42d9-489e-8df2-9dc8c2635a61@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213183033.GA2635051@joelnvbox>
 <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
 <009ef653-f41e-4101-886e-d9a4ce4d6e32@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009ef653-f41e-4101-886e-d9a4ce4d6e32@nvidia.com>

On Fri, Feb 14, 2025 at 01:03:40PM -0500, Joel Fernandes wrote:
> Hi Paul,
> 
> On 2/14/2025 3:20 AM, Paul E. McKenney wrote:
> > On Thu, Feb 13, 2025 at 01:30:33PM -0500, Joel Fernandes wrote:
> >> +rcu for archives
> >>
> >> Hi,
> >>
> >> Following up about our gpwrap discussions, I did some tracing of rdp->gpwrap
> >> with just boot testing.
> >>
> >> I actually never see it set because rdp->gp_seq and rnp->gp_seq are usually
> >> very close.
> >>
> >> Example trace:
> >>
> >> # rnp->gp_seq starts with -1200 on boot and then right around the wrap:
> >>
> >> 178.096329: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap before: 0
> >> 178.096330: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap after: 0
> >> 178.100327: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap before: 0
> >> 178.100328: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap after: 0
> >>
> >> The wrap "before" and "after" are the value of gpwrap before and after
> >> calling rcu_gpnum_ovf().
> >>
> >> Closer look at the _ovf() shows it should be only set if rdp->gp_seq and
> >> rnp->gp_seq are quite a distance apart (say if the CPU was idle for too long
> >> and many GPs have passed. This can happen both with/without wrap. So imminent
> >> wrapping seems not necessary for ->gpwrap to be even set AFAICS.
> >>
> >> I think the problem is ULONG_CMP_LT is not really "<" so even after wrap, it
> >> can false. i.e if rdp->gpseq + ULONG/4 wraps, it could still return false.
> > 
> > Exactly, and all of that is in fact the intended behavior.
> 
> Ah I think I get it now, so the wrap isn't really about the counter wrapping
> causing an issue, but about the design of the ULONG_CMP APIs which are designed
> for comparisons that wrap around. Due to this design, there is a side effect
> that the numbers being compared have to be at a distance that is less than half
> the number wheel. Otherwise the comparisons of numbers yields incorrect results.
> Is that accurate to say?  IOW, ->gpwrap == true means, don't compare the numbers
> anymore till we sort these huge deltas out.

But "incorrect" is such a harsh and judgmental word.  ;-)

Somewhat more seriously, ULONG_CMP_{GE,LT}() are defined to return the
sign (or its complement) of differences between a pair of 32-bit or 64-bit
numbers, as sizeof(unsigned long) dictates.  This is, mathematically,
how you do signed differences.  The result coming out negative isn't
incorrect, but instead the expected result given the numbers in question.

Current RCU use cases might interpret a negative result as "no one did
it for us yet", as in rcu_barrier(), "this CPU has not completed the
current grace period", as in __note_gp_changes(), and so on.

Now, these can get a false-positive/-negative result.  In the case of
rcu_barrier(), we get a needless rcu_barrier() computation.  In the case
of __note_gp_changes(), the false negative is OK, but a false positive
from wrapping all the way around, could be fatal for a CPU that was idle
for a long time (hence ->gpwrap).  And so on.

> >> >From a testing POV, the example shows it is not set even when around when a
> >> wrap actually happened.  So may be, we are not testing gpwrap much, or at
> >> all, with rcutorture?
> > 
> > True enough, and that would be well worth fixing.
> > 
> > One simple (and maybe too simple) fix is to add a Kconfig option to
> > kernel/rcu/Kconfig.debug that makes rcu_gpnum_ovf() use something like
> > (32 << RCU_SEQ_CTR_SHIFT).  This, or some similar value, should cause
> > rcutorture's stuttering and/or shuffling to trigger setting of ->gpwrap
> > within a few minutes.
> > 
> > And I would not be surprised if doing this located bugs.
> 
> Ok cool! So I will work on this next then. I am curious to see how often it
> triggers both with/without such a change.

If you can make it trigger without this change, you are far more patient
than I am.  ;-)

> >> But before that, I am feeling it is not behaving correctly. I'd expect it to
> >> be set even if rnp and rdp values are close but we are actually about to
> >> wrap.  So most likely I am missing something.
> > 
> > If I understand correctly, you would like ->gpwrap to be set
> > unconditionally at various points in the cycle, for example, at zero,
> > ULONG_MAX/4, ULONG_MAX/2, and 3*ULONG_MAX/4.  But this could easily
> > have the effect of discarding each CPU's quiescent states that showed
> > up before the first call to rcu_watching_snap_recheck(), even if that
> > CPU was active.  Our users might not consider this to be a friendly act.
> 
> Got it.
> 
> > In contrast, the current setup only discards quiescent states for CPUs
> > that just came back from idle prior to call to rcu_watching_snap_save().
> 
> Do you mean the check of ->gpwrap in rcu_report_qs_rdp() which returns early?

Well, it also resets the CPU to collect quiescent states for the current
grace period, but yes, it does return early.

> > In addition, use of the aforementioned Kconfig option has the benefit of
> > making any ->gpwrap-related bugs appear during testing, not in production.
> > On the same grounds, one could argue that absence of this Kconfig option
> > should also cause gp_seq to zero rather than the current;
> > 
> > 	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
> 
> Hm, I think it still make sense to the do -300 even without debug options, just
> so we have a true wrap early on, regardless of which APIs we use for comparison.

It has certainly been as it is for a long time, so agreed.

							Thanx, Paul
