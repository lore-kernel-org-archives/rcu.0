Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9AF13AD9
	for <rcu@vger.kernel.org>; Sat, 24 Feb 2024 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708750745; cv=none; b=YRbZxEiIebNTQRu9VXEbHs3M86SCnMGC8hmme3wJhfKvJ6m+MFKntuG3sctLmMY96xvBpY1jYzgBV+U9dCyls8fxzAiL+dLqeISvoEVwuYid8TrwzB2tuLPMJaxW8AqkI4DyT5XREN892fUG3zbYWPS5NGiSwY7gT3sn4oFIHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708750745; c=relaxed/simple;
	bh=UVnMe3riV2mEE9PMTOsDaFkqLCkxkOumV5ClPcR8WmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CredYEx65ZBK1JPTwLCw/xTRg67BhADXkchQj6115oFA4gksjLXGTBlnQp5B7RZ8MT7kKICjfRz39wm6kgBkz1p2xzTk5sNzoSQBvGm2RJs0H/cH6h1KGkpVQH7LPNXJCGozDLM1kcYmDO+Im1Br/Ula2fb5mjvvR5/726nyD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=uvBEBBUW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uvBEBBUW"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7838af983c1so96877485a.3
        for <rcu@vger.kernel.org>; Fri, 23 Feb 2024 20:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708750742; x=1709355542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0DR/r8YGEcoi+M428q3lMVHPYxJfzAFlwNC1nO7OJA=;
        b=uvBEBBUWCuMsLEwcgOxq5oDfofFs/y9yvwH4glSkTAiDpPbk16VkzDpjwdEU8HWCfd
         Uex3k1tIvnHvm5oAnQEIuYtO97+Zcugyy9jcOHYP09UxfjU6RymnCuHLh7goMP9w0oDF
         N9RLWABUtwrNfD8soOmmm2iwiCy3W9WYEZIds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708750742; x=1709355542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0DR/r8YGEcoi+M428q3lMVHPYxJfzAFlwNC1nO7OJA=;
        b=MUVHPX6u7Lt9OAeg4/OGr9/GSRM1luHfF3/RZpAvt6Y8J76vjGZxwpZmM7z3G99LRB
         ZK+M23PcNBG//+er4QdEryX1i4Y0trAo0EfvXpDf5GNm659kcWANtynBm76nW/T4aYxw
         u7F4lF6J2xq0+c4RRFKwG2C5wOy0Fsd7OBhDemcEMycVRBa+TjsWXGiLtVfVaEg6I+cj
         3L/QIbUunbuwMoefk+kkeDCN9f77KcbjyQ7cEtozs8iFbirfnzCdWvbwsAncGaOKBup0
         o3qCsM3xt1BMmxiLNJPlCSDs+elGc3fLEX+ekCVFNxNmmQJkIbhZDY7YNfi6KwS/YgK1
         UJkA==
X-Gm-Message-State: AOJu0YwNDnvU2wmqD3Udph9GBe6XNHc6FN6v3LO7nhUNTW+UdHSZQjsC
	Zmpfv+NKYzOebAV4KASpZECbQLcVPqGcr+r2l5DzxH+LhtO4UYRgYsev/TPLBKX+rx75YI39t/5
	g
X-Google-Smtp-Source: AGHT+IFSX+n9PnM8+ZEtqzUGuqdnEg8aQSqj+a21ftSVDlhZaELMIT3DL+QZnBBMwUTpSh71NIqyIA==
X-Received: by 2002:a0c:de08:0:b0:68f:e855:5502 with SMTP id t8-20020a0cde08000000b0068fe8555502mr780228qvk.31.1708750742494;
        Fri, 23 Feb 2024 20:59:02 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id qm16-20020a056214569000b0068fef023e6esm92590qvb.88.2024.02.23.20.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 20:59:01 -0800 (PST)
Message-ID: <cfe9394d-8144-48d0-a8f1-de9fb54eabc5@joelfernandes.org>
Date: Fri, 23 Feb 2024 23:58:58 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Neeraj's email address
Content-Language: en-US
To: neeraj.upadhyay@kernel.org, paulmck@kernel.org, frederic@kernel.org,
 boqun.feng@gmail.com, josh@joshtriplett.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240224045730.29812-1-neeraj.upadhyay@kernel.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240224045730.29812-1-neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/2024 11:57 PM, neeraj.upadhyay@kernel.org wrote:
> From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> 
> Update my email-address in MAINTAINERS and .mailmap entries to my
> kernel.org account.
> 
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  .mailmap    | 3 ++-
>  MAINTAINERS | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 08f28f2999f0..dd6ea71c9271 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -441,7 +441,8 @@ Mythri P K <mythripk@ti.com>
>  Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
>  Naoya Horiguchi <naoya.horiguchi@nec.com> <n-horiguchi@ah.jp.nec.com>
>  Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
> -Neeraj Upadhyay <quic_neeraju@quicinc.com> <neeraju@codeaurora.org>
> +Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <quic_neeraju@quicinc.com>
> +Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <neeraju@codeaurora.org>
>  Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
>  Nguyen Anh Quynh <aquynh@gmail.com>
>  Nicholas Piggin <npiggin@gmail.com> <npiggen@suse.de>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 189184ecdb11..1006a6973320 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18461,7 +18461,7 @@ F:	tools/testing/selftests/resctrl/
>  READ-COPY UPDATE (RCU)
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
> -M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
> +M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)

Reviewed-by: Joel Fernandes <joel@joelfernandes.org>

thanks,

 - Joel


