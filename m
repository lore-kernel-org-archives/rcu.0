Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C52E2EF9;
	Tue,  5 May 2026 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970051; cv=none; b=AdQoVobuUNhyDTZsYdvkRaXMZGVnkgLKtcdOxvDPZUMt2Inr2aSCptJ2fgiZe6DWg5FPgEnXHIh/p/0aRhzrrWa8tumftgNr+vsp2PswdDK0T4Lui3WpYA9TNxZ5uif2Gh2Ui9L3rZ8gW1a+6xP7Cb0ZdmgAS72OBD4MrggxhVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970051; c=relaxed/simple;
	bh=iL+883R5Q+9exYJqHmeU+iQbjaHoADuS/Lv6ELMcyHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOKn9onGmtjJNFHihml1OEPNyakCrV55e3HIQrS20AMzPN8JufaAD4Uxrw4wJ/Q+XEhbvOo6bpGcGwAEBZpcOwx7zhXYDLnOP6e0flC57st3myT4xTNCC2uCH7oZZlBHGaS0uBY5T0hQkV6y/sorHgCbEn6P1x1dc4vfwK3ZC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYshelks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYshelks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC3C2BCB9;
	Tue,  5 May 2026 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777970050;
	bh=iL+883R5Q+9exYJqHmeU+iQbjaHoADuS/Lv6ELMcyHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYshelkspeco3aIqm6NbDNeOeatT3S0h7zW/nZO7PwW9rSSUHIMIV0xmA+1a2GES9
	 U2T78a4yYwv9I+SA5A9oRBQl5cfaMIXCQQluMf9pXhqMo4RrifQwSXZYNWwnQTIaw9
	 eV1k6qzep2gq8WnXilM54wRBOaf8sLLuaDvPg6XitdBo+jYu+sSe4KvGskzrTEPh65
	 02y/5j/KKKlHOrKwwvgolCFXjxDFtx62YNq20qzrad9gdgQKrkpuK4LzRmtr6ulX/a
	 0G2cMmxmzTgAT9YsM4eqSo5N9/Uh0ld7ERHm1qiY5+8NWFxzvUG4sRh4rDHljzL5O/
	 NTXobAShl0UNQ==
Date: Mon, 4 May 2026 22:34:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Message-ID: <afmrgVdEHKF0FbNs@slm.duckdns.org>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
 <20260504161543.674488-3-yphbchou0911@gmail.com>
 <c402160a-dbc6-4292-a684-395a80d677d4@paulmck-laptop>
 <20260505154006.G743b@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505154006.G743b@cchengyang.duckdns.org>

On Tue, May 05, 2026 at 04:20:25PM +0800, Cheng-Yang Chou wrote:
...
> > There might be more than one stalled CPU.  You could pass in a cpumask_t
> > or similar to print all of them, or take the first or the last or
> > some such.
> 
> sched_ext's exit_info carries a single s32 exit_cpu, so we can only
> record one CPU. Would taking the first stalled CPU be acceptable as a 
> best-effort hint, or would you prefer we pass -1 and skip the CPU field
> entirely for the RCU stall paths?

We carry only one cpu in exit_info but we can easily dump the cpumask and
prioritize dumping all the cpus in the mask.

Thanks.

-- 
tejun
