Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E54221D90
	for <rcu@vger.kernel.org>; Fri, 14 Feb 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521254; cv=none; b=QUDe2JU1AzXDmrHXfmjbOco0eoowxfRCaIIuAtFYt4LqwmPYBRLqz46nZI9eTS6qH/S6viRXaXjBzGMaXznhOK9FAo2EQmTGKe1vj8crRKy8vaq2dagoR3aZhxRtSQf8xg48UFq8q1OWhk4zHlHzUeFMJfGWpg3u9SPpyP94PLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521254; c=relaxed/simple;
	bh=JOeel8AXhlTyz1kYCHLHepTD4D4xb+OS61FFE4NGmOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO6ioEjQb49P0iaH0sxGsBl/VrDil28WGq1ONa2PVZt+IoOlL4DAf5U7E0mUKJzHluQ1JkgKNhDSm4E1ZJleHWrGfQ81fFcOSL0ytsPhIgRoOmgG0cMskaeJzoKwq8AOst9kGsJKBWk59X4CvpG3FM52qob29Vza1FaRPOHeIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPpG9RvB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPpG9RvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54A8C4CED1;
	Fri, 14 Feb 2025 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521254;
	bh=JOeel8AXhlTyz1kYCHLHepTD4D4xb+OS61FFE4NGmOI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TPpG9RvBDOTVB5tzPTqtD6wsn7rwSlc6rfocYlphxEg7cRhXiujHqvOO0jalgZlNj
	 TXWghD0MpouUNCKpJuUuX/FsqqrZ2unjM7LOTgJyQ9fIoYEDC+qfkyD2/SWfwAiejA
	 vHm//ORao1K9YU4Z5nChdH1QdhCS+T8L4UIdaL3Rsfk6Vocq2uBqYILRFkv8eHHm2/
	 NSeFNYC1oC/Tz3ui6vtuwh1iJac0Sug+ZKXj4HaB60U2W5o84Awuk+jkbPaNID7qsh
	 pibtorQhzKI6OZQOQ7EWRr4cLgQfp9PSTSOI09FZ1WlOTAlEKmkzV16JGJFBzVhKxh
	 vBWPl89Go495g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CF1BBCE0402; Fri, 14 Feb 2025 00:20:49 -0800 (PST)
Date: Fri, 14 Feb 2025 00:20:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org
Subject: Re: The rdp->gpwrap behavior
Message-ID: <b04b997e-fee6-4c5f-a0f9-12e671d27f8c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213183033.GA2635051@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213183033.GA2635051@joelnvbox>

On Thu, Feb 13, 2025 at 01:30:33PM -0500, Joel Fernandes wrote:
> +rcu for archives
> 
> Hi,
> 
> Following up about our gpwrap discussions, I did some tracing of rdp->gpwrap
> with just boot testing.
> 
> I actually never see it set because rdp->gp_seq and rnp->gp_seq are usually
> very close.
> 
> Example trace:
> 
> # rnp->gp_seq starts with -1200 on boot and then right around the wrap:
> 
> 178.096329: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap before: 0
> 178.096330: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: -3 (0xfffffffffffffffd), rdp->gp_seq: -3 (0xfffffffffffffffd), wrap after: 0
> 178.100327: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap before: 0
> 178.100328: rcu_gpnum_ovf: CPU: 2, rnp->gp_seq: 1 (0x1), rdp->gp_seq: 1 (0x1), wrap after: 0
> 
> The wrap "before" and "after" are the value of gpwrap before and after
> calling rcu_gpnum_ovf().
> 
> Closer look at the _ovf() shows it should be only set if rdp->gp_seq and
> rnp->gp_seq are quite a distance apart (say if the CPU was idle for too long
> and many GPs have passed. This can happen both with/without wrap. So imminent
> wrapping seems not necessary for ->gpwrap to be even set AFAICS.
> 
> I think the problem is ULONG_CMP_LT is not really "<" so even after wrap, it
> can false. i.e if rdp->gpseq + ULONG/4 wraps, it could still return false.

Exactly, and all of that is in fact the intended behavior.

> >From a testing POV, the example shows it is not set even when around when a
> wrap actually happened.  So may be, we are not testing gpwrap much, or at
> all, with rcutorture?

True enough, and that would be well worth fixing.

One simple (and maybe too simple) fix is to add a Kconfig option to
kernel/rcu/Kconfig.debug that makes rcu_gpnum_ovf() use something like
(32 << RCU_SEQ_CTR_SHIFT).  This, or some similar value, should cause
rcutorture's stuttering and/or shuffling to trigger setting of ->gpwrap
within a few minutes.

And I would not be surprised if doing this located bugs.

> But before that, I am feeling it is not behaving correctly. I'd expect it to
> be set even if rnp and rdp values are close but we are actually about to
> wrap.  So most likely I am missing something.

If I understand correctly, you would like ->gpwrap to be set
unconditionally at various points in the cycle, for example, at zero,
ULONG_MAX/4, ULONG_MAX/2, and 3*ULONG_MAX/4.  But this could easily
have the effect of discarding each CPU's quiescent states that showed
up before the first call to rcu_watching_snap_recheck(), even if that
CPU was active.  Our users might not consider this to be a friendly act.

In contrast, the current setup only discards quiescent states for CPUs
that just came back from idle prior to call to rcu_watching_snap_save().

In addition, use of the aforementioned Kconfig option has the benefit of
making any ->gpwrap-related bugs appear during testing, not in production.
On the same grounds, one could argue that absence of this Kconfig option
should also cause gp_seq to zero rather than the current;

	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,

One argument against is that production 32-bit systems can wrap ->gp_seq
in a relatively short time.  Maybe moreso for ->expedited_sequence, so
perhaps leave ->gp_seq and modify ->expedited_sequence.  Maybe similar
decisions for others as well.  ;-)

							Thanx, Paul
