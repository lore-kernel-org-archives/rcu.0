Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6060C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4329207E8
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeLKhCms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgFRSXk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgFRSXk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 14:23:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAECC06174E;
        Thu, 18 Jun 2020 11:23:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so4035298lfe.11;
        Thu, 18 Jun 2020 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtZ+S0yqkpnvGyiBpEd57efqY8RnbTwuIeP3LIO4+t8=;
        b=JeLKhCmsNWf+iu8vSE/iGVFYwqW4hCzZfzX0iNjqFxiezlwkzt9KzkdWB0XQeN+chQ
         3LqWxHBswCD+kUSUVh2ImpHTCzgDK9jLEl7eN4KOanMP3vx/0uIiMSt6ey1Gy4Ac4Plh
         r76s8iF/jiXHIKFCiNEK8K+5HBfmdcmAW3Dls5nA+y9vOWkgLPmv63MIkH6V/+MX3eZj
         KybciiszOPkEPwLkqAgaeOSLYImnR4IOP+ZKECNZ+h0PZu73+MeRtNRmg9BYKl0ByOJ4
         kZe6MeZDFYwB9skflValj9ymybfiN1LcmMjvhm9Ty0pKqL6qT+jWDTLSxxZZfmXDRr2j
         wyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtZ+S0yqkpnvGyiBpEd57efqY8RnbTwuIeP3LIO4+t8=;
        b=uJtkk/ybd+h6BcUl29Tgjkv1yvcu4HcIUTmd9IUKs4I/HyhDl0ajzmwBIk9Vm+2Prb
         Nc2UT8ryoyl99xUdyz8d9eT8R+PtYbQhpS3ANRgqRNazCVGRn9eh4fVphhgIY8NoPUuM
         FJlb0WS7cTOI7ep2whR+8CKmEwX9EMndFhJHOdbbM9Qu/WlDLydgJMqCAolMt0pXRjYA
         NQuQJcz9z9ijRhZeK6bCIrRpagDluUemxPsJlncxURunDX0E/GTGmelK8Jas+Fq0He9c
         xXdc9T3GqgpYmVaNoae2W8mDHrDZ5HQlcphme3qKPq3mZluoSFyFZ9fBJfuQPqQXCjHJ
         TAbg==
X-Gm-Message-State: AOAM532hMvoxuNmo53dUzfZTAEUXUYhLfmhLQzZWmFFWtb7i76REwl8c
        sxx58kW/nbI0GeDHwHmUqUI=
X-Google-Smtp-Source: ABdhPJwE8GlFDZ2vhKPL+bYHMUSg0Cv+ZXbjDv+hC3D0Zkyui+dYWdjJjnf4HhwVurZAsGWY9zoxWQ==
X-Received: by 2002:ac2:5f07:: with SMTP id 7mr3112274lfq.132.1592504617032;
        Thu, 18 Jun 2020 11:23:37 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n4sm135298lfl.40.2020.06.18.11.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:23:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 20:23:33 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618182333.GA15082@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618172504.GA14613@pc636>
 <20200618173206.GS2723@paulmck-ThinkPad-P72>
 <20200618175623.GA14865@pc636>
 <20200618181541.GS8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618181541.GS8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 11:15:41AM -0700, Matthew Wilcox wrote:
> On Thu, Jun 18, 2020 at 07:56:23PM +0200, Uladzislau Rezki wrote:
> > If we mix pointers, then we can do free per pointer only. I mean in that
> > case we will not be able to use kfree_bulk() interface for freeing SLAB
> > memory and the code would converted to something like:
> > 
> > <snip>
> > while (nr_objects_in_array > 0) {
> >     if (is_vmalloc_addr(array[X]))
> >        vfree(array[X]);
> >     else
> >        kfree(array[X]);
> > }
> > <snip>
> 
> [PATCH] Add vfree_bulk interface
> 
> This is a useful interface to have for the RCU kvfree code.  There is
> scope for more performance gains later, but introducing the interface
> now allows us to simplify the RCU code today.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 48bb681e6c2a..dc2bbb61af61 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -119,6 +119,7 @@ void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
>  
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
> +extern void vfree_bulk(size_t count, void **addrs);
>  
>  extern void *vmap(struct page **pages, unsigned int count,
>  			unsigned long flags, pgprot_t prot);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index abe37f09ac42..6042f9b4394a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2366,6 +2366,22 @@ void vfree(const void *addr)
>  }
>  EXPORT_SYMBOL(vfree);
>  
> +void vfree_bulk(size_t count, void **addrs)
> +{
> +	unsigned int i;
> +
> +	BUG_ON(in_nmi());
> +	might_sleep_if(!in_interrupt());
> +
> +	for (i = 0; i < count; i++) {
> +		void *addr = addrs[i];
> +		kmemleak_free(addr);
> +		if (addr)
> +			__vfree(addr);
> +	}
> +}
> +EXPORT_SYMBOL(vfree_bulk);
> +
>
Can we just do addrs[i] all over the loop?

Also, we can just call vfree() instead that has all checking we
need: NMI, kmemleak, might_sleep.

Thanks!

--
Vlad Rezki
