Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB722F8EBD;
	Thu,  7 May 2026 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189984; cv=none; b=VP6I3p5XnvCQd2Lp/1I3wWV0KXA0kHsRyrFHGo7E6lSaFEHNM4AoXR3KlzlpUVYAvhv/kWnS9+UlnSn+piKc7MoAiB/sY+lyro7d225lV7GTaUlCZ4DblRUoz6CEfNtpbaPa03OZxMQup3+Q4Zm5WbNF8G0ZM+g+cfq2vnuNdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189984; c=relaxed/simple;
	bh=/lteh37gFrcehzIfySkddYhObpzN3Kh7rgRZtnS3fSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCr1XlP3nFzzRSb5yX5bnvJZLOY4gqcY+Yp336rYtPBdnY1yQcoxPo5oL6YMCYtOZB4N+bUnUTolJhsqN4Qj8SRb9IUrM884uYaGFzgEgYGV3teIrlYXAhZ6oppQDpgnyZul96io2JnAjeQ/YSOLK/ID7DNsLaYMakGwo0nbI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5NiLGTX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5NiLGTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AB8C2BCB2;
	Thu,  7 May 2026 21:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778189984;
	bh=/lteh37gFrcehzIfySkddYhObpzN3Kh7rgRZtnS3fSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5NiLGTX00uOl4BSim7PGAWnDNBOPMloqxlb8qjqPfZlKRlshwR+qjE2M4CKcDQNT
	 B0nMVXcm/E2cmsZWWXj3VEFuIcW5UDcI20MaIPrssdvpcKspe04l1YDqreFhREjXXg
	 VV7HqZSU412PI2aOlvXX94wOQdmSb/LLue+ewk9pbXRvvXe47LBQ2WvEWfeos515HQ
	 bh6zIp3MoXkYMILGopvdEQ6ioQp3qT+G5NKZ+Z/gLeaw02vJ7gvdCiaijbGpyrcOaX
	 Vt8vwGsGG0PJTl68zcDJ7uEtDrqrEXeQbUL5RW58SmTFhA/dy4PRHFc5nOoOTMNJXt
	 IgC6ChnlVR5IA==
Date: Thu, 7 May 2026 11:39:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Message-ID: <af0Gn47y1Lj2BAqd@slm.duckdns.org>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
 <20260504161543.674488-3-yphbchou0911@gmail.com>
 <c402160a-dbc6-4292-a684-395a80d677d4@paulmck-laptop>
 <20260505154006.G743b@cchengyang.duckdns.org>
 <afmrgVdEHKF0FbNs@slm.duckdns.org>
 <20260506181409.Gc6e5@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506181409.Gc6e5@cchengyang.duckdns.org>

On Wed, May 06, 2026 at 06:18:11PM +0800, Cheng-Yang Chou wrote:
> Hi Tejun,
> 
> On Mon, May 04, 2026 at 10:34:09PM -1000, Tejun Heo wrote:
> > On Tue, May 05, 2026 at 04:20:25PM +0800, Cheng-Yang Chou wrote:
> > We carry only one cpu in exit_info but we can easily dump the cpumask and
> > prioritize dumping all the cpus in the mask.
> 
> To confirm: are you suggesting scx_rcu_cpu_stall() take a cpumask, use
> cpumask_first() for exit_cpu, and dump the full mask in the exit message?

Yes.

Thanks.

-- 
tejun
