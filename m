Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9200800;
	Sat, 25 Jan 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737830341; cv=none; b=AUKXuv+xQarVX3ulrhsEdQ4Y121xseqFcEvHnoBHMxdMt5v8yreGFqxTThL5flfwsjufdQ3i58IyftqiH+EddRaZUfIOFVcHPCTo7MheirBCNQEsjHm9b39PJGaKO4n+O/YO9SQb/y6jWmY58UL9d/ZbOX06i7ehdL/S1FlZVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737830341; c=relaxed/simple;
	bh=oZALVaOTZdjRtGkpAKUIzjrQu5GIfdtQhm443DAN5BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Q10pMqTeqRBRJ0JNHIKYb1FjFUG4C6qS8RtGoXZR0LXVKzsK8iEGOOepYUsFrQxxZRBJfumKYASUovmTqg1KI/VXU2LZt73DmsD9848yxdm2yOhYEKDEEsl3woFIayQsBYn3AaKwtzWo/zY9CQx0AwEJ2WmvmjNXeSu77H+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia4vlhuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia4vlhuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920C1C4CEDD;
	Sat, 25 Jan 2025 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737830341;
	bh=oZALVaOTZdjRtGkpAKUIzjrQu5GIfdtQhm443DAN5BI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ia4vlhujep4YwqvqaCVL5Mvq8teFViqurUMLcdJv2IWjShctvpshkqYpqmRLhYoSU
	 NZstSzeowkYewqs0H/CZsfMKTLIEESFvMnzt5gPy+GMeuA8djmMh7x09xtfHEBNuce
	 tKGh6LSdkfWt/QIFf80+be73qGKlJ/ze4PTR+LPPHNGPYcB2qe3QygbFXO0bAcqmbY
	 X6A438jbhgucjNvcrVpXLy7uQEe0DoXINtq0gzGe8OPd9B0FaIFyi8hXW3ufPpmljx
	 1JimJd70YIZO5KkBlU7kvI8SuJtU6ALeoajPo3jzgUf9qs0iI/aE8LaoLSqaglj7e3
	 z3lGhPkIv1t5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2DCA3CE12BF; Sat, 25 Jan 2025 10:39:01 -0800 (PST)
Date: Sat, 25 Jan 2025 10:39:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <a18ec931-a7cb-408b-8707-f88068a13ba9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
 <Z5QcXoE0lrS6yIBt@pavilion.home>
 <d7bbe2cd-d889-40e9-8d46-fb8772fed6db@paulmck-laptop>
 <Z5T7kF7LKIuk05FR@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5T7kF7LKIuk05FR@pavilion.home>

On Sat, Jan 25, 2025 at 03:56:16PM +0100, Frederic Weisbecker wrote:
> Le Fri, Jan 24, 2025 at 04:01:55PM -0800, Paul E. McKenney a écrit :
> > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbecker wrote:
> > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a écrit :
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> > > >  {
> > > >  	unsigned long cur_s = READ_ONCE(*sp);
> > > >  
> > > > -	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> > > > +	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> > > 
> > > This might need a comment.
> > 
> > Good point!  Would you like to propose one?
> 
> Ok.

Sounds good!

> > > The way I understand it is that rcu_state.gp_seq might be seen started while
> > > root_rnp->gp_seq is not. So rcu_seq_snap() on the started rcu_state.gp_seq
> > > may return maximum 2 full GPs ahead of root_rnp->gp_seq. And therefore it takes below
> > > 2 GPs to safely deduce we wrapped around.
> > 
> > Exactly!
> > 
> > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK + 1))) ?
> > 
> > Quite possibly.  I freely admit that I allowed a bit of slop because
> > time was of the essence (holidays and all that) and also it does not
> > hurt much to lose a couple of counts out of a 2^32 cycle, to say nothing
> > of the common-case 2^64 cycle.  It would not hurt to be exact, but it
> > would be necessary to convince ourselves that we were not off by one in
> > the wrong direction.
> > 
> > I would be happy to see a patch, as long as it was sufficiently
> > convincing.
> 
> I'm not so much concerned about being exact but rather about making
> sure we still understand what we did within one year. We can leave one
> more grace period than what we expect out of paranoia but, the most
> important is that we comment about what we expect and why. Let me
> prepare a patch for that.

Even better!

> In the meantime for your patch:
> 
>    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you, and I will apply this on my next rebase.

							Thanx, Paul

> > > Or am I missing something?
> > 
> > Not that I can see.  So the answer is probably "yes".  ;-)
> 
> Thanks! :-)
> 
> > 
> > 							Thanx, Paul
