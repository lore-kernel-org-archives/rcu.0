Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA720FA96;
	Fri,  9 May 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801180; cv=none; b=UvzTkV8/YNRnLcfzGQCZo9Cw07uKRwEvuWv3/N1kdhypdf7r8n33l/klzP9MMiEtgW6uWgvBOCoTBfUV54/HnDV+aL9iWsptMZcyzfYSIsa4kN0231BIvUwjAE8BfQME52pV7avwA+sLm4ht+q7ecV2G7Zy3yBoLIXc4UFI+q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801180; c=relaxed/simple;
	bh=bnv6WvKGCd+BC4dR2FMi0pVqt0dFJbKiGJOa88vOM5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4RXa34QxA0kRGmqVdfbJwyJyfP1yXmyx1BN8s9lUokRUCF5PF3wrQ1x1TAW/J6ZOOqQcmM1h55bXKKTnh3wQQV3lDJqmK/8lLCyzI5+Zp4XSybWgIOzHfDjLGaqgci/a9dMhHK+pX6+XPFKaCA07pIzZSPfTeke664d/5a0HU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijxhFHRh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijxhFHRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC911C4CEE4;
	Fri,  9 May 2025 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746801179;
	bh=bnv6WvKGCd+BC4dR2FMi0pVqt0dFJbKiGJOa88vOM5Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ijxhFHRhCzuckcLpR/2gUNK+IIaYU1Dhswqz5MoFapT1HxKB1Ql4ElsaTVGzgj88k
	 NbNLYckxKBbCY5U0OMzSXq7Dl0IcMBcLDm2YJy9x0N4uMpPKHh8rU137U6AME7FfKh
	 NgXtvTfkf4RXtdLnUJou6XoKaSB5ruFNVQJEARuQj1g1tmqSHNwxMYXBw5Xyr2UKLS
	 jVtIXlQ3dtT4QvVqV8AwMGGHsgnz+tBX3j3qveeeM/cW6p25JIDLUkcRfydxXA2XqE
	 lIM6Nj2eoFauFSBYW0uos2p8vtwCeU92fYV6i2kwVDQKVMIICcG0FXCJBStNzND8Jz
	 8UL3ovo7Zez5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 65CD7CE083E; Fri,  9 May 2025 07:32:59 -0700 (PDT)
Date: Fri, 9 May 2025 07:32:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/3] Make rcutorture safe(r) for arm64
Message-ID: <bd8dc7fa-92e6-4bd4-9393-d4d66d1227c9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
 <0cabdd10-658e-4577-9b4e-5d4a2641360e@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cabdd10-658e-4577-9b4e-5d4a2641360e@nvidia.com>

On Fri, May 09, 2025 at 09:18:00AM -0400, Joel Fernandes wrote:
> 
> 
> On 5/8/2025 7:42 PM, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series makes a few small updates to make rcutorture run better
> > on arm64 servers.  Remaining issues include TREE07 .config issues
> > that are addressed by Mark Rutland's porting of PREEMPT_LAZY to arm64
> > and by upcoming work to handle the fact that arm64 kernels cannot be
> > built with CONFIG_SMP=n.  In the meantime, the CONFIG_SMP=n issue can
> > be worked around by explictly specifying the TREE01, TREE02, TREE03,
> > TREE04, TREE05, TREE07, SRCU-L, SRCU-N, SRCU-P, TASKS01, TASKS03, RUDE01,
> > TRACE01, and TRACE02 scenarios, preferably in a script.  (But if you
> > want typing practice, don't let me stand in your way!)
> > 
> > 1.	Check for "Call trace:" as well as "Call Trace:".
> > 
> > 2.	Reduce TREE01 CPU overcommit.
> > 
> > 3.	Remove MAXSMP and CPUMASK_OFFSTACK from TREE01.
> > 
> 
> These I will take for 6.16 and run some tests, since we're seeing these issues
> on ARM. But let me know if you want to delay to 6.17. Thanks!

Your decision on both sets makes a lot of sense to me, v6.16 for the
simple ARM-related ones and v6.17 for the less-important and more-complex
series.

							Thanx, Paul
