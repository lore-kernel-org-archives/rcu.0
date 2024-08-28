Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25B19DF40;
	Wed, 28 Aug 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868013; cv=none; b=WZQ3lfa1+1sXeRIgvyM4fEIEt/ba8CZxAhcFGzms8ekH0FBtsG/uMcnxf53+C1r2Gd1eP03f7ZUhGPjzsldWDMgxW99JmV/A5GHeBUGmZMyfrxs2Su+xKUN7Qj9vzZojZqAEEQswYYa/sE8m935fjpDDcM6kylLsNcnAYNMUztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868013; c=relaxed/simple;
	bh=7H/E7MSDZxVkPqQwHScaGrL3nzpRLI/Qqo9WirUXiIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4QjZPUg6DYxzjksetoU/kv+CjAaQV7yKQY3dStEeYLEdMO6rwppAUDUOI/QpNjWzuliE2e/CWfQvFgqjhKW2QRq+dPWICWfMG+3ZpHYDolFjrnrPD7ZySb2ITkHo6oyu4dkwbrapM7UUeLzQRXrvFNEpcc/eLIWv1Y41nTChfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3s6Q64y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3s6Q64y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A404FC4CEC1;
	Wed, 28 Aug 2024 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724868012;
	bh=7H/E7MSDZxVkPqQwHScaGrL3nzpRLI/Qqo9WirUXiIw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=N3s6Q64yg3+L2ByOW9TijOw2EdzX3BuWiid6c7ce/haA10hMLak1BggFTW1ZrWoRF
	 7mrSyehShsVwFo4RFkHB0kU+LBMdO9OZDR5L7AYVFtMS/Cxbv1aM64ChcTySOAQ58L
	 5+AUWY9tDBaHj1lQs7lKIqzfq2PtPiqg89GO5Vr6xVRVQIPiBKwt1quVrqg9i18v5H
	 xZUZl7jp5XZGCwvcoQLjZjKzOHx+nG3ufciY/a7RzcRSUh2qoDzsK43Y0K+9NZF3XE
	 S6ZBmmNGZshEXApDyNbsPxDmnnDJKwWEMy3cSNwIMLIQjzzspyf3matxcLdHqwA7ZB
	 EMULHU7RREyHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 43F8CCE0FF3; Wed, 28 Aug 2024 11:00:12 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:00:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/4] rcu/kvfree: Support dynamic rcu_head for single
 argument objects
Message-ID: <184844f5-71fd-4b62-bf86-87cdff3aa546@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240828110929.3713-1-urezki@gmail.com>
 <64bebc29-a007-4ebc-bf86-8c2c0a7e6bf6@suse.cz>
 <Zs9Xm6VKcpMkWbLE@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9Xm6VKcpMkWbLE@pc636>

On Wed, Aug 28, 2024 at 07:00:11PM +0200, Uladzislau Rezki wrote:
> On Wed, Aug 28, 2024 at 04:58:48PM +0200, Vlastimil Babka wrote:
> > On 8/28/24 13:09, Uladzislau Rezki (Sony) wrote:
> > > Add a support of dynamically attaching an rcu_head to an object
> > > which gets freed via the single argument of kvfree_rcu(). This is
> > > used in the path, when a page allocation fails due to a high memory
> > > pressure.
> > > 
> > > The basic idea behind of this is to minimize a hit of slow path
> > > which requires a caller to wait until a grace period is passed.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > So IIUC it's a situation where we can't allocate a page, but we hope the
> > kmalloc-32 slab has still free objects to give us dyn_rcu_head's before it
> > would have to also make a page allocation?
> > 
> Yes, you understood it correctly :)
> 
> >
> > So that may really be possible and there might potentially be many such
> > objects, but I wonder if there's really a benefit. The system is struggling
> > for memory and the single-argument caller specifically is _mightsleep so it
> > could e.g. instead go direct reclaim a page rather than start depleting the
> > kmalloc-32 slab, no?
> > 
> This is a good question about benefit and i need to say that i do not
> have a strong opinion here. I post this patch to get some opinions about
> it. This "dynamic attaching" we discussed with RCU folk a few years ago
> and decided not to go with it. I have not found an information why.

If I remember correctly, I asked "How are you testing this?", which
was then taken as a criticism rather than a question.  ;-)

No one has reported an OOM-related problem with the code in its current
form, for what little that is worth.

							Thanx, Paul

> The page request path, which is "normal/fast", can lead to a "light"
> direct reclaim, if still fails, then we are in a high pressure situation.
> Depleting a slab is probably not worth it, especially that the patch in
> this series:
> 
> [PATCH 4/4] rcu/kvfree: Switch to expedited version in slow path
> 
> switches to more faster synchronize_rcu() version to speedup a reclaim.
> 
> + this [PATCH 3/4] rcu/kvfree: Use polled API in a slow path
> which also improves a slow path in terms of that a GP might be already
> passed for the object being freed.
> 
> I am totally OK to drop this patch. This is fine to me.
> 
> --
> Uladzislau Rezki
