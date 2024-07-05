Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BEB16D9A4
	for <rcu@vger.kernel.org>; Fri,  5 Jul 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201166; cv=none; b=M7oSedIJig8YVa8g698UZUuvJun2TsJJwySakVLZfr/rFihU9LlXZnUkidd56fXonLqRoeqXTa34OJPxiXN9tGZgYiCG91Rk0gadK/EV4BvDe+6skkfewCwSYP9tfojdSxk5LJy6OuUK+jRNl/9HQGtgopTnnj4+4CrhC8j8OT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201166; c=relaxed/simple;
	bh=rQ3bIaBNPE665FP1PFesgZ5MB098e0LREV8YsP4qGn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXtItkqUwzkXD+bjw95r0bnDSGeSRpghRjyWhRUi48nUyL1ifn6nerppsa84JO5t+kWWdzPoUpYHAJOURm2I4V4OEKz/NEwGXJZSDHAwnPbZIA4OVh9AQUqfAgzbrAjwvDlyE4MFhqgetGHEJWmm6L38J3J3rfxUDfRJfUOT+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bziOXSda; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bziOXSda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3FFC116B1;
	Fri,  5 Jul 2024 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720201166;
	bh=rQ3bIaBNPE665FP1PFesgZ5MB098e0LREV8YsP4qGn8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bziOXSdaQwGh3bg6Wsiis4/1gVQrDE74vsQNZNyZ/pdn2guEaK18097Br4KZJVVax
	 vVRtznKVCfPfcLxySBIGmr//62vontnpArIZSsVcWKJv0OQ6pD2LPD2KbIeNplrqsl
	 O+zEukvnTbskF6vZbdydq1eQWvaAgid9Cc9kaktk5Uu59WIGZ/CTgRsdrW59AW99la
	 ka8WC1xMVSuHDxuArT7jXC0JuAnlY12oSdow+VBSaJoc8JA5YSRCpRd9MCytwVP9e1
	 wquKI6aj7lbctoJp8S+TYSaagd8wQLllnb8XC+/frHx7yUWwoEfJgdcJSJ8XeUbnkR
	 3O+YtLeTbeb7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA4F6CE0A34; Fri,  5 Jul 2024 10:39:25 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:39:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wakes of the rcuc/ thread on isolated CPUs.
Message-ID: <b73f21c1-cee8-405f-8eb2-52d79320052f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240705161240.HiOFN5hH@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705161240.HiOFN5hH@linutronix.de>

On Fri, Jul 05, 2024 at 06:12:40PM +0200, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> I noticed this on an older kernel and reproduced it on -rc6: I boot the
> (RT) kernel with
> 	isolcpus=4-15 nohz=on nohz_full=4-15 rcu_nocbs=4-15 rcu_nocb_poll
> 
> and compiled a NOHZ_FULL kernel. If I pin a shell onto the isolated CPU
> and do nothing then everything seems fine. If I issue commands, this
> happens:
>    tick_nohz_handler() -> update_process_times() -> rcu_sched_clock_irq()
> 
> rcu_sched_clock_irq() invokes rcu_pending() which returns true due to
> |         /* Have RCU grace period completed or started?  */
> |         if (rcu_seq_current(&rnp->gp_seq) != rdp->gp_seq ||
> |             unlikely(READ_ONCE(rdp->gpwrap))) /* outside lock */
> |                 return 1;
> 
> And it is the first check of the two. Later I see 
> |         /* Is the RCU core waiting for a quiescent state from this CPU? */
> |         gp_in_progress = rcu_gp_in_progress();
> |         if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm && gp_in_progress)
> |                 return 1;
> 
> which triggers it but then "later" it fallbacks to the first case again.
> In both cases it wakes the rcuc/ thread on the isolated CPU.
> 
> Is this something that needs to happen on the isolated CPU or can this
> be excluded for rcu_rdp_is_offloaded() CPUs?

As a workaround, the following commit in -rcu that is slated for
the upcoming merge window addresses a similar case involving KVM and
nohz_full:

68d124b09999 ("rcu: Add rcutree.nohz_full_patience_delay to reduce
nohz_full OS jitter")

The KVM guys found that setting rcutree.nohz_full_patience_delay to 1000
(AKA one second) made things work better for them.  Does this help your
use case?

This is again a workaround.  Clearly, it would be better if we could
eliminate that second rcuc wakeup.  I tried something similar some time
back, and there was a problem with it.  I will see if I can reconstitute
the corresponding brain cells.

But in the meantime, one advantage of the workaround is that in the
common case, it would reduce the number of rcuc wakeups to zero, rather
than to just one.

Thoughts?

							Thanx, Paul
