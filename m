Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D303C433B4
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 19:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E14613E1
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 19:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhDTTjW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhDTTjU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Apr 2021 15:39:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1BC06174A;
        Tue, 20 Apr 2021 12:38:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id q4so1207251qtn.5;
        Tue, 20 Apr 2021 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnARtP+uP1DchxUYKI/5VcNMJQIOlS/yRqSiMEZtvXs=;
        b=gwBN8QKDOZbIX5Xw/3NQFidpiuNssHneim4IycyV9/mPUC0tGy93UFvFItssSptJBZ
         mBGiskvSZCxJjPMKtaFLexvc+XIcy/5VuzA1GeyQE9KFNOH6fBEQe9YhlscprGOh7XeD
         YJwy7GnzZIUQ66LFgPKwywVwVsEaYiqnoDwRHX6aSEj1mKKN88aGUPYIz8q9YxhENuOx
         24z+FTyq0SrHfUd0Dyq9NujbrYKxXPZiBIIe/9f5/ectNRSKebjD56UZVSKlFt/OMERG
         +adsY7QVWKTjYaaQYSgNyHU/bzlO7+Me7zqpo0k8m+ZBS18UJlQBkDWmdFoywcC+Tigj
         PPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnARtP+uP1DchxUYKI/5VcNMJQIOlS/yRqSiMEZtvXs=;
        b=KrequED5RjvGOhhg4S6056pPofX6oGWeK3xDFaAPg15PGxpvzv8HNlZeWWGgT6TkX/
         cZB2Mr4wBKeB1P0nH1YLYTHfQMRnboSAYga1Ot40fyZA5T5HCIF/XnWfDIotxdfw+aiL
         8O6oFVX4YgsECHmbTbUlJYlHil9rrSDpH6CMLAgAQ8bouSX0H7hs4I3CzP/0YZvF3IkR
         w8DCU2bNAjzYrYIUX66AxvBlU9JuA1oW6Ag2gp4bejg6fbne+95Djk0Pef2M8W9UQp2z
         65FCAj3Zzlj0RtrjR60uPKJJO56LZkFMtmg9dzAaZbrnxkbdbork4rTksmFAP6BCRUOD
         K3bQ==
X-Gm-Message-State: AOAM533+UwCem6+jQcB8oc+DWyf/xEj6TIB4IOXhLg9Hw1RFCYom2CTL
        88xAbAmtYWKCPIFRDrAiUvR0BfKzFc4=
X-Google-Smtp-Source: ABdhPJy7CkrW8SNRn4LAWJ2HO6RCjd9DHJZesyG6EfmDwFWVOF96advIZN4W2gll4lWBWphHWJ8ELA==
X-Received: by 2002:ac8:78b:: with SMTP id l11mr9571993qth.321.1618947527395;
        Tue, 20 Apr 2021 12:38:47 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id j9sm1117853qtl.12.2021.04.20.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 12:38:47 -0700 (PDT)
Date:   Tue, 20 Apr 2021 12:38:46 -0700
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
Subject: Re: [PATCH 2/2] rcu/tree_plugin: don't handle the case of 'all' CPU
 range
Message-ID: <20210420193846.GB61766@yury-ThinkPad>
References: <20210420000131.21038-1-yury.norov@gmail.com>
 <20210420000131.21038-3-yury.norov@gmail.com>
 <YH6qgHH1RtBCHxEy@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH6qgHH1RtBCHxEy@smile.fi.intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 20, 2021 at 01:18:40PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 19, 2021 at 05:01:31PM -0700, Yury Norov wrote:
> > The 'all' semantics is now supported by the bitmap_parselist() so we can
> > drop supporting it as a special case in RCU code. This patch does not
> > add any functional changes for existing users.
> 
> > -	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
> 
> Perhaps move comment as well to new location.

I actually wanted to remove this comment. The reason is that 'all' is
verbose, clear and proven to be useful for at least RCU. In v2 I'll
mention it explicitly in commit comment.
