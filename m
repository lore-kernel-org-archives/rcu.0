Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A73373BF1;
	Tue, 21 Apr 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796908; cv=none; b=QFEDB4CSJOUkQubUMwVGjlXT/3wg7urdEBFWwGI5lB3ydpE2ivibS1iY6zQhRBbWu2MjkSAg+5wCPF7HxLAG/SE6SHMV6ToULvq116fHFI1WtiBiBFlIzidpvPgIrLoz/0TW4Zd2jogp2H4nvA5DmsaEmUUAkg8e1lPQ6kFyI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796908; c=relaxed/simple;
	bh=Tmc2hBfg1iGJMwHOsYpxSlY74mmCtZjE46Eu1PSSJGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxmctMATu6DoAUXj0ReSHrSYrt9KnhaSf6fy6nBdniOygCaffVUNyeDK0VkggYAEF7byUA+ix5YfHLipIbCImsCpk6C7eiogh/B8F7nTZxhm9G/l1FjegO798Ebepj8RbAzL8kcjewvlqlVHQ+nqHtxhPvyzKdVtjVM99SkMkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfW1rCCh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfW1rCCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0214FC2BCB0;
	Tue, 21 Apr 2026 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776796907;
	bh=Tmc2hBfg1iGJMwHOsYpxSlY74mmCtZjE46Eu1PSSJGQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jfW1rCChNfxi0nSv/rwdEazIW2exvg2M++jy9YVYFMZ6W7sOg5ZVKnGme8fUThGqo
	 gxg5cOAskQRanejO1qVI+y/EDst9FQDeJLdizlP3XK/vwDfpUgoJECOdnJC7oPG+dV
	 /9HpC5TFhTpvLQVcpkIk2HsYV0R/uVqMCynHdrp/HOHOAzaUJ84e8R6AUYwCZhw+YY
	 1v8GidRaGCNlfvRL0uSopH5tFvRk9N4urLxQ02o5O/UJqclbcpg1Rq5SxRQml1XIN9
	 jUvrVr7fN2mdrl8FBVnAcddkRq7720N3k1UKSoho7A7GI6TZWqgFqYWOJGkQ5+PTzA
	 gGARLvAZ8PTlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9B612CE0ADA; Tue, 21 Apr 2026 11:41:46 -0700 (PDT)
Date: Tue, 21 Apr 2026 11:41:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	rcu@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 2/3] Documentation: RCU: adopt new coding style of
 type-aware kmalloc-family
Message-ID: <7a49fee0-09c8-4a48-9506-d9172ef024b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260421175516.224960-2-manuelebner@mailbox.org>
 <20260421180652.225394-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421180652.225394-2-manuelebner@mailbox.org>

On Tue, Apr 21, 2026 at 08:06:53PM +0200, Manuel Ebner wrote:
> Update Documentation/RCU/* to reflect new type-aware kmalloc-family as
> suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
> 
> ptr = kmalloc(sizeof(*ptr), gfp);
>  -> ptr = kmalloc_obj(*ptr);
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  Documentation/RCU/Design/Requirements/Requirements.rst | 6 +++---
>  Documentation/RCU/listRCU.rst                          | 2 +-
>  Documentation/RCU/whatisRCU.rst                        | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index b5cdbba3ec2e..faca5a9c8c12 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -206,7 +206,7 @@ non-\ ``NULL``, locklessly accessing the ``->a`` and ``->b`` fields.
>  
>         1 bool add_gp_buggy(int a, int b)
>         2 {
> -       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
> +       3   p = kmalloc_obj(*p);
>         4   if (!p)
>         5     return -ENOMEM;
>         6   spin_lock(&gp_lock);
> @@ -228,7 +228,7 @@ their rights to reorder this code as follows:
>  
>         1 bool add_gp_buggy_optimized(int a, int b)
>         2 {
> -       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
> +       3   p = kmalloc_obj(*p);
>         4   if (!p)
>         5     return -ENOMEM;
>         6   spin_lock(&gp_lock);
> @@ -264,7 +264,7 @@ shows an example of insertion:
>  
>         1 bool add_gp(int a, int b)
>         2 {
> -       3   p = kmalloc(sizeof(*p), GFP_KERNEL);
> +       3   p = kmalloc_obj(*p);
>         4   if (!p)
>         5     return -ENOMEM;
>         6   spin_lock(&gp_lock);
> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
> index d8bb98623c12..48c7272a4ccc 100644
> --- a/Documentation/RCU/listRCU.rst
> +++ b/Documentation/RCU/listRCU.rst
> @@ -276,7 +276,7 @@ The RCU version of audit_upd_rule() is as follows::
>  
>  		list_for_each_entry(e, list, list) {
>  			if (!audit_compare_rule(rule, &e->rule)) {
> -				ne = kmalloc(sizeof(*entry), GFP_ATOMIC);
> +				ne = kmalloc_obj(*entry, GFP_ATOMIC);
>  				if (ne == NULL)
>  					return -ENOMEM;
>  				audit_copy_rule(&ne->rule, &e->rule);
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index a1582bd653d1..770aab8ea36a 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -468,7 +468,7 @@ uses of RCU may be found in listRCU.rst and NMI-RCU.rst.
>  		struct foo *new_fp;
>  		struct foo *old_fp;
>  
> -		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
> +		new_fp = kmalloc_obj(*new_fp);
>  		spin_lock(&foo_mutex);
>  		old_fp = rcu_dereference_protected(gbl_foo, lockdep_is_held(&foo_mutex));
>  		*new_fp = *old_fp;
> @@ -570,7 +570,7 @@ The foo_update_a() function might then be written as follows::
>  		struct foo *new_fp;
>  		struct foo *old_fp;
>  
> -		new_fp = kmalloc(sizeof(*new_fp), GFP_KERNEL);
> +		new_fp = kmalloc_obj(*new_fp);
>  		spin_lock(&foo_mutex);
>  		old_fp = rcu_dereference_protected(gbl_foo, lockdep_is_held(&foo_mutex));
>  		*new_fp = *old_fp;
> -- 
> 2.53.0
> 
> 
