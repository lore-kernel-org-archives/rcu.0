Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B94145B39;
	Fri, 19 Jul 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410210; cv=none; b=SWh4KyNRNvswNSOnR6s3Enb/9Q8xwMJ2dLXQmgnCoc00mhrAtxln5xtZNVBxq9Irf/o6kVY+V5IDCNyQyXj7aiYpwXX7l6OhH8kvf0yVToywqg3AlQHMgfBwc+QmZmS4zocW1uL/a6kqpES23/sf7DYHGYgz4nsnjKa2cwEecIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410210; c=relaxed/simple;
	bh=4NkRW9YdVT+ay+RfdaFb6xC9m/ZBT/pHcIOtHEw7Gk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzQi4UHpBlWq5HG1AfyOOBWXUMx50jQrk+L7UCxWl9WxKkxVNuhDOFGySGYOYL1Lt4ldTMZi1+OxPYvhHbBR/mVYM28qGbvTFbz4Xkf0zQF4DYyJu91OZQWIPlNp6wpJFHipACT4SulFphepSvC0cDwhCuZHtmboeEtVD7QQ2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grEa504E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grEa504E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5042C32782;
	Fri, 19 Jul 2024 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721410209;
	bh=4NkRW9YdVT+ay+RfdaFb6xC9m/ZBT/pHcIOtHEw7Gk0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=grEa504E+hzwBFlqpZVLcePSjfBWHI7Y4plD9pW8TAvxXxZ2p0EVSLewiKEZo68uu
	 9V9trhwY0rriRo2tk/AqqNw/Hrzpuv5uD0wkYcAm/ADiDq7N8D2J3+Ke3n8ObR47Yp
	 BaEyXnkppTX82SQf8/orFpE1Bj3/zvwF1nwjRh5dMwepWzo0QtF9ZjjctuUE6tlgnn
	 b9dlc/Xv5CWxxisnppAsJ1TOVD88U6t9EdP3ZgBTbHEWWRMFU7PixJk8fYS6mlE/dO
	 wcR2gV97jvd5bsmjRBUxNzz0tvu3WQ2EeoJpipaw0VpzXGEeYfneL/oa2YRzILU83F
	 dETduaF7aRsGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 71D1DCE09EA; Fri, 19 Jul 2024 10:30:09 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:30:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 00/11] rcu/nocb: (De-)offloading on offline CPUs
Message-ID: <c3b486c6-c0f1-404c-839c-7ebdc396824d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240530134552.5467-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530134552.5467-1-frederic@kernel.org>

On Thu, May 30, 2024 at 03:45:41PM +0200, Frederic Weisbecker wrote:
> Last LPC's debates seem to have raised general agreement that nohz_full
> cpusets interface should operate on offline CPUs to simplify the picture.
> And since the only known future user of NOCB (de-)offloading is going
> to be nohz_full cpusets, its transitions need to operate on offline
> CPUs as well.
> 
> The good news is that it simplifies a bit the (de-)offloading code, as
> the diffstat testifies.

Good stuf!!!

For the series:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> Thanks.
> 
> Frederic Weisbecker (11):
>   rcu/nocb: Introduce RCU_NOCB_LOCKDEP_WARN()
>   rcu/nocb: Move nocb field at the end of state struct
>   rcu/nocb: Assert no callbacks while nocb kthread allocation fails
>   rcu/nocb: Introduce nocb mutex
>   rcu/nocb: (De-)offload callbacks on offline CPUs only
>   rcu/nocb: Remove halfway (de-)offloading handling from bypass
>   rcu/nocb: Remove halfway (de-)offloading handling from rcu_core()'s QS
>     reporting
>   rcu/nocb: Remove halfway (de-)offloading handling from rcu_core
>   rcu/nocb: Remove SEGCBLIST_RCU_CORE
>   rcu/nocb: Remove SEGCBLIST_KTHREAD_CB
>   rcu/nocb: Simplify (de-)offloading state machine
> 
>  include/linux/rcu_segcblist.h |   6 +-
>  include/linux/rcupdate.h      |   7 +
>  kernel/rcu/rcu_segcblist.c    |  11 --
>  kernel/rcu/rcu_segcblist.h    |  11 +-
>  kernel/rcu/tree.c             |  45 +-----
>  kernel/rcu/tree.h             |   6 +-
>  kernel/rcu/tree_nocb.h        | 266 +++++++++++++---------------------
>  kernel/rcu/tree_plugin.h      |   5 +-
>  8 files changed, 122 insertions(+), 235 deletions(-)
> 
> -- 
> 2.45.1
> 
