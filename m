Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F13BD24C
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914743; cv=none; b=M0bEK5c7V/4jEgiz3dHIhCGJz5hDPP39C2z1TvqoMxWwExoSQUWcXwYyfyJ/b3M6oKnkyprdgSVZP7o8eDPZhsc5aHMpYIFB+aD6YG7cswc2/kF4sPQJBPMb6jNPqInSHMwwMdFL/m0d39tvH9zo3WwmQuK69j2xZsNddqp25mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914743; c=relaxed/simple;
	bh=xu70wuVXcgW8KwEksjeoHeITcBETBLw6wgrhoYdu9/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wp9856KQW+NW21ZfGTEUi4RNniBAQVZ15wCg1nXEbo6yk4XpGfQpJy1Fg3PYjfHWU6gkmcYfHswre8Mi5NmCcHnFTpfqyA1ytb9urPMABGAH62cBgT855ngz8IzVvxmYiN8bOfOe0pEpYGye50NuUqugbWEHDlwfZSkapzHjiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvy92lGS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvy92lGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B99C2BC87;
	Thu, 19 Mar 2026 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914743;
	bh=xu70wuVXcgW8KwEksjeoHeITcBETBLw6wgrhoYdu9/4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mvy92lGSYbBU9cwONKU0DMKT4LtQIaNXrROgAyz3cTQFnhQrlFZxuxrbjaV9cf+sh
	 jp1696bEJ/lK1/1mcauUGQLpNBLtWJRbZAOWcv1fCcKnJaFFz8LAQVjcLLdnYem3fo
	 1Jx1xshv23JjBNVFm2e2DnAh+aFLNbW6lwR29N5KWkaGqcXpG2SgtXej+6kpaM+OG9
	 YW8fC1yrbwJhVl7RGxtV8ZRCOo3JbZB/BYviq3fxTPnM/paWI5DsT43vycHAidGPA7
	 avHN4yh8T6yvU/2ExWYVnv1QusdrXGwaIsrITuossiNgD7QLdcX7h04hNM4NX6+kJe
	 SktpzxoZbfwCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33C8ECE0C97; Thu, 19 Mar 2026 03:05:40 -0700 (PDT)
Date: Thu, 19 Mar 2026 03:05:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <b449bfaf-9a52-492c-bbcd-4756c0a14eb4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de>
 <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de>
 <76ef9a5e-7343-4b8e-bf3c-cabd8753ecdb@paulmck-laptop>
 <20260318160445.IyUiWV0T@linutronix.de>
 <06a0cb91-1737-4691-a810-8340e1acf1d6@paulmck-laptop>
 <20260318164710.gUolNYgg@linutronix.de>
 <9b685d13-5496-4bc9-ab6a-508bd4bf0f16@paulmck-laptop>
 <20260319085548.UZQk1cyW@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319085548.UZQk1cyW@linutronix.de>

On Thu, Mar 19, 2026 at 09:55:48AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-18 11:48:56 [-0700], Paul E. McKenney wrote:
> > We would need a lockless enqueue, which we have in llist.h.
> 
> Only if CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG. Otherwise you must not
> provide call_rcu_nmi().

I *think* that BPF is provided only in such architectures, so agreed.

> > The irq-work to actually do the call_rcu() or similar.
> 
> reasonable.
> 
> > There would also need to be rcu_barrier() changes, for example, to
> > drain all the llists.
> > 
> > > I mean I am curious here who needs it any why ;)
> > 
> > You got it right above, BPF.  ;-)
> > 
> > They currently check in_nmi() and to the irq-work step themselves.
> 
> Then it would make sense since you do actually have users.

For more fun, they would like to attach BPF programs to call_rcu() and
call_srcu() internals, which would require a per-task recursion check.
Or perhaps some other trick.

							Thanx, Paul
