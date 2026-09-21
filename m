Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B254FB9AB;
	Mon, 21 Sep 2026 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025273; cv=none; b=oVGy8AcMJKg6/T/1esp0nm+ZJ+uLfHr//i8TpcYRiOF1L1CISpe/3YWlT2z92I1AGcJflWHr4mw/TCUOYVEtMhZ+wW/KBGDAm+JQ2lGlUkdioeyOExGyHjHCsUM9QiIedwKH+Zmgrj0jnOByE3I/eBLLVUdXY+AzDudOhipR1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025273; c=relaxed/simple;
	bh=bsfZeOTA7JOZFY6p2g+PrCTUNPsCyRgMS5WqkkbZ7bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JELa+Xsm+YNoHMTIJXbfugIHtp26d+5ubyKXxuPNFslYl6T+Yxs9NaiYNDyY8Xrwhg2cuZSlXVXvcRrqBOwqU3lg1Cblg7Od3sg2WiiiXBl5qx5IVoJkvcb0fbrxdFqBWEMK5o6Q4IMKd3DKyHhWptf9dZU4hWYtPt66hiWcVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErM2Fuyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErM2Fuyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69161F00898;
	Mon, 21 Sep 2026 21:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790025271;
	bh=DrXcZsfczcwr/hIIMkLYXk6XLU5JJdjxbSOMA9FHHX0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ErM2FuyndbwgemX8a85YrlCbVi7lnp2b8oSu254n6397PHoifjC93i0S+CVyJvZ1P
	 ghl4ejm260oHoEXZ6BTalgcAi6dYjKwn2jq3g+nVv8xbrctuenOD7dN5xZKMSFTpPg
	 FFD3pPiHmZqzblBSLuEOSoRS5W2fhVS0Rlq0Qex+DT/KW4yhdzfC7LPOaysvv7ooTz
	 kXVBkw+Eu0SSN3ovQTVuUfja3MPOnZ3mwKfUpvIBRx/tJgvMsSPfxamgePOoBIkcM1
	 YHk7CVTQNbzYcJDsGrbGg2O62yBH1em1e+t3uvg2ZCQFYz7OU+zJxdMNRIzbD8hIGn
	 VdlJSYgnvVd4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 641F1CE0ABC; Mon, 21 Sep 2026 14:14:31 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:14:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, jiangshanlai@gmail.com,
	josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] srcu: Add lockdep coverage for atomic SRCU and fix
 IRQ-state bug
Message-ID: <8779d1dd-7a9e-44ca-b41f-8459745e28d4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260914093419.1474829-1-kunwu.chan@gmail.com>
 <arGTMdkrE3oMcBq3@MacBook-0RXW5>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arGTMdkrE3oMcBq3@MacBook-0RXW5>

On Mon, Sep 21, 2026 at 10:27:29PM +0200, Boqun Feng wrote:
> On Mon, Sep 14, 2026 at 05:34:14PM +0800, Kunwu Chan wrote:
> > The atomic SRCU fastpath enables synchronize_srcu_atomic() to be called
> > from contexts with interrupts disabled. This series extends the
> > rcutorture lockdep tests to cover the atomic SRCU path and fixes an
> > IRQ-state preservation bug discovered along the way.
> >
> > Patch 1-2 add lockdep test coverage for atomic SRCU:
> > - testtype 4: same-type atomic SRCU deadlock
> > - testtype 5: atomic SRCU + raw spinlock dependency cycle
> > - testtype 6: rcu_read_lock() -> synchronize_srcu_atomic()
> >   legitimate nesting, must not trigger lockdep warning
> >
> > Patch 3 fixes a bug where the synchronize_srcu_atomic() call chain
> > unconditionally re-enables interrupts on unlock, by switching to the
> > irqsave/irqrestore variants throughout the call chain.
> >
> > Patch 4 fixes a pre-existing double nerrs count in the script.
> >
> > Patch 5 adds testtype 7: cross-CPU IRQ context mismatch detection,
> > where an atomic SRCU reader held with IRQs enabled on one CPU is
> > paired with synchronize_srcu_atomic() via IPI on another CPU.
>
> Acked-by: Boqun Feng <boqun@kernel.org>

Queued for testing and further review, thank you both!

						Thanx, Paul

> Regards,
> Boqun
>
> > Kunwu Chan (5):
> >   rcutorture: Add atomic SRCU lockdep support
> >   selftests/rcutorture: Wire atomic SRCU into srcu_lockdep.sh
> >   srcutree: Preserve IRQ state in synchronize_srcu_atomic() callchain
> >   selftests/rcutorture: Fix double nerrs count in srcu_lockdep.sh
> >   rcutorture: Add atomic SRCU cross-CPU IRQ context mismatch test
> >
> >  kernel/rcu/rcutorture.c                       | 109 +++++++++++++++++-
> >  kernel/rcu/srcutree.c                         |  42 ++++---
> >  .../selftests/rcutorture/bin/srcu_lockdep.sh  |  77 ++++++++++++-
> >  3 files changed, 205 insertions(+), 23 deletions(-)
> >
> > --
> > 2.43.0
> >
> >
