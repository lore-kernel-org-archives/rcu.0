Return-Path: <SRS0=zSQN=5V=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F6C2BA1B
	for <rcu@archiver.kernel.org>; Sun,  5 Apr 2020 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF4620675
	for <rcu@archiver.kernel.org>; Sun,  5 Apr 2020 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2Wq6j+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgDERVS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:21:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37960 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgDERVS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 5 Apr 2020 13:21:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id l11so2429634lfc.5;
        Sun, 05 Apr 2020 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zwBcCHHECxsy4xrXTCZkcr0zHpq0uhitj4f/Ihb3Jww=;
        b=q2Wq6j+wwZlfVB10YaIf6oEJrGFxX2gUVvNbQm7yWbtmHdm1oOsstizxpK4vhtHBJA
         XRzFRAL4ByUKgyi66JCV5ubHvsDsgIzgcdwbLPVVum9NgBN2ZtTvrjJZv4Wh0LBtuWC4
         zzJz2IB+4mOQHt8yc3u8fTAAoFsUFh3I7QGecNiye59T4hEJmDhNv3lwXn7gqzySEPA2
         uRTwkUGgphh+SmcUiIH/ilSTidZyIU23l/Lr0XzSfz+XMrEsRZbGE26ew5lCW7PRNslk
         /uyEPkEhKIoo9ItfOaxVtX6Rth7s/GPvpxgXVkdnpZeiamMOeWPGI/cHr9v0Kn8KVEA6
         MKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwBcCHHECxsy4xrXTCZkcr0zHpq0uhitj4f/Ihb3Jww=;
        b=CeoJ6tT3SwfcLC70GJWjdE1t48JYqMxlRsHBe3caUuVq6Tjt63oJuu7OSNcwKvrwRE
         QyvMGZfw8VTanjc9Wz8IHTbQXdkvqq7gbAprriZhg5HrfUPGijzPR+hCgytoZfb2AcRP
         hXuAp1bdtRLClfUQkSArhfVYMUCtSpyqubHw808NE9sikzDRIwZmnfe7QP0p/9wNp++c
         fMcZwoDqRystSKd3V75mJS1XTjW3doslv/4oWyKKXLNxyO6OxDfzfRJ6KXEne3DpuXDc
         9roNGeIaaSz2+7d3sQYkcHu8vwIERQDDHVuIeKmr+d4Ols8mS7kIIceS7588UAxIZ63V
         dzEg==
X-Gm-Message-State: AGi0Pua33qG72yEd6UPS9m8QOtdW0u0Uhybxq7aSow6sRZpyvv7RNlID
        7NktCFz/WFOV4Cd5ZsPcxGYWtH7L3eE=
X-Google-Smtp-Source: APiQypIjUwiKKSLdhhd2Jdh2960gWUe+aIV1fDy4BmsOrg1/hmJB9PnK7T1VRvf6tPSmGnCiuvX9vA==
X-Received: by 2002:a19:e00b:: with SMTP id x11mr4398037lfg.147.1586107274422;
        Sun, 05 Apr 2020 10:21:14 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id d27sm10176612lfq.73.2020.04.05.10.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:21:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 5 Apr 2020 19:21:05 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200405172105.GA7539@pc636>
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200404195129.GA83565@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404195129.GA83565@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Apr 04, 2020 at 03:51:29PM -0400, Joel Fernandes wrote:
> On Fri, Apr 03, 2020 at 07:30:51PM +0200, Uladzislau Rezki (Sony) wrote:
> > Maintain an emergency pool for each CPU with some
> > extra objects. There is read-only sysfs attribute,
> > the name is "rcu_nr_emergency_objs". It reflects
> > the size of the pool. As for now the default value
> > is 3.
> > 
> > The pool is populated when low memory condition is
> > detected. Please note it is only for headless case
> > it means when the regular SLAB is not able to serve
> > any request, the pool is used.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Hi Vlad,
> 
> One concern I have is this moves the problem a bit further down. My belief is
> we should avoid the likelihood of even needing an rcu_head allocated for the
> headless case, to begin with - than trying to do damage-control when it does
> happen. The only way we would end up needing an rcu_head is if we could not
> allocate an array.
> 
Let me share my view on all such caching. I think that now it becomes less as
the issue, because of we have now https://lkml.org/lkml/2020/4/2/383 patch.
I see that it does help a lot. I tried to simulate low memory condition and 
apply high memory pressure with that. I did not manage to trigger the
"synchronize rcu" path at all. It is because of using much more permissive
parameters when we request a memory from the SLAB(direct reclaim, etc...).

>
> So instead of adding a pool for rcu_head allocations, how do you feel about
> pre-allocation of the per-cpu cache array instead, which has the same effect
> as you are intending?
> 
In the v2 i have a list of such objects. It is also per-CPU(it is scaled to CPUs),
but the difference is, those objects require much less memory, it is 8 + sizeof(struct
rcu_head) bytes comparing to one page. Therefore the memory footprint is lower.

I have doubts that we would ever hit this emergency list, because of mentioned
above patch, but from the other hand i can not say and guarantee 100%. Just in
case, we may keep it. 

Paul, could you please share your view and opinion? It would be appreciated :)

> This has 3 benefits:
> 1. It scales with number of CPUs, no configuration needed.
> 2. It makes the first kfree_rcu() faster and less dependent on an allocation
>    succeeding.
> 3. Much simpler code, no new structures or special handling.
> 4. In the future we can extend it to allocate more than 2 pages per CPU using
>    the same caching mechanism.
> 
> The obvious drawback being its 2 pages per CPU but at least it scales by
> number of CPUs. Something like the following (just lightly tested):
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] rcu/tree: Preallocate the per-cpu cache for kfree_rcu()
> 
> In recent changes, we have made it possible to use kfree_rcu() without
> embedding an rcu_head in the object being free'd. This requires dynamic
> allocation. In case dynamic allocation fails due to memory pressure, we
> would end up synchronously waiting for an RCU grace period thus hurting
> kfree_rcu() latency.
> 
> To make this less probable, let us pre-allocate the per-cpu cache so we
> depend less on the dynamic allocation succeeding. This also has the
> effect of making kfree_rcu() slightly faster at run time.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6172e6296dd7d..9fbdeb4048425 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4251,6 +4251,11 @@ static void __init kfree_rcu_batch_init(void)
>  			krcp->krw_arr[i].krcp = krcp;
>  		}
>  
> +		krcp->bkvcache[0] =  (struct kvfree_rcu_bulk_data *)
> +					__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +		krcp->bkvcache[1] =  (struct kvfree_rcu_bulk_data *)
> +					__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  		krcp->initialized = true;
>  	}
We pre-allocate it, but differently comparing with your proposal :) I do not see
how it can improve things. The difference is you do it during initializing or booting  
phase. In case of current code it will pre-allocate and cache one page after first
calling of the kvfree_call_rcu(), say in one second. So basically both variants are
the same.

But i think that we should allow to be used two pages as cached ones, no matter 
whether it is vmalloc ptrs. or SLAB ones. So basically, two cached pages can be
used by vmalloc path and SLAB path. And probably it makes sense because of two
phases: one is when we collect pointers, second one is memory reclaim path. Thus
one page per one phase, i.e. it would be paired.

Thanks, Joel!

--
Vlad Rezki
