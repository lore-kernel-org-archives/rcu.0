Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBC3DD526;
	Tue, 19 May 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177177; cv=none; b=chL1sPdQ0p7qGYdDzrkuahDrzDqt2ngwZznad/b8p0qSQt6FZgNXS45pCAnpdFAI9OdykaW18WmKnSg2KuZef4ALnUMhrui3SO8Ilxzrs/hh2Mxp4G1Df6oo1i7+tpKBGfeWSiCJ14a+58W5Pwb9T4fuC3o9PcX9Aif6DPyJQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177177; c=relaxed/simple;
	bh=Y4Pfi131QEGx2U1d21Xv/Ynq6wBAvSNPx6ruKbBI9ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV3N7sbEU8qAX1B6KRyN1qJB/pVf00PXsrlGpMya8IQ27V1yHBzx42bZ9aupjhCSKfJaQP4GlcCj4kER5xgEjeARoSTAyO0RFVx/HmarKWeDA5X22Dbv9IsZNhMnQfjL6mOkSw9MtQbpFJmK8RqB2/kyhoiqyMVO5YkJE8yXpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBcSUizj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBcSUizj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C745C2BCB3;
	Tue, 19 May 2026 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779177177;
	bh=Y4Pfi131QEGx2U1d21Xv/Ynq6wBAvSNPx6ruKbBI9ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBcSUizjIbBWkl56BaY8YjNJKCqgY7Iem7s46etiALvjzAUukC2xyvJv8nC1p9uHf
	 Ntm0i0Dby4XROP1I3F5dEQVZ/5XNsOuEoAbUJ/NhGvI4+L0/keNBPC2/beyaRlZIL+
	 55u0/gCLWkXecNCRb7Amx2w8gm107jNNdvqGmheP8NxhdTprWVm54ul9beTO1J7QeZ
	 R+FXoqz5QYj8PfNcLnRWedrIUrRqa2OoQuoXKkG/zjzU6t4gpl0uBJE3b+7ovpK47e
	 HggSyk4jgBCpQyewEr3Xmzolzk8sxfXhmzkJKSfddw1jBO7j659MSNEdRIxHC37T22
	 tf15kdCFrv3jA==
Date: Mon, 18 May 2026 21:52:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <agwW2PET7rOcL_87@slm.duckdns.org>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
 <20260518131311.1170786-3-yphbchou0911@gmail.com>
 <agtoyycMdwatAiFc@slm.duckdns.org>
 <20260519152904.G1f99@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519152904.G1f99@cchengyang.duckdns.org>

On Tue, May 19, 2026 at 03:43:45PM +0800, Cheng-Yang Chou wrote:
> Hi Tejun,
> 
> On Mon, May 18, 2026 at 09:30:19AM -1000, Tejun Heo wrote:
> > On Mon, May 18, 2026 at 09:11:49PM +0800, Cheng-Yang Chou wrote:
> > > +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
> > >  {
> > > -	return handle_lockup(-1, "RCU CPU stall detected!");
> > > +	int exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> > > +
> > > +	return handle_lockup(exit_cpu, "RCU CPU stall on CPUs (%*pbl)",
> > > +			     cpumask_pr_args(stalled_mask));
> > 
> > Wouldn't you want to pipe this down so that you can prioritize all stalled
> > CPUs when dumping?
> 
> Ahh yes, will add stall_cpus to scx_exit_info, store the full mask
> there, and update scx_dump_state() to dump all stalled CPUs first.

I'm not sure I'd add it to scx_exit_info as that's public interface. Just
pipe it to dump?

Thanks.

-- 
tejun
