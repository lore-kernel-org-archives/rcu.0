Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F42C48BD6
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E2C208CA
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 21:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFYVkM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:40:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:34736 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfFYVkM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jun 2019 17:40:12 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 80BDC30A;
        Tue, 25 Jun 2019 21:40:11 +0000 (UTC)
Date:   Tue, 25 Jun 2019 15:40:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Jiunn Chang <c0d1n61at3@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [Linux-kernel-mentees][PATCH v3 5/6] Documentation: RCU: Add
 links to rcu.rst
Message-ID: <20190625154010.557448ff@lwn.net>
In-Reply-To: <20190625211740.GQ26519@linux.ibm.com>
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
        <20190625062627.26378-6-c0d1n61at3@gmail.com>
        <20190625155623.GA26519@linux.ibm.com>
        <20190625150155.5c9b8880@lwn.net>
        <20190625211740.GQ26519@linux.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 25 Jun 2019 14:17:40 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> > Certainly "up_rcu" seems like a better name.  I do believe, though, that
> > you can also use the title directly:
> > 
> >   See `RCU on Uniprocessor Systems`_ for more information  
> 
> That does look prettier, though we might want to do something more
> directly mapped for people directly reading the .rst files.

Yeah, the alternative there is to just say "Documentation/RCU/UP.rst".
It's vaporware at the moment, but the plan is to recognize such strings
and link them up automatically in the build process.  It's easy enough to
do, I just have to get around to it.  In anticipation of that, just
putting in the file name is probably the right thing to do.

Thanks,

jon
