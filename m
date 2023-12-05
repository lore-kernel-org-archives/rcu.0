Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4286FCDA
	for <rcu@vger.kernel.org>; Tue,  5 Dec 2023 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVNG/uEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B34C433C8;
	Tue,  5 Dec 2023 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701813666;
	bh=3oc7m0TW9vs6E4ZG1Whu8Y/db6CQ79nhN1Ql18OdrjI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oVNG/uEbLQH1jBzUH0nrTz6FaSVMGQACN+x7r2qwEoxjkAGpTKKsa3WfiH9ivukiP
	 s5qVpR9W7TqoMCFrqV3XNUQ+PYQABXGUQXuzNySMkLfrt9pNet6LJsB3jDn/df0D3L
	 /pzAxB1PT93/EJC4M1z/FoLUsKlSX3gBj7XVfYY55T4yFaFmxrSSn/cs86TAKumiSp
	 fzTH21gtNBZN/x0Ihe+OCifoc4IDfm2SDAIIm3btjVZEKQxpeJBIwmr3PU33fkaWJq
	 9yQr6fC3S0wdTCLyi1aVLJUlC+b/djsSF7WpIelmWWLZu+xdEJ/neUMU3RV8m1o3NC
	 Zb1+y19hA2HSA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 03DC3CE10B6; Tue,  5 Dec 2023 14:01:06 -0800 (PST)
Date: Tue, 5 Dec 2023 14:01:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RCU] rcu_tasks_trace_qs(): trc_reader_special.b.need_qs value
 incorrect likely()?
Message-ID: <770fa784-d9cd-456c-b651-221c485a65ea@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231201154932.468d088b@gandalf.local.home>
 <b0772bf3-5b47-4aea-b964-17a2bebc6313@paulmck-laptop>
 <20231202184507.26178c17@rorschach.local.home>
 <20231205155927.4b3b9151@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205155927.4b3b9151@gandalf.local.home>

On Tue, Dec 05, 2023 at 03:59:27PM -0500, Steven Rostedt wrote:
> On Sat, 2 Dec 2023 18:45:07 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 2 Dec 2023 14:24:26 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > > Note, the unlikely tracing is running on my production server v6.6.3.
> > > > 
> > > > The above trace is from my test box with latest Linus's tree.    
> > > 
> > > Nice tool!!!  
> > 
> > Thanks! It's only been in the kernel since 2008 ;-)
> > 
> >   1f0d69a9fc815 ("tracing: profile likely and unlikely annotations")
> > 
> > > 
> > > My kneejerk reaction is that that condition is suboptimal.  Does the 
> > > (untested) patch below help things?  
> > 
> > I'll give it a try on Monday.
> > 
> 
> This looks to have caused a difference. Although there's other RCU
> functions that need dealing with, but that's for when I have time to
> analyze all the places that have bad annotations.
> 
> 
> Anyway:
> 
>  correct incorrect  %        Function                  File              Line
>  ------- ---------  -        --------                  ----              ----
>  [..]
>    17924        0   0 rcu_softirq_qs                 tree.c               247
> 
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you very much, and I will apply this on my next rebase.

One of the disadvantages of userspace-free rcutorture testing...

							Thanx, Paul
