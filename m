Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F27260D;
	Fri, 16 Jan 2026 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768603749; cv=none; b=QE1ZjJoLk4BKEabeEOZRgVQoFBD173y7F/c2QQV1jRqneHp6NnL0U822skGPlCLDoVpyJCppc7gxUtQAGHEi486ZOo7CE6QKAtAgTPOrI4tOcoEg+HxHbyyp3S75v+ZsyIfnUbKQ1YMMIBHZ4eB8rvyiIqaR6WZvWVByeiNd6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768603749; c=relaxed/simple;
	bh=l7ZbjyWM2CQvlCjIv/R0dDAA05h4M09DYS5TvSegRSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzcvUQnSk+SoyvhkyD6GHhqIxHr86EUT7caE103T33tuNPi5OxMAoe2JCN5UQ9ZXl3NUFx2ML7J+dDLxcSFIPF5hJGMDKB8pwIjCyO6BuJQuH5T24LdUCmCUDtv221JdhZnT6KmD/fY+LX+J78b2aWifrxGrh4QfbU92V7g7dr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quymhSbN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quymhSbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48720C116C6;
	Fri, 16 Jan 2026 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768603748;
	bh=l7ZbjyWM2CQvlCjIv/R0dDAA05h4M09DYS5TvSegRSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quymhSbNgEAVtloQ+TcIiZhAzlgbfbQ+/m1MGYCnutq+HXRqVc91P4mhUWcxSxN5S
	 iBeTkFOI9o8P2f9UqoANZNk6NOneV8NMqaMbiXnlpKtWV9oDpIaBw8S4CfHoli8MXt
	 RDYFBmQqvbaJ6FWQ1bF1Z37OFzXJ6RRdgXeBPy++PkEoLmKJJKwAnWkZvq706d9zGc
	 u7IA3PWfoScIW9cN0Fv9OLZ71UNeW8EkCcPUoxgtDeiXWVKiwck6NjJyVFY4tCH1F0
	 wcD3IRbuCxoR3aVQWXMwS9KyekrAvDRFvuj2J4R0M1/KLGPXvQKY3fZVBLGttqBUka
	 FG6tI8hLkB+AQ==
Date: Fri, 16 Jan 2026 23:49:05 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v2 4/4] rcu/nocb: Extract
 nocb_defer_wakeup_cancel() helper
Message-ID: <aWrAYTgIGZUbLA0Y@pavilion.home>
References: <20260114173154.1701056-1-joelagnelf@nvidia.com>
 <20260114173154.1701056-5-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114173154.1701056-5-joelagnelf@nvidia.com>

Le Wed, Jan 14, 2026 at 12:31:54PM -0500, Joel Fernandes a écrit :
> The pattern of checking nocb_defer_wakeup and deleting the timer is
> duplicated in __wake_nocb_gp() and nocb_gp_wait(). Extract this into a
> common helper function nocb_defer_wakeup_cancel().
> 
> This removes code duplication and makes it easier to maintain.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
