Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F31401C;
	Fri,  8 Nov 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073579; cv=none; b=Gs7MeXVoFqQeqbS+8l03/ayuItOosrz9lUgexNOLVV3Z4/v6BpEVsBaCBvPdoy2ELzg8O25KmmEmJuDNkhtTb5GBRPOCTSMEuwGYP8H4ZvusE5h1518kbWfluU1eKsu7pFxWE4ffEi2o7xaIudIjaiqexb7/3DRgsQmMW/Ya+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073579; c=relaxed/simple;
	bh=/p3pTCkhZFWoezcX0Ua12rwpQhBOpEwQJXd9Sy5MQD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li8CFGAhWcTaZHO51ngNXwbnyYTk6abdTYIT83+7xvzkvV5KE/r2tEEvPfKbnw6QOuEfEkfhuRhn7Xt7EPpu19GZPsRrFR6B7A8roWxLh0WzBgVXG8wtfeJBCGOMYQP5OtWomu4CQ7ZLP56dE2/zyaJanKL9DessM3EfpDdjpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I73NRg5x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I73NRg5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD01C4CECE;
	Fri,  8 Nov 2024 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073578;
	bh=/p3pTCkhZFWoezcX0Ua12rwpQhBOpEwQJXd9Sy5MQD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I73NRg5xJxCQDui4+79Kx0W1YRR9ULcFX7hPC/44EfErKMnLN+FWu+ggJLTiDmyfp
	 ZbQcBpJ6vZnO1eKL7NObar/xdKAfdfWSZNyqrP7wuQTfhmhu7MoP/eHhxus0Mhaltp
	 yQGm/az4NMzNC1CSrnGdNDLxZC6trcYE+qG95Oz5CnmJVBR1CAyqWyhP/yLmlmf16s
	 pZ8Qe9f2mDZiduVpK24G4aoes8ejEqxoJQhPNI4vQT3HxpxQqsYoTwB3cB/Vpki32p
	 GmU5e46NwLeoS/w99V5ONluWVHfIYc5KlWTdLGWu1UoDlG+BNm4QCE/KRZWbMi52SB
	 /ndXGX4sdRGrA==
Date: Fri, 8 Nov 2024 14:46:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
	sakiiily@aosc.io, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [Regression] wifi problems since tg3 started throwing rcu stall
 warnings
Message-ID: <Zy4WKKq18GunXa6S@localhost.localdomain>
References: <b8da4aec-4cca-4eb0-ba87-5f8641aa2ca9@leemhuis.info>
 <ZxjLQzHKuR-w16hF@pavilion.home>
 <2b25a988-6965-48e4-a788-58dd8a776e06@leemhuis.info>
 <e2ffd3d06fad236ea900d4fb439b2240@aosc.io>
 <937c258b-f34c-4f63-949d-a5e7c8db714d@leemhuis.info>
 <ZyyQuTfMMSLwStf_@pavilion.home>
 <a7fc57a1a49b5f710c4354ca21c91dba@aosc.io>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7fc57a1a49b5f710c4354ca21c91dba@aosc.io>

Le Fri, Nov 08, 2024 at 12:29:40AM +0800, Mingcong Bai a écrit :
> Hi Frederic,
> 
> <snip>
> 
> > Sorry for the lag, I still don't understand how this specific commit
> > can produce this issue. Can you please retry with and without this
> > commit
> > reverted?
> 
> Just tested v6.12-rc6 with and without the revert. Without the revert, the
> touchpad and the wireless adapter both stopped working, whereas with the
> revert, both devices functions as normal.
> 
> I have attached the dmesg for both kernels below. Unlike the log we got last
> time, there is no direct reference to tg3 any more, but the NMI backtrace
> still pointed to NetworkManager and net/netlink-related functions (perhaps a
> debug kernel would be more helpful?). Here's a snippet:
> 
> [   10.337720] rcu: INFO: rcu_preempt detected expedited stalls on
> CPUs/tasks: { P683 } 21 jiffies s: 781 root: 0x0/T
> [   10.339168] rcu: blocking rcu_node structures (internal RCU debug):
> [   10.591480] loop0: detected capacity change from 0 to 8
> [   11.777733] rcu: INFO: rcu_preempt detected expedited stalls on
> CPUs/tasks: { 3-.... } 21 jiffies s: 1077 root: 0x8/.
> [   11.779210] rcu: blocking rcu_node structures (internal RCU debug):
> [   11.780630] Sending NMI from CPU 1 to CPUs 3:
> [   11.780659] NMI backtrace for cpu 3
> [   11.780663] CPU: 3 UID: 0 PID: 1027 Comm: NetworkManager Not tainted
> 6.12.0-aosc-main #1

Funny, this happens on bootup and no CPU has ever gone offline, so the path
modified by this patch shouldn't have been taken. And yet this commit has
an influence to the point of reliably triggering that stall.

I'm running off of ideas, Paul any clue?

Thanks.
