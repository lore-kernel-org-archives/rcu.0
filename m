Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA326B971;
	Fri, 28 Feb 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767159; cv=none; b=XeYR1afxWi0LRdNwjkKjkixyPP50Q2v6GFkXnzUOjKXTajDddBeF3O3p9top6Uf5Tduzi5Z3NpZzkwKjhblwa/pHJw6+rV2pxnDRSteC8pulg5x/5g73iWYXiFddJ5AaRez+MX5jMN9zDFkaHhExhtUlUc4uUQxnJZv4NxFKY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767159; c=relaxed/simple;
	bh=KWNfmpF8H7ef8BfvDKRANl/bBOIRz9uB8GRqpQxwgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6pMiclM4rSTEEfToK7aSUbuL1tSc1o7mCKyn6i/DDJu2XL1Ce7qELu7wzDpk8uo9AQBwXeBhd7UYga2mF1cWsXih9xNHRFjwlIc5hyh21EBjV7GFUH85mzz/MqOAY3wJphhD/fukgxfhPzC94yiyzyj2jgg9sSQkWSmKVedpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRf83pOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRf83pOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB03EC4CED6;
	Fri, 28 Feb 2025 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740767159;
	bh=KWNfmpF8H7ef8BfvDKRANl/bBOIRz9uB8GRqpQxwgZQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mRf83pOlLO7uGDaTA1eEb5PonlPf2Y/HOTCNDx+63r5NM4kSc4U71dQnlfjSm9xNl
	 +U8gZSFZ466rq9EKmSV1BQTrFMUrFWBRsTRHTZxb0YuDDWaWmuQlr65vXOEWnZI7/7
	 kcrv9cyJNOQeQozt5Z+LbeOL4W+2GgyJ4Q8IetNsrGkXSwKKVlHXT/ZoSZPsg2hU5r
	 EDlxE9g7oActngZ77pZa+6oe5WJhUvbTMNepB7uHq2XsGE6oyZWQA1moSsO5wtXSu3
	 F6Wb6Wm1AERTkWMm1MdWh0Cz+g/gQIrJuiZUzKMERgm2kI5azq4GpcRkGSn8AU4FN5
	 V0dqc/aj0J9Xw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97089CE0DEB; Fri, 28 Feb 2025 10:25:58 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:58 -0800
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
Message-ID: <6e4688d1-afe7-4508-9ebc-eeece0692365@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <Z8Htg565HnNumdxy@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Htg565HnNumdxy@pc636>

On Fri, Feb 28, 2025 at 06:08:19PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 28, 2025 at 05:36:47PM +0100, Uladzislau Rezki wrote:
> > On Fri, Feb 28, 2025 at 07:41:40AM -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 27, 2025 at 06:44:15PM +0100, Uladzislau Rezki wrote:
> > > > On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > > > > > Hi Ulad,
> > > > > > 
> > > > > > I put these three patches into next (and misc.2025.02.27a) for some
> > > > > > testing, hopefully it all goes well and they can make it v6.15.
> > > > > > 
> > > > > > A few tag changed below:
> > > > > > 
> > > > > > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > Switch for using of get_state_synchronize_rcu_full() and
> > > > > > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > > > > > synchronize_rcu() call.
> > > > > > > 
> > > > > > > Just using "not" full APIs to identify if a grace period is
> > > > > > > passed or not might lead to a false-positive kernel splat.
> > > > > > > 
> > > > > > > It can happen, because get_state_synchronize_rcu() compresses
> > > > > > > both normal and expedited states into one single unsigned long
> > > > > > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > > > > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > > > > > run.
> > > > > > > 
> > > > > > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > > > > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > > > > > for expedited and normal states.
> > > > > > > 
> > > > > > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > > > > > 
> > > > > > I switch this into "Closes:" per checkpatch.
> > > > > > 
> > > > > > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > > > > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > 
> > > > > > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > > > > > Would you or Paul double-check the Reviewed-by should be here?
> > > > > 
> > > > > I am good with keeping my Reviewed-by tags.
> > > > > 
> > > > Thanks Paul!
> > > 
> > > Except that I got this from overnight testing of rcu/dev on the shared
> > > RCU tree:
> > > 
> > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > 
> > > I see this only on TREE05.  Which should not be too surprising, given
> > > that this is the scenario that tests it.  It happened within five minutes
> > > on all 14 of the TREE05 runs.
> > > 
> > Hm.. This is not fun. I tested this on my system and i did not manage to
> > trigger this whereas you do. Something is wrong.
> >
> We have below code to start a new GP, if we detect that processing is
> starved:
> 
> <snip>
> /*
>  * The "start_new_poll" is set to true, only when this GP is not able
>  * to handle anything and there are outstanding users. It happens when
>  * the rcu_sr_normal_gp_init() function was not able to insert a dummy
>  * separator to the llist, because there were no left any dummy-nodes.
>  *
>  * Number of dummy-nodes is fixed, it could be that we are run out of
>  * them, if so we start a new pool request to repeat a try. It is rare
>  * and it means that a system is doing a slow processing of callbacks.
>  */
>   if (start_new_poll)
>     (void) start_poll_synchronize_rcu();
> <snip>
> 
> we do not use a _full() version, since we need to inform rcu-gp-kthread
> to initiate a new GP.
> 
> Any thoughts?

My kneejerk not-to-be-trusted take is that it does not matter which type
of grace period gets started so long as a grace period does get started.
Presumably you have done the get_state_synchronize_rcu_full() before
this point?

							Thanx, Paul
