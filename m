Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BA264A9D;
	Fri, 16 Jan 2026 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768603352; cv=none; b=hiTqRV17yS12qvqgaurcTaekWLSLCspcqplWl7QhoDJNyOx7izLX0FPenC47kcQVWJMZ1dHrNtNl8Jdw1viHTr5MjK/DLgQ8yODWMljOJKm38jW1fVmUEHHQc2bUecMLzA7DxF3J0SRabhBAMGMTMOrYd9FTB5mV0JS/hHaT1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768603352; c=relaxed/simple;
	bh=1L9EXyK8qG6ALAg465xGrBMJ0SnWibs+3+Dp0g/YSuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZKU0LW0h5zr/85miOaBopCA6yLduNs/nsxeoHwF2DHBMO9SwomseXRPpVd3mYyoDAj1jTCgJ77r6uGas8T676/2Mq0I7FSBhK+YWPQElUnBEdaCQ9wiL4rvFYsYwi4KXboUERcu31xM1EqprZE+RN2zBfTk8ZW09J3rZ8dbMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loiBZF/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loiBZF/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E055C116C6;
	Fri, 16 Jan 2026 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768603351;
	bh=1L9EXyK8qG6ALAg465xGrBMJ0SnWibs+3+Dp0g/YSuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loiBZF/ZgY+sHBJm/KALS6ADJkxk+vOR/BrnRV1d55rF27Eyg5apEi5VkIfb7g7vH
	 A3r6WsQi4PrnrwOd0JELIsnOC4W82/nfinVmttuGxI+L19PAPyXktzwzEduTMs2TLr
	 jWFf5dky3rDKxModDIbIzP1OpIyjrQbH4t6wQdllP+u+MqsXbGk1esm/uMPi8fKv8f
	 uTaOyw9am4m6UBhzV3NW9+xCb/uxKQHIrxU0fPxqXIy2GckD2x6Tn318a1G/Nv/2bq
	 AEPHCDko2Mm7mHBZnJ8yqVSKIyEuOjEgHuktY7/luZVr9KKaa0iUQZUgcAZ+2FBZKm
	 JjLDQq+iRv6tw==
Date: Fri, 16 Jan 2026 23:42:28 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v2 3/4] rcu/nocb: Add warning to detect if overload
 advancement is ever useful
Message-ID: <aWq-1IXhOeisfKC3@pavilion.home>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com>
 <20260114173154.1701056-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114173154.1701056-4-joelagnelf@nvidia.com>

Le Wed, Jan 14, 2026 at 12:31:53PM -0500, Joel Fernandes a écrit :
> During callback overload, the NOCB code attempts an opportunistic
> advancement via rcu_advance_cbs_nowake().
> 
> Analysis via tracing with 300,000 callbacks flooded shows this
> optimization is likely dead code:
> - 30 overload conditions triggered
> - 0 advancements actually occurred
> - 100% of time no advancement due to current GP not done.
> 
> I also ran TREE05 and TREE08 for 2 hours and cannot trigger it.
> 
> When callbacks overflow (exceed qhimark), they are waiting for a grace
> period that hasn't completed yet. The optimization requires the GP to be
> complete to advance callbacks, but the overload condition itself is
> caused by callbacks piling up faster than GPs can complete. This creates
> a logical contradiction where the advancement cannot happen.
> 
> In *theory* this might be possible, the GP completed just in the nick of
> time as we hit the overload, but this is just so rare that it can be
> considered impossible when we cannot even hit it with synthetic callback
> flooding even, it is a waste of cycles to even try to advance, let alone
> be useful and is a maintenance burden complexity we don't need.

Rare is far from impossible with billions of android devices living out there.

I can imagine the warning to just hit if the flooding callback enqueuer happen
to hit the qhimark right after the GP has completed but before nocb_gp_wait()
managed yet to advance the callbacks.

But what would that prove then?

> 
> I suggest deletion. However, add a WARN_ON_ONCE for a merge window or 2
> and delete it after out of extreme caution.

2 merge windows is the least of time for that warning to ever land on the billions
machines. My phone still runs a v5.4 kernel :-)

And the patch doesn't quite qualify for a stable backport.

Anyway, consider an unpleasant case where nocb_gp_wait() is starving for
example. How would just advancing the callbacks help? We still need
nocb_gp_wait() to run its round to eventually wake up nocb_cb_wait()
so that the done callbacks are executed. And before doing that, it needs
to advance the callbacks anyway...

I'm personally in favour of removing this right away instead, unless Paul
has a good reason that I missed?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
