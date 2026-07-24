Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48B2E7F2C;
	Fri, 24 Jul 2026 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916666; cv=none; b=Ks/EqrLhYKsS4YncduEk23kg/KCxGqA+u7ZWsZQa21m6BT1DyeU1d/TpRDOmPd6yjA7EwB3Q9d5YzAVw/XWyb7TxyOZ9zTgKYiSrt5Ivq3GkqCVdD8oCBNmyvm45BlqfqnXDeYMjM8DWHVwt1jR9m1kcsi8pfZJYIRgyQmUXpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916666; c=relaxed/simple;
	bh=Qd+k830jyPj11rkFyngrdhPQcZKKfV87tUL9uj03Z2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMFGpZtSrM/gb2tcqE4xZ0tfWjfviejjYoDZkNspiiGtfBPqH2ZLwTKrpYa8Cm/JrmtBywpXHu1QLWw8sbSNctBFHta8qasMaWL6UJHlNKJm/oc/J0ZCydTzeA3kBjDUAu8MECYpW+0/v6ACA9Yc1FsaOhJhMWw97Oy53EGmlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRonc7Xk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRonc7Xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC31F1F000E9;
	Fri, 24 Jul 2026 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784916664;
	bh=1qpKXFTPwxplzBJWmCqJ3f9BRHXUqrbc/wk8dZw+g2o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=eRonc7XkMDhf6bzvUniFqPWr84ic2iMkcSMLAcwlc8H+uWPSmqKQSp2S1VHoH+jkt
	 FdIFiFnW5dNBh/FRveEPSFbGhjX4SLCA4c7mAtVPZpAloOXjPnkgC3DNCS9DcUu/an
	 NEBuk8zJYgMEvA3dCp6z7tHgEJHVZ7bV4qq9FlFav8f6BNTsWlaOUUViZ4IDVpEoFL
	 k1tt4WbEUsbzKDllKl/gQ1XhjmQC6KoWxmDz6628HnEjX5KOxfVa6dVn5EIY+rLtYI
	 nYHw9vpwpE37FdMBSjM8QLbFa6QpUOrqDGvcqzCVnI8CGzGfoUxSf+YxGB3GW8NiPW
	 MqqHj+aIpMHAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96CC2CE0B13; Fri, 24 Jul 2026 11:11:04 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:11:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Zqiang <qiang.zhang@linux.dev>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, urezki@gmail.com,
	boqun@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Reduce stack usage in show_rcu_gp_kthreads()
Message-ID: <666a1990-6b12-42bb-a40e-5b77da56e1e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260723100430.17813-1-qiang.zhang@linux.dev>
 <20260724142048.53e392a9@pumpkin>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724142048.53e392a9@pumpkin>

On Fri, Jul 24, 2026 at 02:20:48PM +0100, David Laight wrote:
> On Thu, 23 Jul 2026 18:04:30 +0800
> Zqiang <qiang.zhang@linux.dev> wrote:
> 
> > When CONFIG_KASAN=y and CONFIG_KASAN_STACK=y builds, the
> > show_rcu_gp_kthreads() exceeds the 1024-byte frame-size limit:
> > 
> ...
> >  	rcu_for_each_node_breadth_first(rnp) {
> >  		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
> >  		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
> >  		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
> >  			continue;
> > -		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
> > -			rnp->grplo, rnp->grphi,
> > -			(long)data_race(READ_ONCE(rnp->gp_seq)),
> > -			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
> > -			data_race(READ_ONCE(rnp->qsmask)),
> > -			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
> > -			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
> > -			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
> > -			".G"[!!data_race(READ_ONCE(rnp->gp_tasks))],
> > -			data_race(READ_ONCE(rnp->n_boosts)));
> 
> Isn't that code carefully reading all the values twice?

You are quite right, it does, and it did before Zqiang's patch.  I would
welcome a patch that carefully used locals to avoid the double reads,
as that could avoid some debug confusion that might otherwise result
due to low-probability races with updates to these same variables.
However, this function is invoked quite rarely in error conditions,
so I would also avoid holding anything up waiting for such a patch.

> Also the "ab"[!!val] generates far worse code than the more obvious (val ? 'a' : 'b').
> For the former gcc indexes a constant string, the latter is done using arithmetic.

This code is invoked quite rarely, so I am not concerned about the
overhead and I like the compactness.  In the longer term, perhaps
compilers will recognize the pattern and optimize it.  Or not, who
knows?  ;-)

> I'm sure there is a good reason for data_race(READ_ONCE(xxx)) ...

And there is!!!

The data_race() says "ignore the contents from a data-race viewpoint"
and the READ_ONCE() says "carefully avoid destructive optimizations that
might otherwise be applied to this load."

For an example, suppose that we had a global variable x that was accessed
only under a lock.  Except that we have lockless access for debugging
output like that in Zqiang's patch.  We want the normal lock-protected
accesses to be plain C-language accesses so that any accidental (and thus
likely buggy) lockless accesses are spotted by KCSAN, but we very much
to *not* want to acquire the lock when doing the debug output, because
if the lock was held, we might get a debug-output-free hang just when
we are in the greatest need of that debugging output.

So we use normal C-language accesses for the non-debug uses, and we use
data_race(READ_ONCE(x)) for the debugging output.

Does that make sense?

							Thanx, Paul
