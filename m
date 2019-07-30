Return-Path: <SRS0=Tqm2=V3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70884C32750
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B211206E0
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564523469;
	bh=uci6l7hzYzfi082Q8YOe3NQ5JTEQQzOYYBkU2r/xrb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m4PXNCG7smJCHe+Q68FAIIqN9t6UkJfCa8BTRBGL8HkvkDAeC6tBj4D5W7DElJc2e
	 Sowa4oH/Yf28fYcleUhWmHZ7K9x4D9zIMUF5Hfk7/h/iMomga5Ls9zthBxICWEr+m2
	 FGrgzLhRd1L5msdt5sB6rSE6vqkGFT+r2WGzOvkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfG3VvJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:51:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfG3VvI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jul 2019 17:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2YM+iRTjD02xQQLTCNDr1ceqwh6Wn/ZI6sRCyZvD2A4=; b=UNTzpSj0IBHeyp8yWfAy3K6FW
        gjgzxQNn3C438iKxDw5RmIGgU2Pz/4y5w1JRT39KFWJmBsS8MTh67PHnH0/i1jh/VYJiofZzDRUDY
        seUpmRwkfz4XkEmgqy9RVUz5Jk9cqaJorZRh/nsiJPknmOpGYTiqzhRAKvzOV8V4NdWLU/37z4B8U
        sy73T/Dg0gJVCVtBrZm7h+ybABXvVIJEy06PK7eub2hc0noABxnvI+z2030tZyvKJW0AvKz74AL8j
        /RZyT9pzwEmhUb4j0zAylhKCmHK/sD6mHj9iZKiWliU05EAYDc5ZCmx6+mu26UDyyHHIvkPkC07N7
        m5hqRrDJQ==;
Received: from [177.157.101.143] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsa1H-0001XD-Uc; Tue, 30 Jul 2019 21:50:56 +0000
Date:   Tue, 30 Jul 2019 18:50:51 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 25/26] docs: rcu: convert some articles from html to
 ReST
Message-ID: <20190730185040.3fbc44ca@coco.lan>
In-Reply-To: <20190730212250.GJ14271@linux.ibm.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
        <20190730212250.GJ14271@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Tue, 30 Jul 2019 14:22:50 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> escreveu:

> On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:
> > There are 4 RCU articles that are written on html format.
> > 
> > The way they are, they can't be part of the Linux Kernel
> > documentation body nor share the styles and pdf output.
> > 
> > So, convert them to ReST format.
> > 
> > This way, make htmldocs and make pdfdocs will produce a
> > documentation output that will be like the original ones, but
> > will be part of the Linux Kernel documentation body.
> > 
> > Part of the conversion was done with the help of pandoc, but
> > the result had some broken things that had to be manually
> > fixed.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> I am having some trouble applying these, at least in part due to UTF-8
> sequences, for example double left quotation mark.  These end up being
> "=E2=80=9C", with a few space characters turned into "=20".
> 
> Any advice on how to apply these?

Didn't notice it ended with UTF-8 chars. It is probably because it came
from the html conversion.

I guess it shouldn't hurt keeping those, but if you prefer I can find 
some time later to replace them.

> Should I just pull commits from somewhere?

Yeah, if you prefer, you can pull from this branch:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=rcu-v1

It has just two patches: the RCU and tools/memory-model ones.

It is based on v5.3-rc2.

Thanks,
Mauro
