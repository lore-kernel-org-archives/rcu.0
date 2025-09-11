Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A092DC778;
	Thu, 11 Sep 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619705; cv=none; b=s4pnCi7C7YSmn7VYg5YyZZnoNXdPoxKFHe2b7XQiJb9h581+vxcF2+dptOk2MW8oemTwTlbBjhyIRReWJVvVZuOn5qGMjd97xUramfxj1X2stLXS4a7cjlTE+sfecIkEPzHoRZQSj78bkDrfSw85hVYzOBQuOHBdw5IUP9zqprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619705; c=relaxed/simple;
	bh=WBN1qw9XvX2TZPZRSozKY24wzhqRXw/RPAq/2Xyeemc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5/OPHk731M5yDkmEviOFhkUGi5b6u+ysYhNilY3LZoGCjjll8n0MNJYIsSVL9fJXQqnZMRXbA0tOpSEEtalz0eqH+PpNs6eTV18F+lPO6mxEuPCyRQQlQJYBc51UqcpH6DWkbxs1utdQjM3YRxkq61U18NrbzOGIIjkBIBqhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyurqR5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyurqR5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA35DC4CEF0;
	Thu, 11 Sep 2025 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757619705;
	bh=WBN1qw9XvX2TZPZRSozKY24wzhqRXw/RPAq/2Xyeemc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AyurqR5n/BDnIw9jreAvwb+soyiosTy16vpONtLgOKLA9FJ/5a5mmQ+Pd/NTa6Xw0
	 g2cCnxzwideLBlZ8fL6faK0Ulkyvw62IQloIDteG4+MZKHfbXeFKij6+ICPxl6I/VC
	 PSdwKIKs2G0GMp6O+eJANTDtYPCG1gRFTLYrdo7jzU1Acz0MkZtDgST6UESA3zcTpW
	 Qy/0dmfEEq2qwt1TRvx7ZWDI7LDN51BwDJGDhEw8ulyROM05gOVwP2VyCuB6tii9pR
	 8FCs7eCk6BwbkjJd07lqoWPNFtrQeZ76hVgxmD9N6qV0Df0eAnOk6kjbWmx9tgcXv4
	 DUSDtPfw05lmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5B0D0CE0C15; Thu, 11 Sep 2025 12:41:43 -0700 (PDT)
Date: Thu, 11 Sep 2025 12:41:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/segcblist: Use WRITE_ONCE() for rclp->len
 decrement
Message-ID: <d0f20036-70d7-4dcb-9745-99341fd1c501@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250911162641.796716-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911162641.796716-1-kaushlendra.kumar@intel.com>

On Thu, Sep 11, 2025 at 09:56:41PM +0530, Kaushlendra Kumar wrote:
> Use WRITE_ONCE() for rclp->len decrement in rcu_cblist_dequeue() to
> maintain consistency with rcu_cblist_enqueue(), which already uses
> WRITE_ONCE() for rclp->len increment. It maintains consistent access
> patterns to the rclp->len field across both enqueue and dequeue operations.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Again, why is this patch needed?

Please keep in mind that unmarked normal C-language loads and stores have
value in that KCSAN can detect data races involving them.  If we decorate
all loads and stores with READ_ONCE() and WRITE_ONCE(), respectively,
KCSAN is unable to detect buggy concurrent accesses.

							Thanx, Paul

> ---
> Changes in v2:
> - Revised justification to focus on code consistency rather than
>   concurrent access claims.
> - Revised commit message to use imperative mood throughout per kernel
>   documentation guidelines (suggested by Markus Elfring).
> 
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
