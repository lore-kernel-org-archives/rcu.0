Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426E8F66;
	Thu,  5 Sep 2024 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524620; cv=none; b=s1qvp5OWzhCUrgt5QCbJAjG8tN0Mr+BSXhorBfhlZ0/AutLpGJVbG1JBFtOBtLYGHdtl5CIJNYuMFpiRvDd95ktSE68uIO0fSgq3oE9rDscq1bU9p9OapTIvBDoWeRKQrAEq+uszGQLU844FAcwbOwYxzF6jWHRzLOnTimcCJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524620; c=relaxed/simple;
	bh=y3dFxhgxZzfvZh20Mow60IChxR9ARek7qGa52EdFTOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr3YIqnNmHJrptOisIGKeVGiT1ey91rqZ8xWwaOlJqNQYECzVoqA6cd5A9CJMp9Y4JvLn6aHlKioatSHD6KGeFhmSZyhKV4eWlfFf3onj75WnDFPN5dYo1c3ce714z9LofzhOuSO1MlhYxOY+CPMHksnMmvgdLCd50G1+Eoh4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h44JK/rX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h44JK/rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68958C4CEC3;
	Thu,  5 Sep 2024 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725524620;
	bh=y3dFxhgxZzfvZh20Mow60IChxR9ARek7qGa52EdFTOM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=h44JK/rXI/+sbmst1yzOkdzdZ70lcIrVHwfZiAVy9Obnl8L+pO34awpWz/mDNlkDK
	 Chcl7cCt52oI4At70UzAI3FCZkRnD8LpCBM4tolBpMUQH26Z/yPoJrNo2UW4NC1E4W
	 g6ycAUH6O9LMmcs0QFczN+glifBBZwoZ7S0dUaJnCz77YnHZNHtlV57NnMEEJPxs/r
	 lvBdI3+b9OA1zbE/irhFkg55bTQKbMT6+A7CnDik09yE8jjA+FTfCo+w+JfyeI0AVc
	 CYfMronWGGKIIDy+4YRs5GO0BHnjTNALeyUNqwWGXT99jIODbfas2CPuL2V65XSlZZ
	 4b2ymYoh4fTNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7975BCE16C7; Thu,  5 Sep 2024 01:23:34 -0700 (PDT)
Date: Thu, 5 Sep 2024 01:23:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.08.30b] [srcu]  558049054f:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <d59a4591-33a1-439d-8c45-b98e77610afd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202409031433.5ce7c1e3-lkp@intel.com>
 <474f6fa0-e5b5-4834-9c6c-25549eb6478f@paulmck-laptop>
 <ZtkVrGo+GeyyG2bO@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtkVrGo+GeyyG2bO@xsang-OptiPlex-9020>

On Thu, Sep 05, 2024 at 10:21:32AM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Tue, Sep 03, 2024 at 03:26:43AM -0700, Paul E. McKenney wrote:
> > On Tue, Sep 03, 2024 at 02:49:48PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "BUG:using__this_cpu_read()in_preemptible" on:
> > > 
> > > commit: 558049054fe90985d650a50b6a757943a9faf646 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
> > > https://github.com/paulmckrcu/linux dev.2024.08.30b
> > > 
> > > in testcase: boot
> > > 
> > > compiler: gcc-12
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > 
> > > +------------------------------------------+------------+------------+
> > > |                                          | ddf16dbef6 | 558049054f |
> > > +------------------------------------------+------------+------------+
> > > | BUG:using__this_cpu_read()in_preemptible | 0          | 12         |
> > > +------------------------------------------+------------+------------+
> > > 
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202409031433.5ce7c1e3-lkp@intel.com
> > 
> > Good catch, thank you for testing!  Does the incremental patch at the
> > end of this email fix this for you?
> > 
> > 							Thanx, Paul
> 
> I applied patch directly upon 558049054f, confirmed the issue gone.

Thank you!  May I add your Tested-by?

							Thanx, Paul

> > commit 01c732e108f6ea51e1660ad6bd59fff36e653ddb
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Sep 3 03:25:27 2024 -0700
> > 
> >     squash! srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
> >     
> >     [ paulmck: Apply kernel test robot feedback. ]
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 3133646f0b258..637d366a4dc7b 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1239,7 +1239,7 @@ static bool srcu_should_expedite(struct srcu_struct *ssp)
> >  
> >  	check_init_srcu_struct(ssp);
> >  	/* If _lite() readers, don't do unsolicited expediting. */
> > -	if (__this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
> > +	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
> >  		return false;
> >  	/* If the local srcu_data structure has callbacks, not idle.  */
> >  	sdp = raw_cpu_ptr(ssp->sda);
