Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71D22D4EC;
	Thu,  6 Feb 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835915; cv=none; b=klt40b8cPgwy3M+uozEOpZYMeZfMyXZd1IIAQAVOiZk3KeRGPDPHQUs8Oe/2W8hUbVqweqsmkQL3cUuVPOGfvMhxEpTSezH1NgMf5qa2Cq+t65iEu5HL85VAcY6e7DZ21EgVuUCNCr3BbH4mSbP+XyKxfehP8QVahoGDPEsWTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835915; c=relaxed/simple;
	bh=fJZ5knD00ceYH7HVhwhzARvJoSUI+ycBzjsOjt2tNaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXOn1d5OW6I1pmnQU3wefO5Jcjo0O73v0wsXF7u6i2D6o3AIjKpxzWuvBFZUrvlLT0VrdvtjN/S9WvvybltsNS4QBQJJ+mbDhDoCU1PIrcmR/YEvXKYpy3O84PFnFvhv8Zi8RIrn0sjxdkpbQJkJHxs4eNhZj1ByezhdMU6JQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2qD16d4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2qD16d4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F3C4CEDD;
	Thu,  6 Feb 2025 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738835915;
	bh=fJZ5knD00ceYH7HVhwhzARvJoSUI+ycBzjsOjt2tNaI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=P2qD16d4T9jav2JGdccXG5Yq0og3IAyEn65iJz2EMKkIeQrvciMOcq+Nt8fbeVf6H
	 ESjedLfm2hYGmNapWyYGCOYoDVgpn7QnSLdcTNoWf7qpOcBRwKSNQijbr1sOOOXM/f
	 LZzG03PJTqqCuS8M5RQI4IB0bp0cayRRnd+6mrKgDN8OSCveWlsR8bGB6NZ3HjCbo7
	 peRZPMIBObWMr7vTvR7cDW9LnZKT/2Nks+Y2e+rGFXjv6k4sVLoqAo86WeBy4CHdce
	 wFd7B1Pymlc+8IPzptcshMlahCUJ4y97zMr9RI7o9HbIP/9fCMPEJ6aIDGN4IYMixL
	 aHYJ0Xxug1mFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83854CE0809; Thu,  6 Feb 2025 01:58:34 -0800 (PST)
Date: Thu, 6 Feb 2025 01:58:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2] 4/5] rcu-tasks: Move RCU Tasks self-tests to
 core_initcall()
Message-ID: <e3012763-2242-476e-842c-678ecb1e7622@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop>
 <84pljwi2w0.fsf@jogness.linutronix.de>
 <3a0ceabe-d5a0-4cb3-8343-ec56bc9bd0fd@paulmck-laptop>
 <af84eb57-2da2-461c-82bb-36312bbb49b0@paulmck-laptop>
 <84ed0c1401.fsf@jogness.linutronix.de>
 <efef835a-d2dd-4f03-bb02-c0cf873433e1@paulmck-laptop>
 <841pwc11ae.fsf@jogness.linutronix.de>
 <84y0ykyqf6.fsf@jogness.linutronix.de>
 <2a7774e4-a3fc-48d5-97b0-6f74396e7f93@paulmck-laptop>
 <84ed0bmq9a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ed0bmq9a.fsf@jogness.linutronix.de>

On Thu, Feb 06, 2025 at 09:34:01AM +0106, John Ogness wrote:
> On 2025-02-05, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > commit 35679c18b062368855e183ee6712ca5c16145d8c
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Feb 5 12:27:23 2025 -0800
> >
> >     printk: Flush console log from kernel_power_off()
> >     
> >     Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
> >     and shutdown time, which hides shutdown-time RCU issues from rcutorture.
> >     Therefore, make pr_flush() public and invoke it after then last print
> >     in kernel_power_off().
> >     
> >     [ paulmck: Apply John Ogness feedback. ]
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul
