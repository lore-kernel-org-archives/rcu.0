Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AC34CDD;
	Thu, 25 Dec 2025 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766688861; cv=none; b=Y5TMnJQGLDlYgY9rCteElGS43QRsM24iLWOcMpBkdBY8UhAvUCj66wl6tgP6qNUN9KZQsd3lkB2mPbnDOtl77NIvI+ku+l8MD4UMRNqIlZP2zca3k4xB7SUDfYm8Kwo9VUERwWuFLCilkB8z3pMPR+8miQXwumBxdq0rpmzWyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766688861; c=relaxed/simple;
	bh=j4fdIbNqqZP70fpS0lFVa3+jcXcWJtm3hj1eDwwJNKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF29faZj1iUuh/pGM0+Wlp6+NaS5acjphIKhRPCu/A66fv6lbE1HxYrFqKhTwU6+d9ghUPogiCvjrQWAq/9yFPZ0rKHgz4l4yphb1io3OxiDUxyDbC60DmhSXVfJtM1+7cuxzgr/8L6fVFBEy8sr7kbKm7220ulAUPj1I110gmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuQ+g3xe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuQ+g3xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD0C4CEF1;
	Thu, 25 Dec 2025 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766688860;
	bh=j4fdIbNqqZP70fpS0lFVa3+jcXcWJtm3hj1eDwwJNKM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MuQ+g3xe7EP0Jc/CgywMZ2Kgv9Xl+ehMdTAzD5ySQ+uXyYbSJ6Hx8uYedonJiwGHh
	 ftzWnEEI05+E6rDLoNAVoUyh5OBkW/8JQjVIww9sr4J+y2/mguFR+EZo+TZWd4WbB9
	 omkUODYHHggYgsiziO3CLhLsD+uo2nS1VP++GAOwpyg6RmEKhMKsWEwrcQOXhezSuL
	 wfBt69XGiwrwe0E1QaTccuTQuGOt8cYhtiV4Va6DJ2aLJ+AIPz81kaEYVtPemBEtTS
	 LQm/U6AZ6ZTyIMtOZten0RJuyOOwImVNeHKm9jfGDNPHPbzdtiL7XieKCnft7gpW1h
	 PJZebHKw6TCGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 190D8CE0D19; Thu, 25 Dec 2025 10:54:20 -0800 (PST)
Date: Thu, 25 Dec 2025 10:54:20 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC] jiffies_till_first_fqs off by 1
Message-ID: <b6bd973d-3cc6-4174-aaae-f3d67d8ccca1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>
 <2f95e414-7d0e-4e2a-9656-25abf84c27ec@paulmck-laptop>
 <20251224020619.GA1297269@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224020619.GA1297269@joelbox2>

On Tue, Dec 23, 2025 at 09:06:19PM -0500, Joel Fernandes wrote:
> Hi Paul,
> 
> On Tue, Dec 23, 2025 at 03:53:23PM -0800, Paul E. McKenney wrote:
> > On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
> > > During studying some synchronize_rcu() latencies, I found that the
> > > jiffies_till_first_fqs value passed to the timer tick subsystem does is always
> > > off by one. This is natural due to calc_index() rounding up.
> > > 
> > > For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
> > > is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
> > > never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
> > > to interrupts.
> > > 
> > > Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
> > > before passing it to the wait APIs.
> > > 
> > > But before I wanted to send a patch, I wanted to get everyone's thoughts.
> > > Considering this the RFC.
> > 
> > Inadvertent passing of the value zero?
> 
> This should not be an issue because at the moment, even a value of
> jiffies_till_first_fqs == 0 waits for ~1 jiffie due to schedule_timeout(0).
> 
> But you raise a good point, we should cap the minimum allowed jiffie value
> for the fqs parameters to 1 so that we don't pass schedule_timeout() with
> negative values when/if we do the reduce-by-one approach.

There is a potential use case for jiffies_till_first_fqs=0 and no wait,
which would be systems that want to scan for idle CPUs immediately after
the grace period has been initialized.  Note the word "potential".  ;-)

If we want to support this, then perhaps we would need to avoid that
schedule_timeout(0).  Or rcu_gp_fqs_check_wake(), as the case may be.

							Thanx, Paul
