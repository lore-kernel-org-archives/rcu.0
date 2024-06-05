Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7248188CBE;
	Wed,  5 Jun 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589378; cv=none; b=Chno5NUvZe6/53P8ZiOc2o4N5QbE+4+R2E/scWsuQdptwsEhXbxF0tShDOMZiwcQpyCpSIx5/Rv3n8zX8XrrdYVdMwew3XZl8lagGiZhttWutVFiZdQkgsER7Hcpl1lPR6GOXuYxxss4F6DUVQIQmUueiTK2cqSMGhAhY5OhgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589378; c=relaxed/simple;
	bh=wVH3V0ZiYy8bt0BX0U/EChRzQBLdHlpA3Toip9MADsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwUL59ThRAITPC8QvPN2opIhCA9Lv1dFH95FkpGkOiZG1hoPFw98DVIfrWpJA7jw3DB+bOFH3L/ZgwLeZhxOVCwTh0ZPCtA+/AQ3icNK3NZ9GpqwnRsjAGUNfjBT7fJxZEUEoR2ea7OnMvN64g4AiFPXumrh3+pi5niLsWlPaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGQUSfzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGQUSfzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0145DC3277B;
	Wed,  5 Jun 2024 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589377;
	bh=wVH3V0ZiYy8bt0BX0U/EChRzQBLdHlpA3Toip9MADsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGQUSfzGSRPFgtqyyTejrHMnwLEc1VvFndNQqSzNSOuYXekLMeXzMm66OlwWhDuov
	 pBt5MCbUOTrWSXGugJzufLDADDaEOJxy5qIiA4wKRtZIcNBLsjaRRakHSjbLiZ3svs
	 6Wnz7lx/GrcH5KZ0PIiF6JH6Qu+PpQuw89zNgPULZJAxet+e0HWUFcbRGc2D/fnB2u
	 h66SmDewopwrQV3byfAqLbObqj1A9kv8jC6iQ9LvJPR3G+bRB6vM0TB2YHU0P+3Gjq
	 0C7DI8jwqsws1jgB7VsmI3+Bisw7aympJ6IJMn6QIcsfRYoo0Y1WAazUpgGfU7mQgS
	 wZk/Z+DYM1Phg==
Date: Wed, 5 Jun 2024 14:09:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH rcu 2/9] rcu: Reduce synchronize_rcu() delays when all
 wait heads are in use
Message-ID: <ZmBVfpyEZeTIAHJn@localhost.localdomain>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604222355.2370768-2-paulmck@kernel.org>

Le Tue, Jun 04, 2024 at 03:23:48PM -0700, Paul E. McKenney a écrit :
> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> 
> When all wait heads are in use, which can happen when
> rcu_sr_normal_gp_cleanup_work()'s callback processing
> is slow, any new synchronize_rcu() user's rcu_synchronize
> node's processing is deferred to future GP periods. This
> can result in long list of synchronize_rcu() invocations
> waiting for full grace period processing, which can delay
> freeing of memory. Mitigate this problem by using first
> node in the list as wait tail when all wait heads are in use.
> While methods to speed up callback processing would be needed
> to recover from this situation, allowing new nodes to complete
> their grace period can help prevent delays due to a fixed
> number of wait head nodes.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

IIRC we agreed that this patch could be a step too far that
made an already not so simple state machine even less simple,
breaking the wait_head based flow.

Should we postpone this change until it is observed that a workqueue
not being scheduled for 5 grace periods is a real issue?

Thanks.
