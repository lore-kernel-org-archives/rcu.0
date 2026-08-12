Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA2490BE2;
	Wed, 12 Aug 2026 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570026; cv=none; b=rTIHmggPxPiKrE+wRn8F9Ao1RLvZkB4TfUN7+5Lce4rQxmvuue6+IME50eGSy0UaHMcukZOK6DXFETU/K5fhyMeht/uxq/qk2bBEc6mPDUIoNCsq3j3kp0EIZSDUUONDftAdXPYJcOSND/C6ZBS1OC83y1ZiUCGGF9DM6q9dCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570026; c=relaxed/simple;
	bh=aRYUUqHwLCH9J5qPwA8C2e1PRfbrPHnkeWjcd7jChZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH53ysWU99Pr66O6byHZPO0+0DlgjZimNjBJ8th3yL6C3fr+UuK+Jgt5tJr1MShWryUwc4pt+aQqQJy+bVyV0K+ud4uZaBKNqUypIWe+g0F2fguLwaJkp900TBDa8ZE3hoDOrk3uuaZsQzC4JSbdkFJAla12QmJtHjJRHowxGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP9oFoBt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP9oFoBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC4B1F00A3A;
	Wed, 12 Aug 2026 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786570017;
	bh=0tKpPjGzkf8Xj+uCWoNNLTUaBvdi59dJkV8/z3hY3hk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=XP9oFoBtFLw8G6h2pExLyiU+NsfcI4igRxhnTm6+L1Kk3nAa0C/ar2/NAXIv4/DXH
	 Hem8UJ7MY1sjeNYkiO+KnQlOiNIA6T54O3XXkJFe0HKwN6jPvi2XtnwLIZNaFDS+mf
	 klvFiIueqCFCwIzZ01ygOnTy13RrJVndiRobuYrSEx3H8sAz+n6NRxck8hzs989/w7
	 syQnRTMVUD8n7VXTM+ffOeqJIgZ7ZAcJXhyr7Pk8fnQJJe8XmJQ5MUkdtsuWOgfy6N
	 KzfXPS0r/V6/EPDEqlDkE3gqyQj2hHql9vKRjK4DXbJL25Q0/NP/CofS4kaOnefgBO
	 F3mKEkWRxxStA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 68F03CE0EBE; Wed, 12 Aug 2026 14:26:57 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:26:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Zqiang <qiang.zhang@linux.dev>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, boqun@kernel.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] srcu: Fix WARN_ON() for timer_delete_sync() in
 cleanup_srcu_struct()
Message-ID: <12a80fb0-d725-4f20-8c97-f636866eebd4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260811002951.106631-1-qiang.zhang@linux.dev>
 <anw3uOzb-WXTh6B4@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anw3uOzb-WXTh6B4@gmail.com>

On Wed, Aug 12, 2026 at 02:07:13AM -0700, Breno Leitao wrote:
> On Tue, Aug 11, 2026 at 08:29:51AM +0800, Zqiang wrote:
> > The WARN_ON() for timer_delete_sync() means that the caller forgot
> > to call srcu_barrier() before cleanup. however, it still can trigger
> > even when srcu_barrier() was properly called.
> > 
> > When a SRCU grace period ends and find that the allocation of srcu_node
> > tree has been completed, but the ss_state is still less than SRCU_SIZE_BIG,
> > the mask=~0 causes delay_work timer be queued on every CPU which has
> > been online regardless of whether it's sdp->srcu_cblist has callbacks.
> > the srcu_barrier() only wait srcu_barrier_head's callbacks to complete,
> > however, the srcu_barrier_head will not be inserted into an empty
> > sdp->srcu_cblist. after that, when cleanup_srcu_struct() finds a pending
> > delay_work timer on a CPU with no callbacks, triggering a false positive.
> > 
> > This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(), make the
> > warning triggers only when the timer is still pending and there are
> > actual outstanding callbacks.
> > 
> > Fixes: 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is successfully deleted")
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@intel.com/
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> 
> Tested-by: Breno Leitao <leitao@debian.org>

Thank you, Breno!  I will add this to the original, which I merged this
fix into.

							Thanx, Paul
