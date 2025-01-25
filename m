Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099625A631;
	Sat, 25 Jan 2025 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737763316; cv=none; b=HqgUpCUQmy/CkBl9FaJC39N2FtHkzixUWIYFityqeCVGNzeFc+fwvWuJNC6H9MXMOsnrqtYl0I91URdC2PUp2L1aqHHNhKWfdA2atXx2rCQGbO9H2McLFpiVk6JYNBY11O+Dm6L4PlMwkmBqBD8IazWHebMhC2ZEmH2DBH4sPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737763316; c=relaxed/simple;
	bh=WzQYtYKYljIjHkV/4VwzFXzd16Fsn+C2g/r687UfU0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8hJWO9gp2VzvufuhCxneXBEOJ+QPlnaeeZtV03/GEpdEHrSvjxb75PPPzysZXwCFmUyydDkKgpZBihD+PUjnNP8iUyKkj/p//z1zLSR2VW0ArqJUE4qt7V9VmpM+axaFPf1pBo8gfJphuBiiBDOneQ7N8AjJp7JrfhnioLRlVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1YFWExZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1YFWExZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF663C4CED2;
	Sat, 25 Jan 2025 00:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737763315;
	bh=WzQYtYKYljIjHkV/4VwzFXzd16Fsn+C2g/r687UfU0U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Y1YFWExZzlEsuHQ7JHQXvX9cC/Ae78Q351rf2dgHPsbHigPE1oQ+i+FneBM3P/bLX
	 ujyGvRR/YuE/rkQwdpoCxVjSF1xSdG4j7mGyQq2DMu+0/mA2An9/7fKeGUDN/iPx9w
	 5xOIAzgZBrydWLkzzbyNXmJvRYxkN0zHShLYi42xbjkfWYFjgtXi35Argh+8+vLhR7
	 +mO3Z646STrjcuTyATKcr7yIFgNVbBjKqTrvU6K/eZJqhq6dd2UH28TjkhtcAKKiBp
	 MVZ3i9UU/OC+hTQV6ukJ64GRRDqrAM/dXegEMIkTAAarxqaLWFGdMG7R1q43udCB6Y
	 1Xj9+0nN8OI7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 51726CE13C5; Fri, 24 Jan 2025 16:01:55 -0800 (PST)
Date: Fri, 24 Jan 2025 16:01:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <d7bbe2cd-d889-40e9-8d46-fb8772fed6db@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
 <Z5QcXoE0lrS6yIBt@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5QcXoE0lrS6yIBt@pavilion.home>

On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbecker wrote:
> Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a écrit :
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 2f9c9272cd486..d2a91f705a4ab 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> >  {
> >  	unsigned long cur_s = READ_ONCE(*sp);
> >  
> > -	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> > +	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> 
> This might need a comment.

Good point!  Would you like to propose one?

> The way I understand it is that rcu_state.gp_seq might be seen started while
> root_rnp->gp_seq is not. So rcu_seq_snap() on the started rcu_state.gp_seq
> may return maximum 2 full GPs ahead of root_rnp->gp_seq. And therefore it takes below
> 2 GPs to safely deduce we wrapped around.

Exactly!

> Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK + 1))) ?

Quite possibly.  I freely admit that I allowed a bit of slop because
time was of the essence (holidays and all that) and also it does not
hurt much to lose a couple of counts out of a 2^32 cycle, to say nothing
of the common-case 2^64 cycle.  It would not hurt to be exact, but it
would be necessary to convince ourselves that we were not off by one in
the wrong direction.

I would be happy to see a patch, as long as it was sufficiently
convincing.

> Or am I missing something?

Not that I can see.  So the answer is probably "yes".  ;-)

							Thanx, Paul
