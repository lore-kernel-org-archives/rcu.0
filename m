Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08B23ED41
	for <rcu@vger.kernel.org>; Tue, 10 Dec 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856744; cv=none; b=BoxELDWZKRYolrmKUx+6b1HUo8yogT4pwZtb34hKwfMixiwbyfpakzXQBYGfHsCVXambEehvKOw0f23HoL/lPvIBFR6r58nu0qt3LjlZtTIaepY0aLWz3Kqtlh/BGr0FU3WpwSHqLQ6sNfzQFMSFUCpv9F11XmXcddOEZ4vB5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856744; c=relaxed/simple;
	bh=Jae+gkX8xGuMfiRgBk7ZjZNz1o0dED5BNGeq84xAduo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqfCM9kLvvXfhDJ5GZopV+/V5Ge+OSejAmduXdoGxQX80b/AKPBsZ6vk2/qIrXpOOQCut195YXmMB4b7m4RAmulXUIsPnbT9VzD7NJiqCjNj81oeb3M6LzQXz5+YEOyl/GKhylos04ex3t22htdwSrRZ6CpyjGIkn+Tzz+EosGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQI4Op6b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQI4Op6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC89C4CED6;
	Tue, 10 Dec 2024 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856744;
	bh=Jae+gkX8xGuMfiRgBk7ZjZNz1o0dED5BNGeq84xAduo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LQI4Op6bPG7+RKd1aMI1TvpQcEpV+EYkLz5e0r99oAPBSzQ0+zguqSkbIVk07qzVf
	 bawGVFWTAxVR19+h9dspeGYjknDXvDjZvJrl5baHu2TRTLsjwhvuK0uVI1PYlaaCC+
	 /YUX0vIF5nRu0UwYk/OX3VfhAepwpHmSqD82Z3OFiOqdFOllsDInX5GWomdSopUSOH
	 z22Oi1BEmOS7Ua6vHa1tiBNcKl1nep/3Nd7hI61MwtWr3prQf9s7ISlCkJFDGWObaY
	 yOUjwiyCvoRbhBzgs4o2CNOiZjDXXm5a+kd0552YdJfly0c7mFj6pnJwSEcD2BaDCP
	 GU6mZjtFqUWCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 85626CE0B74; Tue, 10 Dec 2024 10:52:23 -0800 (PST)
Date: Tue, 10 Dec 2024 10:52:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Lee <379943137@qq.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org
Subject: Re: [PATCH -next] srcu: Remove redundant GP sequence checks in
 srcu_funnel_gp_start
Message-ID: <7450b6a9-8d21-4c31-86a3-3f7ed335f799@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <tencent_E213C035373D59F2469A887D3D60498E6B08@qq.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E213C035373D59F2469A887D3D60498E6B08@qq.com>

On Tue, Nov 19, 2024 at 03:29:49PM +0800, Feng Lee wrote:
> We will perform GP sequence checking at the beginning of srcu_gp_start,
> thus making it safe to remove duplicate GP sequence checks prior to
> calling srcu_gp_start.
> 
> Signed-off-by: Feng Lee <379943137@qq.com>

Pulled in unofficially for testing and review, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 5e2e53464794..cbef5674d201 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1076,7 +1076,6 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  	/* If grace period not already in progress, start it. */
>  	if (!WARN_ON_ONCE(rcu_seq_done(&sup->srcu_gp_seq, s)) &&
>  	    rcu_seq_state(sup->srcu_gp_seq) == SRCU_STATE_IDLE) {
> -		WARN_ON_ONCE(ULONG_CMP_GE(sup->srcu_gp_seq, sup->srcu_gp_seq_needed));
>  		srcu_gp_start(ssp);
>  
>  		// And how can that list_add() in the "else" clause
> -- 
> 2.47.0
> 
> 
