Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390F12BF02;
	Fri, 24 Jan 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733524; cv=none; b=EZGQuFs0LEsVKFsxfkd8oiAk+UGI0dqb6aZTK1jE7CCNoGRYhZ1OkmmdznxPCKZQRYi8GJEVqd1Hc1MJBzUlmjlGiVA7K85z7Hc9sotVdPCq8b5kd6jlyMy0iAzwQU3IEfNZ//EMHPRbz4lfBfn3/33IdlYxlbXKnZcBmv4i2R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733524; c=relaxed/simple;
	bh=S3/2Ia3VmQ5YFu51XFVEOifogH6IFRdY1kEQup13u+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEnif45qn456K1fhVUnW2tX7UQkaR4QumjYVIm8zjFdyquDCEb4qEKbwtSHi1IpQTxnORtpg2D+cH+JKaeGrQQqwYN0aTSQL3W3Zy+hG+716fd2jGXboC+isjQleBIqiXz5q2O6Yj6MerohM0TFwMC83fnbb37T2UL/aLfsQAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB7hyvLo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB7hyvLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8AEC4CED2;
	Fri, 24 Jan 2025 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737733524;
	bh=S3/2Ia3VmQ5YFu51XFVEOifogH6IFRdY1kEQup13u+g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BB7hyvLoWl00IeZmTA+OvQOUynKSodSId2w0sFCigT54S6E7182pqk6PId7FMk3B8
	 RgDpLXC/V0rczv3zfH3oHnK8tRHAifCFk9BM5fhGf6jow9QcFgExXoMXSYpGa+DR3x
	 lg29My5qpS0VzHykcv2O7ly/KdYwuzYPii+zUQWDMeyETmCheiDHeOY2NXhEhMNUSs
	 7ffUAOr4Mb9uYrCFmHyRgZFumrH+wbUraI8hzJfFTORJamAWNPGaC+Wbt+c7Xi0ceO
	 KifB2www63fZWgu0dwJR6b5z6Yomjl8Z7dRuXteyjzzi+W9w9Tc7Vm8d90s0QtnG7a
	 4GNX33FS1Z+IA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96292CE0DCA; Fri, 24 Jan 2025 07:45:23 -0800 (PST)
Date: Fri, 24 Jan 2025 07:45:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
 <Z5N8cmpD-HmTYQQJ@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5N8cmpD-HmTYQQJ@pc636>

On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > This configuration specifies the maximum number of CPUs which
> > > is set to 8. The problem is that it can not be overwritten for
> > > something higher.
> > > 
> > > Remove that configuration for TREE05, so it is possible to run
> > > the torture test on as many CPUs as many system has.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > You should be able to override this on the kvm.sh command line by
> > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > For example, see the torture.sh querying the system's number of CPUs
> > and then specifying it to a number of tests.
> > 
> > Or am I missing something here?
> > 
> It took me a while to understand what happens. Apparently there is this
> 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> you need to know about that. I have not expected that.
> 
> Therefore i removed it from the configuration because i have not found
> a good explanation why we need. It is confusing instead :)

Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
make use of 20 systems with 80 CPUs each.  If you remove that line from
TREE05, won't each instance of TREE05 consume a full system, for a total
of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
command line, but that would affect all the scenarios, not just TREE05.
Including (say) TINY01, where I believe that it would cause kvm.sh
to complain about a Kconfig conflict.

Hence me not being in favor of this change.  ;-)

Is there another way to make things work for both situations?

							Thanx, Paul
