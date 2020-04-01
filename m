Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1BC2D0F0
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274E92071A
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585757466;
	bh=sdqNCMsXIutp4Q5binKYP979DEqV9uoSaRz85ONNJk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=npcMzAFQLrf94CryxwSa/PgJk//qYcREj2eFeNPCEltg+xnIS2riSma5IsWqmyPuZ
	 xufDFsF5jfNLMYd0SSP6ot+aP/RVdDnoisLCyWpzJRGWehQTdLZfwH7jZtiKplM4el
	 KyqSmfcPSqZ3NpyP8ml/iGmm4sl39xIqu4cHZkQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgDAQLF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:11:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33594 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDAQLF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 12:11:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so776219wrd.0;
        Wed, 01 Apr 2020 09:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6SgSqYLabdht19WsqZYrt1JZCOHPoNOa62kgTyu4dDY=;
        b=gxPfVNTVtYMFQ72Wu+U1w5wupZXg47CZVJfLSuT0NJ0jVnHykL3jNCSLCz24ZzDsec
         9LWKCwOdZCL6Yf7gXVq1HRn60jNitQB+5GzsooD76lxpu+JqP+lVWDyqkbDIBcFBm+x+
         heTcZHKCNhlJuOdHdVytZQvYoupZYFxMJr5Px1C4PDo8eKAlntx87BCuYSCfcFXDf+Co
         hVnYeWevW4cVWH2OVHNCSC9OXcJ5131SR19f8V97rBTTvEYpyP7H6MEiUu+HeAvUUdvi
         w42/Mh/sM426P2A2SiYFS1gMPyavd7E0egu8yf9rq1PnbqO4mzI8sKymlBtEOPRq55Uj
         TXbw==
X-Gm-Message-State: ANhLgQ093Bf1GrJOAcCnULEY52IoPBrF+htTKUaKMyoKmb40DWfRwgMs
        iRPeqdfbEfTxMrenztcaVjU=
X-Google-Smtp-Source: ADFU+vsJ7ptO/+sfU8MVbmxUQXnHszAgWJSKgC0msCpRCKplGfHo1pAnZvZsGDgekyFl//FlRsrmVg==
X-Received: by 2002:adf:df8a:: with SMTP id z10mr25302935wrl.278.1585757461997;
        Wed, 01 Apr 2020 09:11:01 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id i2sm3499892wrx.22.2020.04.01.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:11:01 -0700 (PDT)
Date:   Wed, 1 Apr 2020 18:10:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401161059.GV22681@dhcp22.suse.cz>
References: <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
 <20200401070958.GB22681@dhcp22.suse.cz>
 <20200401123230.GB32593@pc636>
 <20200401125503.GJ22681@dhcp22.suse.cz>
 <20200401130816.GA1320@pc636>
 <20200401131528.GK22681@dhcp22.suse.cz>
 <20200401132258.GA1953@pc636>
 <20200401152805.GN22681@dhcp22.suse.cz>
 <20200401155712.GA15147@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401155712.GA15147@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 01-04-20 08:57:12, Paul E. McKenney wrote:
[...]
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index e3ab1c0d9140..8f09cefdfa7b 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -127,6 +127,8 @@ struct vm_area_struct;
> >   *
> >   * Reclaim modifiers
> >   * ~~~~~~~~~~~~~~~~~
> > + * Please note that all the folloging flags are only applicable to sleepable
> 
> s/folloging/following/

Fixed. I will add it on top of http://lkml.kernel.org/r/20200401120502.GH22681@dhcp22.suse.cz
and post both later this week to Andrew.

From ce456c2f6c8fe0588c1d743a5b87e283aa4806f8 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 1 Apr 2020 18:02:23 +0200
Subject: [PATCH] mm: make it clear that gfp reclaim modifiers are valid only
 for sleepable allocations

While it might be really clear to MM developers that gfp reclaim
modifiers are applicable only to sleepable allocations (those with
__GFP_DIRECT_RECLAIM) it seems that actual users of the API are not
always sure. Make it explicit that they are not applicable for
GFP_NOWAIT or GFP_ATOMIC allocations which are the most commonly used
non-sleepable allocation masks.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/gfp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e3ab1c0d9140..8040fa944cd8 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -127,6 +127,8 @@ struct vm_area_struct;
  *
  * Reclaim modifiers
  * ~~~~~~~~~~~~~~~~~
+ * Please note that all the following flags are only applicable to sleepable
+ * allocations (e.g. %GFP_NOWAIT and %GFP_ATOMIC will ignore them).
  *
  * %__GFP_IO can start physical IO.
  *
-- 
2.25.1

-- 
Michal Hocko
SUSE Labs
