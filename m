Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254941A256B;
	Wed,  9 Oct 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486814; cv=none; b=fDomaIcH12j2pbh2wZF9fbCWAGgR9Gs4LcaXnLkkKLphIkw60qPfPDI7yWEU3ngjlUwZHNiTBpR8AfVeCU4imrn7lHTGjDdNOGUc9NvuKvKYC19RWEtuNJsYCiCC9wbWC9/5AAizYgysXAib99FeWVh3GwilR01nBNGnxsjr0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486814; c=relaxed/simple;
	bh=6sqMKBeiE/2i6apxFggtxp0XNmSdo86LFLaq2IGy15E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZe6msAAw/zniXihW7J1VE3C2QAODXV7dKCMhRrQ+Et1F1jAmdJDugZNgCmhsQUoCw3+qDH+MTWAPPmp8aDXqjeL8LkdAYLqmvywHvK+7aT067lChSMvtgSzR9CCiISKLIw2LJ8mC7mYme+/lGy67XMNjb851eDJub+QvY31r3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfnZhqUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfnZhqUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C359C4CEC3;
	Wed,  9 Oct 2024 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728486813;
	bh=6sqMKBeiE/2i6apxFggtxp0XNmSdo86LFLaq2IGy15E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LfnZhqUrsiPF7KJscBTNOIAw/IaB0Dx0l82rFOEinvexaNfAp2a5xFoTtxo6ytAZW
	 AQFwlS/cJ7AwKkjDRzTASu0guzG8rRrZNFiw5UO2w9FRCNyKhqF3r/WajwqY4u6gNV
	 n0MJyaERzzmCHaZUFN2FsQd88G5A636hW9VaPpgOOORer/Bnydt6Aw5NLkmvDf5qRj
	 xyE5AeR10dMTvk6jMZm1rOv7NwEX4sEGplxVNWo4D0k73UnWKjPE/mHSQcT5pwTY6n
	 FczEZvBZfQoUOVt5prnWGjwpxHHBvGRqMnYRta3l9G89ghnEuwI1Zi7vXvW4SoRrUU
	 A2CH31zn0ap8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 42A9CCE044C; Wed,  9 Oct 2024 08:13:33 -0700 (PDT)
Date: Wed, 9 Oct 2024 08:13:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu: Report callbacks enqueued on offline CPU blind
 spot
Message-ID: <084a9230-c272-49c8-9c67-6c51b595f6e2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241002145738.38226-1-frederic@kernel.org>
 <20241002145738.38226-4-frederic@kernel.org>
 <Zv1f8-1tLd-r1cyu@localhost.localdomain>
 <4e81816e-3a4d-4642-a86c-fd9bd49ca163@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e81816e-3a4d-4642-a86c-fd9bd49ca163@paulmck-laptop>

On Tue, Oct 08, 2024 at 07:03:50PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 02, 2024 at 05:00:03PM +0200, Frederic Weisbecker wrote:
> > Le Wed, Oct 02, 2024 at 04:57:38PM +0200, Frederic Weisbecker a écrit :
> > > Callbacks enqueued after rcutree_report_cpu_dead() fall into RCU barrier
> > > blind spot. Report any potential misuse.
> > > 
> > > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  kernel/rcu/tree.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index a60616e69b66..36070b6bf4a1 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3084,8 +3084,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > >  	head->func = func;
> > >  	head->next = NULL;
> > >  	kasan_record_aux_stack_noalloc(head);
> > > +
> > >  	local_irq_save(flags);
> > >  	rdp = this_cpu_ptr(&rcu_data);
> > > +	RCU_LOCKDEP_WARN(rcu_rdp_cpu_online(rdp), "Callback enqueued on offline
> > > CPU!");
> > 
> > This should be !rcu_rdp_cpu_online(rdp)
> > 
> > Sigh...
> 
> I am pulling this in for testing with this change, thank you!

And:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> 							Thanx, Paul
> 
> > > +
> > >  	lazy = lazy_in && !rcu_async_should_hurry();
> > >  
> > >  	/* Add the callback to our list. */
> > > -- 
> > > 2.46.0
> > > 
> > > 
> 
