Return-Path: <SRS0=Ypbo=VX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2875CC76191
	for <rcu@archiver.kernel.org>; Fri, 26 Jul 2019 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3261218B8
	for <rcu@archiver.kernel.org>; Fri, 26 Jul 2019 17:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QA8YC1na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfGZRza (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:55:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46795 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfGZRza (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Jul 2019 13:55:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so1724919pfa.13
        for <rcu@vger.kernel.org>; Fri, 26 Jul 2019 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fIEQ/rN6TuynElYAq5+lHqap74wdnXdLlsttyXNjH4=;
        b=QA8YC1na5sGMKcBdn4bysIlb2yL9sVlYEPximyWG2Mbn0jj+5chPnPXvVfFnlGeu1F
         H/icn9uOPIRD8RsEeUQYaenrQhycela8rSIE9f4jLrCNokfA2TNwzcHvqLKmg2Yb9gKf
         uS3yJ1mqbOe+mLzcZyXStwZPqoBj1sEjd69h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fIEQ/rN6TuynElYAq5+lHqap74wdnXdLlsttyXNjH4=;
        b=FDl/QvXxo9mHGNVjoxEVEpaejksm9eIoldfkRiix/ULzyAmI4G2j3RDKLvh6XwMVtb
         lIhAfs/DVvPQMorM2bwxDhAFbdXIAKZLpDVVDine8U1BTbuMOEQmhAhEBY3L+EHhQRV8
         uBd1WyGzJmqfonRCUXTCDgk9wJZivAdl3+OTAGPqXaRdGIUQESeIjCZKvJQeBR9152Mo
         iTvWPR+m5PjixXXijM0RetYZDQgd5RDo/LknMg+GPemYOoEppmASh7YOiBtLDoXn3Wn8
         y7dUGbc4NbUGOBoARJplGauPtdXMkqCiiKAALWFod8h0Y735Okpc9dlinN6x99k2sENx
         +CBw==
X-Gm-Message-State: APjAAAWXfMJ6L87d6/nE5VX0k0ghbENFYo5B8Jb64odwz96qrUmcxwfI
        eZGAi231E/67KZ8XGkx4fhY=
X-Google-Smtp-Source: APXvYqxxu6QceJ+8y8qbWMgZcdskuT5YWE9rp2petvNwlDt0G92QRX4JPz26bnDmlBn8OePHLp6Odg==
X-Received: by 2002:a62:2582:: with SMTP id l124mr23333722pfl.43.1564163729394;
        Fri, 26 Jul 2019 10:55:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a25sm27783889pfo.60.2019.07.26.10.55.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 10:55:28 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:55:27 -0400
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
Message-ID: <20190726175527.GD146401@google.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
 <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
 <20190726162002.GA146401@google.com>
 <20190726140028.38abb5fa@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726140028.38abb5fa@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 26, 2019 at 02:00:28PM -0300, Mauro Carvalho Chehab wrote:
> Hi Joel,
> 
> Em Fri, 26 Jul 2019 12:20:02 -0400
> Joel Fernandes <joel@joelfernandes.org> escreveu:
> 
> > On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:
> > > There are 4 RCU articles that are written on html format.
> > > 
> > > The way they are, they can't be part of the Linux Kernel
> > > documentation body nor share the styles and pdf output.
> > > 
> > > So, convert them to ReST format.
> > > 
> > > This way, make htmldocs and make pdfdocs will produce a
> > > documentation output that will be like the original ones, but
> > > will be part of the Linux Kernel documentation body.
> > > 
> > > Part of the conversion was done with the help of pandoc, but
> > > the result had some broken things that had to be manually
> > > fixed.  
> > 
> > This looks Ok to me, but I also nervous something could have been done
> > incorrectly during the conversion.
> > 
> > Could you list what were the "some broken things" that you had to manually
> > fix to make reviewing easier?
> 
> There are a couple of things.
> 
> At least the pandoc's version I used here has a bug: its conversion 
> from html to ReST on those files only start after a <body> tag - or 
> when the first quiz table starts. I only discovered that adding a
> <body> at the beginning of the file solve this book at the last
> conversions.
> 
> So, for most html->ReST conversions, I manually converted the first
> part of the document, basically stripping html paragraph tags and
> by replacing highlights by the ReST syntax.
> 
> Also, all the quiz tables seem to assume some javascript macro or
> css style that would be hiding the answer part until the mouse moves
> to it. Such macro/css was not there at the kernel tree. So, the quiz
> answers have the same color as the background, making them invisible.
> Even if we had such macro/css, this is not portable for pdf/LaTeX output
> (and I'm not sure if this would work with ePub).
> 
> So, I ended by manually doing the table conversion.
> 
> Finally, I double-checked if the conversions ended ok, addressing any
> issues that might have heppened.
> 
> So, after both automatic conversion and manual fixes, I opened both the 
> html files produced by Sphinx and the original ones and compared them
> line per line (except for the indexes, as Sphinx produces them 
> automatically), in order to see if all information from the original 
> files will be there on a format close to what we have on other ReST
> files, fixing any pending issues if any.

Thanks, I am in the process of going through these docs today and will let
you know anything I find. It would be nice to include the above challenges in
the changelog as well.

Some reason 'make htmldocs' needed me to install a whole bunch of
dependencies this time around.

By the way, that tools/memory-model/Documentation/explanation.txt is a useful
little document. Well not really little with over 1000 lines ;-). But it
would certainly benefit from ReST's / htmldocs ability to jump to labels and
search, etc since it is so long..

thanks,

 - Joel






