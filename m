Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E15DC433ED
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 17:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2279E61405
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 17:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbhDURu2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbhDURu2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Apr 2021 13:50:28 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA1CC06174A;
        Wed, 21 Apr 2021 10:49:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d6so13579464qtx.13;
        Wed, 21 Apr 2021 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kiwlnfkgGTrM7xFnB6+P2WRhoU4ZK1BamhT8u+Eu9o8=;
        b=SO3/cL9dMcFliYhY106EhS8fdV+uEsYaSg5zP2OT4O5D76ne7bv2CyKrvbLObDsoKJ
         2XDS4qmIRr+ui5w18Z03FWsnrdARAF4ktMDEYwTXbiNNKkPtPdrgiiuaIZPWEWgx1a9s
         oZRHym3RcnN6eNGfqKdBghmZgFZAHbJhgRURn0P0byGaikoMkfc+DX4DRY3k/N8iu7lo
         zdi2p4GFVzZowDSgGd1MHpshXHKqeUnOPu2TDtE8zvLkzYIQxKJ4WVgMwe7cnC7hEq0K
         pgDC2/+AydJOTlICk3V4NansoYundMK+G+ChTBJProdeau8TkOAtDNddRXbdlZ3qP70S
         2SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kiwlnfkgGTrM7xFnB6+P2WRhoU4ZK1BamhT8u+Eu9o8=;
        b=Y3r5aUYWuaIWABZ3H9Yp81x1R94TPcnWZFh3MsWrWoFjhu6r3461XOAR/D1FFcGCfX
         BsYN98Si7FAzf+AePzQFFpgJbMDp67+B8X/2XRL3c/I03N882E/T/tUCUeUAc7r+833F
         CBdQHlJtUPnfRRfKdwRL88Oz6zKXKIS+Q+QvQJhWHpvbB6KogeUtvS4faEqriiGjb+rO
         P3HI7FX4C5eflh4yQQr6qxxnH0bUS84lTd8OjUMzn8XOXDuzg+mAc7tY2+3qjtF/obMs
         BaseiOur5x/Naua4PW5bRdujUSXXv3Psh0DD+ZbVw4DqNljxaRi4uFZnURt09sMPDFjS
         Qb2g==
X-Gm-Message-State: AOAM531NT2iSuA242ZcVZxZh406JAJwd9sNB5d6bquxXMpBnktE9l37d
        ivvqleh/Yp3tBb2LBYP0aBp5VvqPAlM=
X-Google-Smtp-Source: ABdhPJzjqtGEdIv0HyEfkFIOQvHJ0dsbpdxxCKNjTgAyBLn4RiZk1g1PtbaawkV98dgcHwiIlbrnDQ==
X-Received: by 2002:a05:622a:46:: with SMTP id y6mr21947498qtw.44.1619027392326;
        Wed, 21 Apr 2021 10:49:52 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id h62sm15225qkf.116.2021.04.21.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:49:51 -0700 (PDT)
Date:   Wed, 21 Apr 2021 10:49:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/2] bitmap_parselist: support 'all' semantics
Message-ID: <20210421174950.GA106553@yury-ThinkPad>
References: <20210421031326.72816-1-yury.norov@gmail.com>
 <20210421173008.GV975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421173008.GV975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 21, 2021 at 10:30:08AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 20, 2021 at 08:13:24PM -0700, Yury Norov wrote:
> > RCU code supports a special group 'all' which selects all bits in a bitmap.
> > We have recently added 'N' extension for bitmap parse, so that '0-N' would
> > have exactly the same meaning as 'all'. But because the 'all' is already
> > used by RCU, it would be reasonable to support it in core bitmap code as a
> > common and easy-readable alias for '0-N'.
> > 
> > Moving the 'all' support to core bitmap code adds another level of
> > flexibility for system configuration by supporting patterns. For example,
> > every second bit in cpumask may be selected like this:
> > 	isolcpus=all:1/2
> > 
> > v2:
> >  - cleanup patch 1;
> >  - in patch 2 explain why dropping legacy comment.
> 
> Nice!
> 
> I have pulled this into -rcu with some minor updates, including replacing
> the "isolcpus=all" with "rcu_nocbs=all:1/2" per Steve Rostedt's feedback.

Thank you Paul and Steven for fixing this 'isolcpus=all'.
'rcu_nocbs=all:1/2' would look better in the documentation.
 
> Could you please check to make sure that I didn't mess anything up?

Everything is OK. Thank you for fixing this.

> If tests go well, this will go into -next later today or tomorrow.
> Although I cannot prove that this will not make the upcoming merge window,
> but Murphy insists that it will instead be the v5.14 merge window.
> 
> 							Thanx, Paul
> 
> > Yury Norov (2):
> >   bitmap_parse: support 'all' semantics
> >   rcu/tree_plugin: don't handle the case of 'all' CPU range
> > 
> >  Documentation/admin-guide/kernel-parameters.rst | 5 +++++
> >  kernel/rcu/tree_plugin.h                        | 9 +++------
> >  lib/bitmap.c                                    | 9 +++++++++
> >  lib/test_bitmap.c                               | 7 +++++++
> >  4 files changed, 24 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 
