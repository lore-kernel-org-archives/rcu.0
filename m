Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D353C108E;
	Fri,  4 Sep 2026 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537625; cv=none; b=qv/wHxe2vAWLBJz02CUVmDuyW85PUTHUx3TEb/YF8hLpiqb/C/Jx451MeMqE/ahDmtbgzl5WQuDCJBPABNTK1USDvnNVaQzcF5XvpNNc6hffJn20C2EWZnyVVm1caFL1u8hfoJnJN9gK2EI0RccovRkEgPd1sKn0e5ugtstdbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537625; c=relaxed/simple;
	bh=ce07x9ph3CKj5wRibERy84xXZ56sWK0SXZxKV6UZq48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiBmUPqFfzxbWV47dIN5XlxIcrFJvUN9PyS60IVl2kA1txaWdPqnW2OrfQ5/Eui/o+qKIyza1nfyl1O2nqFp5t+CTuacD1CexsunEd7MBqcPQtsr2mttaGwvZvwVjulPKN9yjmw6KttxVngVE3EyH4cKe5cPJNBk4vSxXc1CEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgyqxp7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgyqxp7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293B31F00ACF;
	Fri,  4 Sep 2026 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537623;
	bh=cymQYDePLMHXo+caVBo5osxnEFPmGwBfxQBqiFzTcfg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Bgyqxp7sB5Gjwxs2SCBOMMgXVS4p84R03+/BDpwOz/nHiERMJNFtL5W6hOwkgidwj
	 /rRQWU1yqot4OnleWoXeWd8LHArxSnE9RWA1IOPEoD5heaUkpoWCkUZt+D8YziHgiV
	 AP3vsKRXfWG3Yk7wiX7LUN3D9i4W6kzxg3lyv8YBvuS0mcZW6bFm3NTWn288bx51mW
	 X0p5m4mAeKRwLuPthjStYC5ShKRB1K1+0kLyCoCDoS0fP2qtxOG1T3a9U1rm1Iq7aQ
	 4iPzURiQGS3OqMVxCi4Zave8HM68f+uP2EZsZN5HiRxvAWHF6+Z3BDwL7pa6P2gHqX
	 PpG1qExObJNRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E43F4CE0877; Fri,  4 Sep 2026 09:00:22 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:00:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <include@grrlz.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hazptrtorture: Fix inverted sleep condition in
 do_pending kthread
Message-ID: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260804000340.4812-1-include@grrlz.net>
 <cd110e62-da2c-4366-b9c9-24c1df6a39ec@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd110e62-da2c-4366-b9c9-24c1df6a39ec@efficios.com>

On Fri, Sep 04, 2026 at 09:01:05AM -0400, Mathieu Desnoyers wrote:
> On 2026-08-03 20:03, Bradley Morgan wrote:
> > The do_pending kthread never sleeps. Its supposed to.
> > kthread_do_pending_ms sets the gap between cleanups, and the docs
> > say so too. But the sleep sits behind torture_must_stop(), and thats
> > false while the test runs. So the kthread never sleeps. It just loops.
> > It drains the pending lists over and over, no pause, and burns a full
> > CPU for the whole test.
> 
> Paul, I just found this patch in my junk email folder. Maybe relevant
> for you ?

We got it in my -rcu tree:

15b9fca2f5ce ("hazptrtorture: Fix inverted sleep condition in do_pending kthread")

But I do appreciate your checking for missed patches, thank you!

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > Flip the check. With !torture_must_stop() it sleeps for
> > kthread_do_pending_ms between passes. When the test stops it does one
> > last cleanup and exits. Nothing left to do, so no sleep needed then.
> > 
> > Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release deferred hazard pointers")
> > Signed-off-by: Bradley Morgan <include@grrlz.net>
> > ---
> >   kernel/rcu/hazptrtorture.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> > index 72aeb50668e9..7c8b5899fb01 100644
> > --- a/kernel/rcu/hazptrtorture.c
> > +++ b/kernel/rcu/hazptrtorture.c
> > @@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void *arg)
> >   			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
> >   			hazptr_torture_do_one_pending(cpu, &rand);
> >   		}
> > -		if (torture_must_stop())
> > +		if (!torture_must_stop())
> >   			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
> >   		// Omit stutter_wait() because this function needs to do cleanup.
> >   	} while (!torture_must_stop());
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
