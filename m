Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA6262FD0;
	Thu,  5 Mar 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737704; cv=none; b=jCIPuXAUgrCqFK+zm0vTF/oBZXhQ2uAVu36rcTl70QwVa66cv7deA15EjjAmgo9ZscpLq1W/j65YOvy6i3WtT8+3SzAeptn1I8EA/KZBQ9paauMqHfk/35PJq86WyOrPPbtIqNwbpIlbV8ltCc+T+5YzhGd25NLFsVejWSbolP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737704; c=relaxed/simple;
	bh=sIOoDsELdTfX5IMolGGpLTgfUndWqpN5cBTrmzd6yxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJOQD1x1p3XR4p5mqJQw+hBsRnfTzav7k8n/iJZpW34+kCM+tAzZNRdFsHeARHvXq6ObsX+KYJLSSTvcC6nzua6dNeAD6oJnifRcoia/kf7c9573LJUaw7CDjrWK8m+jjh3GEKQQJfFwsnISyp+bYXpn1wvIDAJaEpJNYL5IC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Otzj+l+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Otzj+l+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327EDC19422;
	Thu,  5 Mar 2026 19:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772737704;
	bh=sIOoDsELdTfX5IMolGGpLTgfUndWqpN5cBTrmzd6yxU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Otzj+l+z4+kcYSYRmTuJheM9UEDcrZmfOFGzNKKr4252blVS+gFnEDmdq4WI2PIr6
	 sf1rSkHz+4cHbpba4bwB+yh0WbTXEvRomxA5WKRweVWkGq5G2rQjPHno5SPOLA19fo
	 ThijJemgcRLnVjDbstpmWejhJ6Y+OYEEBtpS1PmJ+/Vk99QOUZ3tz3QqZtrIprWri2
	 GFPTjUp78AtL15C8HtPQNF9jaybYFkSNtXsLAKh993ho0T6L5VY8Bx/CGBvDnam0YW
	 xV58rGKtRQaIyYVc/9+jpAlrSIL/sAMqGQXkLdFpeQbBiLnTlD+jGu1Zt0ErGml++N
	 ZKuns2fv05mKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A47F2CE10B8; Thu,  5 Mar 2026 11:08:23 -0800 (PST)
Date: Thu, 5 Mar 2026 11:08:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v3 1/4] rcutorture: Update due to x86 not supporting
 none/voluntary preemption
Message-ID: <e2562191-169d-4d38-bbd9-96ce2cc9b3ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
 <20260303235903.1967409-1-paulmck@kernel.org>
 <dda12988-2a5c-4549-bdfc-8e429fc0aab1@paulmck-laptop>
 <bfe89f6c-3b63-40c6-aa6d-5f523e3e9a31@paulmck-laptop>
 <0f6f8cde-ebd6-4f77-8eeb-51c2fcccfbba@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6f8cde-ebd6-4f77-8eeb-51c2fcccfbba@nvidia.com>

On Thu, Mar 05, 2026 at 12:53:48PM -0500, Joel Fernandes wrote:
> 
> 
> On 3/4/2026 7:01 PM, Paul E. McKenney wrote:
> > As of v7.0-rc1, architectures that support preemption, including x86 and
> > arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
> > Attempting to build kernels with these two Kconfig options results in
> > .config errors.  This commit therefore switches such rcutorture scenarios
> > to CONFIG_PREEMPT_LAZY.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > ---
> > 
> > Changes since v2:
> > 
> > o	Fold in c69ac5693540 ("rcutorture: Adjust scenarios for default
> > 	lazy preemption")
> > 
> > Changes since v1:
> > 
> > o	Add CONFIG_PREEMPT_DYNAMIC=n in order to test non-preemptible RCU.
> > 
> > o	Remove CONFIG_PREEMPT_COUNT=n because it conflicts with
> > 	CONFIG_PREEMPT_LAZY=y.
> > 
> > o	Remove some stray conflicting CONFIG_PREEMPT_LAZY=n instances.
> > 
> [...]
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > index 34aee1acb8662..ac857d5bcb222 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
> > @@ -1,11 +1,12 @@
> >  CONFIG_SMP=y
> >  CONFIG_NR_CPUS=8
> > +CONFIG_PREEMPT_LAZY=y
> >  CONFIG_PREEMPT_NONE=n
> > -CONFIG_PREEMPT_VOLUNTARY=y
> > +CONFIG_PREEMPT_VOLUNTARY=n
> >  CONFIG_PREEMPT=n
> >  CONFIG_PREEMPT_DYNAMIC=n
> > -CONFIG_PREEMPT_LAZY=n
> >  #CHECK#CONFIG_TREE_RCU=y
> > +#CHECK#CONFIG_PREEMPT_RCU=n
> 
> nit: Let us add this #CHECK# to the other configs you changed too? Otherwise it
> is a bit confusing because it took some digging to clearly see that
> PREEMPT_DYNAMIC=n and PREEMPT_LAZY=y implies CONFIG_PREEMPT_RCU=n ;-)

Tell me about it.  ;-)

I will add "#CHECK#CONFIG_PREEMPT_RCU=n" as a separate non-urgent commit.

> Otherwise, I could not find any other flaws in the approach and it makes sense, so:
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Boqun, you will be taking this through the 7.0-rc tree right? So that 7.0
> release tests don't fail.

Unless I hear otherwise, I will assume that Boqun will apply your
Reviewed-by.  Easy for me to do, just no point in its being done twice.

> Also I will drop the 2 related rcutorture patches for 7.1 and rebase on top of a
> 7.0-rc fixes branch Boqun might be creating.

Sounds good, and thank you both!

								Thanx, Paul

> Thanks!
> 
> --
> Joel Fernandes
> 
> [...]
> 
