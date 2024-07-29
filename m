Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E17CF39;
	Mon, 29 Jul 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220984; cv=none; b=Kd+Ndtq7JVOPSo6L+CT2KOgaMQb3r71b2NUGffMrXyTxT/q4Hrn1deOhC7rlYUVw4cEc6BhY6/sMwAhna4WgeuoofaS9eOFeAHB33VT5R/vaouGdhyJIuCcWy1LTqpGTQDTpWY6looUZQzylxxSan1XEHu6PAGJGywLxCDMeguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220984; c=relaxed/simple;
	bh=/J9X9cTXpjkzJ4gmht/FCGx5HSMtviqHuUp+nsPY85Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2h23Gk6mVTzqq7OhnC8qD1THVmcTklRZB3COw9keiH0iybOQeCqZ3FyUQFadGcuMTvkb6jdNvGLvV/H+yh+cg2tp4/aTZBdZTY2CkBOc0PsiG+zPV6f9TSMr9z4sZVJXIB8Ly6gKUjd6QxUXu5g7YVML8CDg1VA4Hu77k5fHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh2HE0f4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh2HE0f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77537C116B1;
	Mon, 29 Jul 2024 02:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722220982;
	bh=/J9X9cTXpjkzJ4gmht/FCGx5HSMtviqHuUp+nsPY85Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hh2HE0f4BHMHgxqCfvVLysy51EM/iwDRQltyxUTYukRmx09SoMv1sxWeHQpvIi4b7
	 aX25vVS/BlcJS1VoT4Obd3U0SjQ1eYW2Agk8SnCvP1y2B681aO+2cpfhnZQDrJGZh5
	 7rPLGE+wdpUcfkk80bJjFCC2pH7g7c9hurm/MQsSoAl220Oan7og5QGdstJ6eCDS41
	 gOodgxQsZZQ+m00Cp4d0gf2XxJ7qKJY2A+bDVpZKsljIQqJKM94rsKBpSkwJZ4gUUz
	 uN9tPSl0uTYXO/YU3zVkWys1rsAjSqIRFd6DHreulSc0/qMvp0+TUm2qC8tr0nl96J
	 2kBHw5ozp6dtA==
Date: Mon, 29 Jul 2024 08:12:55 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [PATCH v3 00/25] context_tracking, rcu: Spring cleaning of
 dynticks references
Message-ID: <20240729024255.GA210579@neeraj.linux>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240725152212.GA927726@neeraj.linux>
 <xhsmhed7gciye.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhed7gciye.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Jul 26, 2024 at 04:43:21PM +0200, Valentin Schneider wrote:
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
> >
> 
> FYI I've stashed what will be v4 at the below, based on rcu.2024.07.12a:
> 
> https://gitlab.com/vschneid/linux.git -b redhat/isolirq/defer/v3-rcu-v4

Thanks!

- Neeraj

> 
