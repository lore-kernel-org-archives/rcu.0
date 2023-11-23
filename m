Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E04AF71
	for <rcu@vger.kernel.org>; Thu, 23 Nov 2023 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXKJjY2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E95C433C8;
	Thu, 23 Nov 2023 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700762645;
	bh=sa/nTboLB82VKSg+Hj+ux7+4ADWl2DePCUmqbSyIWaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXKJjY2i/tnzFA+0F3lWc3baj5S4XgpWLi+IseofMdPiBu388LrvlzjJbmF150G9L
	 pViHY8ZlE4XSfTshoFIb0FB3iojhYqBvb2fIN8XgHrvQxc3IlsTN6lWESI+IGiGbHI
	 kSzQ5Nk4wdNGgmlUN+20QHo7Lpl4grep7kJrku0/Z5CJ5ZPm4hZWfbyg6UNAkCLQZU
	 t/zz+iR8GfbCI4thGrplRIDBs7dr55jHvKkOQ2d5t7J1nfgT1J4jimD+ZbrojbQS73
	 1ZpVw+js5yweYUxFFXDBh5gO3pO2eyo1l4ERc/VZRsLQ6CFHRjTWVE83u7PrepP/Nx
	 IlBde4jLzLgpQ==
Date: Thu, 23 Nov 2023 19:04:02 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Provide a boot time parameter to enable lazy RCU
Message-ID: <ZV-UEjyjjOHaRVPh@localhost.localdomain>
References: <20231121205304.315146-1-qyousef@layalina.io>
 <811b2157-1009-4339-8ff2-0433512f3094@paulmck-laptop>
 <20231121214415.ovoskvbjarzpxi6e@airbuntu>
 <8ad4e628-7a88-490c-a54d-df09f851f189@paulmck-laptop>
 <20231121221556.vtpmboamgszbt3jf@airbuntu>
 <4ec83bf4-4c56-4f47-8473-151b57b80840@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ec83bf4-4c56-4f47-8473-151b57b80840@paulmck-laptop>

Le Thu, Nov 23, 2023 at 09:42:12AM -0800, Paul E. McKenney a écrit :
> On Tue, Nov 21, 2023 at 10:15:56PM +0000, Qais Yousef wrote:
> > On 11/22/23 15:26, Paul E. McKenney wrote:
> > 
> > > > Either way; I'll follow what the crowd wants too :-)
> > > 
> > > Usually a wise choice.  ;-)
> > > 
> > > But I must defer to the people using it.
> > 
> > >From Android PoV I'd like to be able to boot with default disabled and allow
> > people to opt-in. At least for the time being until we have confidence no one
> > is caught with surprise if this caused unexpected problems.
> > 
> > In the future it might default to on once it gets wider usage and testing.
> > 
> > So having a new Kconfig to DEFAULT_OFF sounds good to me to enable a compile
> > time switch to pick the default with a boot time to further control.
> > 
> > Which would be my plan for v2 unless I hear another suggestion in the coming
> > week (where I hope people would have had a chance to look and think about it).
> 
> Sounds good to me!  Silence will be interpreted as assent.  ;-)

Silence sounds good to me :-)

Thanks.
