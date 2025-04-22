Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D11B3935;
	Tue, 22 Apr 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344683; cv=none; b=heWWuEb2c1yqeQ1tl134IwR8DcxgSdubGnxJjlOfM/1iVHdSbJ5v/0kGwyhfxWGZQLavqAuwc+yf6RFQaxGy8IAxOXVnXvaUyB/5EfDOuujJzdFQqHBnsk4l8G+Q5zkL3fpfpBBmWZsomzNJZ7iWa7StaO+hzPGKv10etQkqrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344683; c=relaxed/simple;
	bh=OPofQBC2ykw4T8o8gILKx8E4Ig86DZ8245++vqzdnt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS/8Gz0+Jm4p/+vWB4CcASJxL6oFADvsNRayaUrdjMLo8vvHgRuFGm9KuL68SzuTo5fFYgh1A6x7Ao3KMfUVwfI9ddMwYv6IR4GuYSPkdN0me1TN5ThVJyqqLX/J/q3J7fXseMWkp8rA71IiaaQnij7L5VG4jRC3nurnHD0DM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUciZhoF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUciZhoF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E81C4CEE9;
	Tue, 22 Apr 2025 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745344682;
	bh=OPofQBC2ykw4T8o8gILKx8E4Ig86DZ8245++vqzdnt0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KUciZhoFIfwmCnPB7nSYUs3S09AjVOrmlly4UvJug6fZjbNBF9jPmACPGQYkDRuE6
	 Y2Myhbc8pz4GgTiEtaOJ0lM13ilmumfQ5RFebq1hJ5Mfx86xLQurdWleYwSdqG2Gnc
	 t1db7tO1m7JBt0KLtSA4IYDbpYlGYiH979o1t8txqsv33/v2P1BayZtH0ZX7HHv54P
	 xIMFScgLOM6wgS3Owxz/XewIz9SO9MIURDV4SzPDfPex0dGC1W4/vNWxVrmhB4OBMw
	 K+01xoTI42iqGOcKLlLjv28gLJOLYBr0v6GicGRNPAkrjSYfKcG1PpTOxrNVJTsW9V
	 jqZ0tcxleUyhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2A713CE0875; Tue, 22 Apr 2025 10:58:02 -0700 (PDT)
Date: Tue, 22 Apr 2025 10:58:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] rcuscale: using kcalloc() to relpace kmalloc()
Message-ID: <ae61d78a-e950-41e1-9a2c-afac2a385156@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250421061508.718752-1-suhui@nfschina.com>
 <20250422015144.2012708-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422015144.2012708-1-suhui@nfschina.com>

On Tue, Apr 22, 2025 at 09:51:45AM +0800, Su Hui wrote:
> It's safer to using kcalloc() because it can prevent overflow
> problem.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> v2: 
>  - using kcalloc rather than kmalloc_array().
> v1:
>  - https://lore.kernel.org/all/20250421061508.718752-1-suhui@nfschina.com/
> 
>  kernel/rcu/rcuscale.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 0f3059b1b80d..b521d0455992 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -762,7 +762,7 @@ kfree_scale_thread(void *arg)
>  		}
>  
>  		for (i = 0; i < kfree_alloc_num; i++) {
> -			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> +			alloc_ptr = kcalloc(kfree_mult, sizeof(struct kfree_obj), GFP_KERNEL);
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> -- 
> 2.30.2
> 
