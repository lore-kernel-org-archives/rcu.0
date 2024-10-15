Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121671B0F1F;
	Tue, 15 Oct 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033358; cv=none; b=s0sUJD4hIR/8CqoXaAVcuHpxrxqFyWNREsNC+2Ty4KmbmEZ+7z7XrlsHXxL8v3mkfqM5LivZI+d+M3HRSxQbs/he3P2XHnxsYc0S8GsnLrvvOJRxzpdVJiZedoZKkaGU2O1uWEA1AKjzBDm9IqP3exC9dbplQBKOHxRasQit3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033358; c=relaxed/simple;
	bh=Mh22a83gJV5bSpvhN5uzzyv9X2ldBJwBfJ6ImtJn+SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngKy1ZxQc9RH0nizj/qEYbJAyBLQ403NRl7dS+tbcECVj9SwMyy8SJEbjUKrYioItX0fK5amhFpPnO3rqsGrjBt2pS1KuSXKCMW/bNYLiGVo8y+uK4WpijAeWnc8cTPXHde9ohbMWHEsCOt/dkfAHNjTqo8eRXeECFKGYV4nPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVdG0VXw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVdG0VXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813E2C4CEC6;
	Tue, 15 Oct 2024 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729033357;
	bh=Mh22a83gJV5bSpvhN5uzzyv9X2ldBJwBfJ6ImtJn+SE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RVdG0VXw2vtAFhwjTZf3nusK0qEbhjLdcKT8zkYPzFQYAm2sHHUXXMvH5tV4q5N48
	 khzVBdNv8mUqA8m01KyaSZXPXYAupjsRGm2CxmdKxjYtaW4FV7EDod2aUGKu/8pdsE
	 kwztW7zQSOKPP9Ec4HRFsvVoreJwStBWnrIGXmpRyefsmeEH+Kl4FsRmtYSuBdEIka
	 UKGCIcbwD9PkfV857m2K8dR/30k1O3Ak7ugKx4H/P5H670iCortRC+CVPQvFYjc4KH
	 /Hg5xPZU74bNUOTNQBxvzRdaF9etVuOYojltKnglHnBRI2Dl2sPRdpZIuYu7VRER5Z
	 aVNGvhXrupUkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B867CE098E; Tue, 15 Oct 2024 16:02:37 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:02:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/3] RCU CPU stall-warning changes for v6.13
Message-ID: <f5a833c4-6346-4ec4-8360-4a818342fb52@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
 <670eb924.050a0220.63bb1.4746@mx.google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670eb924.050a0220.63bb1.4746@mx.google.com>

On Tue, Oct 15, 2024 at 02:49:06PM -0400, Joel Fernandes wrote:
> On Wed, Oct 09, 2024 at 11:05:02AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series contains RCU CPU stall-warning changes for v6.13:
> > 
> > 1.	Delete unused rcu_gp_might_be_stalled() function.
> > 
> > 2.	Stop stall warning from dumping stacks if grace period ends.
> > 
> > 3.	Finer-grained grace-period-end checks in rcu_dump_cpu_stacks().
> > 
> 
> Other than small nit in 2/3, 
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you, and I also added the data_race() in 2/3.

> I was curious if you're seeing perf or other improvements with the
> finer-grained rnp locking.

This is about robustness rather that performance, though I suppose you
could argue that lack of robustness is an extreme form of bad performance.
Holding the leaf rcu_node locks for too long while dumping stacks can
result in things like CSD-lock timeouts due to the dumping CPU having
interrupts disabled for an extended period.

And earlier commit, 1ecd9d68eb44 ("rcu: Defer printing stall-warning
backtrace when holding rcu_node lock"), took care of most of the issue
by deferring the actual output.  But while in the area, it seemed wise
to avoid up to 64 dumps being generated (but no longer printed) while
holding a leaf rcu_node lock.

Hence this commit.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  b/include/linux/rcutiny.h |    1 -
> >  b/include/linux/rcutree.h |    1 -
> >  b/kernel/rcu/tree_stall.h |   30 ------------------------------
> >  kernel/rcu/tree_stall.h   |   35 ++++++++++++++++++++++-------------
> >  4 files changed, 22 insertions(+), 45 deletions(-)
> > 
