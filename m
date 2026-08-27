Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD43FFD;
	Thu, 27 Aug 2026 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848638; cv=none; b=CNagmIOB4P5+L+vmTXXL4NBoFdtQOUtWZS11JTeDcEpPBlcZwOFcv3HOpt5XKkJl2kePRUpLjDjpcWwuc71WQ6WYhSiRWNYFpaJQHUP4zqEtAYtFFlkXoXvV+AwekutOFLx/g/wCp9qARff/8Bgzg4VidPaEsGrgGRXqPPgujOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848638; c=relaxed/simple;
	bh=AoKcWIAi3dlVaXhoM4ksXxXwZtRpod0+vGyJjRGzBYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KH4ZX3UK74TqjTxxjQg39dU8qo5Jdq0JIpLvgZQNTlMWZoioA8zaeL8onKk4917pOIAqfo8ipvZ8zGeCcgSZEkYGQBE/xVUaiJiBmBKVGX+Xf5GKblr61ao7DQz7JBIddxiBGeYp1vBlKwH+l0RJzp4FxaE+G/p7pTrTkcGHSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OvxIsvp3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OvxIsvp3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=VjWd7jawRMf1GjIFoqYNHQZJX5s6jHeoiKZeb9PnSfI=; b=OvxIsvp3XMWMaTYhanpLMCzui+
	gRkWgYMnfwBPtpvmsgqY6oI4OvHlZsMf8ObRrZ37P5ENP+z0DFvynYkA7qAQVsDee5wlLZ36aHjuu
	d7Le4EDh/09nb3b+4QXUXwMq+OE2jKTOvWhzn3XsR99YriFDKRCcziLU2yEENM8QgblTmj396Nlai
	POe+k+taVKfwlGpZbHYD9YULXDzV3eOtSK5MAUPpaoUtj2j3qlDDuRZV6obkVE/CeiHxz9g+QrONK
	HgFQ8tF0GgWwLR/AL9qUH3Rlbh9x+aBr8ZePSpXlw6AQ2jR5WFueveiZAIigx8ppHiYlz63PrpnG7
	8O/NsvZg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzd6H-00000004MLq-1Ge0;
	Thu, 27 Aug 2026 16:37:13 +0000
Message-ID: <9f2abc12-a3c0-482a-b5d4-57b129db10fa@infradead.org>
Date: Thu, 27 Aug 2026 09:37:11 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] doc: RCU: Fix typo
To: Costa Shulyupin <costa.shul@redhat.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
References: <20260827090506.1172620-1-costa.shul@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260827090506.1172620-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/26 2:05 AM, Costa Shulyupin wrote:
> strategem -> stratagem.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 8101fe6229d5..b10e0484ae13 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1442,7 +1442,7 @@ periods:
>     corresponding CPU's next scheduling-clock.
>  #. CPUs mentioned in the ``nohz_full`` kernel boot parameter can run
>     indefinitely in the kernel without scheduling-clock interrupts, which
> -   defeats the above need_resched() strategem. RCU will therefore
> +   defeats the above need_resched() stratagem. RCU will therefore
>     invoke resched_cpu() on any ``nohz_full`` CPUs still holding out
>     after 109 milliseconds.
>  #. In kernels built with ``CONFIG_RCU_BOOST=y``, if a given task that

-- 
~Randy
