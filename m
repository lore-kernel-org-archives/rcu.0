Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933032B126;
	Sat, 12 Sep 2026 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789239040; cv=none; b=UTxDVs5SYnInrHc53WdMzPZgyNsftSjlzq0v3UZp4bzXCRbLEw2BW/VzPr4xjltyjy53gV1GcBbY7jjNAG7lzNViBK2FExuwYRByyUXmQpL7sWkAgT3/ZdVxELPZkbJt6Fq6UH3pRAeiY5Mkc7BTHj2ApObEnVmMAC2rDVy85GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789239040; c=relaxed/simple;
	bh=OhvyiMsp/mZoEtAboDo8kyMAfh6o9vfe+qVneM15LBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8lxLd00CVV0o/Y2bQ6lL8W7Uu8YlAsHaJZxq4tGX/Ys4dTMQoCVXdNx2luiy0q1Jm0uwb0NdXNP0/QhZbRCJrIjVYK/PNx4YQLe8NR1hEMwUAimrSDJAI1ZxtXn+k1iwGf5hTQkkdodVtO1E5Cm/zvBCtsyYLkBaXG5sbfdq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLgsxU6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLgsxU6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0381F000FF;
	Sat, 12 Sep 2026 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789239038;
	bh=07Lq/XL1IlEUe96PwnmgESbCWMzA0hrr6WiCfxD8Fb0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=RLgsxU6PeWZGIJJzuyvy0mpF8AcE0juypLZ1Ik603Ce6CC6jQSHYlfeWfLhC/WNoI
	 EyMcc/mB867y2U4esY7SAF4acLDpm2GnSZLEZGY39F++WpybLl1DKuSuYjzhNEePMH
	 USmeBRCO7Yu6tqRUXE3VuJeCCUGj/fAV72oe4CgEiX3Bwf8caRGUSTkkFExsTcvj+R
	 ntksnKiLez9gCOnL9SEf6wjPgsbQn7TJeQcjVbYX3HQJDBNZKMcpHGk+TLB0sHm6PE
	 iZTzdj3P0DLKmRlQilr+VN8nRvk2TW3ona3DkqCKpk21pMC9aELUz9wOScdxTbhIju
	 zqjnm1Jag1WvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92247CE0D0D; Sat, 12 Sep 2026 11:50:38 -0700 (PDT)
Date: Sat, 12 Sep 2026 11:50:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] srcutree: Add lockdep and early-boot checks to
 synchronize_srcu_atomic()
Message-ID: <e6be6641-731c-4b21-ad4e-c05bedc388d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911093515.2802551-1-kunwu.chan@gmail.com>
 <0cf7b133-d2fd-4298-adba-70a2b86d1892@paulmck-laptop>
 <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa-uuim=aiOuAmHYUoD5S=vBREemj-dCvcunF-4zNdp1=A@mail.gmail.com>

On Sat, Sep 12, 2026 at 08:37:33PM +0800, KunWu Chan wrote:
> On Sat, Sep 12, 2026 at 12:47 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Sep 11, 2026 at 05:35:15PM +0800, Kunwu Chan wrote:
> > > Add the lockdep annotation, same-type SRCU nesting warning, and
> > > early-boot check used by __synchronize_srcu().
> > >
> > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > Queued for review and testing, thank you both!
> >
> > Interestingly enough, it is now the case that there is a grace-period
> > wait that can be placed in a normal RCU read-side critical section.
> > Does this mean that we should also adjust the --do-srcu-lockdep testing
> > in tools/testing/selftests/rcutorture/bin/torture.sh?
> 
> Thanks, Paul. Good point.
> 
> I’ll check the current `--do-srcu-lockdep` coverage, including the
> case where `synchronize_srcu_atomic()` is called from a normal RCU
> read-side critical section, and follow up with the necessary torture
> testing changes.

Sounds good!

Perhaps you and Zqiang can work together on this.  Co-developed-by,
for example.

							Thanx, Paul

> Thanks,
> Kunwu
> 
> >
> >                                                         Thanx, Paul
> >
> > > ---
> > >  kernel/rcu/srcutree.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 6a9c432a3bd0..6c729e805fb3 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -2123,6 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
> > >       unsigned long rdm0, rdm1;
> > >       unsigned long unlocks0, unlocks1;
> > >
> > > +     srcu_lock_sync(&ssp->dep_map);
> > > +
> > > +     RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> > > +                      "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
> > > +
> > > +     if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> > > +             return;
> > > +
> > >       // Initialize.  Either init_srcu_struct() was invoked or
> > >       // DEFINE_SRCU() or similar was used.  Therefore, no allocation
> > >       // will be done here.
> > > --
> > > 2.43.0
> > >
