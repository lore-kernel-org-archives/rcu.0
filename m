Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F513A86C;
	Wed, 20 May 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280274; cv=none; b=ipHbL4sIRZUfYRb6spABGG88puT2mDG2XFluqGcsFNmw7iatJ03H5yDSMHwYPk/AC37Ii80Itel39M2p/8zMAYiS2CY1IykRLr/1xp/vsR0G+eQDTtHY/wO4acrbjvJ2NFoPTMu7dPZRqJ+dfPUDAvRI0peKqBG/SZRpQXBrt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280274; c=relaxed/simple;
	bh=nmSyjYte1T5KE/r6CtwF5kkGvKNTIQxyZL7rthNCylU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJvULDAtCisqlHNdIo/s4EH2eOy1NV0L8fUISSfs5D58cE51AEhGBTi3h1Tn57a54rfJU6GX1G49KduylF6DdE3caNF5W4pJx30vaYi6eBKKFwwkAApuodtLXRUNxuLBhpAhhWpm06JvRV5jF0Il2PWjdwHb5eSYXTa2o44cZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuyQKKEz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuyQKKEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81171F000E9;
	Wed, 20 May 2026 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779280273;
	bh=96yul7Yr2ww3QxQgDCqLw0g5s4eXQhhjtEOD0alXmio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fuyQKKEzb8QlFtWdCf6MTUD9SdoR29NcSQ8zRtM7XeV4IrdKFgLq9XYyqPI4nNDsX
	 Q351dMrT9fT0TBG77YjD8VEDZ91h/8W3H/9DdP7aJuzKPhFSj0csFJEd9Z2ebRijfI
	 7m8haccwp32sXqnaUywtw/8j0Iap3/H23bN9wqv7G4Fq+R1eOIZQwA5vyg6OK4QBg/
	 vUmqYA2Nthhb2mYo7KDBhl4ZF3O/PXggVuQPvTaXX5ZJqpikpN2QoqeTjHAmrwsB0H
	 LMdHTioVsbHmodpUsEuh5gfL46sd0/aJxBuTgPhfYq2ciPLRq/MT/AYuclOpZ+cNq8
	 4tXErFSpqazGQ==
Date: Wed, 20 May 2026 14:31:10 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2 08/11] rcu: Simplify
 param_set_next_fqs_jiffies() by applying clamp_val()
Message-ID: <ag2pjq6hBnZLJ_PJ@localhost.localdomain>
References: <20260519194524.158515-1-urezki@gmail.com>
 <20260519194524.158515-9-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519194524.158515-9-urezki@gmail.com>

Le Tue, May 19, 2026 at 09:45:21PM +0200, Uladzislau Rezki (Sony) a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit replaces a nested ?: sequence with clamp_val().  This does
> not reduce the number of lines of code, but it does simplify the line
> that it modifies.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e46a5124c3eb..09f0cef5014c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -492,7 +492,7 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
>  	int ret = kstrtoul(val, 0, &j);
>  
>  	if (!ret) {
> -		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
> +		WRITE_ONCE(*(ulong *)kp->arg, clamp_val(j, 1, HZ));
>  		adjust_jiffies_till_sched_qs();
>  	}
>  	return ret;
> -- 
> 2.47.3
> 
> 

-- 
Frederic Weisbecker
SUSE Labs
