Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160182E401;
	Thu, 11 Sep 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596669; cv=none; b=LP+eRhsU9dQlJqkJPOzeXBKJYuY1J0YB+l0XOjSD8JCrWZ5Gr39JX9hP1IxKQAAR0RUqqezb758H9emJhjWq3YkIWvgJoefpV1UB5WrocZ18EVoofMLhBmGWammbt5ZWAht6djhlDSbnyuauO7YeJFjo/HPVMuydnNXXOuzI/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596669; c=relaxed/simple;
	bh=52yjfSRJPXc/LoEFAxcO5TxqbWqDz5cZGC0otcKr94U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaGvs5SzQ688Lzug4o4iteXpDNOlsJ+UJXE4FX0xgLj+kXDGyeoHVGC3ZRX32RgzbmhqWpygRapZcFz3TK++HxZOz+K2d6JuaBbUjpaatDtrH/T7u6easQOJKjqkDyd2GcD35QvZTIhJKu0VNRJNHHdQ3vvtNms1YenZf8GSlnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTJCDhgq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTJCDhgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB29C4CEF0;
	Thu, 11 Sep 2025 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757596668;
	bh=52yjfSRJPXc/LoEFAxcO5TxqbWqDz5cZGC0otcKr94U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HTJCDhgqYFQxHRQk4jsxVLtvkA7Ew1rfILFYZPnPm1qp+YeK5E2pzZFLtYx4BFitT
	 hw5ZU1Y/uf4y88B1zgVz6bBGChOvYdYhTjv9VIr/7V/5jIOutRlbfI+lZ9kHZKvmOn
	 tofpCpeAirtUnytjxc5MaxWDZDa4mq6+qpYkCdyjiEuCnAJCYruUAjtfcvF+OSYcGa
	 xqTt2tuVkuG7hJCBosS8omyi8Eo2TWNyGU5+76JHiYHAxFGXFjZL/eSBh1/75Kf1VD
	 vvM5KmBDjETm/6eYIdP0zQ6oYGJcNmRcl8VSAn7uqTW5VRB4PsDixHDNiFB9wUmwz2
	 /O2Nuo/Vd0DaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 551BECE0DDA; Thu, 11 Sep 2025 06:17:47 -0700 (PDT)
Date: Thu, 11 Sep 2025 06:17:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/segcblist: Use WRITE_ONCE() for rclp->len decrement
Message-ID: <d1cee525-84c4-41f8-8594-0643d532e3ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250911051009.682429-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911051009.682429-1-kaushlendra.kumar@intel.com>

On Thu, Sep 11, 2025 at 10:40:09AM +0530, Kaushlendra Kumar wrote:
> The rclp->len field is accessed concurrently by multiple contexts
> in RCU operations. Using WRITE_ONCE() provides the necessary memory
> ordering guarantees.

Could you please be specific here?  What calls to rcu_cblist_dequeue()
are such that hte ->qlen field can be concurrently accessed?

(Full disclosure: I don't see any, and KCSAN hasn't found any.  Of course,
that does not necessarily mean that there is no concurrent access.
But we need such concurrent access called out explicitly here, because
it might well be that the concurrent access is itself the bug.)

							Thanx, Paul

> This change ensures that the callback list length is updated atomically
> and provides consistent visibility across different CPU contexts,
> maintaining the integrity of RCU callback list management.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  kernel/rcu/rcu_segcblist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 1693ea22ef1b..e10b36e9de54 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -71,7 +71,7 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
>  	rhp = rclp->head;
>  	if (!rhp)
>  		return NULL;
> -	rclp->len--;
> +	WRITE_ONCE(rclp->len, rclp->len - 1);
>  	rclp->head = rhp->next;
>  	if (!rclp->head)
>  		rclp->tail = &rclp->head;
> -- 
> 2.34.1
> 
