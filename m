Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA947DFBE
	for <rcu@vger.kernel.org>; Fri,  4 Sep 2026 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524653; cv=none; b=OnmrFLnzrfFn+uZcYgh45AF9BrigSdcil8gSzhhlQ8KKHUGDwMqGdiWNuP6/17eeRUIfb66la7IBj3nY9ll+53D4UgALlJCqtcD7ZpmPz83JlLwJwhgGH+0+JhU2an6BPcRfKoZOOg1IGmvm5yotSuPN8lDkEiHKU8OBUqGV3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524653; c=relaxed/simple;
	bh=wR/GhMnJZ9wmvp6B9oPm+Sfk1KbILaQYlnm8rSCkz8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G+WpQ06/OuLIEesKioymV7kt2KhNRLn1t7y0MX0AjXu6Nwd37NalLTkCnTbQ7eNnBmWi+LqyTMrbAzNgI7qUHLhRFpsOwzf1Mbvjsgvo5ceigqdKHm1SteWolzEJSaeLNEnXEDOXlAb9u3MYqDdURFeN28yXWjKcxFvvFW6zCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCzJyzX4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCzJyzX4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so888185a91.2
        for <rcu@vger.kernel.org>; Fri, 04 Sep 2026 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524651; x=1789129451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pIL91sr3+OT6rJUxsidIwPqNv7AO5E5ENrVFAKX+zGU=;
        b=SCzJyzX4LRYD0PTk0tuT3sz8pgsjsoMpZMQO8dC8B/MCXcXIA4ST9ReeBesc2aUcse
         fVyxpJ+7mWIei6XuzIctgbNyqANclAbLVCYfeZVT/7DIgFWhQJyuQy35PGzDisWNiqVN
         1okxydSDQI0ppUdtAfiCMs+1woDrZ6z5QlrKwampIh/OKVNLl6XUmZrhB7KBcYHylRpa
         O99zzcPhbTPZNYgd4gUPFD/KB678a0yix0/2KD8XV3X1iCmCiwsC52SdGQljwZb50xNH
         ocBsJ7w4B+BMWz7ZPSXM9MIUG+WaLwpeV4V0CVSpnUrA6tX5NoVMr+PoRlCXfaOdwrFc
         IeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524651; x=1789129451;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIL91sr3+OT6rJUxsidIwPqNv7AO5E5ENrVFAKX+zGU=;
        b=nTqH4C+H/HreNH8oq13ueQrlfQ81DUgHDGVQbK5iHJLU2zIEJLTptO/Qssg7JooAiQ
         2U5KpVfmdyQu4nAKm2G2AcK2XFO+pIS+/bROWlyVkzjhl9g2BQpsncdMtggfOlv9257/
         cE7BdmBKEUtGCCtKxlP2Cou4UGFqXcdQgLESYJqSaZ8u3MY+i9mFPpI5GDYLA2yXMl9/
         KlOSc1J2Yyu/0cDd6guarlxy5sQgw9bqy+hQiXlvSPMhRs7qVSu5WkeslAGOmgFk6uiI
         Bywt00eTBBXGZzMCmJsG3i46MLmXaruYZiQN04FrnXBmEWR/g/dzn7ntYfhgPHbcs09B
         MzhA==
X-Forwarded-Encrypted: i=1; AKwUvBxsXh1L/atMTFkPVHxNYA2Bf9pCswPLWy9p4ra/ran76X/vgM/alfJqR454wrxLmL6rsik=@vger.kernel.org
X-Gm-Message-State: AFuF++mM8QYlndADkHc8CDIpwF85isPeJBgyUcoQmp05kSOKJ9pYk0Tw
	+cCQry45nSrOSs7F5dnoxh8grI7Kd3rdeYwoW8P7uzlJJRoHsC6Fa8AE
X-Gm-Gg: AYBFou1BCIuvtaum88uylKu+nGPtLJpZDAAqb4zPfumLklrHFmaVrct4xai2swwbl9Y
	5TfG7tJADFPnnW0p7fjqIOKKFzOVOj3ApEnTKjrkCppyyQbw88+zLtCSBhbnXxVVJGOL1GMy/Tj
	/LA5HP+4zi9y8Yv5HCkiHk4DAp/hY298bX3Xbd0ENKchR+/1j0tL36Z0COEyKd/muD+v49T38CK
	pubgP64jFix69WeOM//9UhFR0bl0AAsb2A70iLJwykFGt/JVomLSjbgbZaDD5d7xPfq/odNkVw2
	kTrh9aNttxfXig2AIPrg2FJ9fnmew4s/xUS1UaZ/zg/KW5jhA3b7gPfB10naFGOmySPigwO87ha
	yq8xB8Qf9hg+Rd4iRoGMicOT7ekkiKHjdCHomHDZSM4QctbcaXaNCwLnmVxNNUVuzdaxZW3by3d
	sMtIkRtqEE9rRQNVhcEO1l0DpVG3+jFwQIWlTLNDxgHFjGHp6FhyMljmodKcZMoUjsxs5f
X-Received: by 2002:a17:90b:3b8d:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39b2624f10amr8155113a91.22.1788524650787;
        Fri, 04 Sep 2026 05:24:10 -0700 (PDT)
Received: from [10.189.137.81] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c3a526sm10593628a91.10.2026.09.04.05.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 05:24:09 -0700 (PDT)
Message-ID: <483ad434-4512-442e-ae6c-4108d5af5e49@gmail.com>
Date: Fri, 4 Sep 2026 20:24:05 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Align stall warning 'idle=' output with
 documentation
From: Peng Donglin <dolinux.peng@gmail.com>
To: paulmck@kernel.org, joelagnelf@nvidia.com
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, qiang.zhang@linux.dev,
 rostedt@goodmis.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donglin Peng <pengdonglin@xiaomi.com>
References: <20260105032112.1156359-1-dolinux.peng@gmail.com>
Content-Language: en-US
In-Reply-To: <20260105032112.1156359-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/26 11:21, Donglin Peng wrote:
> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> The RCU stall warning message includes an "idle=" field to indicate
> the dyntick-idle state of a CPU. According to Documentation/RCU/stallwarn.rst,
> the hexadecimal number before the first '/' represents the low-order 16
> bits of the dynticks counter. An even value denotes that the CPU is in
> dyntick-idle mode, while an odd value indicates otherwise.
> 
> This was valid until commit 171476775d32 ("context_tracking: Convert state to atomic_t"),
> which merged the context-tracking state and dynticks counter into a
> single atomic variable. In the new layout, the dynticks counter occupies
> the higher bits starting from CT_RCU_WATCHING_START.
> 
> However, the current stall warning code prints the value from
> `ct_rcu_watching_cpu()`, which returns `atomic_read(&ct->state) &
> CT_RCU_WATCHING_MASK`. This masks out (clears) the lower state bits,
> resulting in a value that is always even. This obscures the CPU's true
> idle state and makes the output inconsistent with the documentation.
> 
> To restore consistency between the code's output and the documentation,
> shift the atomic value right by CT_RCU_WATCHING_START bits before printing.
> This extracts and displays only the relevant dynticks counter portion,
> allowing the parity (even/odd) to correctly reflect the CPU's dyntick-idle
> state.
> 
> Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
> v2:
>   - Use CT_RCU_WATCHING_START to replace ilog2(CT_RCU_WATCHING) to clean
>     up the code, thanks to Zqiang.
>   - Clarify the commit message.
> ---
>   kernel/rcu/tree_stall.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..fd9d7fd6e17c 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -555,7 +555,7 @@ static void print_cpu_stall_info(int cpu)
>   			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
>   				"!."[!delta],
>   	       ticks_value, ticks_title,
> -	       ct_rcu_watching_cpu(cpu) & 0xffff,
> +	       (ct_rcu_watching_cpu(cpu) >> CT_RCU_WATCHING_START) & 0xffff,
>   	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
>   	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>   	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,

Gentle ping on this patch. Thanks!
