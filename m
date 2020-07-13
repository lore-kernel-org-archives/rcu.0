Return-Path: <SRS0=XkjU=AY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47AC433DF
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CA42077D
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHFwLI6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGMVNY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgGMVNY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jul 2020 17:13:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A5C061755;
        Mon, 13 Jul 2020 14:13:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so486522pjg.3;
        Mon, 13 Jul 2020 14:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFFtVBi0HSpUYn8AGsyHnTvFEzCVFTNzBhRqHb3wbuM=;
        b=HHFwLI6tmgvIy66L0Ly3bb+VZRnO8OyG/nDqoH9lxt+3yQqzjvLx9PYXjF9j2T1hYX
         FUUbV7Qzw/ozSEQ4GR0BdRuUpPMFObLAomFrNFaasdv520z9OHdFYDXbwH6tTJWg+phz
         5QY7uWROElqO3rcGG0XYCQFonabWdAWDcBSxsk5EOvTkjX4dE/RtlRYc6m3DuiVlawz4
         UZTh+gPqQr7SZIt0fQbtvzmtgk+g/AAYUH1X1W+Me3EAKiRrxAfDb4+MGgHzqtciUJmi
         ooDTtEtSnKhMm7K/Zn2BxRyf7W11QVeT1Ae36HfwQze8XeNX3AOgRynZZWvkkzCsDIn5
         k8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFFtVBi0HSpUYn8AGsyHnTvFEzCVFTNzBhRqHb3wbuM=;
        b=Qdqv67EFKxQ0bBb9vpPjqsVgHlxXLmtFSKjUz/bJCD1g7fCEmYCRLgswptEyydZlYU
         mh0ksMq6Nyacr+h/cehSfB2npF7zdMDbwSXtqlFvRDHi7f7XUXUxwSHD0b+Q9p10jBdK
         ZXrptAmb9DNcGPe9QezYauC828AWqvaT7xfpHhMe+OHSnKRN1w/nujkdB6qeseszCk5b
         0B/5f72ipXx3o73N55MRJhFs4Ln0x47GUjE3tNiUDdqCfG6KcHmi9DCaKv5A5WtMcogg
         wMc3OirqwTphsYbA5EVjinnOc6DpRb+yoZwaSSldLqLvMPmovN8RifSsvW2J0XwQLj1G
         SzIg==
X-Gm-Message-State: AOAM533gHOaTmQ6yoJrQqloVwJXDHjeCRj3NUod1VL9e+u6PfGGd4e/Y
        p48y1qKio1ymp/odBVX4wSHh+Vw27A==
X-Google-Smtp-Source: ABdhPJzbeEMeKcNLxHDebrt2Na4dXkZPoL24OaG7qnTCAkM8pplx3jxvfivkC1lBENOWe5MEnslkDQ==
X-Received: by 2002:a17:902:788b:: with SMTP id q11mr1326079pll.216.1594674803373;
        Mon, 13 Jul 2020 14:13:23 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2409:4071:200a:9520:4919:edd3:5dbd:ffec])
        by smtp.gmail.com with ESMTPSA id g19sm15305137pfb.152.2020.07.13.14.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jul 2020 14:13:22 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Tue, 14 Jul 2020 02:43:16 +0530
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik10@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Fix _list_check_srcu() macro
Message-ID: <20200713211315.GA19516@madhuparna-HP-Notebook>
References: <20200713174846.8681-1-madhuparnabhowmik10@gmail.com>
 <20200713210244.GL9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713210244.GL9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 13, 2020 at 02:02:44PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 13, 2020 at 11:18:46PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > This patch fixes the macro _list_check_srcu() for CONFIG_PROVE_RCU_LIST =
> > False.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Thank you, Madhuparna!  I am folding this into your original, but
> with lowercase "true".
>
I am really sorry and thanks for applying this with the correction.

Regards,
Madhuparna
> 							Thanx, Paul
> 
> > ---
> >  include/linux/rculist.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index 516b4feb2682..a435ad62b90b 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> >  #define __list_check_rcu(dummy, cond, extra...)				\
> >  	({ check_arg_count_one(extra); })
> >  
> > -#define __list_check_srcu(cond)
> > +#define __list_check_srcu(cond)	TRUE
> >  #endif
> >  
> >  /*
> > -- 
> > 2.17.1
> > 
