Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9322305674;
	Thu, 27 Aug 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853980; cv=none; b=MfPck+6IO4Hx6SgrSdhVA0m+xJHy40Q4xI/FkCl8Nq3ptBaey3Vn0nzn0G8zgr9b168lYafo0o/ztSpkqyF522IkGnEtxK1YTo5tJeUMfrDxhMTOo/j5jK8IwgO/Wtxcniie3SL7YwLLV/kCfO9Gk0Prr2j1wA67vHdwgKXHTC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853980; c=relaxed/simple;
	bh=AhKY/CrS56Gdz0tAHFL9cTprEA5T+TJQYnxim6ftHYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFmQyo/TsHC3IVppK1w1nXrcFMC344ew30YpR/QrbY9r7sFRy4ZLa9++iteXq3wzP6DOOnabRQj6EscV2WBSNip2YSHi5nOI/FIzRL4LPwwHfzxSGH586Z45n2oliJtEl7spjdGYwqneHam2oJYb8Lz/hJGodnfje7gKtALbmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d76v9w0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d76v9w0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFFB1F00A3A;
	Thu, 27 Aug 2026 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787853979;
	bh=TEewTLCll1T3j7ifs0LSey6suBIGLeb44gYkoX8XVTA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=d76v9w0P5F6w7iZ3ZAIk2OTCMO6qVxuobc3+ZXSbOu1GBycu5/nnzT6Olv50IJSsv
	 6piWjGuBA8j1wMH9B7mNqAp8xU9DH78Ue5EaG7vQ9l8/5gxRSwOktWUUJhalz/fFWL
	 tmKYr0BAK5uy3520R1NlgCtvq71+grWKfpPYFr6W68lAJB8PvBTVdj2CK7kgMbyRaH
	 iXi7lYGAXJnZur/d3y1VpUb7i6OZdcMHTPOJxvj0h3FYTohXk0Tlv+fjClCGXpg+4A
	 lNumLWbZg/cqy8KeEbOjBOO/CeyHOZ+f9MVb6lD8RYHHsFwn88oqTUA+ngFuw3rB16
	 0t5mHfrgc5ikQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0A6E8CE1496; Thu, 27 Aug 2026 11:06:19 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:06:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, rcu@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1] doc: RCU: Fix typo
Message-ID: <3c85f35b-6867-4b16-9f22-20e8e7a5c094@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260827090506.1172620-1-costa.shul@redhat.com>
 <9f2abc12-a3c0-482a-b5d4-57b129db10fa@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f2abc12-a3c0-482a-b5d4-57b129db10fa@infradead.org>

On Thu, Aug 27, 2026 at 09:37:11AM -0700, Randy Dunlap wrote:
> 
> 
> On 8/27/26 2:05 AM, Costa Shulyupin wrote:
> > strategem -> stratagem.
> > 
> > Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.

Hand-applied, thank you both!

Costa, your patch's headers say "Content-Type: text/plain; charset=true"
which "git am" does not like at all.  I hand-applied this one because
it is quite simple, but please fix your email setup.  If this patch had
been at all complex, I would not have risked hand-applying it.

This line is normally:  "Content-Type: text/plain; charset=utf-8"

							Thanx, Paul

> > ---
> >  Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > index 8101fe6229d5..b10e0484ae13 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -1442,7 +1442,7 @@ periods:
> >     corresponding CPU's next scheduling-clock.
> >  #. CPUs mentioned in the ``nohz_full`` kernel boot parameter can run
> >     indefinitely in the kernel without scheduling-clock interrupts, which
> > -   defeats the above need_resched() strategem. RCU will therefore
> > +   defeats the above need_resched() stratagem. RCU will therefore
> >     invoke resched_cpu() on any ``nohz_full`` CPUs still holding out
> >     after 109 milliseconds.
> >  #. In kernels built with ``CONFIG_RCU_BOOST=y``, if a given task that
> 
> -- 
> ~Randy
