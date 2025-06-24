Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C3201032;
	Tue, 24 Jun 2025 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806371; cv=none; b=fQQKG5zy5o6CPT/NYWC1kZ2HVHXIb3/lq/eTm1rO590cvS0rzqS6h4oznn2WEusvoXvTZsCFpB63LWRNVFxf4fy52qSpE08ESeVLrHGQu9AUq8a1vAvNJry5GtZv5shvdbfG4MHZjTa0ZWOGFdqFPcGkn6vRjN/fRuVU2vAAjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806371; c=relaxed/simple;
	bh=ZKeAJqTicUmLnXLiLwvAD4i7tFLvu3JVM5VvufIaisk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DABSJtv6aHLN+NMHjQTuCRPra9AUG4zy9Kj0xvKdC0YYV5DcI0o5VeEfJ+ZcHTi+Dg2EKPe5casxmvnmf+UElUoaIMue0Ot+pMSSdokw/1Afi6sPbWAvAfbxw1Xbr4Bh6BTn3CV3GTu5oiBBJX20D6vQW8ElZfqoIRDarUfRlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS6bMEsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS6bMEsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C773C4CEF0;
	Tue, 24 Jun 2025 23:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750806371;
	bh=ZKeAJqTicUmLnXLiLwvAD4i7tFLvu3JVM5VvufIaisk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dS6bMEsprGQPy3kIieYd4bXhAoluCQiXpR1pqq0PofDMEvyIMROU5lCabyLhhgBqc
	 BAjAdY+BGcsuwoTejgAcMlvkPqKxe5U3fLjV5Z2dZGOZ2TAdd7XAdLnJQapYjBUakM
	 mxhSyAdmVMf0kAlu5h1TizswVLplzTamogu/8Cotc3Y2N+ShU55THG/zJw5KHtMXr8
	 Xwt+zB8GpQdctCBqJbAgW3nNn4DeMoCSm3BJ8KY2dGBeJapU9LHz0e4my7V+CRb3I9
	 YQoFcdlW9ai9I+4wf0N5YsmVOsVgEZpN9nwnRYC4FT/QvtS3wa3HlikLmCfPLb/gWv
	 uOMDu51vbBC8A==
Date: Tue, 24 Jun 2025 13:06:10 -1000
From: Tejun Heo <tj@kernel.org>
To: David Dai <david.dai@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	paulmck@kernel.org, davidai@meta.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] sched_ext, rcu: Eject BPF scheduler on RCU CPU stall
 panic
Message-ID: <aFsvYhPTIyQWSFmL@slm.duckdns.org>
References: <20250624224906.3662221-1-david.dai@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624224906.3662221-1-david.dai@linux.dev>

On Tue, Jun 24, 2025 at 03:49:06PM -0700, David Dai wrote:
> For systems using a sched_ext scheduler and has panic_on_rcu_stall
> enabled, try kicking out the current scheduler before issuing a panic.
> 
> While there are numerous reasons for RCU CPU stalls that are not
> directly attributed to the scheduler, deferring the panic gives
> sched_ext an opportunity to provide additional debug info when ejecting
> the current scheduler. Also, handling the event more gracefully allows
> us to potentially recover the system instead of incurring additional
> down time.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: David Dai <david.dai@linux.dev>

Applied to sched_ext/for-6.17.

Thanks.

-- 
tejun
