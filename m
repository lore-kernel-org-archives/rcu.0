Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF2435500;
	Mon, 20 Jul 2026 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562729; cv=none; b=YhJ7pJbwTJib0AL0D3EUBUNFEkDgNZdJocE9A071vB+SeqSVfvz+1QsO0yCEkWbf+arZRWsccAjwr2yTkiSi5RrAddQbr5jD7QNcVrGmEod0xaKPNS4kRpU1NZJWEp55QkxTw/+YslGlazZbsrQPjOylV3tK4YrkT68ZqqnXh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562729; c=relaxed/simple;
	bh=42nEbvTlxlBi6I+HWkk/O0iTUrX6oyadqLEcAslHMkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdURrAW9jhm50fZc3kVQ/7j9gn6G5SzXBmEcV+1aK1hJR65HR6QZr9u7n7ji35cLQLzo1Zx4VQSZfhyYb0a9TI9kiu6cUpxGYfSW+t9fUvgcj79EHPGv0TplnKv565bM4N2ts/h1MQWXeXNLWhIoWRA7JXzNMPA2vsuQ9ufU+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeeDEQL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeeDEQL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EDA1F00A3A;
	Mon, 20 Jul 2026 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562728;
	bh=VRvRh9LEA43CCaZXF5qT/QG7vDrXN37NsekHvD+SHOw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=BeeDEQL7zf2E5+hq5V4O8XhXcoTZ9i8525TR0oUKUDW9BI5p6GIhbywtDmCbXaHyS
	 /NOgao1iwirYHgoMS4Fy/LAZdyEPrmEK+E/Pftwf6eFIkoG1hZpWc9cNssENkKHV9L
	 bnd+AdiyOlMhaZYEenXN2iiTBrjQTfG83PoyDOXCiJdjjsToNC/TMZTNOxfD/Xi557
	 BwN3InPiey9u7xsmhkA2LHNoaeu9FEYzDdV1WSJj5sxEo/zcWuuLhrDz5h6JECTF1t
	 YSMeFMe32ACekb1KOkRdq4pjxALPlGjzpX0VfggJeIesN8zFxkidhWUE2+JTI2JpWS
	 ryZNQr04AOWzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2EBECCE0C57; Mon, 20 Jul 2026 08:52:08 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:52:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: Re: [PATCH v1 0/6] RCU and torture fixes and cleanups
Message-ID: <3264c7da-4fc4-4fc1-9979-21ec5bc160cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260718171539.3781595-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718171539.3781595-1-joelagnelf@nvidia.com>

On Sat, Jul 18, 2026 at 01:15:31PM -0400, Joel Fernandes wrote:
> This series contains miscellaneous RCU cleanups and torture-test fixes for the
> next merge window. Tested various rcutorture and scftorture scenarios.
> 
> The git tree with all patches can be found at:
> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-torture-simple-fixes-v1-20260718)

Good catches!  Applied for further review and testing, thank you!

							Thanx, Paul

> Joel Fernandes (6):
>   rcu: Remove unused expedited_need_qs field from rcu_state
>   rcu: Remove unused rdp parameter from trace_rcu_this_gp()
>   rcu: Remove unused func parameter from callback-enqueue functions
>   torture: Don't leak shuffle_tmp_mask when shuffler kthread fails to
>     start
>   scftorture: Count single_rpc offline failures in statistics output
>   scftorture: Make invoker threads actually wait for all threads to
>     start
> 
>  kernel/rcu/tree.c      | 33 +++++++++++++++------------------
>  kernel/rcu/tree.h      |  3 +--
>  kernel/rcu/tree_nocb.h | 10 +++++-----
>  kernel/scftorture.c    |  3 ++-
>  kernel/torture.c       |  7 ++++++-
>  5 files changed, 29 insertions(+), 27 deletions(-)
> 
> 
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> -- 
> 2.34.1
