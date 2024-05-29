Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E015B0E6
	for <rcu@vger.kernel.org>; Wed, 29 May 2024 22:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021267; cv=none; b=pN53NlezTByX4a570yMLyXiRDfYxF8d5WhHzTzrXy5PR8rFD7UvV2f/GR1YL7VtDJoKyVSWM5a3VT66L/OaRK/ssoYrQnHBrZQbcbEHvvmo67O0md96sOXK4m/jjnbyCDNVF0q6gJnDgQytb/wWDGAVMUdbE3lZb1chvlNjJ7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021267; c=relaxed/simple;
	bh=j0mSXA6tw9NOHSoZg51U+8F5V+RiVhiNY47IXnz8Kz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqhyryXI4UxMALa3KgEx11W5TaL2OPMtAs/1OTwauUJh/s9FErL2Y+/Rn4NGbVOp8nfC4dWKlzNjMFQN7G9YylM77c3GR/kktH1MW1HOOIYFO35+vvrtc+i7iE6qOyr7kG7g8/0EYtH7eQO9533XnyNpgIStdSSqJWcKZ/fdjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4I7wZmZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4I7wZmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E89C113CC;
	Wed, 29 May 2024 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717021267;
	bh=j0mSXA6tw9NOHSoZg51U+8F5V+RiVhiNY47IXnz8Kz4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=P4I7wZmZjzsngQ3SjxE7vv+tpNgDqRiO5o3ommrC9g+KuagjiKo6HQ2/wcONwC2t7
	 fZU1OhzDr7twgzHl4EEXdJl/B1iaDF80KQCsFnKmFeYEdmu/MKNVmCqdnLfWnYAhHM
	 SXueDho9nFI7GQzI4iliP27+B/ibwKStzrhLYNeeolQwq5YKAGCFaaBTIgBy/hi+Jh
	 o5ihh7x0Bkuf3EYilW2ZezYN4G/d3T2VzExgEJS8uxVl1uaQPiUnvlKO73JXHHzp3i
	 /vd++clSy80QOtSCnVQtJIi04fUBHK8PB/9R4Tr3l4eXPJLIx/4ip69Nus4T/nk7nR
	 9K57YzZxXbB3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9ED4ECE0EE0; Wed, 29 May 2024 15:21:05 -0700 (PDT)
Date: Wed, 29 May 2024 15:21:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, neeraj.iitr10@gmail.com
Subject: Re: Updated -next branch and repo for RCU commits
Message-ID: <0cb42d29-4c2e-412d-82af-0f2e42b40669@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>
 <732c43ae-6d7a-4a98-995e-e96086a94678@paulmck-laptop>
 <20240529080212.21a8ab42@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529080212.21a8ab42@canb.auug.org.au>

On Wed, May 29, 2024 at 08:02:12AM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> On Tue, 28 May 2024 11:54:44 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > From here on, could you please pull from branch "next" in our shiny new
> > shared RCU tree?
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux
> 
> Do you want this to replace your current tree, or in addition?

Please add this one from the shared tree, and change my -rcu tree's branch
from "rcu/next" to "non-rcu/next".  If the non-RCU stuff from my tree
continues to be under "rcu/next", someone is going to get very confused,
and there is an all-too-good chance that this someone will be me.  ;-)

> > Please let me know of any questions or concerns.  Or, for that matter, if
> > there is some automated way to do this that I have long since forgotten.
> > 
> > I will still have non-RCU commits from my own tree for -next, and I must
> > confess that the name "rcu/next" seems entirely inappropriate (to say
> > nothing of confusing) for that purpose.  Would you be OK changing to a
> > branch named "non-rcu/next" or something similar?
> 
> I don't care what the branch is called as long as it is a stable name.
> 
> I have done the following for now: added the new rcu tree as above and
> renamed the old rcu tree to be the paulmck tree (still fetching the
> rcu/next branch).  Let me know what you want the final set up to look
> like.  Also, do you have more contacts (preferable full email
> addresses) for the new rcu tree (currently I just have you)?

Please make the newly renamed paulmck tree pull from "non-rcu/next".

The additional contacts for the new shared RCU tree are:

Frederic Weisbecker <frederic@kernel.org>
Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Boqun Feng <boqun.feng@gmail.com>
Uladzislau Rezki <urezki@gmail.com>

							Thanx, Paul

> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window. 
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and 
>      * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.
> 
> -- 
> Cheers,
> Stephen Rothwell 
> sfr@canb.auug.org.au
> 
> -- 
> Cheers,
> Stephen Rothwell


