Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017EA390234;
	Mon, 18 May 2026 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132621; cv=none; b=grtRLgv4bkHVwU7rDvEA+W1LsgY6n2q/imQSX0iS8VdVMGGigvKfyEhjNn9smrUUR/EOJ7sDTsvpQ88UF23bVj6Vo3mF0qiQFNZn96g1gMrgUzqGjE/eoF8PunoQSLXgzjFOn0avEcOUsCfIMHJ6XpDw+X3fyXLIdup14qpVTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132621; c=relaxed/simple;
	bh=rVbWO/Hq0lQC5ldOAFBGDcMSk5719URhA8XsJZ/v0xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toXScaVNVOdOduzUnyMP4OxhdyUyIKoSPRjOOerS50Ik4SXeHeZtQ/1xDex3OubhSTl4QhlqgB51Z79hF8a+tlXNIvBCWdOTwUfNo3j8A59RmCsEMRTOKhHsnbFf4gCra7iCLx1wnMs6aM4aWLCHMte79BUDk9UF3RT5IA3t5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE6coFqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE6coFqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB0C2BCF6;
	Mon, 18 May 2026 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132620;
	bh=rVbWO/Hq0lQC5ldOAFBGDcMSk5719URhA8XsJZ/v0xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NE6coFqOIIw6kh92Klply41Z7rPAmmJi3sty5BvQeOTCKoBHKo7K0I26BFlA/WOzu
	 hy/x0r7KKdg2i2yRmtGcMc6oWY43B9zN/TkX3vAh5+CyS+XMl1jbb0RDlI9JdjCXZ3
	 e1iLesMy0DxjTq9VqP6E/3f85kMtra7ph9KYABKEwT6aRbZmw2JRfQZFA+rK2hqNVo
	 k+5WPm0uthFNX7Latmu1BiIyx2jzlUh5tbbNaU2hbMOZHhoCk/+h155HQSFlOAcZ7W
	 NEFHxUybuL+Qs9ddhkDRw9Yi53VMN2W+NYL/+q7RBiXcm19UH2sX9039UAizflQr0q
	 yy0g13O453YzA==
Date: Mon, 18 May 2026 09:30:19 -1000
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
Message-ID: <agtoyycMdwatAiFc@slm.duckdns.org>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
 <20260518131311.1170786-3-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518131311.1170786-3-yphbchou0911@gmail.com>

On Mon, May 18, 2026 at 09:11:49PM +0800, Cheng-Yang Chou wrote:
> +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
>  {
> -	return handle_lockup(-1, "RCU CPU stall detected!");
> +	int exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> +
> +	return handle_lockup(exit_cpu, "RCU CPU stall on CPUs (%*pbl)",
> +			     cpumask_pr_args(stalled_mask));

Wouldn't you want to pipe this down so that you can prioritize all stalled
CPUs when dumping?

Thanks.

-- 
tejun
