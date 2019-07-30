Return-Path: <SRS0=Tqm2=V3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072AAC433FF
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B87206A2
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564524040;
	bh=uNVfPPQJACAy+AbA4vS891ftxvhHlCZXPaGdqCEb3kI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EA8aSLe/DjvAts8QSSs5uaOX1isfvyry3mbGvhmOUwtvIYONHd4bao0LzH0TK5i1L
	 NpYKkthr9zKiNb2keaAPr38NZXQG1fdpC09VQ5wwE9tKySHCl40GRh5iP2nHivhORV
	 yno6lHy75t91XDQ+nA4U+Tj62uScRpWeorTuDZwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbfG3WAk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:00:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfG3WAk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jul 2019 18:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JPE4z/54GZJAi4KJOYIBhWx0j3Q+U99EDqkMHhIoEAE=; b=nXowbY6Mc163fxDxlTttICxL1
        39aGFPrTWkqoUx0Qu0qgixT3syDOkPSyBkRXhFlEzMfyBpzT3mLnXzgXt4puO7TBT4IU8f8ldZ5jM
        qghC2hykFpM0I4k+Ah5a+ALJcnvFlmE6bf+X4gPG8nUes2HvFZm5G9fvbbaNw/QZIMUFprFGsbv8V
        IVQSPc1eH6ss1kaCJchtI9El2T+ONNqUHNRWlAhR8C8v+k4HasgmZ0NmfjkdPQsFYJmGR58z7O5dW
        BshFztR2qrT5f+n/mUakRrXwo0J5hg9whzUYO11SNY8/NNZMMESgcWWme4zOB8BqhKWZrEVo4por8
        LWlOO5i2w==;
Received: from [177.157.101.143] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsaAb-0006bf-1C; Tue, 30 Jul 2019 22:00:33 +0000
Date:   Tue, 30 Jul 2019 19:00:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 25/26] docs: rcu: convert some articles from html to
 ReST
Message-ID: <20190730190028.740c131e@coco.lan>
In-Reply-To: <20190730215007.GA254050@google.com>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
        <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
        <20190730212250.GJ14271@linux.ibm.com>
        <20190730215007.GA254050@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Tue, 30 Jul 2019 17:50:07 -0400
Joel Fernandes <joel@joelfernandes.org> escreveu:

> On Tue, Jul 30, 2019 at 02:22:50PM -0700, Paul E. McKenney wrote:
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
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> > 
> > I am having some trouble applying these, at least in part due to UTF-8
> > sequences, for example double left quotation mark.  These end up being
> > "=E2=80=9C", with a few space characters turned into "=20".
> > 
> > Any advice on how to apply these?  Should I just pull commits from
> > somewhere?  
> 
> I was able to successfully apply and build this particular patch. I think
> this is the only one in the series that applies to RCU.
> 
> Sadly, I can't find the patch in any of the public archives, but I could
> perhaps email it to you as an .mbox attach which 'git am' should be able to
> apply.
> 
> Mauro did say he was going to add some more details to changelog, or it could
> be added when it is applied:
> https://lore.kernel.org/rcu/20190726154550.5eeae294@coco.lan/

Yeah, I'm also planning to address at least some of the issues you
pointed, in order to improve the html output, but got sidetracked by something 
else and didn't find any time yet to finish. I'm adding some CI automation for
the media subsystem in order to help us dealing with the huge amount of patches
we receive there.

Feel free to add those details to the changelog. I may find some spare time 
this week or the next one for the improvements you suggested, but those 
could be sent on followup patches, once done.

Thanks,
Mauro
