Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A0481BA
	for <rcu@vger.kernel.org>; Mon,  4 Mar 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569167; cv=none; b=cAiwpEceFsVtMQ8ySLujoTf72vFvYRh6yk5VubuWRF2IoPLh2gT0vOsfH7molmFBH/czcZtsahtgKpnK4eoga75N6EMl+3i7w6pWvchMhYmzwar9nY3ZB34CkyfGejcMKY/ku4ACqiZm1RSRld97DLlJQ8lsIsW5i/revEGelxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569167; c=relaxed/simple;
	bh=AyK9vkFDxSdFY7pAAcpyEeR0clBo4J9X95OLjQ6YFoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5xfsrv5v/t3kvE4CkURSb2EjvYf8paEZPdnVsANTFwTSffO1QVi8VXxcTJzNIVYfomjvOmbKGEAgis2GFdlyQBdxRvwlcCiTyXTH94rM5NkdEWNw4B6wtqLBfCqwpUdDAFDxca0RKm0ed9gzTf950gtlKI9tkXJ2MPtbyJ40YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=R7I1Gw0X; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="R7I1Gw0X"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68f571be9ddso42928346d6.0
        for <rcu@vger.kernel.org>; Mon, 04 Mar 2024 08:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709569165; x=1710173965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwFydJvCBlry2uVIEmH1Py5ewOn9oa12Fu2r23KnJkU=;
        b=R7I1Gw0XYobRrdSQVqlXE+Bo0+ez2IcX79w/xf/C31KtRLQZR68t5f3UEcr5wTUpGX
         PzwQnA2CalRVf+8RWdYxShQmrIHg3sS1kyMEUt/hcg2DuwBjvJNQ+epAzGaf+n4bWvX8
         rfrebGxSMBQOr0u+52z2IX2o3LYO1yDCcvqK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569165; x=1710173965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwFydJvCBlry2uVIEmH1Py5ewOn9oa12Fu2r23KnJkU=;
        b=QA48BWwIBlX6Z9Eg4MplTm9xHBVEHVY5Apq0GWr3idEW47m2QLLffuPIxbMZ39ozMi
         CVNT4bmW3UUt2a5p97YSsrmvszuOwH5TSKGwtIFe+S9+GKMRqtq3NrDtXbH9NGAKrA2U
         oIYcPHhrXx18okRVK6JEPIzLXJkVphTiAEw5s2EfKs8sNkiQKNOI6nHLu/1JpAQ1Af8m
         G7QdUYGPtwD/Wyoza2JJWLQPiReOvUud0Zp9BqeWh0JKkAxCjyJbYYLiXWDQQDNEXT3O
         QU1+/Q0C5zfe/+beN/a/bTIqjTzefCvXOyh/PyiG45NherHoJ5Vl/vZBeJ+5dpoi2R9e
         WfaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcOQTCk4snt9Obedh9b3dXQCSgd/iKeH+MOhlaxg6Qs2YdLIOaVSdZCEgRA+UHHyUs897TZxB9UCSo5LhEJsz9Opbs
X-Gm-Message-State: AOJu0YwHbSHU3KyXq1eDpOtSAneVgIeChIao1mXztLuhHfZ1tCBCskXp
	e+Dg7TlMcfO2TefSafGDRO4Z19atkQLEz6BqpPEmN8iTyn1ix8pxwJWNqpiR1jk=
X-Google-Smtp-Source: AGHT+IHRnHA4BPN1k/dST9tqeSMDTfcXQLpJ7zegjvXgs4LzDEZavQjCLkpW3DBSjVkbGjDt+PABZg==
X-Received: by 2002:a0c:eed4:0:b0:690:6eb7:c678 with SMTP id h20-20020a0ceed4000000b006906eb7c678mr4951142qvs.18.1709569165125;
        Mon, 04 Mar 2024 08:19:25 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id r8-20020a0ccc08000000b0068f6e1c3582sm5142982qvk.146.2024.03.04.08.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:19:24 -0800 (PST)
Message-ID: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
Date: Mon, 4 Mar 2024 11:19:21 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
To: linke li <lilinke99@qq.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng
 <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/2024 5:54 AM, linke li wrote:
> Some changes are done to fix a data race in commit 202489101f2e ("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race")
> 
>  {
>  	int i;
> 
> -	i = rp->rtort_pipe_count;
> +	i = READ_ONCE(rp->rtort_pipe_count);
>  	if (i > RCU_TORTURE_PIPE_LEN)
>  		i = RCU_TORTURE_PIPE_LEN;
>  	atomic_inc(&rcu_torture_wcount[i]);
> -	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> +	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> +	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>  		rp->rtort_mbtest = 0;
>  		return true;
>  	}
> 
> But ++rp->rtort_pipe_count is meant to add itself by 1, not give i+1 to
> rp->rtort_pipe_count, because rp->rtort_pipe_count may write by
> rcu_torture_writer() concurrently.
> 
> Also, rp->rtort_pipe_count in the next line should be read using
> READ_ONCE() because of data race.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>  kernel/rcu/rcutorture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 7567ca8e743c..00059ace4fd5 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -465,8 +465,8 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
>  	if (i > RCU_TORTURE_PIPE_LEN)
>  		i = RCU_TORTURE_PIPE_LEN;
>  	atomic_inc(&rcu_torture_wcount[i]);
> -	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> -	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> +	WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
> +	if (READ_ONCE(rp->rtort_pipe_count) >= RCU_TORTURE_PIPE_LEN) {

I want to say, I am not convinced with the patch because what's wrong with
writing to an old index?

You win/lose the race anyway, say the CPU executed the WRITE_ONCE() a bit too
early/late and another WRITE_ONCE() lost/won, regardless of whether you wrote
the "incremented i" or "the increment from the latest value of pipe_count".

Anyway, a slightly related/different question:

Should that:
WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);

Be:
WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);

?

thanks,

 - Joel
