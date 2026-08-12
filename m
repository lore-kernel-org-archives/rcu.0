Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC12F8E96;
	Wed, 12 Aug 2026 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493922; cv=none; b=FY0yrlsDyz6CNG8hO8P81gTWCv6u/5NCKQgcsz0Gs5BlXE/0llITQ/UOy7PLyRvL9D26yzuS5B6wao/y5PiAOTQoVQse25RS/OLse/2nDfqwAgf4Ul0yEHUJHYXJfvUyLCnx5BGmVFgXwMnSYckJ93s472ZOi+f0wJRnERpS3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493922; c=relaxed/simple;
	bh=AeEDkGCSA7Q5EeNDGqMlkVuOHhKUhiVNHYjDfFV6Q8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSNeeYMQwItj2Lj5bvbwr/0U/nM6ew4xzZQwDBq2K8YfYV0uQtHUhS/cH9daOtzcKAoehDQG41vAihF2VN1DxIAEtjOA/04EmSRgiTV9W9wl+Vued1zIUY0gVhBVuhmipJFYImpqjs6bF+d67m7PTvJwCPGqOG/cQ83a0HoYvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTh4Dq7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTh4Dq7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B622E1F00A3A;
	Wed, 12 Aug 2026 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493915;
	bh=l9eGRtCC/G4jYX7KbiMCKPIdYdgb/VcymFwDuz9ApUM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LTh4Dq7sU4t4kmABRoKENu4Et5Uhw2toDNCALWi9lrApw8Q/HUmSMtdtgyi9u6z5e
	 XgrM+XwHr5oE82IWIj2Upp5XORboJyORGUNSPC8a0VsPGlnc/2o2b37b6FMy9qRMb8
	 BW2mTETwyUeyKOSRFNIKqo+R0KaRCAf2FDqHjATXpsFZ8sTn0jPrzFL5243hzJJMy9
	 S8Wg/VRCWLbj591skb63V8VeD7yB5e4q7H58RhFyK6UjMyxBvqa2IEk8Njd4Z6/luP
	 Huhd5WPGG2RR/QjB+7kNRcjh1F00U4aG52TAZsPnlxh8KkKsZy97DzMLmJ60kEYUKW
	 VwhvrF6gMFBJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 72ED2CE17BD; Tue, 11 Aug 2026 17:18:35 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:18:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Zqiang <qiang.zhang@linux.dev>, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	leitao@debian.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] srcu: Fix WARN_ON() for timer_delete_sync() in
 cleanup_srcu_struct()
Message-ID: <c1a3654a-fc51-42f9-b7e0-425b253a6007@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260811002951.106631-1-qiang.zhang@linux.dev>
 <ans3nJDeaO6ujzbl@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ans3nJDeaO6ujzbl@localhost.localdomain>

On Tue, Aug 11, 2026 at 04:54:20PM +0200, Frederic Weisbecker wrote:
> Le Tue, Aug 11, 2026 at 08:29:51AM +0800, Zqiang a écrit :
> > The WARN_ON() for timer_delete_sync() means that the caller forgot
> > to call srcu_barrier() before cleanup. however, it still can trigger
> > even when srcu_barrier() was properly called.
> > 
> > When a SRCU grace period ends and find that the allocation of srcu_node
> > tree has been completed, but the ss_state is still less than SRCU_SIZE_BIG,
> > the mask=~0 causes delay_work timer be queued on every CPU which has
> > been online regardless of whether it's sdp->srcu_cblist has callbacks.
> > the srcu_barrier() only wait srcu_barrier_head's callbacks to complete,
> > however, the srcu_barrier_head will not be inserted into an empty
> > sdp->srcu_cblist. after that, when cleanup_srcu_struct() finds a pending
> > delay_work timer on a CPU with no callbacks, triggering a false positive.
> > 
> > This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(), make the
> > warning triggers only when the timer is still pending and there are
> > actual outstanding callbacks.
> > 
> > Fixes: 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is successfully deleted")
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@intel.com/
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

I pulled this in for further review and testing.  My plan is to fold
it in to the commit that it fixes, of course with attribution.

Thank you both!

							Thanx, Paul
