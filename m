Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9A4430
	for <rcu@vger.kernel.org>; Sun,  1 Dec 2024 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733027474; cv=none; b=aQnSxl7MFNySnBixyc4QXmTTUQINDKvT+BTPBmaU/77DdI+5cYE0PdUCdrKY/qCJGrY0oH1JCPm6R/IWGVdanKbXZUNfluMzaiqZteuvy3SfZ7JOwTJdJZL8tjFlp4Iy5Q6QejXrEybZLmxuxs8ZU5NAbCcaMBikIkaxw/7Xt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733027474; c=relaxed/simple;
	bh=358iiU7og7/Rn4O7EJidsBbJT9LXXaatHGNkdUfqpEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK7Jcjgln3AlFBbnRJYFtbFkPjOThUiXGGYDPHY2t8WMKlEDCGtJ/U+cufjPq2jZd+Z+d5qQokzDowhweoLrP51t9nD9hMJqf9fjPJWSBs1HTZx/7Wcn4Mqb4g3lYXK7xpclI6ebj8BqzEBjSJGFENPF8LqrNakBk1eKGEKPbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mayXtkvb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mayXtkvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D690BC4CECF;
	Sun,  1 Dec 2024 04:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733027473;
	bh=358iiU7og7/Rn4O7EJidsBbJT9LXXaatHGNkdUfqpEI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mayXtkvbJjo6BlYl+5cuXsaGl0IWwKYF7d9dZw8pQwScBBvYE3G1ZzjvQMT+4qOvH
	 aFXqV+WfY84EfUx+kYENGB0a+OkBT9bWWfK1DADlWnwtGGm0KCcwGp4OEVuBFqwulO
	 WyUAOwm5eRuvf8iZiHcE9e604FWyi3TEfS0UcnLbI7tEBVFbnPtJL/FYHLReSlEvpU
	 2G+Qk+LDUmYty3IjaZNtmrlMAXI6092m5lh/CdtCA8xvLG0kg2sBfydqR5Tl59cVo8
	 7s4OCGAc6RC821N4DCAMxpTDchyH1kxxuJ+Rs/eGXL6nhq0bVNf5q4NGWEIP8UlJ2R
	 lol+HRujQmARA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6FAA5CE1068; Sat, 30 Nov 2024 20:31:13 -0800 (PST)
Date: Sat, 30 Nov 2024 20:31:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: rcu@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>

On Sat, Nov 30, 2024 at 11:22:45PM +0100, Magnus Lindholm wrote:
> Hi,
> 
> 
> First some background:
> I've been trying to boot recent kernels on my alpha machines. Anything
> after linux-6.8.12 gives me trouble. After doing a kernel bisect, I
> found that commit 9187210eee7d87eea37b45ea93454a88681894a4
> (net-next-6.9) is where my troubles begin. The problem consists in
> that the boot process gets stuck when trying to set parameters for
> network interfaces. The bad commit does make a lot of updates to the
> network code.
> 
> When booting the system with kernel 6.12.0 I'm able to boot into
> single-user mode, but when starting system services one by one I
> trigger a kernel Oops when the network interface is renamed (see stack
> dump below). Looking at the changes made by the bad commit, it seems
> to (among other things) be replacing the locking mechanism (RCU
> instead of rtnl_lock). The stack dump from the kernel Oops suggests
> that something is happening in the RCU locking code. I'm no expert on
> RCU-stuff but I read somewhere that it is done by volatile access on
> all systems other than DEC Alpha, where a memory barrier instruction
> is required. This indicates that the change could affect Alpha
> architecture differently? Inspecting the changes to networking code in
> the bad commit, particularly the changes made to net/core/dev.c, I put
> together the patch below. This patch reverts one of the lines changed
> in the "bad commit" for net/core/dev.c. After reverting the change on
> just this line, I'm able to boot kernel 6.12.0 on my Alpha ES-40 to
> full multi-user again. I've tested this on an Alpha ES40 and an
> UP2000+ and the problem is 100% reproducible on both machines.
> 
> The patch might not be a real solution to the problem but could be a good
> place to start looking when figuring out what's really going on. The feedback
> I've gotten so far (forums and the netdev mailing list) is that the
> RCU implementation on alpha is probably where things go wrong.

Does booting with the "rcupdate.rcu_normal=1" kernel boot parameter
also suppress the problem?

That "pc =" down below is the program counter?  If so, I am at a loss
as to what RCU could do to make it be zero.

							Thanx, Paul

> ------------------------------------
> Patch to "fix" the problem:
> -----------------------------------
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 13d00fc10f55..26fda14367e5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1261,7 +1261,7 @@ int dev_change_name(struct net_device *dev,
> const char *newname)
> 
>         netdev_name_node_del(dev->name_node);
> 
> -       synchronize_net();
> +       synchronize_rcu();
> 
>         netdev_name_node_add(net, dev->name_node);
> 
> 
> --------------------------
> dmesg/kernel log:
> -------------------------
> 
> [   93.431592] tulip 0000:01:02.0 enp1s2: renamed from eth0
> 
> [   93.436475] Unable to handle kernel paging request at virtual
> address 0000000000000000
> [   93.436475] CPU 1
> [   93.436475] rcu_exp_gp_kthr(17): Oops -1
> [   93.436475] pc = [<0000000000000000>]  ra = [<0000000000000000>]
> ps = 0000    Not tainted
> [   93.436475] pc is at 0x0
> [   93.436475] ra is at 0x0
> [   93.436475] v0 = 0000000000000007  t0 = fffffc0000e62440  t1 =
> 0000000000000001
> [   93.436475] t2 = 0000000000000000  t3 = 0000000000000001  t4 =
> 0000000000000001
> [   93.436475] t5 = 0000000000000001  t6 = 0000000000000001  t7 =
> fffffc0003138000
> [   93.436475] s0 = fffffc0000e62440  s1 = fffffc0000ec3a10  s2 =
> fffffc0000ec3a10
> [   93.436475] s3 = fffffc0000ec3a10  s4 = fffffc00003a90f0  s5 =
> fffffc0000e62440
> [   93.436475] s6 = 0000000000000000
> [   93.436475] a0 = 0000000000000000  a1 = 0000000000000000  a2 =
> 0000000000000000
> [   93.436475] a3 = 0000000000000000  a4 = 0000000000000001  a5 =
> fffffc0000517744
> [   93.436475] t8 = 0000000000000001  t9 = 0000000000000001  t10=
> fffffc0000e3d320
> [   93.436475] t11= fffffc0000220240  pv = fffffc0000b73210  at =
> 0000000000000000
> [   93.436475] gp = fffffc0000eb3a10  sp = 00000000ea2ea184
> [   93.436475] Disabling lock debugging due to kernel taint
> [   93.436475] Trace:
> [   93.436475] [<fffffc00003aee60>] wait_rcu_exp_gp+0x30/0xa0
> [   93.436475] [<fffffc0000b6c200>] __cond_resched+0x30/0x90
> [   93.436475] [<fffffc00003569b8>] kthread_worker_fn+0xc8/0x1f0
> [   93.436475] [<fffffc000035863c>] kthread+0x17c/0x1c0
> [   93.436475] [<fffffc00003568f0>] kthread_worker_fn+0x0/0x1f0
> [   93.436475] [<fffffc0000311128>] ret_from_kernel_thread+0x18/0x20
> 
> [   93.436475] Code:
> [   93.436475]  00000000
> [   93.436475]  00000000
> [   93.436475]  00063301
> [   93.436475]  0000077c
> [   93.436475]  00001111
> [   93.436475]  000022a2
