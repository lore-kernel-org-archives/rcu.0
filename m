Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDF230BD0;
	Fri, 28 Feb 2025 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772796; cv=none; b=idP02zJkcLwkyPiu/C9Kw1niw6gcRrzA7tfIMCG/GSeL0RK4nASl9yxKL2N2U1CxTjeevYrGii9fQv5PfGHiPzUtIr1XrxxaqHQu2NEznUeBKClBoB7Xcs+L4PAMufM6PMQeiLQHhPQ5P4qVdWUsPAJPNbTtCKsX/8Wr7w6eiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772796; c=relaxed/simple;
	bh=iMLzNP2CNTsdRqKCkwyK0u0Mfa7U3vhEemC06t/KnZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrAU7ynA2eCjDElISwlasvuFsXoMa1UrA/eziJ5Ln5YyCn18YxvK+0DhzYB2KHrQCjPdkMHn5wQClZQ5o3X/zrlhCU3DB0dyajfdugSr/kxklUL0dh8vn6iB5ZU7Bv7q+t6JtiJGcqAMxrIeuvDmgaeJAwNZoxugaQAfsWQkjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spyZd7Wi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spyZd7Wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99482C4CED6;
	Fri, 28 Feb 2025 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740772795;
	bh=iMLzNP2CNTsdRqKCkwyK0u0Mfa7U3vhEemC06t/KnZY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=spyZd7WiPxbNV+DhqyWzXYEaATf8dfgoRbBib4/DkFtWaYvQHyxjZoPUuytPSfaRP
	 eKr5Zr3hK8vN328OTq50SKtTmNOs10/xbqUbBuj7BQPJ//6NLUIQThRYo/N+aItj6A
	 zkg9mVT+QfwIfNu7vM+ZH9ZcImmo/SGBa0xluNQZQSmDNyggn7P/+1b9W8eZ9kftzX
	 ZN99rmzbohGtSedizmkgM6suB2VoX1Q+uDbnz7kIYaQxOSonKELsBd6zwn4HMEOO/I
	 mT0ioE3Z0FwegOZNsrNbTneuCbVZm/lgPwCgapt4Q4G3OVXmhZiF+/Pqz+NzR4j1Tg
	 JR+j43H6Eg8rw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 43283CE0DEB; Fri, 28 Feb 2025 11:59:55 -0800 (PST)
Date: Fri, 28 Feb 2025 11:59:55 -0800
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
Message-ID: <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
 <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8IKs-I-YsOoS4uw@pc636>

On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> Hello, Paul!
> 
> > > > > > 
> > > > > > Except that I got this from overnight testing of rcu/dev on the shared
> > > > > > RCU tree:
> > > > > > 
> > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80
> > > > > > 
> > > > > > I see this only on TREE05.  Which should not be too surprising, given
> > > > > > that this is the scenario that tests it.  It happened within five minutes
> > > > > > on all 14 of the TREE05 runs.
> > > > > > 
> > > > > Hm.. This is not fun. I tested this on my system and i did not manage to
> > > > > trigger this whereas you do. Something is wrong.
> > > > 
> > > > If you have a debug patch, I would be happy to give it a go.
> > > > 
> > > I can trigger it. But.
> > > 
> > > Some background. I tested those patches during many hours on the stable
> > > kernel which is 6.13. On that kernel i was not able to trigger it. Running
> > > the rcutorture on the our shared "dev" tree, which i did now, triggers this
> > > right away.
> > 
> > Bisection?  (Hey, you knew that was coming!)
> > 
> Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> 
> After revert in the dev, rcutorture passes TREE05, 16 instances.

Huh.  We sure don't get to revert that one...

Do we have a problem with the ordering in rcu_gp_init() between the calls
to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For example,
do we need to capture the relevant portion of the list before the call
to rcu_seq_start(), and do the grace-period-start work afterwards?

My kneejerk (and possibibly completely wrong) guess is that rcu_gp_init()
calls rcu_gp_start(), then there is a call to synchronize_rcu() whose
cookie says wait for the end of the next grace period, then we capture
the lists including this one that needs to wait longer.  Then when we
look at the end of the grace period, boom!  This would be a real bug due
to some CPU coming online between the time of the call to rcu_gp_start()
and synchronize_rcu().

Or is there some other way that this can happen?

							Thanx, Paul
