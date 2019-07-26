Return-Path: <SRS0=Ypbo=VX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926EDC7618F
	for <rcu@archiver.kernel.org>; Fri, 26 Jul 2019 18:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B52421842
	for <rcu@archiver.kernel.org>; Fri, 26 Jul 2019 18:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ATl2MF1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfGZSCF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:02:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46268 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfGZSCE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Jul 2019 14:02:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so25002932plz.13
        for <rcu@vger.kernel.org>; Fri, 26 Jul 2019 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=14H5paQYitVS4/WKEkQEhitnAZvza/nR/XH2Tu80JBM=;
        b=ATl2MF1PvrU6lqcczyISZ5li9yUR8jig8dOSRgnjQeXeiDCIVHf64anGGJiNWgbJRZ
         8D0mrbgpCzlusjkYRt+BFu3Sjf507OvqqyxGlU54NakUjQCByhzDfCAJ8KbksbolpjiE
         6l81eTSLCHx3OmpsLBpNnYlhDb2+PuQ5S0q70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=14H5paQYitVS4/WKEkQEhitnAZvza/nR/XH2Tu80JBM=;
        b=nIYmhnIcTDzdupf9j2AdXlJxzXsNWfKW/MGRA3XaP0b2tD48KRYZPzcutnoBvYjAYt
         8RIr+3nU5KUXZUYm2PprUnSE5L4jljv28aj+IG5S3FSPJYksNhj7vrwunPNkduqwRPg8
         qIQWA4vhq6z8ILMCYQzvrHxVhceBH9f3lUJvcV3wSXAKR6/kiuGenf5I6j8Kmucp0sps
         LhMGhh8lOs+Hx/Ov6QCC/TwDl76HS78BgHELzZ6mC94zPe11pIk2uymZ2yZPvpI/1pYK
         K2kIRXzCw07Dx9C4JtymbZLD0yx80aYFE1NaXAVxbydEIMjaP9JEbYPu0L3coJEtTaPq
         R/jg==
X-Gm-Message-State: APjAAAVxpTZ+w/fC8a2K8uPr5oqGp1UVmiY6Q9dIkEdrtCHk0IxJIPd+
        tzKi9cWBkujQ8gSjORwHKAA=
X-Google-Smtp-Source: APXvYqw97ZsPDtoTN2djhrefEf5+wLhvEdfdhidAUMzWJN9QkJDPwJHLI27GDbQ70fWEquCP6vW8Kw==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr99206440pla.5.1564164123861;
        Fri, 26 Jul 2019 11:02:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d17sm63317928pgl.66.2019.07.26.11.02.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 11:02:03 -0700 (PDT)
Date:   Fri, 26 Jul 2019 14:02:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 25/26] docs: rcu: convert some articles from html to
 ReST
Message-ID: <20190726180201.GE146401@google.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
 <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:
[snip]
> +| until the assignment to ``gp``, by which time both fields are fully   |
> +| initialized. So reordering the assignments to ``p->a`` and ``p->b``   |
> +| cannot possibly cause any problems.                                   |
> ++-----------------------------------------------------------------------+
> +
> +It is tempting to assume that the reader need not do anything special to
> +control its accesses to the RCU-protected data, as shown in
> +``do_something_gp_buggy()`` below:
> +
> +   ::
> +
> +       1 bool do_something_gp_buggy(void)
> +       2 {
> +       3   rcu_read_lock();
> +       4   p = gp;  /* OPTIMIZATIONS GALORE!!! */
> +       5   if (p) {
> +       6     do_something(p->a, p->b);
> +       7     rcu_read_unlock();
> +       8     return true;
> +       9   }
> +      10   rcu_read_unlock();
> +      11   return false;
> +      12 }
> +
> +However, this temptation must be resisted because there are a
> +surprisingly large number of ways that the compiler (to say nothing of
> +`DEC Alpha CPUs <https://h71000.www7.hp.com/wizard/wiz_2637.html>`__)
> +can trip this code up. For but one example, if the compiler were short
> +of registers, it might choose to refetch from ``gp`` rather than keeping
> +a separate copy in ``p`` as follows:
> +
> +   ::
> +
> +       1 bool do_something_gp_buggy_optimized(void)
> +       2 {
> +       3   rcu_read_lock();
> +       4   if (gp) { /* OPTIMIZATIONS GALORE!!! */
> +       5     do_something(gp->a, gp->b);
> +       6     rcu_read_unlock();
> +       7     return true;
> +       8   }
> +       9   rcu_read_unlock();
> +      10   return false;
> +      11 }
> +
> +If this function ran concurrently with a series of updates that replaced
> +the current structure with a new one, the fetches of ``gp->a`` and
> +``gp->b`` might well come from two different structures, which could
> +cause serious confusion. To prevent this (and much else besides),
> +``do_something_gp()`` uses ``rcu_dereference()`` to fetch from ``gp``:
> +
> +   ::
> +
> +       1 bool do_something_gp(void)
> +       2 {
> +       3   rcu_read_lock();
> +       4   p = rcu_dereference(gp);
> +       5   if (p) {
> +       6     do_something(p->a, p->b);
> +       7     rcu_read_unlock();
> +       8     return true;
> +       9   }
> +      10   rcu_read_unlock();
> +      11   return false;
> +      12 }
> +
> +The ``rcu_dereference()`` uses volatile casts and (for DEC Alpha) memory
> +barriers in the Linux kernel. Should a `high-quality implementation of
> +C11 ``memory_order_consume``
> +[PDF] <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__
> +ever appear, then ``rcu_dereference()`` could be implemented as a
> +``memory_order_consume`` load. Regardless of the exact implementation, a
> +pointer fetched by ``rcu_dereference()`` may not be used outside of the
> +outermost RCU read-side critical section containing that
> +``rcu_dereference()``, unless protection of the corresponding data
> +element has been passed from RCU to some other synchronization
> +mechanism, most commonly locking or `reference
> +counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.

From the make htmldocs output, this appears very poorly for me, I get
something like this in the browser:

The rcu_dereference() uses volatile casts and (for DEC Alpha) memory barriers
in the Linux kernel. Should a high-quality implementation of C11
``memory_order_consume` [PDF]
<http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__ ever
appear, then rcu_dereference() could be implemented as a memory_order_consume
load.

Is there a syntax issue here?

One more feedback,
the image under "RCU read-side critical section that started before the current
grace period:" should probably be blown up a bit.
