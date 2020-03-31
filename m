Return-Path: <SRS0=gdpO=5Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB15C43331
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DBF20BED
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 14:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt8ZOLs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgCaOEo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:04:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33238 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbgCaOEo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Mar 2020 10:04:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id f20so22136880ljm.0;
        Tue, 31 Mar 2020 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MDdUt2Xx7CsJa6khvoaGnC8v0ElEvPxQibVr3Q0lyA0=;
        b=Xt8ZOLs/9+oLndJW2LeyLzmXHPe+a5ZaO7yuXusrKEEooFZqJk0SHV3D5NA3A0tuof
         Kuj/fghd8kbgdHaUOc23KMYkypOLAU8gB6NyPHUFgg6SCPgGUmTbACI/mMMaDR7SOmfG
         frE/wPklAnN/5IRz2rVDhBP/aSR25XIMr6DXr+Byi8O6Py3p5icVgGmRDJSAxIknYxVj
         aOntTMQKGKCBLPwY3RRzXo1PD1vykgic5clRiQESmlZro7NwH4Uynitkua8q3blTXTku
         kdVz+AHtttOrqkhXiSxnccwW44LMKSbPqguxWFkiWVRjtlmnHMQxbyjHuLkHxI8uFVRV
         0nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MDdUt2Xx7CsJa6khvoaGnC8v0ElEvPxQibVr3Q0lyA0=;
        b=QVJHEylCIDN/xV7LktuHgBJqmoX+2YMMTYuoyqx/kPMnkFPxH+6zcCHDv2Yxah7r/Z
         Wrh3v9TDjSbWxu/7urScad6QnexMRTqcG59+9KyYKCwiaG/1yeTJNXRCBWbgZox9hBeP
         Y7K1HEk1k+qEh5xdVDRABovxAWfVEIxbhUSOh2tFMq+187EZm8SVGM0i7h657jdtRN8B
         X/+F44H1kz33wf88yYg8TdUtwjNjR5T09W9nZct410YFgMduoddTkM4Z8RhX0QedtU/a
         bLLSI+WTADcU8duwd/BA3RTkmUNjQq90obvINTfGCzm0lsV/KfYg+nwyaztiafkfEgAd
         DfFA==
X-Gm-Message-State: AGi0PuYATzY9hm/NekKWQZlfa9uOiQLN27o3gjrHuh4LJ+frsDmkzqv9
        Wh/zRMh46qlyqHMPr0vQPh8=
X-Google-Smtp-Source: APiQypI4fAWKLnARPHwBzr7LMf8/4/VuGvwrht4oSGSknhX+lU0YSToDfvpjMh2o1Loq9tzpRQlO0A==
X-Received: by 2002:a05:651c:1102:: with SMTP id d2mr10524529ljo.102.1585663481281;
        Tue, 31 Mar 2020 07:04:41 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id j125sm8678528lfj.38.2020.03.31.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:04:40 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 31 Mar 2020 16:04:33 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331140433.GA26498@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331131628.153118-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 31, 2020 at 09:16:28AM -0400, Joel Fernandes (Google) wrote:
> In kfree_rcu() headless implementation (where the caller need not pass
> an rcu_head, but rather directly pass a pointer to an object), we have
> a fall-back where we allocate a rcu_head wrapper for the caller (not the
> common case). This brings the pattern of needing to allocate some memory
> to free some memory.  Currently we use GFP_ATOMIC flag to try harder for
> this allocation, however the GFP_MEMALLOC flag is more tailored to this
> pattern. We need to try harder not only during atomic context, but also
> during non-atomic context anyway. So use the GFP_MEMALLOC flag instead.
> 
> Also remove the __GFP_NOWARN flag simply because although we do have a
> synchronize_rcu() fallback for absolutely worst case, we still would
> like to not enter that path and atleast trigger a warning to the user.
> 
> Cc: linux-mm@kvack.org
> Cc: rcu@vger.kernel.org
> Cc: willy@infradead.org
> Cc: peterz@infradead.org
> Cc: neilb@suse.com
> Cc: vbabka@suse.cz
> Cc: mgorman@suse.de
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> 
> This patch is based on the (not yet upstream) code in:
> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/kfree)
> 
> It is a follow-up to the posted series:
> https://lore.kernel.org/lkml/20200330023248.164994-1-joel@joelfernandes.org/
> 
> 
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4be763355c9fb..965deefffdd58 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
>  
>  	if (!ptr)
>  		ptr = kmalloc(sizeof(unsigned long *) +
> -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> +				sizeof(struct rcu_head), GFP_MEMALLOC);
>  
Hello, Joel

I have some questions regarding improving it, see below them:

Do you mean __GFP_MEMALLOC? Can that flag be used in atomic context?
Actually we do allocate there under spin lock. Should be combined with
GFP_ATOMIC | __GFP_MEMALLOC?

As for removing __GFP_NOWARN. Actually it is expectable that an
allocation can fail, if so we follow last emergency case. You
can see the trace but what would you do with that information?

Thanks!

--
Vlad Rezki
