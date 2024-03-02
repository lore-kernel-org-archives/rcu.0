Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8793EA8C
	for <rcu@vger.kernel.org>; Sat,  2 Mar 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709408623; cv=none; b=QnrhvF/hRxI8IEMOfuFnDlFxWccHJHuYqQ03jhUIcHREqG/TbbG7p+X2j6RrfaWJblFmvS0dDIM4buYxeXFBgqqMu3u59/vor2mUTgGGuoylzE5KT/TbKZSjIy860DJZAId24u4ATdv6Vvdrozc2BSSbYoNEVBIPhhLOx/tbnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709408623; c=relaxed/simple;
	bh=MubbEwdSzMXjXRVmb/ZUmFJOCXi/+4qDvwdjGt7Xk1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ6Mdj1wBPYvqectFmwf27JeLR/8wAcfcseSfu0YRLJa7DTbGfirEFWCsPQ5gMHHrj9MwfEY56P00VZmWWq2EM55YtyhO7rq36Y8nnYFJRxeZYUq/V8kVyK7JiSdpBC2usd9Vjy1EpOLXdD8EwcPDBdSGhm91ABLl8fdwo7/z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4eWzcHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4eWzcHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26068C433F1;
	Sat,  2 Mar 2024 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709408623;
	bh=MubbEwdSzMXjXRVmb/ZUmFJOCXi/+4qDvwdjGt7Xk1U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T4eWzcHPZ6oY7hyiD/kfQjkni96kzt0JgcooF7PqeiRs07nCSKKOf1TPdmbsVvVkG
	 r00xlL8IomWpQdys/CNECE0Djr/+O9zslo4ufWOVbb2ECQR9l+QeK0B2K2Dp5ISCS4
	 81Yp9Psxhy4xNFiqAutZBwtJIBV6WX552brKjg1YSV8HQTAtEiFTlxSbc0+YhHRvhG
	 sSuUi/2T+dF3/cvKfvc4mdHAP9auM3RT+bW34CY2d8QM9D7cTauylRql4Zy4NEMFsv
	 flpyJrRmYYLY7zWcmwZxXJyxjTfEnZK+/sJcVsQ31r0IKoKIlQ73jTlssUW2DE0CTM
	 8FQ099aRlxDUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B37EECE141F; Sat,  2 Mar 2024 11:43:42 -0800 (PST)
Date: Sat, 2 Mar 2024 11:43:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Max Boone <contact@maxboone.com>
Cc: boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: Re: Advice sought on RCU stalls on ARM64 WSL2
Message-ID: <1a5d96d6-2057-44d9-a4b0-8771c46032fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6a07-65e37700-1-4052b980@161649365>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a07-65e37700-1-4052b980@161649365>

[ Adding Boqun and the rcu list on CC. ]

On Sat, Mar 02, 2024 at 07:59:08PM +0100, Max Boone wrote:
> 
> Dear Dr. McKenney,
> 
> For a couple of years now I've been the sometimes frustrated owner of a Microsoft Surface Pro X ARM64 device, which has been getting progressively better as more vendors start targeting their builds at ARM64 architectures but since the introduction of the device there have been issues with the Windows Subsystem for Linux (not more than an opinionated Hyper-V VM with extensive tooling) locking up and hanging. 
> 
> When this happens, traces like the following are dumped in the kernel messages:
> https://github.com/microsoft/WSL/issues/9454#issuecomment-1942222109
> 
> When watching your talk "Decoding Those Inscrutable RCU CPU Stall Warnings" you mentioned one can feel free reaching out when bumping into such issues. Building other kernel releases, switching off-and-on modules and playing with the RCU grace period times so far don't seem to work for me (or others in that thread).
> 
> Anyways, I don't really know where to start looking and the call stacks aren't very informative (to my eye) either. I'm hoping you might help me find the direction to look for the root of this problem.

I am assuming that you have filed a bug with the Debian folks, and before
doing that, searched for similar bug reports.

At first glance, this is because things were stuck here:

[  967.115632]  clear_rseq_cs.isra.0+0x4c/0x60
[  967.116433]  do_notify_resume+0xf8/0xeb0
[  967.116960]  el0_svc+0x3c/0x50
[  967.117537]  el0t_64_sync_handler+0x9c/0x120
[  967.118323]  el0t_64_sync+0x158/0x15c

So including these function names (clear_rseq_cs() and so on) in your
search for similar bug reports would be a good idea.

I am unfamiliar with that code.

So I added Boqun because he works with Linux on HyperV as part of his
day job and has a great deal of experience with RCU.  He will likely
have quite a number of questions for you including exact versions,
Debian bug number, the results of your web search, and so on.  He might
also know an ARM person to get involved in this.

Or maybe he knows the solution off the top of his head!

							Thanx, Paul
