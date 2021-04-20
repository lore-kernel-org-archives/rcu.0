Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDDDC433ED
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 19:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1917F613DB
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhDTTdZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhDTTdY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Apr 2021 15:33:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587BC06174A;
        Tue, 20 Apr 2021 12:32:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i12so9065606qke.3;
        Tue, 20 Apr 2021 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+SxMgumr24PRznk/dw2CQAvRlHHtf2Bm9jyWKNq7r2U=;
        b=tXFpeh2kvp8PPMCJjFV0Ko5/Zf56vNqWdARCa2gbOjxq5Hb4geDXZiXFOqK8PUBSL+
         mz+NP+2E5PKTYzsTsYkQwV1riQMIJgYDp3uYRo75rgDCs5qo20xxKeKSjGx527n8pON3
         fzKKBWLam9WkgZhTt0yaRgiQkQkd/tySAUkND3xHWxJDkuVJzM7+/V503E2CE4aDeFv8
         gx3ZmP6Jnx2uzaNEuO5pD8HWcIDO0kfQL6lZ5w4L+gRjyxX2MGqLTCuTEewhle6gy0QV
         w+IyILdqvPzS+BYN70+rCDorHf6ZiKGdF6mNtMQTN5xvZUB6JrGePgYog+cUpXyDYYdI
         TE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+SxMgumr24PRznk/dw2CQAvRlHHtf2Bm9jyWKNq7r2U=;
        b=s5um6eosDUBLLKfYz59YQL3rv3wJaDdL7SnHyxIA8a4aLiFtSqYafzRS2J89+nnEUL
         eiAVBptydWIfJ3W3HSgL1tXp8YLaFfml7INKMA6W+c6tv6W7Slzv4bPMqiWGNQJgBKe7
         AF9NzOTS8bU8dD3K8clablrwudwdB9OPuuwEUwvgj2rjwZFqn92nH8hJkjzbOolfpcy7
         pHSr40Jqy7dAoo6P8bp1zzWK+3GTZQMBmKRsF8eANqXj5eI12r6AGJDcJe3B6HEvduas
         feh68fHlcZucJuUnX434vufbdNKD8cWXIVwPPE1/tFS9BXUm9EYqqbB6/yFC4I53eURu
         o+kw==
X-Gm-Message-State: AOAM531RO1DaSPEqbh03Qzd6AfxqYWHBjN4fD1pHrAirjTpPtYPbqmAh
        bUPYl2FwpXiEuao5ncfMzwc=
X-Google-Smtp-Source: ABdhPJxOXz6kQ5QWRK8Nhz0L1WsC2GU2HHhVMn/9pslWTIRT6dkBOzzNxHOBecAxh8oYa3FWPowLGg==
X-Received: by 2002:a37:8906:: with SMTP id l6mr632740qkd.198.1618947171788;
        Tue, 20 Apr 2021 12:32:51 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id t21sm15515qkj.32.2021.04.20.12.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 12:32:51 -0700 (PDT)
Date:   Tue, 20 Apr 2021 12:32:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] bitmap_parse: support 'all' semantics
Message-ID: <20210420193250.GA61766@yury-ThinkPad>
References: <20210420000131.21038-1-yury.norov@gmail.com>
 <20210420000131.21038-2-yury.norov@gmail.com>
 <YH6qUDJmUflEmper@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH6qUDJmUflEmper@smile.fi.intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 20, 2021 at 01:17:52PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 19, 2021 at 05:01:30PM -0700, Yury Norov wrote:
> > RCU code supports an 'all' group as a special case when parsing
> > rcu_nocbs parameter. This patch moves the 'all' support to the core
> > bitmap_parse code, so that all bitmap users can enjoy this extension.
> > 
> > Moving 'all' parsing to a bitmap_parse level, also allows users to
> > pass patterns together with 'all' in regular group:pattern format
> 
> ...
> 
> >  	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
> >  	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
> >  
> > +	{0,	  "all",		&exp1[8 * step], 32, 0},
> > +	{0,	  "0, 1, all,  ",	&exp1[8 * step], 32, 0},
> > +	{0,	  "all:1/2",		&exp1[4 * step], 32, 0},
> > +	{0,	  "ALL:1/2",		&exp1[4 * step], 32, 0},
> 
> > +	{-EINVAL, "al", NULL, 8, 0},
> > +	{-EINVAL, "alll", NULL, 8, 0},
> > +
> 
> Looking at the below hunk it seems like the two above should be actually placed
> there.
> 
> >  	{-EINVAL, "-1",	NULL, 8, 0},
> >  	{-EINVAL, "-0",	NULL, 8, 0},
> >  	{-EINVAL, "10-1", NULL, 8, 0},
> > @@ -384,7 +391,6 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
> >  	{-EINVAL, "a-31:10/1", NULL, 8, 0},
> >  	{-EINVAL, "0-31:a/1", NULL, 8, 0},
> >  	{-EINVAL, "0-\n", NULL, 8, 0},
> > -
> 
> Otherwise this change doesn't belong to the series.

My bad, I'll fix it in v2.
