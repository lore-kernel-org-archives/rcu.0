Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D459136672;
	Tue, 12 Nov 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415844; cv=none; b=qxejMlvz7LZBfJ/IIXwZwcnBq7x3e6ok0D/v7mhJ79NeQ1deDxtr2ZHevNJCEEyIDfoL61dLOW5bV0Eqx/7XOfN2mdQkEaE0+HiiU61H3F/yhVKNNbdeuQwR4pjsSbJSu5Olj2iI9fnYV5jTJwNQ5QI7sPKGH5PrmpAysqP1ObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415844; c=relaxed/simple;
	bh=mnfOiE5eIPKtHfBAoGmaq+Twf9102+gLIWoMtZu0bl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKwUOUj8bHm1AE4UEEivR8M02bQOkTUsMiggrWdQB8TbCUFWZsrBcsMjDdsK+yqK2muee/FEafAtJNNzUbE4hhnXCqIcV5k2JnY5/J4B/T9HhnKCpqggBk72mVyvN5Pt6sdTlkL1mXltLeb9Uq1PwuJSe0NWdJQXeKQQRC5RaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1k9FsZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1k9FsZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93527C4CED5;
	Tue, 12 Nov 2024 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731415844;
	bh=mnfOiE5eIPKtHfBAoGmaq+Twf9102+gLIWoMtZu0bl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1k9FsZkWnzSFQdSuqZTtm74De+U2+fi5KQ9go3TSSh9EmKfhg2x8Hn+cOvRUi6dW
	 IShlat4q6U6iPda++MFYpgkBa4/HiO8fXimkEY8D+sWRoLOfFk/694VpuEH66gWw5A
	 4Adr8RJQCaG3DorphdmKofOi5BKBWE5bepAf0o3Dgx21BQ2ryKL6TsKMvNiC8u0TkR
	 kXvNEF529tO9T+BcKNcFF81h2scalD2x+atDCynMkpmzmiy8CSlI0fUfpKoxD7TrSZ
	 zDh8/772CBWItkKxVkN2xB72B7gftDcwngNwMp0/xn8lwOIQHDxTtzWkpuZN91p6ix
	 Uo9TtZ73dfFnw==
Date: Tue, 12 Nov 2024 13:50:40 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
	sakiiily@aosc.io, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [Regression] wifi problems since tg3 started throwing rcu stall
 warnings
Message-ID: <ZzNPIOR8aaxfrLE2@localhost.localdomain>
References: <b8da4aec-4cca-4eb0-ba87-5f8641aa2ca9@leemhuis.info>
 <ZxjLQzHKuR-w16hF@pavilion.home>
 <2b25a988-6965-48e4-a788-58dd8a776e06@leemhuis.info>
 <e2ffd3d06fad236ea900d4fb439b2240@aosc.io>
 <937c258b-f34c-4f63-949d-a5e7c8db714d@leemhuis.info>
 <ZyyQuTfMMSLwStf_@pavilion.home>
 <a7fc57a1a49b5f710c4354ca21c91dba@aosc.io>
 <Zy4WKKq18GunXa6S@localhost.localdomain>
 <814ca9e3-df3b-45ce-ad36-9659b445c499@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <814ca9e3-df3b-45ce-ad36-9659b445c499@paulmck-laptop>

Le Fri, Nov 08, 2024 at 07:14:41AM -0800, Paul E. McKenney a écrit :
> On Fri, Nov 08, 2024 at 02:46:16PM +0100, Frederic Weisbecker wrote:
> > Le Fri, Nov 08, 2024 at 12:29:40AM +0800, Mingcong Bai a écrit :
> > > Hi Frederic,
> > > 
> > > <snip>
> > > 
> > > > Sorry for the lag, I still don't understand how this specific commit
> > > > can produce this issue. Can you please retry with and without this
> > > > commit
> > > > reverted?
> > > 
> > > Just tested v6.12-rc6 with and without the revert. Without the revert, the
> > > touchpad and the wireless adapter both stopped working, whereas with the
> > > revert, both devices functions as normal.
> > > 
> > > I have attached the dmesg for both kernels below. Unlike the log we got last
> > > time, there is no direct reference to tg3 any more, but the NMI backtrace
> > > still pointed to NetworkManager and net/netlink-related functions (perhaps a
> > > debug kernel would be more helpful?). Here's a snippet:
> > > 
> > > [   10.337720] rcu: INFO: rcu_preempt detected expedited stalls on
> > > CPUs/tasks: { P683 } 21 jiffies s: 781 root: 0x0/T
> > > [   10.339168] rcu: blocking rcu_node structures (internal RCU debug):
> > > [   10.591480] loop0: detected capacity change from 0 to 8
> > > [   11.777733] rcu: INFO: rcu_preempt detected expedited stalls on
> > > CPUs/tasks: { 3-.... } 21 jiffies s: 1077 root: 0x8/.
> > > [   11.779210] rcu: blocking rcu_node structures (internal RCU debug):
> > > [   11.780630] Sending NMI from CPU 1 to CPUs 3:
> > > [   11.780659] NMI backtrace for cpu 3
> > > [   11.780663] CPU: 3 UID: 0 PID: 1027 Comm: NetworkManager Not tainted
> > > 6.12.0-aosc-main #1
> > 
> > Funny, this happens on bootup and no CPU has ever gone offline, so the path
> > modified by this patch shouldn't have been taken. And yet this commit has
> > an influence to the point of reliably triggering that stall.
> > 
> > I'm running off of ideas, Paul any clue?
> 
> Here is one straw to grasp at...
> 
> Is it possible that one of the CPUs had a problem coming online at boot,
> and therefore backed out of the online process, thus appearing to at
> least some of the CPU-hotplug notifiers to have gone offline?

I looked for it in the dmesg and there are indeed rejected CPUs but very early,
before secondary boot-up.

Just in case, Mingcong Bai can you test the following patch without the
revert and see if it triggers something?

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35949ec1f935..b4f8ed8138d3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -5170,6 +5170,7 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	bool needwake;
 
+	WARN_ON_ONCE(1);
 	if (rcu_rdp_is_offloaded(rdp))
 		return;
 


Thanks.

> 
> 							Thanx, Paul
