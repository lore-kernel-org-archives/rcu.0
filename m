Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6D17F368;
	Wed, 12 Jun 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203582; cv=none; b=qqsGPPMTFgO+V+zgyECXL9Y2LA45DqdxA/YMpte97X+Rik66+V3+NRhPdYE06GxehkSemUKnFlHuNovpkC3L6HK10WWnzuLJfFtbdpBkdtp+rpeuIAxWidKEvM7i04BkyrTv2Xez9mR3/OezS7Lfgu97PvjPEji9cnhcJzdEVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203582; c=relaxed/simple;
	bh=L4ejhDpo8Ae0Wo67dQYTHciD4sD7a4I/kmaobkPCv5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsVAAvFuBqnlCTmY2bLYYIoR0GF0sRpFHZY9ic2dPf9lPefYES2anP14NoCb5aogBysp+YYE0hKzlsJLlf/vzs4WoU/0aecmsgjRAIBFvRCK4R/h5oetNvT/p1nqQ75YuOHvKZX9zRfkJV+0/8ioj8qh4kdzWtb+GaQJ6CBFEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjcufpq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjcufpq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2DBC116B1;
	Wed, 12 Jun 2024 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718203582;
	bh=L4ejhDpo8Ae0Wo67dQYTHciD4sD7a4I/kmaobkPCv5c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qjcufpq2759iQMb5gznpH3AesHahwPKiRRPnTBV/XRZKDw113/0E9227ookW9hNoP
	 sUJIbhvz8xA0QZzIaohcfZBAOmK+wpQN8ECFFXSSZbX1+enuT/fOaaJtcMDk0IbvYt
	 nXqMlse5vLNA5H4Axrp52/piuuPD2F6ZyrkQwqslVd/RFvDiyaGfep/gtqLqk3EW4n
	 0fkgNja5nknPX0U/ptpALb/9mt91D3sRro9Hke47jm5GY14biqRDzHJmO65WYoLrqz
	 QRZBECEmbe0pQkPhFibs2+a5JfGHsFO8hMB/ijPREXBPwtt9Zzj+a92mGK74fjt8F3
	 WdvHtf88CEa9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1FD5CE0886; Wed, 12 Jun 2024 07:46:21 -0700 (PDT)
Date: Wed, 12 Jun 2024 07:46:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/6] Grace-period memory-barrier adjustments for v6.11
Message-ID: <39815e48-a035-4701-9a88-f3b753551b28@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240612094207.GA418202@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612094207.GA418202@neeraj.linux>

On Wed, Jun 12, 2024 at 03:12:07PM +0530, Neeraj Upadhyay wrote:
> On Tue, Jun 04, 2024 at 03:26:46PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series removes redundant memory barriers from the grace-period
> > code paths:
> > 
> > 1.	Remove full ordering on second EQS snapshot, courtesy of Frederic
> > 	Weisbecker.
> > 
> > 2.	Remove superfluous full memory barrier upon first EQS snapshot,
> > 	courtesy of Frederic Weisbecker.
> > 
> > 3.	rcu/exp: Remove superfluous full memory barrier upon first EQS
> > 	snapshot, courtesy of Frederic Weisbecker.
> > 
> > 4.	Remove full memory barrier on boot time eqs sanity check,
> > 	courtesy of Frederic Weisbecker.
> > 
> > 5.	Remove full memory barrier on RCU stall printout, courtesy of
> > 	Frederic Weisbecker.
> > 
> > 6.	rcu/exp: Remove redundant full memory barrier at the end of GP,
> > 	courtesy of Frederic Weisbecker.
> > 
> 
> Reviewed-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

I will apply yours and Boqun's tag on the next rebase, thank you both!

						Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> >  b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |    6 +--
> >  b/kernel/rcu/tree.c                                                     |    2 -
> >  b/kernel/rcu/tree_exp.h                                                 |    8 +++-
> >  b/kernel/rcu/tree_stall.h                                               |    4 +-
> >  kernel/rcu/tree.c                                                       |   19 +++-------
> >  kernel/rcu/tree_exp.h                                                   |    8 +++-
> >  6 files changed, 26 insertions(+), 21 deletions(-)
