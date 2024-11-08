Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45841F4FC8;
	Fri,  8 Nov 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078881; cv=none; b=Y2KIGxDqWts8wKb1lX9lXCwA5UpIJ81aVD9gHV2fZVQTHxGeCbNVS1Cj1YfHDZmk+C2+zUmJlVtzonSmcQ3YdQK4ktlCeNEunSdsXsOTEpsPFcdHhR7BKCC/GHr3MFGFXX0jLlnatVTTczW6eaF4bshwcatxeBC6zLEIvk++sFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078881; c=relaxed/simple;
	bh=e/WBFn6CRKQ9dYFlggr5YIMbLvpXIGE7lX/v2YwnbZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzWbYmzhxODLLCI9CPm2NtGYNwPrmKvQmVIoHrzj7eGJ03XS2ajuaG/86JBmE2F5oY+2a+f0FzhaLVrfBCLxU077hpTfng9paet2+1oDkmwLUMlR23cqKlUp/5hNqXWvPuf4OQ0vIA3sNFA9SnRtIJ1XeixpP5F/285RqwIV4lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCztN+Nb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCztN+Nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C6C4CECD;
	Fri,  8 Nov 2024 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731078881;
	bh=e/WBFn6CRKQ9dYFlggr5YIMbLvpXIGE7lX/v2YwnbZw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hCztN+NbNG+V9Tv5AiEI7iS4cmMdVd16lEJGf0vYvfIGWvZg6LgYYccBq7i4J10Kq
	 6zZ/j69lX9zde009X5QFYFJPy8h+tU4xNbkyhQHIm/xwWy0QZ41YlGfks6Dplw5vWd
	 NeGNceDZ8JikH6SLEu3eLXD7nx09lI7WIldmjmzll4Zqq9eTYHBQOsG2P/znmcDYqc
	 aeO/OEfTAgUOpueRIMZTWbjcLh2zZgd+uUqpr/Nn29+kloIzqXpg4gEwBGKI5PyKTk
	 ohg94/oO43gQNZ3hjEBpC/M6b9c7XLD+C4FggwfSrVbifiIh4Ythgjq2bDI24e7252
	 QglEw3NbXsEQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0CD8CCE09E4; Fri,  8 Nov 2024 07:14:41 -0800 (PST)
Date: Fri, 8 Nov 2024 07:14:41 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
	sakiiily@aosc.io, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [Regression] wifi problems since tg3 started throwing rcu stall
 warnings
Message-ID: <814ca9e3-df3b-45ce-ad36-9659b445c499@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b8da4aec-4cca-4eb0-ba87-5f8641aa2ca9@leemhuis.info>
 <ZxjLQzHKuR-w16hF@pavilion.home>
 <2b25a988-6965-48e4-a788-58dd8a776e06@leemhuis.info>
 <e2ffd3d06fad236ea900d4fb439b2240@aosc.io>
 <937c258b-f34c-4f63-949d-a5e7c8db714d@leemhuis.info>
 <ZyyQuTfMMSLwStf_@pavilion.home>
 <a7fc57a1a49b5f710c4354ca21c91dba@aosc.io>
 <Zy4WKKq18GunXa6S@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zy4WKKq18GunXa6S@localhost.localdomain>

On Fri, Nov 08, 2024 at 02:46:16PM +0100, Frederic Weisbecker wrote:
> Le Fri, Nov 08, 2024 at 12:29:40AM +0800, Mingcong Bai a écrit :
> > Hi Frederic,
> > 
> > <snip>
> > 
> > > Sorry for the lag, I still don't understand how this specific commit
> > > can produce this issue. Can you please retry with and without this
> > > commit
> > > reverted?
> > 
> > Just tested v6.12-rc6 with and without the revert. Without the revert, the
> > touchpad and the wireless adapter both stopped working, whereas with the
> > revert, both devices functions as normal.
> > 
> > I have attached the dmesg for both kernels below. Unlike the log we got last
> > time, there is no direct reference to tg3 any more, but the NMI backtrace
> > still pointed to NetworkManager and net/netlink-related functions (perhaps a
> > debug kernel would be more helpful?). Here's a snippet:
> > 
> > [   10.337720] rcu: INFO: rcu_preempt detected expedited stalls on
> > CPUs/tasks: { P683 } 21 jiffies s: 781 root: 0x0/T
> > [   10.339168] rcu: blocking rcu_node structures (internal RCU debug):
> > [   10.591480] loop0: detected capacity change from 0 to 8
> > [   11.777733] rcu: INFO: rcu_preempt detected expedited stalls on
> > CPUs/tasks: { 3-.... } 21 jiffies s: 1077 root: 0x8/.
> > [   11.779210] rcu: blocking rcu_node structures (internal RCU debug):
> > [   11.780630] Sending NMI from CPU 1 to CPUs 3:
> > [   11.780659] NMI backtrace for cpu 3
> > [   11.780663] CPU: 3 UID: 0 PID: 1027 Comm: NetworkManager Not tainted
> > 6.12.0-aosc-main #1
> 
> Funny, this happens on bootup and no CPU has ever gone offline, so the path
> modified by this patch shouldn't have been taken. And yet this commit has
> an influence to the point of reliably triggering that stall.
> 
> I'm running off of ideas, Paul any clue?

Here is one straw to grasp at...

Is it possible that one of the CPUs had a problem coming online at boot,
and therefore backed out of the online process, thus appearing to at
least some of the CPU-hotplug notifiers to have gone offline?

							Thanx, Paul
