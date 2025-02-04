Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CBD13A265;
	Tue,  4 Feb 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738634436; cv=none; b=Tb6u4DCjBZu3F1Rdt60Cx08s6vKqscubqpCRcew0N5vtc0VquZBE6jKlB7UnsoH0GIOhoOMPGgKHjTpjQNQAJP3Q0uO0LVuoREKllyZmBJHSim6/H8Zu+P059jotUBvSw2YElj6Gdn0vesrPnlSrjr09lIirQ/f4ii2/44pdavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738634436; c=relaxed/simple;
	bh=oElDCpeTGeYseGVPtePTNdbmGUPeslhIeHQ0KpryMxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWFR13m65RAmwHdpx2g+AAde8/S5G/AXGRdVyjgy8xx+9+YE7PrRM1RRUq6tuzz77AfvS7KOz5s+yfRqtY8tB6kj9Tig6IcEOw5cGyo1SkAA9UcyCo3swp9/VDxhkhY0ol1Wg8qNHpNFEEldL4EGxIFhvSs+BTzevXGv52VneMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ucqzl5+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ucqzl5+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A53C4CEE0;
	Tue,  4 Feb 2025 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738634436;
	bh=oElDCpeTGeYseGVPtePTNdbmGUPeslhIeHQ0KpryMxA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ucqzl5+oQeM7bZIt+937Oo/pLfFQWVooyZoi3JwhC8lJcoACX0JAfSwjtc+vHJ77a
	 8I+tN98QPAy3WZO100cn36Nlfom3et9x4zuwoPpL7HfQ09NihWBE1TkD7+L3dRrgEr
	 o2BDLW9P6GGMIJ/KWpCd++qQmTwQPgmLLW1np8MuW0XewdAM6SycCPC/Ifz7FSJgTS
	 5j1q4BwmaRB3vvnDQ0KwUqvaVhuSS0BObgXHT1j497e9b+DmMecwd57vfUgcimI1T2
	 J1Cn/IIL7iCkAEug2t2R/mF5oQBEWQxVbcaFCSP/qMOfxu7ZNrsXTbd/9JGmJlZPKs
	 IVQ+UO0jNCuQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A7558CE00C4; Mon,  3 Feb 2025 18:00:35 -0800 (PST)
Date: Mon, 3 Feb 2025 18:00:35 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	MengEn Sun <mengensun@tencent.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	YueHong Wu <yuehongwu@tencent.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 0/4] ucount: Simplify refcounting with rcuref_t.
Message-ID: <fc4c3ed1-aa8b-48c4-92ca-6d177efa869a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250203150525.456525-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203150525.456525-1-bigeasy@linutronix.de>

On Mon, Feb 03, 2025 at 04:05:21PM +0100, Sebastian Andrzej Siewior wrote:
> I noticed that the atomic_dec_and_lock_irqsave() in put_ucounts() loops
> sometimes even during boot. Something like 2-3 iterations but still.
> This series replaces the refcounting with rcuref_t and adds a RCU
> lookup.
> This allows a lockless lookup in alloc_ucounts() if the entry is
> available and a cmpxchg()less put of the item.
> 
> Patch #1 adds HLIST_NULLS_HEAD_INIT for which I added the RCU folks.

The modification and later elimination of get_ucounts() threw me for
a bit, but for the series:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> Sebastian
> 
> Sebastian Andrzej Siewior (4):
>   rcu: Provide a static initializer for hlist_nulls_head.
>   ucount: Replace get_ucounts_or_wrap() with atomic_inc_not_zero().
>   ucount: Use RCU for ucounts lookups.
>   ucount: Use rcuref_t for reference counting.
> 
>  include/linux/list_nulls.h     |  1 +
>  include/linux/user_namespace.h | 15 ++++--
>  kernel/ucount.c                | 97 +++++++++++++++-------------------
>  3 files changed, 55 insertions(+), 58 deletions(-)
> 
> -- 
> 2.47.2
> 
