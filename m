Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6705228;
	Wed,  5 Jun 2024 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612581; cv=none; b=Hi6FHmtkhQ+s+TdVmhR2IetEGNb1kwcuDnAgfxbbv69sBFlh1O/4T+kTj8yVb14yU+TkF/AdIeEbR3NHtw0cpy+EHwavk75PxkRImmob2hy9m97YKuXsqdlDvHHmhklCotp9UNwNJgW2vysz0Nnf/CVKDOIzLNG1S+feOL4h144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612581; c=relaxed/simple;
	bh=U8Pum04kWJiOrMbd7F2SoV1BMtOhRMWdgkflF0DyIpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+XPSbf7+1KWGfV6MrctLW8WvpM7LAfrRot4syXXOrx0sbmMaawN0zFEpn9yFR2knNdO1NTviz69gxp9MQWJVBUEt185oTRu3LjElSAT9e5Fu0UbihOmA/Lp6yiCBNY8jIs/JQgeOhnEtZudeLoHaUhubrCLcVgniqKMX+CrzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQqaYyME; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQqaYyME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F80EC2BD11;
	Wed,  5 Jun 2024 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612581;
	bh=U8Pum04kWJiOrMbd7F2SoV1BMtOhRMWdgkflF0DyIpQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JQqaYyMEqg9hpPKg5pYntV5U+OuriptEh6SxpJLi6zXZr+R5/OzZML1IjXO5hbz71
	 JbkbxnyBmikiw750xEPHjoUdtVaf2oWES2k4w6USStNe/2g56Qo+fLWZvr1yNAf3+U
	 uIPHjKuOaS2Zs6QMqLddi/bhjXxml1qU9W8ejvITtXA8OnzFUnTOEPhpxlFCjvJqBo
	 J3kmURpLuTHqn5atmRaV0w8EIOMN8UalfguhHrlUrwZcyTDOuYQeTm373Jvamqdxzp
	 0hWQg7HOyy/NjPXMcMbMTqk0VJtiRYH+niIbSZm2c0sLkhuzkg79PWYhr5SuhADCuo
	 hjlOLBjMY07mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ABAC3CE0A73; Wed,  5 Jun 2024 11:36:15 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:36:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: Re: [PATCH rcu 2/2] doc: Clarify rcu_assign_pointer() and
 rcu_dereference() ordering
Message-ID: <4035a57f-9873-4178-8d60-3ab07f709e2e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
 <20240604222155.2370541-2-paulmck@kernel.org>
 <ZmBSZ3AAp9TN5YaP@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmBSZ3AAp9TN5YaP@localhost.localdomain>

On Wed, Jun 05, 2024 at 01:56:23PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jun 04, 2024 at 03:21:55PM -0700, Paul E. McKenney a écrit :
> > This commit expands on the ordering properties of rcu_assign_pointer()
> > and rcu_dereference(), outlining their constraints on CPUs and compilers.
> > 
> > Reported-by: Rao Shoaib <rao.shoaib@oracle.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  Documentation/RCU/whatisRCU.rst | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index 94838c65c7d97..d585a5490aeec 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -250,21 +250,25 @@ rcu_assign_pointer()
> >  ^^^^^^^^^^^^^^^^^^^^
> >  	void rcu_assign_pointer(p, typeof(p) v);
> >  
> > -	Yes, rcu_assign_pointer() **is** implemented as a macro, though it
> > -	would be cool to be able to declare a function in this manner.
> > -	(Compiler experts will no doubt disagree.)
> > +	Yes, rcu_assign_pointer() **is** implemented as a macro, though
> > +	it would be cool to be able to declare a function in this manner.
> > +	(And there has been some discussion of adding overloaded functions
> > +	to the C language, so who knows?)
> >  
> >  	The updater uses this spatial macro to assign a new value to an
> >  	RCU-protected pointer, in order to safely communicate the change
> >  	in value from the updater to the reader.  This is a spatial (as
> >  	opposed to temporal) macro.  It does not evaluate to an rvalue,
> > -	but it does execute any memory-barrier instructions required
> > -	for a given CPU architecture.  Its ordering properties are that
> > -	of a store-release operation.
> > -
> > -	Perhaps just as important, it serves to document (1) which
> > -	pointers are protected by RCU and (2) the point at which a
> > -	given structure becomes accessible to other CPUs.  That said,
> > +	but it does provide any compiler directives and memory-barrier
> > +	instructions required for a given compile or CPU architecture.
> > +	Its ordering properties are that of a store-release operation,
> > +	that is, any prior loads and stores required to initialize the
> > +	structure are ordered before the store that publishes the pointer
> > +	to that structure.
> 
> About that, why rcu_dereference() isn't a matching load-acquire?

Here is an example showing the difference:

	p = rcu_dereference(gp);
	r1 = READ_ONCE(x);
	r2 = p->a;

The READ_ONCE() is not ordered against the rcu_dereference(), only the
read from p->a.  In contrast, if that rcu_dereference() was instead an
smp_load_acquire(), both of the two later statements would be ordered.

Ah.  You are suggesting that this be added to the description of
rcu_dereference()?

Or are you asking that this documentation state that an rcu_dereference()
memory-barrier-pairs with an rcu_assign_pointer()?

Or something else completely?

							Thanx, Paul
