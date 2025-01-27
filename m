Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A73D64;
	Mon, 27 Jan 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737989504; cv=none; b=kMW5m9+iNmyYFcf8HRTpzMcD1DxynPhF9K2Q0L6i7RL1YmdKp/bQbSkaIWFu5YU63BqjGd+wbE5/V/bplBwkDyKfb7M1xCb4zIUfg+UnRnUJAbSnJsUfc6Qu2Kql6Po9AvMMKRecELpSnNOQE7YGkXD6h+6+AuD74FNyuc3qfVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737989504; c=relaxed/simple;
	bh=qnE8ltzwvDt3UjSkL2kOfB3DenvBUYhMsngajlMaejA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usuVyDOx/UrOoFSF9PkcH0g3O1Img8LQaWOCQdQ/Q3DTnVwSFbfy9JvkvLX/6/9W/slubHrFUe7xfhCu55OQlI8w51ag8lcYtlbKOjeTWi9wzeiYkUp9sXxWSsx++gdWDBRRcdnZN6wfunK2cU0DWyEmPaN6kp6+Zan79ZL8BmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSdU6pTM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSdU6pTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8C4C4CED2;
	Mon, 27 Jan 2025 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737989504;
	bh=qnE8ltzwvDt3UjSkL2kOfB3DenvBUYhMsngajlMaejA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XSdU6pTMZzS2OzCyV9lkmJZVaW32RzyEW50vr1txCoPKrvzGx9VOK3/GtlPiHSeRy
	 7ynyNCyapo8pvv8lVckOCVvVcn4+t5BFUJWzwdKH4X7QHa1hedRXFjy0vH4slR7a5N
	 nrcsFXMgnyHD1YfJzishasaWlOAxY0jyfUTmeMh2DPjawch4fsCZfe/5esG5sVQBWn
	 hwUrlaZBIIaObkEZRHyCZtC/Y4cxRGNXjaifo72ezCgtfM9YWYtyLturwBryEw9217
	 jGXCZ8AgAlVGIC0QQg3p8GUabLaeRmGUxmnXpQBPj/VoZ4Qowy/4Z3xmtwchQuYj1p
	 3k/MwLlqo4H3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0AF9ACE0D86; Mon, 27 Jan 2025 06:51:44 -0800 (PST)
Date: Mon, 27 Jan 2025 06:51:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
 <Z5N8cmpD-HmTYQQJ@pc636>
 <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
 <Z5PMGlDb489VEZ7S@pc636>
 <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
 <Z5PSeEn_ceFuqbnz@pc636>
 <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
 <Z5eJ13aWwMDK00U1@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5eJ13aWwMDK00U1@pc636>

On Mon, Jan 27, 2025 at 02:27:51PM +0100, Uladzislau Rezki wrote:
> On Fri, Jan 24, 2025 at 11:34:03AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 24, 2025 at 06:48:40PM +0100, Uladzislau Rezki wrote:
> > > On Fri, Jan 24, 2025 at 09:36:07AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Jan 24, 2025 at 06:21:30PM +0100, Uladzislau Rezki wrote:
> > > > > On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> > > > > > On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > > > > > > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > > > > > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > > > This configuration specifies the maximum number of CPUs which
> > > > > > > > > is set to 8. The problem is that it can not be overwritten for
> > > > > > > > > something higher.
> > > > > > > > > 
> > > > > > > > > Remove that configuration for TREE05, so it is possible to run
> > > > > > > > > the torture test on as many CPUs as many system has.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > > 
> > > > > > > > You should be able to override this on the kvm.sh command line by
> > > > > > > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > > > > > > For example, see the torture.sh querying the system's number of CPUs
> > > > > > > > and then specifying it to a number of tests.
> > > > > > > > 
> > > > > > > > Or am I missing something here?
> > > > > > > > 
> > > > > > > It took me a while to understand what happens. Apparently there is this
> > > > > > > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > > > > > > you need to know about that. I have not expected that.
> > > > > > > 
> > > > > > > Therefore i removed it from the configuration because i have not found
> > > > > > > a good explanation why we need. It is confusing instead :)
> > > > > > 
> > > > > > Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> > > > > > make use of 20 systems with 80 CPUs each.  If you remove that line from
> > > > > > TREE05, won't each instance of TREE05 consume a full system, for a total
> > > > > > of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> > > > > > command line, but that would affect all the scenarios, not just TREE05.
> > > > > > Including (say) TINY01, where I believe that it would cause kvm.sh
> > > > > > to complain about a Kconfig conflict.
> > > > > > 
> > > > > > Hence me not being in favor of this change.  ;-)
> > > > > > 
> > > > > > Is there another way to make things work for both situations?
> > > > > > 
> > > > > OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
> > > > > need more CPUs for TREE05.
> > > > > 
> > > > > I will not resist, we just drop this patch :)
> > > > 
> > > > Thank you!
> > > > 
> > > > The bug you are chasing happens when a given synchonize_rcu() interacts
> > > > with RCU readers, correct?
> > > > 
> > > Below one:
> > > 
> > > <snip>
> > > /*
> > >  * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
> > >  * delay between calls.
> > >  */
> > > static int
> > > rcu_torture_fakewriter(void *arg)
> > > {
> > > ...
> > > <snip>
> > > 
> > > > In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> > > > interacts with rcu_torture_reader().  So my guess is that running
> > > > many small TREE05 guest OSes would reproduce this bug more quickly.
> > > > So instead of this:
> > > > 
> > > > 	--kconfig CONFIG_NR_CPUS=128
> > > > 
> > > > Do this:
> > > > 
> > > > 	--configs "16*TREE05"
> > > > 
> > > > Or maybe even this:
> > > > 
> > > > 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
> > > Thanks for input.
> > > 
> > > > 
> > > > Thoughts?
> > > > 
> > > If you mean below splat:
> > 
> > > 
> > > i.e. with more nfakewriters.
> > 
> > Right, and large nfakewriters would help push the synchronize_rcu()
> > wakeups off of the grace-period kthread.
> > 
> > > If you mean the one that has recently reported, i am not able to
> > > reproduce it anyhow :)
> > 
> > Using larger numbers of smaller rcutorture guest OSes might help to
> > reproduce it.  Maybe as small as three CPUs each.  ;-)
> > 
> OK. I will give a try this:
> 
> for (( i=0; i<$LOOPS; i++ )); do
> 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> 	'16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> 	echo "Done $i"
> done

Making each guest OS smaller needs "--kconfig CONFIG_NR_CPUS=4" (or
whatever) as well, perhaps also increasing the "16*TREE05".

							Thanx, Paul
