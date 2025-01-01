Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516EFC2E0;
	Wed,  1 Jan 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707369; cv=none; b=RhxZvzGYBdOy/36lSzwrRAwNPjdnOjlWbn4kHUrpyXR+3SFrV+fUDnKxncmg/J5eh8cO+yMe7YOH+0tliZe2KiUbJpZfuKrNAxjdRIbxRYEeLmuhYsircdXVUDxsriZTuOLz3ZKovj8LZX2p8KvVWymRdhU40PEOzajHMmGf+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707369; c=relaxed/simple;
	bh=lyzf9fMRzlYAMt7sDW9xbl2fM+KurS9ywF+nU9NZfvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpZ1DzK1zIF5UBuA3aThUaNexK9zTFKL/pyuD5y0yF9Nc1BSm6+5NJckTVyQ+s4HWeWZoSTrAU9shzNAxZNz4JPYybnAP0vzLhgbSYbyHb7LmHcksTJxtF2jfzoMTvd5uVk8xfRzSASU3GW8sXgeYq4BvUrqXC2gulGnswfbRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxkKz0zr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxkKz0zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F3FC4CED1;
	Wed,  1 Jan 2025 04:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735707368;
	bh=lyzf9fMRzlYAMt7sDW9xbl2fM+KurS9ywF+nU9NZfvs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UxkKz0zr2Oe00iRHaaGBAA/QdgcI7stpo92tpFheh0djxqWuW20rO2pG/yKPGa1yT
	 bsJW8yfmH1VB2DMVP1442fC/HKofwctZNzXHBTxuz+g1AP/9vugPepsewKp+b8O/nu
	 mfrUvAi08MR8Dj+lNAA+ofVw7n3hSj6uRXK4l2kCQiQQjdjI0aiKtyDlyKB6tMEkWj
	 IVTTKIL7KJOultakQx2i64Jg8LUocm4UksytaHryoPs2EEBq2mvIaisCanJ4niW23b
	 akhI9b8BRCzQ84zFRTuweF24S6uYK37ds+idxtQTcSugI0SJ2+nbWrwFzKYT2DtTAz
	 O7McAq8GHqgXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4FDE0CE0EFB; Tue, 31 Dec 2024 20:56:08 -0800 (PST)
Date: Tue, 31 Dec 2024 20:56:08 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
	rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org, kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 0/3 v2] hrtimer: Fix timers queued locally from offline
 CPUs
Message-ID: <fac80aa4-2dec-4a79-8b96-bf679d75cf83@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241226233052.145450-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226233052.145450-1-frederic@kernel.org>

On Fri, Dec 27, 2024 at 12:30:49AM +0100, Frederic Weisbecker wrote:
> 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> was introduced to fix stalls with scheduler bandwidth timers getting
> migrated while some kthreads handling CPU hotplug rely on bandwidth.
> 
> However this has introduced several other issues which used to be
> confined to RCU. But not anymore as it is spreading to hotplug code
> itself (https://lore.kernel.org/all/20241213203739.1519801-1-usamaarif642@gmail.com/)
> 
> Instead of introducing yet another new hackery, fix the problem in
> hrtimers for everyone.

Tested-by: Paul E. McKenney <paulmck@kernel.org>

I expect that this result applies to v3 as well.  ;-)

							Thanx, Paul

> Changes since v1:
> 
> _ Fix a build issue when CONFIG_HOTPLUG_CPU=n (folded #ifdeffery by Paul)
> 
> _ Remove the unconditionaly base lock within the IPI when both nohz and
>   high resolution are off. There is really nothing to do for the IPI in
>   such case.
> 
> Frederic Weisbecker (3):
>   hrtimers: Force migrate away hrtimers queued after
>     CPUHP_AP_HRTIMERS_DYING
>   rcu: Remove swake_up_one_online() bandaid
>   Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
> 
>  include/linux/hrtimer_defs.h |  1 +
>  kernel/rcu/tree.c            | 34 +---------------------
>  kernel/rcu/tree_exp.h        |  2 +-
>  kernel/rcu/tree_nocb.h       | 10 ++-----
>  kernel/time/hrtimer.c        | 55 +++++++++++++++++++++++++++++++++---
>  5 files changed, 56 insertions(+), 46 deletions(-)
> 
> -- 
> 2.46.0
> 
