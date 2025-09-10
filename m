Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78E32A3D8;
	Wed, 10 Sep 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519541; cv=none; b=Qnf0TbEYiJiSDfwqSQV7hB2rOHNDvBCPUDNeCFz4cd0LACScbaUhgK0BwdrJyIYF8+0wLRMY8zPT7zohTGjJ9/z1zFrYY8SAy8Ycquxb+idQG+FlTGX5WezpsBzRFRLPLq8ZLc6Lod52MB+c0Vpc+6BgoN2FoTaAJOLYyvd37dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519541; c=relaxed/simple;
	bh=+QnlDUP8buKjBRESEhzt4CYoYNQ0cHHIXhiRMLrk+OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLnpEVnzCxPoOjtvmaGmfU/Z6DeUAEUwmlehVUpfKez/f6A32Xyu3X0y8+4M0W0MyCA9IUph2aEBvD7sTJHHtKaqzbGey9uS6ZUWDAGMVkMZtn/8NG6VXpcc+UHWX0ckh3UWF56glgZ/VE+Gk1ogPlHIHwq/pA9BZHw6z16Wv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbvVaqBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbvVaqBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0B2C4CEEB;
	Wed, 10 Sep 2025 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757519541;
	bh=+QnlDUP8buKjBRESEhzt4CYoYNQ0cHHIXhiRMLrk+OY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PbvVaqBo5zoidymIKSi8H+rtvC2IISQ2rCMQXTuaLYjMmi0/B+67cNOrhYIYGxmRf
	 Rf36NtXpCox1dJNGdzEElxCs9Oe3z2UqC/Ooorgsmj/UgnZywk+YyfN04U/tBor1/q
	 Yy6nebCEXOJ4yltEUNDTmre5xsIprfrJBEXALEVYJD0IOQ37iTosDcqrK+naqzbuZ+
	 0iwgyJ3XSkXB57z6Z45aqDhe2Zl/V8PtVjsa5zfY4ribuAfOiBF9m2EcmVArEDNYQ1
	 e+oilJsnewnbr3RPkys1Mzi00f1P1eW9uwxO6W2BoqJ8C8i2W4hHnyKBTbtzaCQjzr
	 191zaoB4xlVHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17877CE0B24; Wed, 10 Sep 2025 08:52:20 -0700 (PDT)
Date: Wed, 10 Sep 2025 08:52:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Zqiang <qiang.zhang@linux.dev>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
Message-ID: <e5e69dc3-ebd3-47ae-b193-bc4b2de36904@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250909133928.615218-1-qiang.zhang@linux.dev>
 <4c7d977b-7d09-48e0-9a88-bae93fa5e401@paulmck-laptop>
 <20250910143620.GA561834@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910143620.GA561834@joelbox2>

On Wed, Sep 10, 2025 at 10:36:20AM -0400, Joel Fernandes wrote:
> [..]
> > >  kernel/rcu/srcutiny.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > > index b52ec45698e8..b2da188133fc 100644
> > > --- a/kernel/rcu/srcutiny.c
> > > +++ b/kernel/rcu/srcutiny.c
> > > @@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> > >  {
> > >  	unsigned long cookie;
> > >  
> > > -	preempt_disable();  // Needed for PREEMPT_LAZY
> > > +	lockdep_assert_preemption_disabled();
> 
> nit: Do we still want to keep the comment that the expectation of preemption
> being disabled is for the LAZY case?

Good point, and I do believe that we do.  Zqiang, any reason not to
add this comment back in?

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > >  	cookie = get_state_synchronize_srcu(ssp);
> > >  	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> > > -		preempt_enable();
> > >  		return;
> > >  	}
> > >  	WRITE_ONCE(ssp->srcu_idx_max, cookie);
> > > @@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> > >  		else if (list_empty(&ssp->srcu_work.entry))
> > >  			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> > >  	}
> > > -	preempt_enable();
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 2.48.1
> > > 
