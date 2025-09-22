Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406224E4AF;
	Mon, 22 Sep 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551254; cv=none; b=ZWal3AAacB4odmZKO3HEAo6DLZxWFh2Qnynj3Q3IpJBeKioDAqzEtcL0HXqTiuOHiYWEY+c8DNPDpT8zlBmT0D5MfpoWiygEV4tAfTz+XI4pbOcCmiNRKhquRw6NEqFXXybDi4I+qafz3uulRT+4SHv9GNLnPf57DJ+fqNBMH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551254; c=relaxed/simple;
	bh=gyCNaIVDTfa76lqXkV2/zis6+w0YYTBg2W4GDkG5jHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxkSsnVpza+EDLR3A9mxw+NzW5+U0m9R+3j9qBhsxDI5pCpdD1/y7QTmY9t8jfgOKa0WAx8QKgCYietqcDitQT3d9gS4YuF88vsdsqvfKYVH8CiLUWcygJ4SyTKB2z5MNyEvMQWpT+u1fbT3JA6lWDzR4zBmIvaC1+HWeNH4IHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/kmYoP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/kmYoP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EBAC4CEF0;
	Mon, 22 Sep 2025 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758551253;
	bh=gyCNaIVDTfa76lqXkV2/zis6+w0YYTBg2W4GDkG5jHw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f/kmYoP5rs7gX5laskYfxMfw91o13U66JxXg5xpkexINl1NFOoEFmMAiIWcZy7ZYn
	 dyx7CPyDSVxrsGtmP8Sn/aVG4wZuubV8xYYp6l0QjsSZlLt2MUebiTybBPAtIUqrrz
	 Wwqo+zxvXbDIK2rK/8zFKj3gs0vWhRPtB98cDTbobOrQm93K1+yHHsM9UK5fjbP9Tj
	 WxQYaT2MurtITazNcyI29MGjqWAfB0bB+qtwYdfogrEuBJ9Zs0WIY5wm5yJlp5XWlv
	 GFmFu5+VxnYXPdqsxdvGrx1BiTOxxSowOlf7x2z2v+TCkkf1NqF7KckddIsG1TlfIC
	 95K7jo9BeqeAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4A0B8CE1109; Mon, 22 Sep 2025 07:27:28 -0700 (PDT)
Date: Mon, 22 Sep 2025 07:27:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2 3/3] rcu: WQ_UNBOUND added to sync_wq workqueue
Message-ID: <a2b31164-2175-4fa5-b003-c0be8301bc9a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250919145040.290214-1-marco.crivellari@suse.com>
 <20250919145040.290214-4-marco.crivellari@suse.com>
 <aNFZ1huhgmMkaIWH@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNFZ1huhgmMkaIWH@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>

On Mon, Sep 22, 2025 at 04:14:46PM +0200, Frederic Weisbecker wrote:
> Le Fri, Sep 19, 2025 at 04:50:39PM +0200, Marco Crivellari a écrit :
> > Currently if a user enqueue a work item using schedule_delayed_work() the
> > used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> > WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> > schedule_work() that is using system_wq and queue_work(), that makes use
> > again of WORK_CPU_UNBOUND.
> > This lack of consistentcy cannot be addressed without refactoring the API.
> > 
> > alloc_workqueue() treats all queues as per-CPU by default, while unbound
> > workqueues must opt-in via WQ_UNBOUND.
> > 
> > This default is suboptimal: most workloads benefit from unbound queues,
> > allowing the scheduler to place worker threads where they’re needed and
> > reducing noise when CPUs are isolated.
> > 
> > This change add the WQ_UNBOUND flag to sync_wq, to make explicit this
> > workqueue can be unbound and that it does not benefit from per-cpu work.
> > 
> > Once migration is complete, WQ_UNBOUND can be removed and unbound will
> > become the implicit default.
> > 
> > With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> > any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> > must now use WQ_PERCPU.
> > 
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Applied, thank you both!

I will push these out on my next rebase.

							Thanx, Paul

> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 4f3175df5999..7137723f8f95 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4888,7 +4888,7 @@ void __init rcu_init(void)
> >  	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
> >  	WARN_ON(!rcu_gp_wq);
> >  
> > -	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
> > +	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> >  	WARN_ON(!sync_wq);
> >  
> >  	/* Respect if explicitly disabled via a boot parameter. */
> > -- 
> > 2.51.0
> > 
> 
> -- 
> Frederic Weisbecker
> SUSE Labs
