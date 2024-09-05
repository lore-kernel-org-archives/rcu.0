Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119D194C62;
	Thu,  5 Sep 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526315; cv=none; b=DGF+obuOJa1vx3+4yVRMEI6OJgjERZuD75nS/etvOqFfRsRqK7k/iJXAwswyWxIz9X2jpWcK3uuWPE1VaOJBbewqoVZMn9lQK7ZerCD864XjGWC01F5yvhTnqPjkCRK0jKFSs4ejW/8fA1qiV4ihxMxRvW78wkd/qkntXWsZ7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526315; c=relaxed/simple;
	bh=3W9Cv493uJ/6eAk3Z50W8FCy2ieOevMkcYEtHO/pPTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPDPMIMEqAmfqvdgr/vL0vYg/vTjooOv01OmfjpgWd8vD4vnF4+W/yjRYSomCRD7SCKb/QNCT81JT1NNmBr7TBSobGNUQGwgKGd2qvSubv+1Rn8eaEQmjEV82GAKMci3xGCANY8pqRdAsPHUokXjOnwKVnbjvzT+JxwHIu+sfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3Bir8LJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3Bir8LJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FB5C4CEC3;
	Thu,  5 Sep 2024 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725526315;
	bh=3W9Cv493uJ/6eAk3Z50W8FCy2ieOevMkcYEtHO/pPTY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=d3Bir8LJmFV7MBpzpPbHaKv3FZQTxkNdd9fP4BmYo0GkCflA7yUdkVwVt13Bo+LXb
	 G4S8ZMsYKo5rLDydi20nHdPPg4bWMPo4/KKmDeggqjO9nriZ6ZTYCdQvIsrM8GgiJ7
	 p0lxRAMg7NE1s9Oyv9xLJBqWB51NKdyD/8KLTkBgGrl7aIyFhLsUJ23TWf8xIQlG54
	 oDaeeuwPNIe6czcbDidNA5S/Cd8YYNhADyhV5DGTHgLJrMoUSHmmswkEYu0Fpp6//d
	 Y5SEOBu6bHq9hUJ13dGps2PXQj2pUuSBa81ertPSVS7daQdKN2z//Wx1NF/1gUTp9l
	 FmPze/ynWbiYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A6335CE16C7; Thu,  5 Sep 2024 01:51:51 -0700 (PDT)
Date: Thu, 5 Sep 2024 01:51:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.08.30b] [srcu]  558049054f:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <1d5e1a25-e96b-4e21-8916-3e6e384769a0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202409031433.5ce7c1e3-lkp@intel.com>
 <474f6fa0-e5b5-4834-9c6c-25549eb6478f@paulmck-laptop>
 <ZtkVrGo+GeyyG2bO@xsang-OptiPlex-9020>
 <d59a4591-33a1-439d-8c45-b98e77610afd@paulmck-laptop>
 <Ztlrizt2KJ7fbbGr@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztlrizt2KJ7fbbGr@xsang-OptiPlex-9020>

On Thu, Sep 05, 2024 at 04:27:55PM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Thu, Sep 05, 2024 at 01:23:34AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 05, 2024 at 10:21:32AM +0800, Oliver Sang wrote:
> > > hi, Paul,
> > > 
> > > On Tue, Sep 03, 2024 at 03:26:43AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Sep 03, 2024 at 02:49:48PM +0800, kernel test robot wrote:
> > > > > 
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > kernel test robot noticed "BUG:using__this_cpu_read()in_preemptible" on:
> > > > > 
> > > > > commit: 558049054fe90985d650a50b6a757943a9faf646 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
> > > > > https://github.com/paulmckrcu/linux dev.2024.08.30b
> > > > > 
> > > > > in testcase: boot
> > > > > 
> > > > > compiler: gcc-12
> > > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > > > 
> > > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > > 
> > > > > 
> > > > > +------------------------------------------+------------+------------+
> > > > > |                                          | ddf16dbef6 | 558049054f |
> > > > > +------------------------------------------+------------+------------+
> > > > > | BUG:using__this_cpu_read()in_preemptible | 0          | 12         |
> > > > > +------------------------------------------+------------+------------+
> > > > > 
> > > > > 
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-lkp/202409031433.5ce7c1e3-lkp@intel.com
> > > > 
> > > > Good catch, thank you for testing!  Does the incremental patch at the
> > > > end of this email fix this for you?
> > > > 
> > > > 							Thanx, Paul
> > > 
> > > I applied patch directly upon 558049054f, confirmed the issue gone.
> > 
> > Thank you!  May I add your Tested-by?
> 
> oh, I saw the patch has "squash!", didn't realize you still will add Tested-by
> in squashed patch :) sure and thanks a lot!
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thank you, and I will apply this on my next rebase.

							Thanx, Paul
