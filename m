Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485C205E23;
	Wed, 16 Oct 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095156; cv=none; b=FOJgy2dq3lAvuK8jkucdal/vu9UjBojNwiMiC99a9rM3W3W9gGX9TkXwHZ7Fmro1ilzSD7aeSownhK2edR0ipaNnD621ykG51KfxRS8OBikCM6XWBWmRxlYuilzKGM7hYCzAXudm8nqXzY2DnFu7+LPRH32MJwUiXvDKOLEbVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095156; c=relaxed/simple;
	bh=/kdo8FDR22c+8gTYCEWztNfSfN4bRIUDHgvEhgdZI5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNwl4NzdQdyXg3Q79JxkdWzSzwTbmRPFlbHqx5UoRFu4hO+ntP/034ACZPh5i14Oacn7iqQmZVNzVpwhLbWpDU6h5ka05J+cuKHp9aJpRwRCv5fIthwRgGNVPwaZxTRm05qOpHIsJCjs4OENfABFr/dkN2A2azM4y/jWEDctbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3bfjRKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3bfjRKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA74C4CECE;
	Wed, 16 Oct 2024 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729095156;
	bh=/kdo8FDR22c+8gTYCEWztNfSfN4bRIUDHgvEhgdZI5c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C3bfjRKcJPQLjFJvsNgHaB8UUDnRw/cy5yHPnAl8g7ESJln1K2SxgdcOPOWrsUFOz
	 1h7wyCIeP7U5iShfhe2dJCGf3S3cz/c8zA083NEEFrHKPw7MoAyrlC2WYtnMaxi6GT
	 ZR5mjHyMumC3LfA8I+9hg9G2Zjve7mWPifWlPiJiGGBjzBPLOqtR3r39wgs2L0zicc
	 8bkGSIgTDUIw6lG2r25A3bS3eyLDW1yqtKyvjFCH0Khv79qaSw14WfCcwasU/jBZe4
	 Z2oe8Je9UwJPWpai68/+oYjJXyQuC2epF7BX9NrNofXS/ZONglmj6x6LioTCkn98Nd
	 zorvdZUtINHAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E1DD1CE0DCA; Wed, 16 Oct 2024 09:12:35 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:12:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [peterz-queue:sched/lazy] [sched, x86]  74d850cd4c:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <b9d0af7f-0b1f-4f55-87a6-f64124f898b8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202410151544.7d2292c6-lkp@intel.com>
 <20241016154048.sdiJ85Zc@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016154048.sdiJ85Zc@linutronix.de>

On Wed, Oct 16, 2024 at 05:40:48PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-15 15:47:20 [+0800], kernel test robot wrote:
> > Hello,
> Hi,
> 
> it took me a while to reproduce this because it does not trigger without
> the ltp userland and this is not downloaded properly so I had to
> workaround it. However…
> 
> > [   98.006999][  T543] busted-torture: rtc: 00000000639e821e ver: 6796 tfle: 0 rta: 6796 rtaf: 0 rtf: 6787 rtmbe: 1 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 89 barrier: 0/0:0 read-exits: 64 nocb-toggles: 0:0
> > [   98.017386][  T543] busted-torture: !!! 
> > [   98.017662][  T543] ------------[ cut here ]------------
> > [   98.019330][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/rcutorture.c:2258 rcu_torture_stats_print+0x24c/0x610 [rcutorture]
> > [   98.021831][  T543] Modules linked in: rcutorture torture
> …
> > [   98.237025][  T543] ------------[ cut here ]------------
> > [   98.238052][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/rcutorture.c:2263 rcu_torture_stats_print+0x373/0x610 [rcutorture]
> > [   98.240000][  T543] Modules linked in: rcutorture torture
> …
> 
> It took me a while to figure out that this test is using
> rcu_busted_torture_deferred_free() which in turn invokes the callback
> before the grace period. Buh.
> So it looks like LAZY preempt triggers this more reliably than the
> normal preempt version…

Agreed!

Please don't run any rcutorture scenario whose name contains "BUSTED"
or "busted" unless you are trying to test rcutorture's ability to find
broken RCU implementations.

							Thanx, Paul
