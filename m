Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCC27CCC3;
	Fri, 28 Feb 2025 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767893; cv=none; b=YHz1crLiTEe46jNURQx9aQv3FTEM6ttdO/gm7v7BnUCWXuJ6vzfUV0A9gYba7FUQ/gCt7F314AySM66uHXlzusYi4DQdkfpoosQKBgz5D8LGf2E+DiYeq+82zKRvCi0xkibRpHfxoVSejKQHuAOU2tG+XO5pYcIbJiipK91kIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767893; c=relaxed/simple;
	bh=+ExAjuCub//33EjRWm6zsYb1gINoL1tsET0MyxuihxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftHqwsVVZnNtd7SnrM99rOQ5x3ILB7ySTgkkAsImDq+ThHjHYHw+StEfLZD+eV8mFJ5ridqjA6ulTjYK3WiM65dK150ppivNmBCkXJqMQAmOrSjH4SOb5O+L8d/fbhrMiZ2XbxZKWwvlkT0KdvupuVOrQxOo6FCTXxk1MRwKN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uofk3v08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uofk3v08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21266C4CED6;
	Fri, 28 Feb 2025 18:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740767893;
	bh=+ExAjuCub//33EjRWm6zsYb1gINoL1tsET0MyxuihxA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Uofk3v08aVuGrhM0C1utDEN8xgDwTdNm4NsHgWyrpjg6HXeyFAtvaNp132OyNOjWU
	 WJh6ZeJJx84dItycbBc6dhJzsfZ01XKgv7xrjUdfr4ih2x07HumDBfhRQREVESIwxZ
	 IFpwjpUN5xYnohKqMFNvnP5sDOP5O1Kvf6Ov7foRUtRAy8x2eshyOzLDVmSdIIQnIT
	 xGjQ9hgOuHPBnfonhPtErFQEBeb3O5UxJ+Y0SnIjbmr9tM5EJIdi9sC4BTlXRNp3oU
	 hhUnQ+ZmWxaPyzzSxbALCvB6K8rpE5682u0kBsrgvhcSJ8HlKrBNEHvaBnu8gsxXc4
	 BhrgyTq4JFC+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ABE7ACE0DEB; Fri, 28 Feb 2025 10:38:12 -0800 (PST)
Date: Fri, 28 Feb 2025 10:38:12 -0800
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
Message-ID: <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8H_aYBUHD2sS2Ir@pc636>

On Fri, Feb 28, 2025 at 07:24:41PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 28, 2025 at 10:21:57AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 28, 2025 at 05:36:47PM +0100, Uladzislau Rezki wrote:
> > > On Fri, Feb 28, 2025 at 07:41:40AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Feb 27, 2025 at 06:44:15PM +0100, Uladzislau Rezki wrote:
> > > > > On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> > > > > > On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > > > > > > Hi Ulad,
> > > > > > > 
> > > > > > > I put these three patches into next (and misc.2025.02.27a) for some
> > > > > > > testing, hopefully it all goes well and they can make it v6.15.
> > > > > > > 
> > > > > > > A few tag changed below:
> > > > > > > 
> > > > > > > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > > Switch for using of get_state_synchronize_rcu_full() and
> > > > > > > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > > > > > > synchronize_rcu() call.
> > > > > > > > 
> > > > > > > > Just using "not" full APIs to identify if a grace period is
> > > > > > > > passed or not might lead to a false-positive kernel splat.
> > > > > > > > 
> > > > > > > > It can happen, because get_state_synchronize_rcu() compresses
> > > > > > > > both normal and expedited states into one single unsigned long
> > > > > > > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > > > > > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > > > > > > run.
> > > > > > > > 
> > > > > > > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > > > > > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > > > > > > for expedited and normal states.
> > > > > > > > 
> > > > > > > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > > > > > > 
> > > > > > > I switch this into "Closes:" per checkpatch.
> > > > > > > 
> > > > > > > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > > > > > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > 
> > > > > > > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > > > > > > Would you or Paul double-check the Reviewed-by should be here?
> > > > > > 
> > > > > > I am good with keeping my Reviewed-by tags.
> > > > > > 
> > > > > Thanks Paul!
> > > > 
> > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > RCU tree:
> > > > 
> > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > 
> > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > that this is the scenario that tests it.  It happened within five minutes
> > > > on all 14 of the TREE05 runs.
> > > > 
> > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > trigger this whereas you do. Something is wrong.
> > 
> > If you have a debug patch, I would be happy to give it a go.
> > 
> I can trigger it. But.
> 
> Some background. I tested those patches during many hours on the stable
> kernel which is 6.13. On that kernel i was not able to trigger it. Running
> the rcutorture on the our shared "dev" tree, which i did now, triggers this
> right away.

Bisection?  (Hey, you knew that was coming!)

							Thanx, Paul
