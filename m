Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A107B3FD;
	Wed,  8 May 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165209; cv=none; b=jtq4INf5Y6rTzgllMi0jwlsRzEwoszy3OKa0trKoZc1EOdS2rg5m0HnIE0ePrMelE7dnQCAOaaL31cTxX3q4ydTbFyXJNTCTZXOLUzNCXGqO96B3HQDqpqI8QnzwgE8SEFE5LgSH2oarHwFINNIvmWN5TTmWlIYFZnPoiMVobcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165209; c=relaxed/simple;
	bh=Z00YMdAglgEZkAiou630en9bCthfc63+DSDxO/Ruiec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrWTIFJsREhRSsDn8w6PHLPmkB4SxuWd1od3Z277Qv/SyhuKJY+RRbGTFO8rVVkrrW4T41YdYt+HIB8ESacevWG7p6EyBA8exPz1Qw/GO0aPWPX4lIWWVT8+FPBGGhoFPKNj4owpRFRWLoPdQHOOgRBqcEHdA6+W93cRN3Z/bUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzvgD9XB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzvgD9XB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA8BC113CC;
	Wed,  8 May 2024 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715165209;
	bh=Z00YMdAglgEZkAiou630en9bCthfc63+DSDxO/Ruiec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzvgD9XBXwxg2y4Wq5EK0VwSa9QkJLBEIxZBYBDPJr+ObyM1aZytNk6UpZdJJLPIw
	 OB7t/LNNfskMdmb/hRr7xPC5+AYqp9Km8DTvwixubv0wovCu+rpCKZ7Cx1iYS5tpgp
	 IjqyYsIj0pvZGGTfoTXpuQAHBCVebas45b0a6CneS0UZ7e1PIQzqBwOaC2uED+tSZR
	 ReXK2hirK5Pjr2vwnYUcQ4SxX52kNSVWP9LHRtMHhP02mq+OeJnjTshguLg8Uv4hmr
	 C+HAAGn5GW1IDSLAYP7QAqLUGro91L94GpmWsH/ZGJxckDN7rIglOyTpPo2/nyixxs
	 VGRToiQ53QIJQ==
Date: Wed, 8 May 2024 12:46:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 17/27] rcu: Rename rcu_dynticks_in_eqs() into
 rcu_watching_in_eqs()
Message-ID: <ZjtYFsRz_qX_CzMZ@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-18-vschneid@redhat.com>
 <ZjotdJwp3RXkrA7S@localhost.localdomain>
 <xhsmh34qtipxf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmh34qtipxf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Tue, May 07, 2024 at 05:48:12PM +0200, Valentin Schneider a écrit :
> On 07/05/24 15:32, Frederic Weisbecker wrote:
> > Le Tue, Apr 30, 2024 at 11:17:21AM +0200, Valentin Schneider a écrit :
> >> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> >> RCU_WATCHING, reflect that change in the related helpers.
> >>
> >> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> >> ---
> >>  kernel/rcu/tree.c       | 8 ++++----
> >>  kernel/rcu/tree_exp.h   | 2 +-
> >>  kernel/rcu/tree_stall.h | 2 +-
> >>  3 files changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 857c2565efeac..d772755ccd564 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -308,9 +308,9 @@ static int rcu_watching_snap(int cpu)
> >>
> >>  /*
> >>   * Return true if the snapshot returned from rcu_watching_snap()
> >> - * indicates that RCU is in an extended quiescent state.
> >> + * indicates that RCU in an extended quiescent state (not watching).
> >
> > *is in
> >
> 
> Oh, thanks!
> 
> >>   */
> >> -static bool rcu_dynticks_in_eqs(int snap)
> >> +static bool rcu_watching_in_eqs(int snap)
> >
> > I would be tempted to propose rcu_watching_snap_in_eqs() but the
> > purpose is not to dissuade people from intoning RCU code after all.
> >
> 
> I've struggled with finding something sensible for the snapshot helpers; I
> think I prefer your suggestion, that way we can have a common prefix for
> all snapshot-related helpers. Also I keep reading rcu_watching_in_eqs() as
> "is RCU watching while being in EQS?" which is nonsense.

Works for me!

Thanks.

> 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
