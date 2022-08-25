Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A65C28D13
	for <rcu@archiver.kernel.org>; Thu, 25 Aug 2022 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiHYPAS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Aug 2022 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiHYPAR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Aug 2022 11:00:17 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178481E3C6
        for <rcu@vger.kernel.org>; Thu, 25 Aug 2022 08:00:11 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h22so15419682qtu.2
        for <rcu@vger.kernel.org>; Thu, 25 Aug 2022 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Adi3AGQuxVv/oOjG9veNa2NPaAlAu1gjNH1Mqy2W878=;
        b=AbWrbsmaxCtjWxpJgGLf9B/8RG/bgre3Jx4AFYKcQT1desD4RX0Divj391d4B+2wQB
         GCQ7EltM8s1EHXwGNchwfOGCuwpkYjlmu3TPeE8setk9XwJZeengn9CGIIRmCL7KKVSU
         gwT6i3TIcoRcLy1eT8XnIhDOj7F9NnogCYTN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Adi3AGQuxVv/oOjG9veNa2NPaAlAu1gjNH1Mqy2W878=;
        b=Z7YbDRfHRi5ZAGELWzzyaSNHnD7q8se5Zu2RaQrdXN7hVkaeZ16kYUjykLKvpTUpEG
         LMS5uSCoMlKZI3bLwdaPwV7FLDAnEG5p0UR0ts4xLznIAgFTmPvZEIz9sUnNV+uSKxoN
         a1pRWtlMIlFuN8wELafqsG0OayqiN6y6hwy67UMPQHill5zncox8S4B6afMcbnfuT4da
         7gcNL01VUVsawD3VivFvenMuuLEZAbeJI/h8H+rBG8kabFhCb2deb4RvCjzRhfVMMiv9
         x8a7K+BO8TPUwlJXfIQo/yosaU6q9Y1e6kz9CK0e4K2r92HgT8p7mhcSzBqWX6dsbjGX
         w++w==
X-Gm-Message-State: ACgBeo1SYz6ww/9afWwHDdlZWpNJJnOSLXq8EGUr2lvTcLa9xnzPzqsN
        DVYZdnJNGEk7R/Ggo/XRkuRxEA==
X-Google-Smtp-Source: AA6agR73hEyh7dwpa/O+wL9caNO7dSDrpCZ1X2eQE4aln9uubMYzQe40gjzuOYuCXj5w6JptksDKVQ==
X-Received: by 2002:ac8:5888:0:b0:343:6cf2:e185 with SMTP id t8-20020ac85888000000b003436cf2e185mr3754025qta.285.1661439610943;
        Thu, 25 Aug 2022 08:00:10 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id h4-20020ac87764000000b0034355a352d1sm14417441qtu.92.2022.08.25.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:00:10 -0700 (PDT)
Date:   Thu, 25 Aug 2022 15:00:10 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     willy@infradead.org, paulmck@kernel.org, rcu <rcu@vger.kernel.org>
Subject: Re: How to increase rcu_head size without breaking -mm ?
Message-ID: <YweOepUcoY3Sol8J@google.com>
References: <85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org>
 <be4edb7f-031b-905e-d615-560ac206d82a@suse.cz>
 <ed9ebc8e-0ea8-4e5b-45fc-38f2538e7d36@suse.cz>
 <9ac74328-decf-bf67-d943-121008ed59b8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac74328-decf-bf67-d943-121008ed59b8@suse.cz>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 25, 2022 at 10:14:16AM +0200, Vlastimil Babka wrote:
> 
> On 8/25/22 09:50, Vlastimil Babka wrote:
> > 
> > On 8/25/22 09:13, Vlastimil Babka wrote:
> >> On 8/25/22 04:56, Joel Fernandes wrote:
> >>> Hi,
> >>> I am trying to add some debug information to rcu_head for some patches, and need
> >>> your help! At least this used to work some time ago (> 1 year).
> >> 
> >> Hmm, got a patch of how it worked back then? Because what I see (in v5.12)
> >> struct page definition:
> >> 
> >> 	struct rcu_head rcu_head;
> >> 
> >> is in union with the whole of
> >> 
> >> 	struct {        /* slab, slob and slub */ ... }
> >> 
> >> which starts with
> >> 
> >> 	union { struct list_head slab_list;  ... }
> >> 	struct kmem_cache *slab_cache; /* not slob */
> >> 
> >> and there's e.g. kmem_rcu_free() in mm/slab.c that does
> >> 
> >>         page = container_of(head, struct page, rcu_head);
> >>         cachep = page->slab_cache;
> >> 
> >> and very similar thing in mm/slub.c rcu_free_slab() - we assume that the
> >> rcu_head and slab_cache fields can coexist.
> >> 
> >> So this looks silently fragile to me? In case rcu_head becomes larger than
> >> list_head, e.g. with your buf[4], it would start overlaping the
> >> page->slab_cache field, no?
> >> 
> >> AFAICS the way it's structured now in struct slab in mm/slab.h, it makes the
> >> overlap impossible, thus the struct slab will grow as rcu_head grows, and
> >> offsets of the later fields stop matching struct page counterparts, which
> >> doesn't grow. Hmm.
> > 
> > The following has made things compile for both SLUB and SLAB (didn't adjust
> > SLOB), the idea is to define more explicitly that everything can overlap
> > with rcu_head except slab_cache. So the structures don't even grow in the
> > end. Which requires moving slab_cache field around. Which would be fine
> > except for SLUB and its cmpxchg_double usage, which requires the
> > freelist+counter fields to be 128bit aligned, which means we can't fit it
> > all with these constraints. So that's broken with the patch and I don't see
> > an easy way to fix this.
> 
> Ah maybe I found a way. It requires that rcu_head in struct slab would be at
> different offset in struct page, and we drop the particular SLAB_MATCH
> check. I think it should be fine as we don't cast struct slab to struct page
> in the rcu calls/callbacks so it was probably there just for intermediate
> steps of the struct slab series, and can be dropped now.
> 
> So this should allow you to use up to 32 bytes of rcu_head.

Thanks a lot, Vlastimil! I can confirm it builds, some comments below:

> ----8<----
> diff --git a/include/linux/types.h b/include/linux/types.h
> index ea8cf60a8a79..daf7682a7a3b 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -220,6 +220,7 @@ struct ustat {
>  struct callback_head {
>  	struct callback_head *next;
>  	void (*func)(struct callback_head *head);
> +	char buf[4];
>  } __attribute__((aligned(sizeof(void *))));
>  #define rcu_head callback_head
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 4ec82bec15ec..dd49851f9814 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -12,37 +12,45 @@ struct slab {
>  #if defined(CONFIG_SLAB)
>  
>  	union {
> -		struct list_head slab_list;
> +		struct {
> +			struct list_head slab_list;
> +			void *freelist;	/* array of free object indexes */
> +			void *s_mem;	/* first object */
> +		};
>  		struct rcu_head rcu_head;

Does this present any problems for SLAB_TYPESAFE_BY_RCU such as the slab
being in use before the end of a grace-period? I was concerned about the
freelist being corrupted by the rcu_head storage, since its now in a union
with it. If this does not matter, then that's all good.

> @@ -66,9 +74,13 @@ struct slab {
>  #define SLAB_MATCH(pg, sl)						\
>  	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
>  SLAB_MATCH(flags, __page_flags);
> +#ifdef CONFIG_SLUB
> +SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
> +#else
>  SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
> +#endif
>  #ifndef CONFIG_SLOB
> -SLAB_MATCH(rcu_head, rcu_head);
> +// SLAB_MATCH(rcu_head, rcu_head); /* not necessary, hopefully? */

I think if it helps, I can make this check as a dependency on a default-off
debug config option.

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

