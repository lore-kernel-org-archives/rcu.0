Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568013B5B2;
	Wed,  3 Jul 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009040; cv=none; b=aOpuXxRzaNOcFjt8SGtQGI7B56LPuqCixBmVlr8EpsAg5nIJPOZKWSqhOBrS2DigWq6LbBH+OY05L+dlZcx7HP+eJJBE2F7lmciabLYZ9giEWn9ozOG5h3bglF/aD6D4JGWN2kz5PsTj2uGHHnanovZnMVpu0WvAxogCHk8NnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009040; c=relaxed/simple;
	bh=ENsY/Z3IpL8lqhpqzp0VxWY+lGl4BxkWPyhFI4265z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1mU7aT6gQNt0oVAGd3sG+v35yHaUCizAB3NFTEViJNoCOeaKs1hVNuEvLnLFMRQWq983kwOsrTRXKVU9n2b0ew0bFiCNax7Ob4vPRePC///VAY3tjvpyWiNQ+zLqCZVLCLP4acrAM1bFp5zPcBDeWP/b0ats5jb2tmkdWMuBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF5ssLst; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF5ssLst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4340FC2BD10;
	Wed,  3 Jul 2024 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720009039;
	bh=ENsY/Z3IpL8lqhpqzp0VxWY+lGl4BxkWPyhFI4265z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OF5ssLst5gpHDxpSPWGbqvcLlEz0dSSUsVpMLGLR+r7FMl5fP3TAXxpOPGntJsdPx
	 0V1Q8pvgz2Z2KY8ec213RIZlpWHKJCc36YRGgeuMuwOB+L/zodBU9v0tZridF0ABRN
	 8yVkr+9/eEicwD/FCOKvwb6d16CwbO/YDSButiw+4GPveIK1rzM2nlgz9gVYmWCOog
	 hVFy/rOqKl98mH/Hv85WGH0SO/7+QylwLrEUrlWTZxQynohdeNzi2xcYaiY6AZYhl+
	 tnOSETsLl4c6oNsH1nnPaRmd+xFy92LCu4CEgBOsYI5273G2l6TWDS1QkaAK75SI+K
	 4MwAzYLzbc5pg==
Date: Wed, 3 Jul 2024 14:17:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 11/11] rcu/nocb: Simplify (de-)offloading state machine
Message-ID: <ZoVBTCcbiTr0zWoF@localhost.localdomain>
References: <20240530134552.5467-1-frederic@kernel.org>
 <20240530134552.5467-12-frederic@kernel.org>
 <ZoSLCHWKXAOvd5Zl@boqun-archlinux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoSLCHWKXAOvd5Zl@boqun-archlinux>

Le Tue, Jul 02, 2024 at 04:19:36PM -0700, Boqun Feng a écrit :
> On Thu, May 30, 2024 at 03:45:52PM +0200, Frederic Weisbecker wrote:
> > Now that the (de-)offloading process can only apply to offline CPUs,
> > there is no more concurrency between rcu_core and nocb kthreads. Also
> > the mutation now happens on empty queues.
> > 
> > Therefore the state machine can be reduced to a single bit called
> > SEGCBLIST_OFFLOADED. Simplify the transition as follows:
> > 
> > * Upon offloading: queue the rdp to be added to the rcuog list and
> >   wait for the rcuog kthread to set the SEGCBLIST_OFFLOADED bit. Unpark
> >   rcuo kthread.
> > 
> > * Upon de-offloading: Park rcuo kthread. Queue the rdp to be removed
> >   from the rcuog list and wait for the rcuog kthread to clear the
> >   SEGCBLIST_OFFLOADED bit.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> [...]
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 24daf606de0c..72a2990d2087 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> [...]
> > @@ -1079,29 +1080,14 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> >  		 * but we stick to paranoia in this rare path.
> >  		 */
> >  		rcu_nocb_lock_irqsave(rdp, flags);
> > -		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
> > -		rcu_nocb_unlock_irqrestore(rdp, flags);
> > +		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_OFFLOADED);
> > +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> >  
> 
> Dropping rdp->nocb_lock unconditionally means we are the holder of it,
> right? If so, I think we better replace the above
> rcu_nocb_lock_irqsave() with raw_spin_lock_irqsave().

Good point, I'll do that.

Thanks.
