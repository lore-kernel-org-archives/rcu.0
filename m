Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D187C433EF
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiENOeZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 10:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiENOeY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 10:34:24 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4941EC68
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:34:22 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kk28so8993119qvb.3
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HdP1xKmix4+4rR9ZpnUsc15X6jZZ5YAzkLCBGIWD1bE=;
        b=yQhO6/blUVEjD4MMlYXltdwGjd8PHXQvME6CiC8zLk4V8TjDBBtUqBtcfcfNTccvGg
         dg2LvF2aKCF9EhjDL8fUdxUjMsZUZPZ1ajBhrsKssqFuemYuNBKsDguZKauPNsYw8wGP
         c1H8mBo7gZC1JhZrzzMZtmoKmEniUvbX4U3uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HdP1xKmix4+4rR9ZpnUsc15X6jZZ5YAzkLCBGIWD1bE=;
        b=zljhE03WvuPL+wTibIXn9U1f4MIrONuPzCz7cECVVM5k7teWM6uQaRy03pZ32+PriJ
         0qU8Ug1fiGRH2RE2rSCSOhQLW27vb4wyzxvFljtSRZAh3y2jMg8t6iASxWOS4Gnza3Re
         Zepn6ZoeeALrw+hMbCSFAYLsiGqiS9+22lT4ePT+76NPvNrgO+RjenLPKrxMl+FN7fg7
         dxIkUCSVBj83nWrcYUq/TSZvopydN5vWZRiI5WjIhbJVqvkJlpEAwxlERAvWHTCzZ85j
         xZ1wIQKXDgMNBotCu3vOaW7N9+r9IEnXzjAchP1kNclUF3t/5cunWb3D+xHtezsUGnr6
         U0Hw==
X-Gm-Message-State: AOAM530A+TLKxYHYMGEUZIKdSk0ZwzrqPqtXdCvfRQryZ9yCycISnpJ0
        FGkvHGXsLSVluWV1znz5/ojgVvi/ZdDGFQ==
X-Google-Smtp-Source: ABdhPJxIo4VSSLst+ZbHEvFU3RIjbFLMtfkhuXcLgaSRlW0X2dXADEA5cSWMd2DTo3CruX3WjX5k7g==
X-Received: by 2002:ad4:4753:0:b0:456:34db:614b with SMTP id c19-20020ad44753000000b0045634db614bmr8385361qvx.17.1652538861241;
        Sat, 14 May 2022 07:34:21 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id g1-20020a379d01000000b006a05a6243d5sm2912333qke.13.2022.05.14.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:34:20 -0700 (PDT)
Date:   Sat, 14 May 2022 14:34:20 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [RFC v1 13/14] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <Yn+97FLqrWySLEt3@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-14-joel@joelfernandes.org>
 <Yn5xCm1EfNPsN2Yg@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn5xCm1EfNPsN2Yg@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 13, 2022 at 04:54:02PM +0200, Uladzislau Rezki wrote:
> On Thu, May 12, 2022 at 03:04:41AM +0000, Joel Fernandes (Google) wrote:
> > As per the comments in include/linux/shrinker.h, .count_objects callback
> > should return the number of freeable items, but if there are no objects
> > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > should be when we are unable to determine the number of objects, or the
> > cache should be skipped for another reason.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 3828ac3bf1c4..f191542cdf5e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3637,7 +3637,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> >  		atomic_set(&krcp->backoff_page_cache_fill, 1);
> >  	}
> >  
> > -	return count;
> > +	return count == 0 ? SHRINK_EMPTY : count;
> >  }
> >  
> >  static unsigned long
> > -- 
> > 2.36.0.550.gb090851708-goog
> > 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

thanks!

 - Joel

> 
> --
> Uladzisalu Rezki
