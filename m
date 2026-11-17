Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906752;
	b=0pWbFUtwjDA6BUAwXVWzyCmgVKriw9a75IHmIfN7BwMdy0jrEDaxHId9i+Rt0z8iquz0
	 9+pBoCkqfwWvHfCCA3sZ8NIASQcFmuXdykVar7v6sVMfAp9DIaONwqD5e7wRKFlLn9tx7
	 MVlQ2YTKleQRjBttjaD7DXWJS+90SqroMGbVU+tq05UGC3aeHqmOEWXp1BGiAoyY/cI/z
	 jS+emc1MSLGjy79OZ4RRV377YYDkTeMcJ9JGR5nW43h/xL8wUjdpekXpPdki/HVmKzspF
	 GUwe5EECXTO7gjFyF3lIvyyhLQ7+0DJYztC7nTxQHV3p0MgF/3oEKYNo9a0TTdQMKqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906752;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WaHgdh/hMMYwIKKAjlZv5gfGqVgYBr8yvhKkfuO1pkY=;
	b=lhDM0F06YqEdeDp+eePSmCRbNvhX1d/XlRUrSjvjj99bukuqRzyX8Hs4CLYmYkAMxJmZ
	 rNoD7zMDkAyZlmZSURkghWTQbejXo5NRiAdeaebk0KiA1g4RJbB6zABecSHVk4hdGCS8J
	 5+YGoAR4R4C9ZUXCTQxcmTNO35+m7l4DQZFOXYQV6fuCCmyvdrqt7YwI59nmoLQvoXqR6
	 HXzQb+LCUjgxubDJRP4wpVRGOkJcQXf1A8sQy10RDmbVIHvMcncNgDbrOccRQc64+vMWR
	 DdPwElB8wU1ZXm1KTpy3gUP3mg3/hK0Pk0DQfKzcL8+8pzDbOyIo2EegP8EdXXErC/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqdCsSR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5CA606A329;
	Tue, 17 Nov 2026 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqdCsSR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DC31F000C4;
	Tue, 17 Nov 2026 09:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906752;
	bh=WaHgdh/hMMYwIKKAjlZv5gfGqVgYBr8yvhKkfuO1pkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RqdCsSR1FdqDBZfot0BDyTnmnJcsQrXHGDcxC8vvBUlme5704R8ikXOhrJN2Lj+17
	 MdzNeSHu1/9iJq9PaA4lEpWFC+uSFvWED4XXakYpYKnzYDz1xe99BwyaVTOpHBEhQI
	 yqAq4Tpx2b/L7i+hYoXxidF7R0DEPV2Tb6FZObJDJcwIwUdrQ+TyGtuup/gTzrf9Bn
	 i9UwbPgr7X5DT1huu8Ov3CiYVJw4DE2Y/E/fS/p1ArddRZsyy8/UEpMw3NQgrqwiKl
	 m7gc9r04e3tSfLOe0fGR03no2GCENxJxhJvKfGfX9K5s4/UL9n0jBzZ+HwlAdAmkUy
	 MnTFCSwAR2EqQ==
Date: Tue, 17 Nov 2026 10:12:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Joel Fernandes <jfern@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH 1/6] MAINTAINERS: Add Puranjay Mohan and RCU reviewer
Message-ID: <avwafaVoS0LB-9Qt@localhost.localdomain>
References: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
 <20261116172630.3845508-1-paulmck@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261116172630.3845508-1-paulmck@kernel.org>

Le Mon, Nov 16, 2026 at 09:26:25AM -0800, Paul E. McKenney a écrit :
> Puranjay has made substantial contributions to RCU over the past year,
> so it is time to add him as reviewer.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Puranjay Mohan <puranjay@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93abbb315065d..6ebe13dce75dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23485,6 +23485,7 @@ R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  R:	Lai Jiangshan <jiangshanlai@gmail.com>
>  R:	Zqiang <qiang.zhang@linux.dev>
> +R:	Puranjay Mohan <puranjay@kernel.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>


>  L:	rcu@vger.kernel.org
>  S:	Supported
>  W:	http://www.rdrop.com/users/paulmck/RCU/
> -- 
> 2.40.1
> 
> 

-- 
Frederic Weisbecker
SUSE Labs
