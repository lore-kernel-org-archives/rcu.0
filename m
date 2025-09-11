Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A331C573;
	Thu, 11 Sep 2025 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590661; cv=none; b=StV4HxUZbJtwI5E4q9sZHMsbRFWjfnpQDFjSBwLImGa/z7VhOUSOav/1R8cOxBO/wL4MtrfHqMcmeBXMxgKW8QoazaCtbQEHUXAHsv56WsQDdjWgfT1pWhtwpKpOm8mdM2DlGfAw3YdqwL3Jv8W0rG3zEIGYJCiblqogNoFFzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590661; c=relaxed/simple;
	bh=qDute3CFkCv8B2In8pozv0w3/FWgNnabl9BzbKm+i9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6c+bXbzfvR9lAvTZd7XnCCgHempz+Sg6Je8Ap2vh/ph6pfXMvTn45+WZRCjzbHV8WcZgBkZfz81J2mqxeShvjcV+QdYwr7f2+VHzgttHS/px11HUxK9GpoHOtpdAnsRJE249vMDh1zxfjOb6em2kniKozhRkgxEG32FRauZ+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLwxjRmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLwxjRmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7845C4CEF1;
	Thu, 11 Sep 2025 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757590660;
	bh=qDute3CFkCv8B2In8pozv0w3/FWgNnabl9BzbKm+i9k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JLwxjRmCuzx3Muna3mWf/Tt8HlEurrjcI1GEwwTMTDwx41nfeYLyFV79H15TIjJ+x
	 m3RZolskM4lA+CjktbQHYFwA9qeq8zOKM/7F1EkUegyAg/QSVCO4loEFkd4RuAWTHT
	 3yCJzlTs59rl1r813BF+JPVKi8wU/zZi3uSAc+9GUMF14BJAtrtax2KpRCAVKqLgjN
	 fRmlXptew4UPehmaGpf1FrXP0tOv2pDSQjqhcxHS7++4Jg8g3kQgp4MtPQlgjheoyc
	 ANMrsz5QLZXQie0TMy37NzKqGfRcjRTGXclIlwg3nfZTROJ8YyWkzT0hJDkBG3jwBp
	 1Mq/z4Wb9cJvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A38BCE0C39; Thu, 11 Sep 2025 04:37:39 -0700 (PDT)
Date: Thu, 11 Sep 2025 04:37:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
Message-ID: <430d5714-4a00-4a75-b763-34918f8017c3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250909133928.615218-1-qiang.zhang@linux.dev>
 <4c7d977b-7d09-48e0-9a88-bae93fa5e401@paulmck-laptop>
 <20250910143620.GA561834@joelbox2>
 <e5e69dc3-ebd3-47ae-b193-bc4b2de36904@paulmck-laptop>
 <70fa9fd07e4fe2b1b498109f3450804e731fd7ce@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70fa9fd07e4fe2b1b498109f3450804e731fd7ce@linux.dev>

On Thu, Sep 11, 2025 at 12:36:45AM +0000, Zqiang wrote:
> > 
> > On Wed, Sep 10, 2025 at 10:36:20AM -0400, Joel Fernandes wrote:
> > 
> > > 
> > > [..]
> > >  > kernel/rcu/srcutiny.c | 4 +---
> > >  > 1 file changed, 1 insertion(+), 3 deletions(-)
> > >  > 
> > >  > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > >  > index b52ec45698e8..b2da188133fc 100644
> > >  > --- a/kernel/rcu/srcutiny.c
> > >  > +++ b/kernel/rcu/srcutiny.c
> > >  > @@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> > >  > {
> > >  > unsigned long cookie;
> > >  > 
> > >  > - preempt_disable(); // Needed for PREEMPT_LAZY
> > >  > + lockdep_assert_preemption_disabled();
> > >  
> > >  nit: Do we still want to keep the comment that the expectation of preemption
> > >  being disabled is for the LAZY case?
> > > 
> > Good point, and I do believe that we do. Zqiang, any reason not to
> > add this comment back in?
> 
> in rcu-tree, this commit:
> 
> (935147775c977 "EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=n kernels")
> 
> make preempt disable needed for CONFIG_PREEMPT=y or CONFIG_PREEMPT_LAZY=y
> when the CONFIG_SMP=n. do we need to replace "Needed for PREEMPT_LAZY"
> comments with "Needed for PREEMPT or PREEMPT_LAZY"?

Good point as well, thank you!  And I need to decide whether I should
send that patch upstream.  Its original purpose was to test PREEMPT_LAZY=y
better than could be tested with PREEMPT_LAZY.

Thoughts?

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> > 
> >  Thanx, Paul
> > 
> > > 
> > > thanks,
> > >  
> > >  - Joel
> > >  
> > >  
> > >  > cookie = get_state_synchronize_srcu(ssp);
> > >  > if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> > >  > - preempt_enable();
> > >  > return;
> > >  > }
> > >  > WRITE_ONCE(ssp->srcu_idx_max, cookie);
> > >  > @@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> > >  > else if (list_empty(&ssp->srcu_work.entry))
> > >  > list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> > >  > }
> > >  > - preempt_enable();
> > >  > }
> > >  > 
> > >  > /*
> > >  > -- 
> > >  > 2.48.1
> > >  >
> > >
> >
