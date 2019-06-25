Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F419C48BD6
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AAE2085A
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 21:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFYVB5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:01:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:34510 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFYVB5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jun 2019 17:01:57 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B2E5F30A;
        Tue, 25 Jun 2019 21:01:56 +0000 (UTC)
Date:   Tue, 25 Jun 2019 15:01:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Jiunn Chang <c0d1n61at3@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [Linux-kernel-mentees][PATCH v3 5/6] Documentation: RCU: Add
 links to rcu.rst
Message-ID: <20190625150155.5c9b8880@lwn.net>
In-Reply-To: <20190625155623.GA26519@linux.ibm.com>
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
        <20190625062627.26378-6-c0d1n61at3@gmail.com>
        <20190625155623.GA26519@linux.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 25 Jun 2019 08:56:23 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> > -  See the UP.txt file in this directory.
> > +  See :ref:`up_rcu` for more information.  
> 
> This rendered as straight text after "make htmldocs" instead of producing
> a link in the HTML output.  The HTML itself is:
> 
> 	<span class="xref std std-ref">up_rcu</span>
> 
> This doesn't look like something that would create a link, though I
> freely admit that my HTML is rather outdated.

The problem is that the reference target isn't called "up_rcu" in the file
itself:

> diff --git a/Documentation/RCU/UP.txt b/Documentation/RCU/UP.txt
> index 53bde717017b..67715a47ae89 100644
> --- a/Documentation/RCU/UP.txt
> +++ b/Documentation/RCU/UP.txt
> @@ -1,17 +1,19 @@
> -RCU on Uniprocessor Systems
> +.. _up_doc:

Certainly "up_rcu" seems like a better name.  I do believe, though, that
you can also use the title directly:

  See `RCU on Uniprocessor Systems`_ for more information

> >  - How can I see where RCU is currently used in the Linux kernel?
> >  
> > @@ -67,7 +67,7 @@ Frequently Asked Questions
> >  
> >  - Why the name "RCU"?
> >  
> > -  "RCU" stands for "read-copy update".  The file listRCU.txt has
> > +  "RCU" stands for "read-copy update".  :ref:`list_rcu` has  
> 
> Same here for list_rcu.

And the problem is the same, it's list_rcu_doc in the actual source file.

Jiang, as with so many things in software, if you haven't tested it, it
probably doesn't work.  Please actually run "make htmldocs" and look at
the results to be sure that they are what you expect.  (Along those lines,
it would also be good to add the new directory to Documentation/index.rst
so that it gets built with the rest).

Thanks,

jon
