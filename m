Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0070186E29;
	Wed, 11 Sep 2024 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051163; cv=none; b=UrkTB7aNBzAfdIosuAPi+4JAFB//5bGR9B5FNKYzNpMH+0K+PqzfqgfGC517GPWTZAYMYX7zQ+xq0mOH590E2jK9LxdeywwdB3zD46ATNehZZ0Zy4L2mMo9kP8Dq3vtnSCeAuM+xzL/yy5U/RRyyeEEDjRnbzfMFmVIJvn5i7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051163; c=relaxed/simple;
	bh=hTPRxjqAv0hvbIBmZQMNx/KXHekumJfEMps97NlvV0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCtD+hiP9Z6KTm0U3oto5WErGvF0YHk8DDbvdBRxy7ZF8kwEatp5OI0DXk1phO0fnwsdK3r0b4QOgH+eW97xULUYMIlGJmRVE6oZ4c5n/quSTLkHeQcpZDyhb+IBA7q0FDWbQqG7ZeFA2Ww60WtUhtmwJDasWfERWMhrpCiHVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhuKmKGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhuKmKGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153DBC4CECF;
	Wed, 11 Sep 2024 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726051162;
	bh=hTPRxjqAv0hvbIBmZQMNx/KXHekumJfEMps97NlvV0E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nhuKmKGGekjKBzrspDVfLz0iUxQb/p+YJIzE5K+t2J8vbuP6iAAizKS6IBzarcDY1
	 hIDTlhxNTrHW5V6PoXK5Sj7YjOxXG+NXTYqwke9SBy9PcGXKUv3+Sp6fCMHCib+rRw
	 HzncVKK3srV4pD6q2YEpxH96B72CeQKX/XBnqgVZvU3Mrz5bYspuaM7n402xpT/o8J
	 bWR4wQvS3VVCIbuwBVlup/O4yYJuR3xa971wsjSHdu3CYCjEOGz6NI0+4fCZXwT90y
	 DSOOajqfA8JMbheeognIbXrdHQOHOHqA1PmTMu3itqxpeXPWAWEEMUGQqEoIDsM/9m
	 AGLRNv9bLvpsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1F774CE13D4; Wed, 11 Sep 2024 03:39:19 -0700 (PDT)
Date: Wed, 11 Sep 2024 03:39:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <cdab7aec-0f03-48ab-b162-28c4a2f198eb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240820155935.1167988-1-urezki@gmail.com>
 <34ec01ee-a015-45bb-90ce-2c2af4ac9dbf@paulmck-laptop>
 <ZuFmWuUK8POsihzf@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuFmWuUK8POsihzf@pc636>

On Wed, Sep 11, 2024 at 11:43:54AM +0200, Uladzislau Rezki wrote:
> On Tue, Sep 10, 2024 at 08:42:54AM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 20, 2024 at 05:59:35PM +0200, Uladzislau Rezki (Sony) wrote:
> > > Add a kvfree_rcu_barrier() function. It waits until all
> > > in-flight pointers are freed over RCU machinery. It does
> > > not wait any GP completion and it is within its right to
> > > return immediately if there are no outstanding pointers.
> > > 
> > > This function is useful when there is a need to guarantee
> > > that a memory is fully freed before destroying memory caches.
> > > For example, during unloading a kernel module.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > As a follow-on patch, once kvfree_rcu_barrier() is accepted into
> > mainline, should we add a call to kvfree_rcu_barrier() to the
> > rcu_barrier_throttled() function in kernel/rcu/tree.c?
> > 
> > This would allow the do_rcu_barrier module parameter to be used to clear
> > out kfree_rcu() as well as call_rcu() work.  This would be useful to
> > people running userspace benchmarks that cause the kernel to do a lot
> > of kfree_rcu() calls.  Always good to avoid messing up the results from
> > the current run due to deferred work from the previous run.  Even better
> > would be to actually account for the deferred work, but do_rcu_barrier
> > can help with that as well.  ;-)
> > 
> > Thoughts?
> >
> Makes sense. To be make sure that all objects are flushed. And as you
> mentioned it is good to have it for benchmarking as a return to a baseline
> point.
> 
> One issue is probably a "name" which would be common for both:
> 
> rcu_barrier()
> kvfree_rcu_barrier()
> 
> i mean /sys/module/rcutree/parameters/do_rcu_barrier. From how i
> would see it, it is supposed to trigger just rcu_barrier() API.

One approach would be to keep the old functionality, but create
a new sysfs variable that does both.  Except that to avoid code
duplication, we would likely end up with both actually doing
both.

Another approach is to rename the sysfs variable.  This might
work if there are not too many people using it.  Might.  ;-)

Other approaches?

						Thanx, Paul
