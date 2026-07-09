Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62740BCBB;
	Thu,  9 Jul 2026 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597868; cv=none; b=fu1uQd4yvrmYeb4w9Kv8/pEEg8rEQdaG/zWx4RIKb5TNeziQ8O+kSBbL4bJYEZAULql2g+jpxQk3AfB+CwpVERmLNXycztI67rDtysYvbMN0LSKrYopgOmrjVBHjP+meNTbblrW5u5H6M2HlYVqLnuG0t2+K+qkPomXyvrTwNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597868; c=relaxed/simple;
	bh=umcYS0s7LUqXGoPnpdvS1XiBmxi5V+ZFpZuh1I78PrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT+i33Q5dNfpRxb3rrIchZh6KIm7RFi/yhvS+VRm/UgoNEX4McasKiR7BmnM310156g8MQysBFYm37wQkD6b/0IqeuXjtORv7tEz2Whrj6OEhQUzJxypjJu9DBG9CmlZHyJjxO9h0c1sgnZhN1ZZB2Ht9f0iUDF/EcpzCk51xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ7VYaEV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ7VYaEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8F61F00A3E;
	Thu,  9 Jul 2026 11:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783597867;
	bh=/BgWEU6M85VKTN0seumdRVrl0L8PKkSxsYxRGVTML8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XQ7VYaEVL0rR/p2E7I1g28j1u+GubAEP5VES44W8CX7XlRC+Ab3aeQKfXEBB3ccGf
	 coWAbYMeqLpz2kf/Lw3VuehJX0zkddQsdlVeR5L0/7WtmR/Q5m2HQVL9yI5aX7F77B
	 rQEEEkIHhucG7F7MPZ0MtxXN1mnjDXJtjESJd4PVwWW+xBNlkpE9WBmuggn3a9G7oO
	 MZfnVVFPEagH6HSH8JEKuYYY2UhQto5WGJHEqUCgC/sD0OuQ37665gOeGW3A4fgVk7
	 DSbII2Re093vF5eg+k8E5k85dFFS59LUjQOHE20db/YweEubOEYBWKL9PduEq2ND5I
	 ceMgne/JHb1tg==
Date: Thu, 9 Jul 2026 13:51:04 +0200
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
Subject: Re: [PATCH v1 02/11] rcu/segcblist: Add SRCU and Tasks RCU wrapper
 functions
Message-ID: <ak-LKCzNbGl-oW7R@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-3-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:44AM -0700, Puranjay Mohan a écrit :
> Add srcu_segcblist_advance() and srcu_segcblist_accelerate() wrappers
> that forward to the core rcu_segcblist_advance() and
> rcu_segcblist_accelerate() functions, and switch all SRCU (srcutree.c)
> and Tasks RCU (tasks.h) callers to use these wrappers.
> 
> This isolates SRCU and Tasks RCU from upcoming changes to the core
> advance/accelerate functions, which will switch to struct
> rcu_gp_seq for dual normal/expedited GP tracking. Because SRCU and
> Tasks RCU use only normal GP sequences, their wrappers will maintain the
> existing unsigned long interface.
> 
> No functional change.
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
