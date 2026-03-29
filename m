Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9B22339
	for <rcu@vger.kernel.org>; Sun, 29 Mar 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774772964; cv=none; b=puzoVT+GxtTRU0FtHZMOe1axSnCfC2GWAg1rsn1e0rGmCyl/5Crls8EBO40EUtRSLnfGGM+qYo12+KT/8Tj477G0S4E0/vJ4z2uiCDn9YUb2Kx0p3hxh7qoHsvrhtAJVr7MRZd4MWLRQACpInkqZNiabDVXSfix8cEQOR+5CGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774772964; c=relaxed/simple;
	bh=FsFsWRcAQdKcP/f9qVBEPqTR90HO0qmw0S1Ktmc3/vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWRYZG5ZOySoMXz1KXJKoKLFJDBW86UxO0/YyfVSY7wahdNL0trxlTpoe1VWdqn+3nsq1zDOWUBswEt0p99eHjx5tBkQhCKd9KHRTiz1iWTDh6nuF7lKl4YdBcTsQLZJa1uvmIDuzmi15/v+VcC8yrdU5OoqlLp/XbO4fB9crow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqC70Scv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqC70Scv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E417C116C6;
	Sun, 29 Mar 2026 08:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774772963;
	bh=FsFsWRcAQdKcP/f9qVBEPqTR90HO0qmw0S1Ktmc3/vE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FqC70ScvX/VkfEyuTFdyweueWJIvw3Qejw08Ebs6/hoXRrlKLT2mWtQpk7G37YuU/
	 2rNr+KHv5GhsA4xpeF+hFqLJH7018T48uKVrEhMOEEt+4gLdADeiwvdoz49qfyfTBN
	 yBAQIXt1uS1V/IsJzI9y+p5mJFL115+zAywS+h6UQLgucK2IdYoD04CWsZUFKGSknZ
	 oCZ5oiBG4i0YfQX95XHUMRRuoMvcnAKw5G+OQwCdhXf85IZ5mL0DICsMmhujJ/tP/k
	 iYWylM+OP3IQiNBQmtj+PHB/Wh/PwfhKmob76j5sbPdnj4fii8DuAmas7sLpvVvOUF
	 vYYuxGrd9ujtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D9274CE08F1; Sun, 29 Mar 2026 01:29:20 -0700 (PDT)
Date: Sun, 29 Mar 2026 01:29:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org
Subject: Re: Semantics for hazptr_acquire()?
Message-ID: <a891f47a-1e7a-4cad-b42a-e8626518b7b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0787677c-809e-47f7-b8a9-75f65f3b0a33@paulmck-laptop>
 <729a4527-5f11-4ef1-b8bc-06e87a6caaae@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729a4527-5f11-4ef1-b8bc-06e87a6caaae@efficios.com>

On Sat, Mar 28, 2026 at 07:23:58PM -0400, Mathieu Desnoyers wrote:
> On 2026-03-28 18:37, Paul E. McKenney wrote:
> > Hello!
> 
> Hi Paul!
> 
> Just to confirm: we're discussing my hazard pointer implementation
> at https://lore.kernel.org/lkml/20260223204418.1429025-1-mathieu.desnoyers@efficios.com/ right ?

The one that you sent out here:

https://lore.kernel.org/all/20260223204418.1429025-1-mathieu.desnoyers@efficios.com/

> > I have been (perhaps redundantly) putting together a torture-test module
> > for hazard pointers, and need confirmation of the usage rules.  Here
> > are my current guesses:
> > 
> > o	A given hazptr_ctx structure that is passed to hazptr_acquire()
> > 	cannot be passed to another hazptr_acquire() until after it is
> > 	passed to the matching hazptr_release().
> 
> Correct.

OK, that is where my current test is broken, thank you!

> > o	A thread that has done hazptr_acquire() can be preempted and can
> > 	be migrated to some other CPU before it does its hazptr_release().
> 
> Yes.
> 
> > 
> > o	Except that a given CPU can have at most four outstanding calls
> > 	to hazptr_acquire() that have not yet found matching calls to
> > 	hazptr_release().
> 
> No, it can have more outstanding acquire than that.
> 
> The fast path does:
> 
> +	if (unlikely(slot->addr))
> +		return __hazptr_acquire(ctx, addr_p);
> 
> going to the slow path.
> 
> The slow path does:
> 
> +	/*
> +	 * If all the per-CPU slots are already in use, fallback
> +	 * to the backup slot.
> +	 */
> +	if (unlikely(!slot))
> +		slot = hazptr_chain_backup_slot(ctx);
> 
> which takes care of chaining a backup slot in that scenario.
> 
> So the unlikely case where a CPU has more than 4 nested
> hazptr_acquire, it will begin to allocate hazard pointer
> context slots into the per-cpu overflow list.
> 
> So the intent here is to get good performance for the common
> case (nesting <= 4) without introducing any nesting limitation
> for the uncommon case.

OK, I will adjust the test accordingly, and again, thank you!

							Thanx, Paul
