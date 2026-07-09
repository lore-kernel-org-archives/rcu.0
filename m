Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC461632E7;
	Thu,  9 Jul 2026 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604004; cv=none; b=MfeuLFZhlAgOxITy1h7bXd+TU8oPtpDocUefdmvyFTaDDRKJqbubfNcTNtdmBGoqK0RHSka7X8abiCRdeoguKPnlY5rS/6nZlqttgU+VTasNh16taDXsrUuE+7nG+LfZQ5tqiQLCV2StXLaBAm9WP1Zn6mTtwrEk1/GYKEj4lW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604004; c=relaxed/simple;
	bh=8rJTXPdceGNh0qX71yw2/S1IiEqiIvPJlELDuZcgpRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeEuJtjLMeafqUy5eR7li8D6wtNjPGZjSHJjHpVg/svNFslUtG2frQz3LysoHCeO2r4kCW3yLMNwCREz78B0A4oMHeFlXFZJq8TreSEoQG0/a1PWQ5NA2xfgQlqT2FZAQSOhw0rlcRMmMkRnp2vmA/PRiF7lIdUS2+YdYm2/PZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu768TT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu768TT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328D61F000E9;
	Thu,  9 Jul 2026 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783604002;
	bh=yCsDvsrSZoRAAUjU6FMk1c3tSIkIQERlVAePzTaLw+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iu768TT6iwWt/s9cVyV2XDy3ZaSaBJVm4FzqRnDLtTxsN4VDJxf32I//3bW1VCAa/
	 ZMZje03n19rNuyudc/xYjJQnasVgvEgOyIahn6C9YD40wswGhHLvevy3LnEbgh0WhF
	 ilVSnZb31rVWsOlXeFB8iekIns9jpzLVy/SKt3sc67XEEG7h1I7sxG75SxTm/MJMpL
	 tR7sms07CRcdaubpH+9HV/cxjZtszWoWY0FfYeZByD3uptQBDxid6/69y4yYBTo3q0
	 f0xLtIed3tlES5OV+BpaAQbWMsb4nhzYtGngVpt3B2dsdG30gbHC0oKft9digzrqXc
	 0W+16/Z+Bo8QA==
Date: Thu, 9 Jul 2026 15:33:20 +0200
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
Subject: Re: [PATCH v1 04/11] rcu/segcblist: Track segment grace periods with
 struct rcu_gp_seq
Message-ID: <ak-jIJlsarNzNBDb@localhost.localdomain>
References: <20260624132356.516959-1-puranjay@kernel.org>
 <20260624132356.516959-5-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624132356.516959-5-puranjay@kernel.org>

Le Wed, Jun 24, 2026 at 06:23:46AM -0700, Puranjay Mohan a écrit :
> Change the type of the per-segment ->gp_seq[] array in struct
> rcu_segcblist from unsigned long to struct rcu_gp_seq.  This prepares the
> callback tracking infrastructure to record both normal and expedited
> grace periods per segment.
> 
> The rcu_segcblist_nextgp(), rcu_segcblist_advance(), and
> rcu_segcblist_accelerate() helpers now take a struct rcu_gp_seq * instead
> of an unsigned long, and all callers use the .norm field for comparisons
> and assignments.  The SRCU and Tasks RCU wrappers construct a struct
> rcu_gp_seq with only .norm set and forward to the core helpers.
> 
> No functional change: only the .norm field is used.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
