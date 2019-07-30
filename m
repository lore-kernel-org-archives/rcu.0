Return-Path: <SRS0=Tqm2=V3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063C3C433FF
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 21:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15D8206B8
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 21:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ahlAaMvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfG3VuK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:50:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36470 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfG3VuK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jul 2019 17:50:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so30528795pfl.3
        for <rcu@vger.kernel.org>; Tue, 30 Jul 2019 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+BKxq2zvW/G3+yMMfWlvFPhL1dIassShUGlUo0+V2Mw=;
        b=ahlAaMvQS4rjYqfVnsUJKeziqu8HKLQYgiaZD8xK1yUMWyZWtGc655v/mrPLRpekW4
         TFlButmmm+cXD9haxjScCAfbdiirsOWOaC9z3AwPi1u/IIrOKpwsEhlTXJh/1541N1rL
         V6Utky5MtINFFV2VWCyzkh8p9xhZ+Thrppldc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+BKxq2zvW/G3+yMMfWlvFPhL1dIassShUGlUo0+V2Mw=;
        b=cgBpkc3HCIcQReZ9qJ1zJ0DURFFLRf+nZuWwfe7fKY1Ao1QJTOZizyab88OIGXyg0W
         n9L5QDUpMtIfdmQCilmsnQGVaSGL26qeKCyzfSPd21k3aLpftlzPaDDoefVwrClM1seg
         oPpaHtHW6SEYWZAkbRm6+eQ9Xu1I0FHOaFepBzvRQOIdzylBXht9Td+D/7ujyxtgZXrZ
         4XlyBWzDY5L08+SBc866eTqjVMMsHwbeEJezxmfKRGL9dCNVgFoP//KOAiWlCwzDdjd4
         OM9qvFDLnlILqxTrMJTPA6ag+dn4Y0pCsxACVQJsm8a35msetZH5MeHDSp2J3e1rMeHV
         v1Dg==
X-Gm-Message-State: APjAAAVLlPzpJBuwjqNpvx2Dqo9GH4IVAPi+djVUHiywTKgiVzTbJT9P
        L9XKUx486UrSgj37tl1TiTV754iK
X-Google-Smtp-Source: APXvYqzBtYvOpW8MZN5Z/2/1reQkPTVdbmFWLbijCAJduuWs4XJmyMykXqW6O3fsrMKTVANHfibzQw==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr42878772pfn.98.1564523409500;
        Tue, 30 Jul 2019 14:50:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s20sm75619140pfe.169.2019.07.30.14.50.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:50:08 -0700 (PDT)
Date:   Tue, 30 Jul 2019 17:50:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 25/26] docs: rcu: convert some articles from html to
 ReST
Message-ID: <20190730215007.GA254050@google.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
 <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
 <20190730212250.GJ14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730212250.GJ14271@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 30, 2019 at 02:22:50PM -0700, Paul E. McKenney wrote:
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
> Any advice on how to apply these?  Should I just pull commits from
> somewhere?

I was able to successfully apply and build this particular patch. I think
this is the only one in the series that applies to RCU.

Sadly, I can't find the patch in any of the public archives, but I could
perhaps email it to you as an .mbox attach which 'git am' should be able to
apply.

Mauro did say he was going to add some more details to changelog, or it could
be added when it is applied:
https://lore.kernel.org/rcu/20190726154550.5eeae294@coco.lan/

Let me know how else I can help! I am reviewing this patch further today.

thanks,

 - Joel

