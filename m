Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A26C175A9E;
	Wed, 18 Mar 2026 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836155; cv=none; b=fT/iHpOo7FoUdb+V7WlSrcPpHDTwb7iaL+4ea8fmTOnSqh3g8bBFWrWGXFq1JWz6b7FqiMPy47mYWzUAId/XV9XnYPvyrnKNs0isYDQnNFtneYS/q2egTyGKUS3Rc0LcyY3mauKJU50rIefYeSBYHadPdGHZW125adMAobJg1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836155; c=relaxed/simple;
	bh=bYZBdXUTwLeQE771mqpLvYrnyV+1W/J73HWKjG4IlKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BywzjmeDN2iUWctP4yMyRqKT44Bn5ZRkD6vd3q2W1RL2+fp3nH2F3PvA4CSFMY9SEak+kOlX3//VYg1N7XGFuuH1AoqvdJeLbA5stHX/ouLpfPpmXfMo4SG9YIC5cAx9zd5BeiU+q9J6rHK2wExNpTuL+VT5J4g7ItCCe8ZAjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG/DZAOj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG/DZAOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A710DC19421;
	Wed, 18 Mar 2026 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773836155;
	bh=bYZBdXUTwLeQE771mqpLvYrnyV+1W/J73HWKjG4IlKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gG/DZAOjL7JYtxLXWxR+ED8rzejgZH7+9Q+PqZg94SVZ1U3CeWn4NeRTORxcomEv5
	 JHkKbwDhfBt/6+ehjERc0fKxPmAVf7MrMHdVcihrtwSIU+hplDaJeF65vrrWke/fzM
	 60hCChe3CZA6OYZMdZ5MbvGAseGQCMZaBN/Nqv3+DnpPhVJ/j1gBiX3G3Fd3zuS/LQ
	 dXOUK4cNVZtdvucuQMswM8lfvR9Tivq3t4iik+6Ucn5BhekmF3ON7S4KXa2zSuOl80
	 addFKoaql57v4s0EitALiAtfsTw6YvVfe8LOHd8tIadc6l0Ix3e9OIi59DKHueDBoj
	 tlq6fHlEMvMgA==
Date: Wed, 18 Mar 2026 13:15:52 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, rcu@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH -next v1 10/16] rcu-tasks: Document that RCU Tasks Trace
 grace periods now imply RCU grace periods
Message-ID: <abqXeHifOg_hYeY3@localhost.localdomain>
References: <20260317212217.1527644-1-joelagnelf@nvidia.com>
 <20260317212217.1527644-11-joelagnelf@nvidia.com>
 <abqGt2CQCfM4PeqK@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abqGt2CQCfM4PeqK@localhost.localdomain>

Le Wed, Mar 18, 2026 at 12:04:23PM +0100, Frederic Weisbecker a écrit :
> Le Tue, Mar 17, 2026 at 05:22:11PM -0400, Joel Fernandes a écrit :
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Now that RCU Tasks Trace is implemented in terms of SRCU-fast, the fact
> > that each SRCU-fast grace period implies at least two RCU grace periods
> 
> two or one?
> 
> AFAIU srcu_readers_active_idx_check() it's only one?

But as Paul just told me offline, we flip the idx so it's two. Sorry for the noise.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
