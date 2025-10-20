Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E701EF39E
	for <rcu@vger.kernel.org>; Mon, 20 Oct 2025 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997284; cv=none; b=Tr2ftXWNnrv/478vW0eh6a4ztWI7/WdWkMMy/qdo2zj0w+3losATEGLqtYJ/Yhn36p372dGLf/8UOVuH0hdiGbvxTR8reYXeNjdiPycBH/SvDjcx5X8Zfc67x0pgXAtoLIbjPgsDC6VoZhZjcSzF72K8hZjDSI4bMQlUzCoJ6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997284; c=relaxed/simple;
	bh=L13Rp7FhzKpBFltNbzLezvMDSbl8kgBMApeX6pbQwtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBY6fxkSo8mzJgcOrCWH/eA49ZRT7WGB/VQ35VESJwFCj6ea7E1qinnxQPy60Y8qjodIb5866xAmJeFPxrqVXU4Wtj6dExCSKi8rUjeEKstd/tCk/0C5Sbtn0mV/8MIks0JRgjG3BWuzRx7gQ69a2MJt8OS8Z5gtMbGM3j+RHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6YlbAQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6YlbAQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2765C4CEFB;
	Mon, 20 Oct 2025 21:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997284;
	bh=L13Rp7FhzKpBFltNbzLezvMDSbl8kgBMApeX6pbQwtA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T6YlbAQfzArRwA6uQyn6c7h6nIJJ8oasMOuT1x5+P9atqZfQkWM0C01sgsQoLmZMP
	 X1LPemA3R2lfoVv3M3gcRlma1mt+RjD74nT898AiuYcNl/4xqNb+Y8oHXWbQoefxSk
	 +zQlQrNr7kZCCQkta4lbASexxXmmfSPswD351MAA5Hcx5Y7WjEeQlAUxrJ1Afv+4nj
	 YHlU59CmFMImM87p4E/m9SuIVAJMT1ULpLmSKdthsvf1nQMa0qC2KZFZxNqqhbBXcP
	 bkXJ2wTIiJY6JEMtSM4cWxw66QCqS9Ijvxf6g2XISuf5aY/fxPDc2OGsK0mooXbxyF
	 zigE93k7X/wMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 735A0CE0C4A; Mon, 20 Oct 2025 14:54:43 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:54:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org,
	edumazet@google.com, mmpgouride@gmail.com, fw@strlen.de,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH v1] rcu: use WRITE_ONCE() for ->next and ->pprev of
 hlist_nulls
Message-ID: <7d4d2a48-1bba-4a47-8cdf-45d3d492e79e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251010064910.605653-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010064910.605653-1-xuanqiang.luo@linux.dev>

On Fri, Oct 10, 2025 at 02:49:10PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> In rculist_nulls.h we can still see ordinary assignments to ->pprev and
> ->next of hlist_nulls.
> 
> As noted in the two patches below:
> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
> rculist_nulls")
> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
> hlist_nulls")
> 
> We should use WRITE_ONCE().
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Hearing no objections, I have pulled this in for further review and
testing.

							Thanx, Paul

> ---
>  include/linux/rculist_nulls.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index 89186c499dd4..d5a656cc4c6a 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -138,7 +138,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>  
>  	if (last) {
>  		WRITE_ONCE(n->next, last->next);
> -		n->pprev = &last->next;
> +		WRITE_ONCE(n->pprev, &last->next);
>  		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>  	} else {
>  		hlist_nulls_add_head_rcu(n, h);
> @@ -148,8 +148,8 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>  /* after that hlist_nulls_del will work */
>  static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>  {
> -	n->pprev = &n->next;
> -	n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
> +	WRITE_ONCE(n->pprev, &n->next);
> +	WRITE_ONCE(n->next, (struct hlist_nulls_node *)NULLS_MARKER(NULL));
>  }
>  
>  /**
> -- 
> 2.25.1
> 
> 
