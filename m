Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B76304976;
	Mon, 15 Jun 2026 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547249; cv=none; b=Xh2Gc88nk335eGF7pMUKc8wyDE46Z1C0Bndk3KxvDXHiPDaOwefUr8+ucpQtwOcRlHY9mGrCTvLpL+BI4L0asSKvfCJG0jttbQk9CfyzlPT+baRfBsQo8PCj6Npd694SJlMT07quPy1NpiecOM267gQRqy6HzrDRxAYvp7ZFh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547249; c=relaxed/simple;
	bh=L8/d/+b95SP5tRhznNhWbYvRKXBage3BilYwlDX2ysY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnYsdVrUgGDs6wRtG/BEN9rmt0gJ82zWG2rjBCHZ6Z3p3gNp4yxEs8RRpg3YxnAD+7kdtoJ1dR8ck9nViUq9Jh3CD9XReQ2w+yYGAHw936rNKeI6lpwaa0Pe5AWfd0PCmZS0VMCwsln+kmcEnk/Jv13DcUjYaTKRzpxVvlqeFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJHfDUpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJHfDUpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208C91F000E9;
	Mon, 15 Jun 2026 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547248;
	bh=wJgupxJXcy3WMLrGwwYZMiWC4Vv4qui6C3r5kw7PlBE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=kJHfDUpyP8WnItyPRl+SHy8S08gyxXDxtcwaeMa9VkMAEWOrcnuijY2AbpPEunKAq
	 yi8Hvt4KxL/TGqVyP2JgfOUAb0sB+/fuPejKkjL7zjmXqG8R1bAQnVP7Xi9WoXx+1i
	 iEWjedNnhyhw9YDQLnQfKAGsxez1CUv8Xoi+zSh/r6MuO6/2WDxgvFmVA/lcXcvAU/
	 VwiTRhAr/xHG4YrrBGQTup/EWktuiWd5f+urb4xxf8m2kb0dPXvyP7u+VMOVIFKDY3
	 oP0RlTmaIAFAEss53W+Kup/hKVe627fcffiUOmJSVyp3RDtu4wkad4idYiCDCagWEo
	 ohyPPZKSvwnlA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DFFFDCE00F5; Mon, 15 Jun 2026 11:14:07 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:14:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, dave@stgolabs.net,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH v2 0/3] rcu: Improve task-state reporting readability
Message-ID: <b272e69e-1176-4aff-93dc-6af10f7d5743@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260612023414.679618-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612023414.679618-1-kunwu.chan@linux.dev>

On Fri, Jun 12, 2026 at 10:34:11AM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> This series replaces raw hexadecimal task-state values with
> task_state_to_char() output in RCU-related diagnostic messages.
> 
> ---
> Changes in v2:
> - Split the original patch into three commits, one per file.
> - No code changes.

Very good!  I have pulled these in for continued review and testing.

							Thanx, Paul

> v1:
> https://lore.kernel.org/rcu/442e80e0-4f91-421c-ab68-d26e0a031472@paulmck-laptop/
> 
> Based on: linux-rcu repo (dev branch)
> URL: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> base-commit: 85bf11e84 ("smp: Make CSD lock acquisition atomic for debug mode")
> 
> Kunwu Chan (3):
>   rcu: Use task_state_to_char() in stall-warning prints
>   rcutorture: Use task_state_to_char() for task-state reporting
>   hazptrtorture: Use task_state_to_char() for task-state reporting
> 
>  kernel/rcu/hazptrtorture.c |  4 ++--
>  kernel/rcu/rcutorture.c    |  4 ++--
>  kernel/rcu/tree_stall.h    | 12 ++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> -- 
> 2.43.0
> 
