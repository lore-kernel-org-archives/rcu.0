Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913917588;
	Thu, 25 Jul 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925899; cv=none; b=MlYWJZm54k6Fl4gm+Qdlx/aysMO0r1+fmc4NV2mXCeGeuVQjnbTIi/M+v62Gq+YIGt8BRELHCbW+QSLaqi8ElB5r4/2Kwbq5Vo/U2GSL/B7khL9HccdikjAxCmmwLtkP+PUvGXx2ueI5Wbu/GP9h4RutL3w45HcM3BSmm+kFFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925899; c=relaxed/simple;
	bh=KxRx72ateMaI4xu7M+ZExqKdzDNiRMXyhKZ1ha9nx6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecp786mtY0PxUXBvl1xpM0ClOJanWDFdAgHlPRUA9FZlKahFUXmhCRZy1rakMVxcKgbuIeFcvjH4aZRGgCGwCV5lY9UcGuA41tnMmyKGoUUSNTh6cBSUiTyc1wYgW7alZ9mDHpE9p2FyFhMLskxCR20UOJHnUIDT980iemeWFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGHa5k/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGHa5k/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB06C116B1;
	Thu, 25 Jul 2024 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721925899;
	bh=KxRx72ateMaI4xu7M+ZExqKdzDNiRMXyhKZ1ha9nx6M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NGHa5k/YUFPEiGX/7TFbP/z4zUlqTF3qDaQpP0nNg0sBHZ2K9+9Gk2Cp5+Ax10O4n
	 NaZhR1YepYdlbeTXqqNR5iDVgdbg1aaGuR733E6Ca2PhFyXKFBrgXzg2UcL/9ZDT+u
	 SyLEksxD7zLunYAgh5o/sooo81t1GDEa4XWr0QAIm4uoSGJ2dHpuhI93v+S1lAoJnD
	 oNDDFvFKzv6/rg5omZAL3TjxO36QxJwTz8xf+Leap+EBpiCxU3MURD/FaiC6iNvbxm
	 jSWWR8HLCWbMaTO9uijTRVjnNCVK6wjQo70ex9ZKDCE6iIQKKF9HzgQ90e0DLOC/DP
	 +4GDcgKRUqxCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E9127CE0ECD; Thu, 25 Jul 2024 09:44:58 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:44:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 00/25] context_tracking, rcu: Spring cleaning of
 dynticks references
Message-ID: <969ccb24-e022-4e8c-805b-cf47c8b15f33@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240725152212.GA927726@neeraj.linux>
 <xhsmh7cd9zc8a.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh7cd9zc8a.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Thu, Jul 25, 2024 at 06:07:49PM +0200, Valentin Schneider wrote:
> On 25/07/24 20:52, Neeraj Upadhyay wrote:
> > On Wed, Jul 24, 2024 at 04:43:00PM +0200, Valentin Schneider wrote:
> >> Git info
> >> ========
> >>
> >> The series is based on rcu/next at:
> >> f395ae346be5 ("Merge branches 'doc.2024.06.06a', 'fixes.2024.06.06a', 'mb.2024.06.03a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a' and 'rcutorture.2024.06.06a' into HEAD")
> >>
> >
> > Hi Valentin,
> >
> > I see that this series is based on paulmck/linux-rcu.git next branch,
> > whereas the RCU tree has moved to shared tree now [1] and the next
> > branch there is pulled for v6.11 (tag: rcu.2024.07.12a). I get merge
> > conflicts while applying it. Can you please rebase?
> 
> My bad, thanks for pointing this out!

Actually my bad, as I haven't done much of anything to inform people of
this change.  Huh.  I do have this LWN RCU API article in preparation,
and that sounds like as good a place to announce this as any.  ;-)

							Thanx, Paul
