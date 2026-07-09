Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C10280331;
	Thu,  9 Jul 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603269; cv=none; b=YrbecY79diFTuLEGGgaWeo5/BQcxliOCGaX4O0t3JmzZ9Zoe2h81C4e5YmaFL/ETq6uwHEDMBWPeloUqd5Qh/mBYdk3W7ftZmgUjLBiAH5YQqk00FMQ12SqLCg+ygefYDYPobyFDszuOySDb8fn14x4luI3TXt5jccsiuIOw+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603269; c=relaxed/simple;
	bh=RKmSMB5r6yyfAGHz3AniEGoLvYl2pyESyvNaD1EqqKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fds1NHJTib0CKPMIiXwRiEhOW0qC3gVrOJK7tYr0hiWDoeoJ/WgJuFLTAO2X6hSY+eYFRdXNDpKj4LY1RptYKE7/nwkgO2NojYUfnZVa3f+LQ5Wo3MB4cPulL3uLWNa4NKWRYi9/J+Laa9L4ySPlI0tQMm9p93Jv0aOnGbj1Lkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1yULooy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1yULooy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7242A1F000E9;
	Thu,  9 Jul 2026 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783603268;
	bh=44xeEcsdBWTa9yg7vkPk2k3o4MOa5JK7uo4IQVKQNNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e1yULooydQQIMjxTGqffDLm9wv9csrV7PduwLazHfVC2FEAB+BUd+KXGks0Fyn22M
	 /GcHoDxll21qRB4zkt84fvNnT/wVLUlVzCberbfplYeKGlS6KChjvBR9J4xu9PKNw+
	 B2JjQZoFPydiNs5LEzsbAuJzB4umz6E/j/3ta0gAnxFHsSLgrtXB48w3RevK7gkGw7
	 Ax+swIO33B6gUoQHkXw621TKVMzqLFbOY7/zNeM7T2tQL4Ffz+A6nrMmIo6yQn68Vt
	 goR+lZeeiD5JBoDL9C3qUKDmA9iFGjdD9q6VeAow0IV0WXPLLGlmhZS2Nyzs1vB4v+
	 mrOqEtiOQ/yNw==
Date: Thu, 9 Jul 2026 15:21:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v1 03/11] rcu/segcblist: Factor out
 rcu_segcblist_advance_compact() helper
Message-ID: <ak-gQQgMHLZOyU7D@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-4-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:45AM -0700, Puranjay Mohan a écrit :
> This commit extracts the tail-pointer cleanup and segment compaction
> logic from rcu_segcblist_advance() into a new static helper function,
> rcu_segcblist_advance_compact(). This shared logic will be reused by the
> upcoming srcu_segcblist_advance() standalone implementation, which
> cannot call the core rcu_segcblist_advance() because that function will
> use RCU-specific globals.
> 
> No functional change.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
