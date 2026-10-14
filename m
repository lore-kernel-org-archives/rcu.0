Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543563E63B0;
	Wed, 14 Oct 2026 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994073; cv=none; b=I6wFBDRcfBd1mxhTJE7QeQjQHjSM9wOfB/ryLRvQYjjVeomm83v33VEKnoCVQxpZtzdo2hgrl0vMggnsvkNxMicR3c68cu7pIzM8TivmLrMZ3W/OwQZXRKxQwUIi1kd/hOQ0Smke3NuPt1XbdZhOHI7tXeVPvSWMIYqAiFCFH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994073; c=relaxed/simple;
	bh=cKQp2zYdXfAM2EUMuoluYMhFB1N13KvmaTbSXbueCms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZSZcvlS1ybyA/vN4qPb83v732R2U6GzYAvxg9iuGXhiQ2hybGmn1v0cQ2c7/tT9iBR6Czmo76SI8/MyiSZqzRxLBeFBx9trf4H5/J531pLUf7EF/qjYeo/9Y05MyunAB8Gxi/HzFMwPEW+Gn5I0KpV5Jr995PJta157XWB+xs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ctv5cG/4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ctv5cG/4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DLzp1ryIGd1RjVH5bVRYOBEKh9UYcCUZqKJJaxxYGJo=; b=Ctv5cG/4tdpLi8nkrRjSlwNrnU
	A8bBKiRB1yG9MHCQyAYtwBjs/Rxp/0EdPvkQqEqt7U22cm+fEga8G02RNLvXPvY7dbiIXJ4kLVo7C
	SMrOVLrlCJdjQZzUrsy4ggocPZklGGLnnRQyv/qbceMJg/JEg7Y6Sr6+CoyvIf4CviFF96oF8qcLI
	5XdQ/EXYhfhd3aAf5C1wB4cDae9ohDw8HZem42RWclJGMvA0DC9M3JX4Dnq9+fHvYdpPgOm5iBqCe
	DXqaofTdNHxcF3+8RxeHp21RF7YCWIvzpsSgR4v269ej/RWw/aE1UWmsjQnErFbOq3UZiWY/aSBvm
	s2Yr/NDQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH1W5-0000000FwNU-3TzT;
	Wed, 14 Oct 2026 16:07:45 +0000
Message-ID: <363ea835-81bd-4045-bf1e-f5a460fd698b@infradead.org>
Date: Wed, 14 Oct 2026 09:07:44 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Fix stale RCU_GP_WAIT_FQS value in stallwarn.rst
To: Yonghao Zhang <hyz3367@gmail.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org
Cc: rcu@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261014063130.3691735-1-hyz3367@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261014063130.3691735-1-hyz3367@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/26 11:31 PM, Yonghao Zhang wrote:
> The sample "kthread starved" splat in stallwarn.rst shows
> RCU_GP_WAIT_FQS(3), which was correct when the example was captured,
> but has been stale since commit fea3f222d352 ("rcu: Record ->gp_state
> for both phases of grace-period initialization") inserted
> RCU_GP_ONOFF (3) and RCU_GP_INIT (4) ahead of it, shifting
> RCU_GP_WAIT_FQS from 3 to 5.
> 
> Update the sample output to show (5), matching the current tree.h
> values and the later "kthread timer wakeup" example in the same file.
> 
> Fixes: fea3f222d352 ("rcu: Record ->gp_state for both phases of grace-period initialization")
> Signed-off-by: Yonghao Zhang <hyz3367@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/RCU/stallwarn.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index b888e13c02a4..049694b9c681 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -379,7 +379,7 @@ If the relevant grace-period kthread has been unable to run prior to
>  the stall warning, as was the case in the "All QSes seen" line above,
>  the following additional line is printed::
>  
> -	rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1 ->cpu=5
> +	rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x1 ->cpu=5
>  	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
>  
>  Starving the grace-period kthreads of CPU time can of course result

-- 
~Randy
