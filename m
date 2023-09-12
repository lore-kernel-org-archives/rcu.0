Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E8CA0EC3
	for <rcu@archiver.kernel.org>; Tue, 12 Sep 2023 13:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjILNPc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjILNPb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Sep 2023 09:15:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E01510D8
        for <rcu@vger.kernel.org>; Tue, 12 Sep 2023 06:15:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-403004a96eeso35757355e9.3
        for <rcu@vger.kernel.org>; Tue, 12 Sep 2023 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694524525; x=1695129325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sedOMqC0ST66FmUVvGzmfSfnZDNkNU5eCUexv6NVk/M=;
        b=Har0kcJEvqaw6LmgLqbiEwtse5NRskHL5ERbXX8vq4kvxpKN/eISrzoUqdpikooKij
         LEQavqjgI3SMxlKKizd9KQ7vNUOIloMQjRlVN9W3x1q/nlqK0A7weL+LbaXrrI/WHJ3b
         idKXmUA9fgieqd9IBMV0V7pCZThIg/uCNQ+jBfj0MsMq5RXu/3HaNm+/WiBFawtX5f7d
         4Be9TIqB6KqibAtnGNu1hiEMGNRICKvVZr1X8xkQNR1PZTPCYDLD9s6ch5N/aBfSBTZN
         D32n7PZp0FgIxt/nhRgxSP640HVEqgJHg6r0JoQi7YK1Zr/FUbALqD2+v3KI4Pw1CYFx
         /j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524525; x=1695129325;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sedOMqC0ST66FmUVvGzmfSfnZDNkNU5eCUexv6NVk/M=;
        b=bh8QfjNL2E5Wk3CGlsbNUz3TPWNe0dF7clJyGlzNm0pJ0AyqqiiaOW/6CatA3pnowm
         iNx2vakT/VqyV9DSyj/K4Wh3O5hGuCUktBpKzM5p5+iBmMrV9AE0a1tAHJL1d9hu6MAi
         TUBSpg0swqQySM4yGwPq8Li8/XNuCBJoXl6LkHsXr4u5Pf3Q0kK/0Nz0FYP3qAOo3J1S
         rLrHqX9q0mp6RkSZF/Ev4aLxvEXBMz9O4iORHiKgzxcNFc3uQdhP1eQxsGtY0cmHVwVh
         WE/WqRK5P3JWF52fhLvrwCtMLJk8CY/F3fpUbdq7/BkImzlGPrnOiKRonvRodF5mjW9x
         Si5w==
X-Gm-Message-State: AOJu0Yy862ZkRxAo9QWByENTi8J3rKWlIGldOTCLtVO3FsRpj96d/3MS
        RHQ9CvfDD1h03CgNGjV5bTLsppucgFzq0uDE+vU=
X-Google-Smtp-Source: AGHT+IF6tIgxuoHTLORnTjjcIWy/852iu4mQRSQtQAW0Snb0QdDZKeJ6BFPd2U+gbeZ9J+RbUALrtA==
X-Received: by 2002:a7b:c01a:0:b0:3fb:d1db:545b with SMTP id c26-20020a7bc01a000000b003fbd1db545bmr10178967wmb.20.1694524525558;
        Tue, 12 Sep 2023 06:15:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:50fd:9518:7cfb:dc7e? ([2a02:578:8593:1200:50fd:9518:7cfb:dc7e])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bcb97000000b003fbe791a0e8sm12831473wmi.0.2023.09.12.06.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:15:25 -0700 (PDT)
Message-ID: <6bd9f6cc-84d0-4f6a-bfd7-912dcb8e476a@tessares.net>
Date:   Tue, 12 Sep 2023 15:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kmemleak handling of kfree_rcu
Content-Language: en-GB, fr-BE
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Christoph Paasch <cpaasch@apple.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com> <20230905111725.GA3737639@google.com>
 <ZPc+HGjmY2ZC4WO3@arm.com> <20230906143529.GB1127143@google.com>
 <ZPizxVT5s9JA5MPw@arm.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <ZPizxVT5s9JA5MPw@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Catalin,

On 06/09/2023 19:15, Catalin Marinas wrote:

(...)

> I had a patch already but got distracted by a few (real) leaks reported
> while testing it. Feel free to pick it up and change _ignore to
> _not_leak if you find that more suitable. Well, it would be good for
> Christoph to test it as I haven't managed to reproduce the false
> positive.

Thank you for the patch!

> ----------------------8<--------------------------
> From b25350cb6f8a906a6164b625bfd57021190cb105 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Wed, 6 Sep 2023 17:52:45 +0100
> Subject: [PATCH] rcu: kmemleak: Ignore kmemleak false positives when
>  RCU-freeing objects
> 
> Since the actual slab freeing is deferred when calling kvfree_rcu(), so
> is the kmemleak_free() callback informing kmemleak of the object
> deletion. From the perspective of the kvfree_rcu() caller, the object is
> freed and it may remove any references to it. Since kmemleak does not
> scan the tree RCU internal data storing the pointer, it will report such
> objects as leaks during the grace period.
> 
> Tell kmemleak to ignore such objects on the kvfree_call_rcu() path. Note
> that the tiny RCU implementation does not have such issue since the
> objects can be tracked from the rcu_ctrlblk structure.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> ---
>  kernel/rcu/tree.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cb1caefa8bd0..2ac39b5705df 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -31,6 +31,7 @@
>  #include <linux/bitops.h>
>  #include <linux/export.h>
>  #include <linux/completion.h>
> +#include <linux/kmemleak.h>
>  #include <linux/moduleparam.h>
>  #include <linux/panic.h>
>  #include <linux/panic_notifier.h>
> @@ -3388,6 +3389,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  		success = true;
>  	}
>  
> +	/*
> +	 * The kvfree_rcu() caller considers the pointer freed at this point
> +	 * and likely removes any references to it. Since the the actual slab

Just in case you didn't send this patch, checkpatch.pl noticed that the
word "the" was repeated in the comment here above ("Since the the actual").

Cheers,
Matt

> +	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
> +	 * this object (no scanning or false positives reporting).
> +	 */
> +	kmemleak_ignore(ptr);
> +
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
>  		schedule_delayed_monitor_work(krcp);
> 

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
