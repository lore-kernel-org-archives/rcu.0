Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63E1F4CBF;
	Fri, 28 Feb 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766917; cv=none; b=R0IFB7r9T0lbbZshESTEhzon7LxODl4tvWkknYmhBy2LMThZqt8anMNM3pgQOQAVhRDYT+usGkmc6kNNrDhEdasXBsq8XDSo7S2oVqBDuQjMBkv0uYuOFg7zKrw6moIYED5LJmHsy1UpWYzB82zWUhjv73vowOpRNrx7eEdRamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766917; c=relaxed/simple;
	bh=gdqNtEjhwLqOLhNKqAMfg7YlwKDCiYemmYOmdof2QbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQl8rl4ZwYns5DCL5dD3SLXHRk2SdiWIsrR85DCZXWYvPE4MPG/3jlYr/uyGjnIq2f8beF/yc/LrGfPSsIsYUS9ewV/z94CrKPkA1xPXwKIEwll4EP9PRAPwN2R9NItKHtYgfCW0v5MP2Zqcen6hkU7HQCKwOf5R61KX+uhTYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWYD1+dU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWYD1+dU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D585C4CEE2;
	Fri, 28 Feb 2025 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740766917;
	bh=gdqNtEjhwLqOLhNKqAMfg7YlwKDCiYemmYOmdof2QbQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IWYD1+dUgQQv8ScSgcW4snocekZXdbVHcEDj9SwlEzOqGdejJ23Oh3VpjhKnH/LXV
	 kvb/co0aDAj8es3En/2w9QSFlcvWgGXGIco1pvgmLdgrYcAhOKn35HbVNb2ezqoKAl
	 PCS1OYXJ0HGx8QFYJgoTtACxbuQl1Nuqu/kN4PTkw7sILj5DKCzW5wwasuUcBkiZKU
	 fj9AzycCHPXLrt0VmUQEjghqxu3QclPA6Vz3UZAmnHPvO7w0xWfbvm1+MsjNA5ws0N
	 pow5sVikuZtn9NV5lFSlJGw+nEsVoS+KnxkXKs/USGaS8jLRCcx+HKnp8ZKZ1jsHid
	 tIZphs4Gmhqmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B1C2CE0DEB; Fri, 28 Feb 2025 10:21:57 -0800 (PST)
Date: Fri, 28 Feb 2025 10:21:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8HmH85bYNU8enJ2@pc636>

On Fri, Feb 28, 2025 at 05:36:47PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 28, 2025 at 07:41:40AM -0800, Paul E. McKenney wrote:
> > On Thu, Feb 27, 2025 at 06:44:15PM +0100, Uladzislau Rezki wrote:
> > > On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > > > > Hi Ulad,
> > > > > 
> > > > > I put these three patches into next (and misc.2025.02.27a) for some
> > > > > testing, hopefully it all goes well and they can make it v6.15.
> > > > > 
> > > > > A few tag changed below:
> > > > > 
> > > > > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > Switch for using of get_state_synchronize_rcu_full() and
> > > > > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > > > > synchronize_rcu() call.
> > > > > > 
> > > > > > Just using "not" full APIs to identify if a grace period is
> > > > > > passed or not might lead to a false-positive kernel splat.
> > > > > > 
> > > > > > It can happen, because get_state_synchronize_rcu() compresses
> > > > > > both normal and expedited states into one single unsigned long
> > > > > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > > > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > > > > run.
> > > > > > 
> > > > > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > > > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > > > > for expedited and normal states.
> > > > > > 
> > > > > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > > > > 
> > > > > I switch this into "Closes:" per checkpatch.
> > > > > 
> > > > > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > > > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > 
> > > > > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > > > > Would you or Paul double-check the Reviewed-by should be here?
> > > > 
> > > > I am good with keeping my Reviewed-by tags.
> > > > 
> > > Thanks Paul!
> > 
> > Except that I got this from overnight testing of rcu/dev on the shared
> > RCU tree:
> > 
> > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > 
> > I see this only on TREE05.  Which should not be too surprising, given
> > that this is the scenario that tests it.  It happened within five minutes
> > on all 14 of the TREE05 runs.
> > 
> Hm.. This is not fun. I tested this on my system and i did not manage to
> trigger this whereas you do. Something is wrong.

If you have a debug patch, I would be happy to give it a go.

							Thanx, Paul
