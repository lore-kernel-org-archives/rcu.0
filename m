Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB56221721;
	Wed, 29 Oct 2025 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781612; cv=none; b=qeFBfhLspoZC/oPwMktaBqZxB5LG5s0R+T5tCPGDdTQuyNBeBTMMKa0e0DQdQDcBgW3WhH5gUPLA9WlB1bqhfE5JQg+OpnUxLoCGiogFpFR0jPSyt7wQKrKw0J4zvMZ3pYU/aiOtuEXNXc/La4jKCPEuxS7I2mnXgYqEojSmWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781612; c=relaxed/simple;
	bh=d1iPbMS3zcmr2QAHKf7WuL1ymO36RDkrk5+Ar6nKunk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+pfjZZRfz6RUc5ba3Qr6WcWKaY/CJm7YQwze0fzt/88SPLDtl7wF3NlsBDeziBi3ATbXpCe0Jc2envUaQA2j+A4YcLyiFXB6zAs1sqri8fqsQ6Mg8CDqapH9U8DYtI5Zxy6Rx4QHE5unKbD5SL/Hjn15i2mInhRrCPJHpA/0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lmg2/e7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lmg2/e7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417F3C4CEF7;
	Wed, 29 Oct 2025 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761781612;
	bh=d1iPbMS3zcmr2QAHKf7WuL1ymO36RDkrk5+Ar6nKunk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Lmg2/e7C0uDwBEAXKmYstAtAZwqDAnOFwSp/GN1CPl6SI84kMTXvGy2JqssGZNI5u
	 LWSStP8OVSsfCsulzfUaJtu+SGK4sJGaNe3V7CduBiw35jcuT1bUuQY4iIN6twc2RM
	 zRRCOE+9Y2psfYMiobYTC4W2i7X2a9qWQb+dxCFdlluYujQKHJOWH8dLLtMnxyjnwB
	 +na1D7TIQMnkqLe2bYEjb18MJrzHD6wC2/sZClS7yIKTr+zzftICIuZACgyMKdt55K
	 BRkEv02Ysr7IIv9DIR64pUqvzV1kzTOAESQq7L9CxlLagkiwURzKPyyOnGLIJjhisc
	 rCQEPGwG1hkRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B6548CE0C96; Wed, 29 Oct 2025 16:46:51 -0700 (PDT)
Date: Wed, 29 Oct 2025 16:46:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] rcu: Improve comments for RCU_FANOUT and RCU_FANOUT_LEAF
Message-ID: <f2ca1650-0bbc-48fb-a6d9-6c4313325a1a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251023032742.2850029-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023032742.2850029-1-kunwu.chan@linux.dev>

On Thu, Oct 23, 2025 at 11:27:42AM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> The original comments introduced in commit 05c5df31afd1
> ("rcu: Make RCU able to tolerate undefined CONFIG_RCU_FANOUT"),
> contained confusing annotations.
> 
> Specifically, the #else and #endif comments did not clearly reflect
> their corresponding condition blocks, hampering readability.
> 
> Fixes condition branch comments. And adds explicit explanations of
> the overall purpose:
> defining middle/leaf fan-out parameters, their relation to Kconfig,
> and how they shape the RCU hierarchy based on CPU count.
> 
> Make the hierarchical configuration logic of the RCU easier to understand.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Thank you for posting this!  Please see below for some comments.

							Thanx, Paul

> ---
>  include/linux/rcu_node_tree.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rcu_node_tree.h b/include/linux/rcu_node_tree.h
> index 78feb8ba7358..b03c0ce91dec 100644
> --- a/include/linux/rcu_node_tree.h
> +++ b/include/linux/rcu_node_tree.h
> @@ -25,26 +25,34 @@
>  /*
>   * Define shape of hierarchy based on NR_CPUS, CONFIG_RCU_FANOUT, and
>   * CONFIG_RCU_FANOUT_LEAF.
> + * - RCU_FANOUT: Controls fan-out of middle levels in the RCU hierarchy.
> + * - RCU_FANOUT_LEAF: Controls fan-out of the leaf level (directly managing CPUs).
> + *
> + * These parameters are determined by Kconfig options if configured; otherwise,
> + * they use sensible defaults based on system architecture (for RCU_FANOUT)
> + * or a fixed default (for RCU_FANOUT_LEAF).

I have no objections to this change if at least one of my fellow
maintainers is willing to speak up for it and none of the others object
to it.

>   * In theory, it should be possible to add more levels straightforwardly.
>   * In practice, this did work well going from three levels to four.
>   * Of course, your mileage may vary.
>   */
>  
> +/* Define RCU_FANOUT: middle-level fan-out parameter */
>  #ifdef CONFIG_RCU_FANOUT
>  #define RCU_FANOUT CONFIG_RCU_FANOUT
> -#else /* #ifdef CONFIG_RCU_FANOUT */
> +#else /* #ifndef CONFIG_RCU_FANOUT */
>  # ifdef CONFIG_64BIT
>  # define RCU_FANOUT 64
>  # else
>  # define RCU_FANOUT 32
>  # endif
> -#endif /* #else #ifdef CONFIG_RCU_FANOUT */
> +#endif
>  
> +/* Define RCU_FANOUT_LEAF: leaf-level fan-out parameter (manages CPUs directly) */
>  #ifdef CONFIG_RCU_FANOUT_LEAF
>  #define RCU_FANOUT_LEAF CONFIG_RCU_FANOUT_LEAF
> -#else /* #ifdef CONFIG_RCU_FANOUT_LEAF */
> +#else /* #ifndef CONFIG_RCU_FANOUT_LEAF */
>  #define RCU_FANOUT_LEAF 16
> -#endif /* #else #ifdef CONFIG_RCU_FANOUT_LEAF */
> +#endif

But these much stay as they are.  The #else echos the "#if" condition, and
the #endif contains "#else" followed by the "#if" condition.  This means
that you can tell where you are without having to find the matching "#if"
and without having to figure out whether there is an intervening "#else".

>  #define RCU_FANOUT_1	      (RCU_FANOUT_LEAF)
>  #define RCU_FANOUT_2	      (RCU_FANOUT_1 * RCU_FANOUT)
> -- 
> 2.25.1
> 
