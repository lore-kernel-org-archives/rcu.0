Return-Path: <SRS0=3CeA=5U=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EBEC2BA17
	for <rcu@archiver.kernel.org>; Sat,  4 Apr 2020 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA326206F5
	for <rcu@archiver.kernel.org>; Sat,  4 Apr 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+3xMmnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDTKR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 4 Apr 2020 15:10:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33369 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgDDTKR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 4 Apr 2020 15:10:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so10461633ljm.0;
        Sat, 04 Apr 2020 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tl3rjpPzWvGvL5lEB/U94s6R20w0vWjGnxBhIo2dvKk=;
        b=R+3xMmnLBQT6BKGYkGzjIs2vz/gt3i1MDNgUWxP2CZUYyP/jPprxcX9sL9dxwqEJRn
         Q0iEfHnfH3kZ13ID8pHx0VYmACizj7+NTuycPI03Ucrz32S7EpRLH3ISv/INGQZCwbhY
         sjb1AGF3pgqxTlDtjqCO8Br8EPRx7Ci/tIQg+Ub271zKXvMvTgWUsEfZ+QqNMNZ5bYnZ
         mQUx2h9e+7VCkbFnX1IoX8FynL+0GW72qGETVQH4Im+UVITmuAqp7ZwoaSPLqlz+sWM4
         CoPpVVIP/UKy4foUp4BK5Na4yKcghfqv3GENVQ6J3/E2DG7rsElwi5qCUeJI/lcYZC2D
         TTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tl3rjpPzWvGvL5lEB/U94s6R20w0vWjGnxBhIo2dvKk=;
        b=A9/Rny+8Pg+ijALeyaCGomZJXEZlofse0xp6X9P5WjxviOftJy2iz8QmdjXXf9xalW
         oJf/hra5J29NDSbQgGP6NG2sN9XDISGhkMkPPzK6wle2n/Q8uiBNyMpHRkcmWHizcFYA
         arFicP95J3ftw8G+IkgoOiTESOBK0UtKgO51/bbNE+QIEcjlKTlSBIKguXxzPll0RLiM
         2hMGgEG90KXNS9YFzZuzxhcZ+b7SLbeavaPW2kaaWedUQgV8TfocYSU3E7ZE5bGpV83U
         aSf4WpEZTSC13adret4cgbDGkQKcxTOnjF7qS2d3ZeCxaSwDEYhV2kqQVwtc3OJ4sTl4
         aPXw==
X-Gm-Message-State: AGi0Pub7MflXO6Mem2xf3opS+SS9vAu81U0UHDNEYAgcx9NvaMQXSFuc
        V6h+0cgniuT0BD1bQcAka7g=
X-Google-Smtp-Source: APiQypJ5Bd4cb55PnwIBXPCIWT2apA4KPXv3BEMMC4L//z/T8pBCdKHDTlpqBVA2XnPhAUyRblNVNg==
X-Received: by 2002:a2e:8316:: with SMTP id a22mr8266776ljh.70.1586027413292;
        Sat, 04 Apr 2020 12:10:13 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id p2sm3419402lfh.85.2020.04.04.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 12:10:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 4 Apr 2020 21:10:10 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200404191010.GD424@pc636>
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200403191419.GU19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403191419.GU19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 03, 2020 at 12:14:19PM -0700, Paul E. McKenney wrote:
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
> > ---
> >  kernel/rcu/tree.c | 133 +++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 97 insertions(+), 36 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 5e26145e9ead..f9f1f935ab0b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -114,6 +114,14 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
> >  int rcu_kfree_nowarn;
> >  module_param(rcu_kfree_nowarn, int, 0444);
> >  
> > +/*
> > + * For headless variant. Under memory pressure an
> > + * emergency pool can be used if the regular SLAB
> > + * is not able to serve some memory for us.
> > + */
> > +int rcu_nr_emergency_objs = 3;
> > +module_param(rcu_nr_emergency_objs, int, 0444);
> 
> Please document this in Documentation/admin-guide/kernel-parameters.txt.
> 
Will do that, Paul!

Thanks for good point :)

--
Vlad Rezki
