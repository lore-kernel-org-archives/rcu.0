Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F72EA159;
	Sun,  1 Mar 2026 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772338492; cv=none; b=HkdFRMZM/0TUgRT1rkQY79SxV+KdsTFNsLNpEqw+Lxh6qepzrLRi0c1L9WaoBH0DiSwSi76kVtWLDsyxUHCGxKornE/0+ihahHWUnNexiKPbdBeEYEe3CL7QpFkCQyR15gNY/oae/8aFwMoVZM+8+8jeCJgCATtZCaTddQF2TnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772338492; c=relaxed/simple;
	bh=zsSbCTK/aQGt/BkrUoBCIcJofE7Bbg8imn+FvSUoGNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzyzftIL/EK+o8IbxGx9IQ0isCS8dLH+neG3UzA2ViQtkWJ6Gi+jb58JB2vSHpk2ZzKUEpg2s11v8s3LwvjaOUPsO44/qmK0yJ19+cBfxoDLhl5XSIb+KAvQ80TJhB5OPmBZisB3MaN5euVQPR+GtBTqJ1cL/FP4ksAMECiPwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE3YN9md; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE3YN9md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B7C116C6;
	Sun,  1 Mar 2026 04:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772338492;
	bh=zsSbCTK/aQGt/BkrUoBCIcJofE7Bbg8imn+FvSUoGNA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hE3YN9mdnbnmbXoCb9qnbZbO6eDy3WyFkIVjP0Lw5A8WdFP8wykC1tlFHTraJG/7p
	 FyCL+RkCLuJEPpa8l6Mpou4DCJRA0g70beqcIP8OKY7N1i5wkqlzSJOo7k583MiIH+
	 afk+d0+g56gNb3zP1ogd6gXUp2y1uJ5MQQjjgV2DOHqAsPhKUgfH86MW52x9+K0cHX
	 1t4nju0XmKpViqsv+Y9pjHepJC5o75ft7jNYG5NBaLd9Qrae4RQAnVi8C/AcG/Qw8l
	 k1dBW4SnMO/ErlDNHEPOZnyVrEYV7xSKoDmDJKm+5unmLm3yGj636UB6iFoYq7lSVA
	 nhb36BFnM36nQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C24D9CE0AB5; Sat, 28 Feb 2026 20:14:51 -0800 (PST)
Date: Sat, 28 Feb 2026 20:14:51 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH RFC] rcutorture: Fully test lazy RCU
Message-ID: <a7dd04f0-52ba-4543-a159-f989b851906c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <07395baa-806d-4e12-84b2-c393aee064cd@paulmck-laptop>
 <8C3B3E86-91D9-4F27-B385-CCCD0041B733@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8C3B3E86-91D9-4F27-B385-CCCD0041B733@nvidia.com>

On Sat, Feb 28, 2026 at 10:09:11PM -0500, Joel Fernandes wrote:
> > On Feb 27, 2026, at 7:39 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Currently, rcutorture bypasses lazy RCU by using call_rcu_hurry().
> > This works, avoiding the dreaded rtort_pipe_count WARN(), but fails to
> > fully test lazy RCU.  The rtort_pipe_count WARN() splats because lazy RCU
> > could delay the start of an RCU grace period for a full stutter period,
> > which defaults to only three seconds.
> 
> But call_rcu_hurry() should completely flush, so if we are still
> splatting with it, does that not mean that there is a real bug the
> splat uncovered?

He was running an old rcutorture without call_rcu_hurry(), which did
splat.  This got me thinking about how to test better.  This patch,
right or wrong, is what came to mind.

> > This commit therefore reverts the call_rcu_hurry() instances
> > back to call_rcu(), but, in kernels built with CONFIG_RCU_LAZY=y,
> > queues a workqueue handler just before the call to stutter_wait() in
> > rcu_torture_writer().  This workqueue handler invokes rcu_barrier(),
> > which motivates any lingering lazy callbacks, thus avoiding the splat.
> 
> But nothing should be lingering with _hurry().

True, but this patch removes the _hurry().

> > Questions for review:
> >
> > 1.    Should we avoid queueing work for RCU implementations not
> >    supporting lazy callbacks?
> 
> I think so, best to isolate non Lazy cases so the barrier call does
> not cause side effects.

OK, done with IS_ENABLED().

> > 2.    Should we avoid queueing work in kernels built with
> >    CONFIG_RCU_LAZY=y, but that were not booted with the
> >    rcutree.enable_rcu_lazy kernel boot parameter set?  (Note that
> >    this requires some ugliness to access this parameter, and must
> >    also handle Tiny RCU.)
> 
> Yes I think we should avoid.

That will require an accessor function, but easy enough to do.  I will
update.

> > 3.    Does the rcu_torture_ops structure need a ->call_hurry() field,
> >    and if so, why?  If not, why not?
> >
> > 4.    Your additional questions here!
> 
> Do we have a reproducer for the splat? If there is a link to the
> report, I could take a look and investigate.

The splat is on an old kernel where rcutorture does not yet have
call_rcu_hurry().  So this patch isn't fixing a bug, but rather allegedly
improving lazy RCU rcutorture testing.

							Thanx, Paul
