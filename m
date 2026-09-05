Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61C22FDE6;
	Sat,  5 Sep 2026 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648880; cv=none; b=gfHtWFZ3oOZqhbkoWXCcybqn8mObM9fwHAME7twGPgoRf0ClMgUeLPMl6PUToLQXp+S8qjHab9/4s//BDiZk9/iv9FG7T8+8p3V28PkRyXXV2MvVEm2gXviTGTxY0Ph12/0naH8/0Cj7yJD5WPL6hRlPWOwa4sW7jg2wxqzILyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648880; c=relaxed/simple;
	bh=egRZqHZvNyhAjZ2hscK68d73YtqKBKGkOG0CdDJUSiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAo00czBLYiTCVsgSQ5Cn850XE9YSvQQJJEK4spFvlHE7CULUzwLRD0WPW7qHDmmEf2bNeYcNDvkpJyRNEzzhjafGDJ+vNQrEcB+VoSMreZvHDt2hgM+KEVlxBCfI6ChtXgvLu9hNQfOKHHfuznUFu5g7Z/vouaMhmEJc97B9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhrIBh2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhrIBh2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971771F00A3A;
	Sat,  5 Sep 2026 22:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788648878;
	bh=LoNzh95s9xKHbGG0VhnSLPAPC6nH1VAsI4kehRM2e2c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=UhrIBh2ReDp+xw5SgKCGSxMsCWAFm24BYiS2L635hEtjsWNX7mHTxeQ8naJnpcmN+
	 PtEMagV4gBfZtPDkoxLRCsoZyzbN6g4W+M/EkQ4h6kAKViiiwPnl1TgvlPRUYQj2q/
	 JOKJ5Yf8Gtn8CKohHscJfZzXQD7n/5d3GvmZ0vyMCw5mawX9UdxDzq+NcYKCqh9NSb
	 QYqbQsstFbf96VxshhZWyXYTZgSlty6f2VRgpf+G7xOZf2vL72rXtGbmnTYHe50+MA
	 TiCOrS9pOnXrvpFbflGrt1MohCStuHQr90fjCGYszpFT55Vox3TQB4ulDiWd0f6i1w
	 178qnxKtUNs+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5D17ECE0AC0; Sat,  5 Sep 2026 15:54:38 -0700 (PDT)
Date: Sat, 5 Sep 2026 15:54:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: boqun@kernel.org, frederic@kernel.org, include@grrlz.net,
	jiangshanlai@gmail.com, joelagnelf@nvidia.com,
	josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
	qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
	urezki@gmail.com
Subject: Re: [PATCH] hazptrtorture: Fix inverted sleep condition in
 do_pending kthread
Message-ID: <34021ed4-1a18-4cb6-8027-a8c919086ec0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop>
 <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org>
 <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop>
 <AF26CA5B-6766-4682-A6A4-61F14F8B81F0@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF26CA5B-6766-4682-A6A4-61F14F8B81F0@mainlining.org>

On Sat, Sep 05, 2026 at 10:08:30PM +0100, Bradley Morgan wrote:
> On 5 September 2026 21:40:28 BST, "Paul E. McKenney" <paulmck@kernel.org>
> wrote:
> >On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
> >> On 4 September 2026 17:00:22 BST, "Paul E. McKenney"
> ><paulmck@kernel.org>
> >> wrote:
> >> >On Fri, Sep 04, 2026 at 09:01:05AM -0400, Mathieu Desnoyers wrote:
> >> >> On 2026-08-03 20:03, Bradley Morgan wrote:
> >> >> > The do_pending kthread never sleeps. Its supposed to.
> >> >> > kthread_do_pending_ms sets the gap between cleanups, and the docs
> >> >> > say so too. But the sleep sits behind torture_must_stop(), and
> >thats
> >> >> > false while the test runs. So the kthread never sleeps. It just
> >loops.
> >> >> > It drains the pending lists over and over, no pause, and burns a
> >full
> >> >> > CPU for the whole test.
> >> >> 
> >> >> Paul, I just found this patch in my junk email folder. Maybe relevant
> >> >> for you ?
> >> >
> >> >We got it in my -rcu tree:
> >> >
> >> >15b9fca2f5ce ("hazptrtorture: Fix inverted sleep condition in
> >do_pending
> >> >kthread")
> >> >
> >> >But I do appreciate your checking for missed patches, thank you!
> >> >
> >> >							Thanx, Paul
> >> >
> >> >> Thanks,
> >> >> 
> >> >> Mathieu
> >> >> 
> >> >> > 
> >> >> > Flip the check. With !torture_must_stop() it sleeps for
> >> >> > kthread_do_pending_ms between passes. When the test stops it does
> >one
> >> >> > last cleanup and exits. Nothing left to do, so no sleep needed
> >then.
> >> >> > 
> >> >> > Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release
> >deferred
> >> >hazard pointers")
> >> >> > Signed-off-by: Bradley Morgan <include@grrlz.net>
> >> >> > ---
> >> >> >   kernel/rcu/hazptrtorture.c | 2 +-
> >> >> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >> >> > 
> >> >> > diff --git a/kernel/rcu/hazptrtorture.c
> >b/kernel/rcu/hazptrtorture.c
> >> >> > index 72aeb50668e9..7c8b5899fb01 100644
> >> >> > --- a/kernel/rcu/hazptrtorture.c
> >> >> > +++ b/kernel/rcu/hazptrtorture.c
> >> >> > @@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void *arg)
> >> >> >   			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
> >> >> >   			hazptr_torture_do_one_pending(cpu, &rand);
> >> >> >   		}
> >> >> > -		if (torture_must_stop())
> >> >> > +		if (!torture_must_stop())
> >> >> >   			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
> >> >> >   		// Omit stutter_wait() because this function needs to do cleanup.
> >> >> >   	} while (!torture_must_stop());
> >> >> 
> >> >> 
> >> >> -- 
> >> >> Mathieu Desnoyers
> >> >> EfficiOS Inc.
> >> >> https://www.efficios.com
> >> >
> >> >
> >> Hi, new email.
> >> 
> >> Could I ask where the heck hazptr is? Its not in next, would you like,
> >> help???
> >> 
> >> --- Thanks!
> >>
> >https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
> >
> >It is still in my -rcu tree.
> >
> >I would not say "no" to a fix for this issue:
> >
> >https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
> >
> >Once that is in place, I would be happy to put this back into -next.
> >
> >At some point, we will need to get rid of the concept of wildcard hazard
> >pointers, as those end up instead emulating RCU, but I don't see that
> >as an immediate obstacle.
> 
> Well, okay, tell me more and I'll develop it.

I must confess that I have not looked much into that bug report, so I
don't have much more to tell.

						Thanx, Paul

> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
> 
