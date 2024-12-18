Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186D4690;
	Wed, 18 Dec 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562216; cv=none; b=k51BHcu6iDgRYdzmwc5sKEeb160mkyDeepd7G2NeN+GBIVOZoQbh8VnSK8duVDX1jtOsvTBDDs08281WnFhYxwO52gx6M/HY7WBbUSnJjTadoVHw79ANmipSxtvrgwIhpkmpCA+uaJyX0E8mu7UjnjN8WVpJaSLG7Qe9Ef19AEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562216; c=relaxed/simple;
	bh=Q8kVodaBIldUSutyV5hCIyKeYwGk8jQY5NcxeuVA/1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN3Y71ybNKfeRnSu0g28izPdoGfOFdLr/3lKrcotRya2ZcAQNTciBFd6SAtJc0rH0wPBlbYCk1NaBUS+D3r4iVWBPtWu+IlByp0tgWqFpcDVjomOp2Uy91gYN54KjSyosnwCK2hdpgG+ASGXfzUtZxYqqtj9EQ8NWlHQIH0vKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxpAjGCj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxpAjGCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E67DC4CECD;
	Wed, 18 Dec 2024 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734562216;
	bh=Q8kVodaBIldUSutyV5hCIyKeYwGk8jQY5NcxeuVA/1g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZxpAjGCjio6PGq/eI5NlN+tsd5+4xVGlZxyac0vSeyQ/j9RUJsMxRR6VxrcjsL8RR
	 tIczXyQlCOy32pQzmAuItSq7a45P6T8yLKTfHWdO10dBZ4NI4mnxeOqjHFLmgElpnc
	 LeOyKD6HmObEJC0I7KNcIlZ/fzhB9PV5z3KyoWALhsaQS8rhRIW7GrtgLWiHHJY6kn
	 ge7QbD8/zp1fhohSNQgumE/Fb4jqbWVXzDQN0Dv1DGwL4sMZUSH64T/bhzUAgy2AhC
	 VC1UjzhKt81XweecNaxBVgg1ZUTZDcgpehTME77GR2ud+NwGuEOWKBWw1erY+5FOeK
	 SonqT22ylmASg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B8A9BCE0924; Wed, 18 Dec 2024 14:50:15 -0800 (PST)
Date: Wed, 18 Dec 2024 14:50:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky>
 <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky>
 <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>
 <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop>
 <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com>

On Wed, Dec 18, 2024 at 10:54:21PM +0100, Magnus Lindholm wrote:
> > If I understand your proposed changes correctly, this could increase
> > the amount of time CPUs spend waiting for for the csd_data to become free.
> > This would be a very unwelcome development in some quarters.
> 
> you're probably right, this might not be the right approach.
> 
> > preventing it from happening.
> >
> > So what am I missing here?
> 
> Maybe a per-cpu variable is the wrong way to go about it. I'm trying to get a
> better understanding of why, even quite simple, structs get corrupted when
> accessed by kernel threads. The compiler may be at fault, but is it possible
> that there is something else going on, which is specific to alpha and we're
> seeing more of this on more recent kernels which makes better use of
> threads?

Are the s390 guys seeing this problem?  Maybe they saw it in the past
and did something to work around it.

In the past, there have been compiler optimizations that would use a large
store to update a smaller variable, and then do small stores to fix up the
clobbered areas.  These were all supposed to have been removed for C11.
Might some linger in Alpha's compilers?

							Thanx, Paul
