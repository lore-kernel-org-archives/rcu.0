Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5ACC55186
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 00:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09B820706
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 00:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587516133;
	bh=mb/GeZW/pAYs7/zVVEqQgr7aut2LB00bzCH+XTKrOxM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hwZQXkGE6hHeyWVicdwEgdti+grY67Ub4IDgYZxvj7B4D0oS27q60bleumMUozGUo
	 CaZRyx3xdVwpEdEdETCi8pV/p4yyi6qlZwNex27ApovG6cmPQzAbTDSpCgXuzN5utz
	 8AiQT2J1ZQN+qib85LokEtzKi25IZYDctWA9a8H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDVAmJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVAmJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 20:42:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56794206D5;
        Wed, 22 Apr 2020 00:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587516128;
        bh=mb/GeZW/pAYs7/zVVEqQgr7aut2LB00bzCH+XTKrOxM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lBmz6kuvve++2V17AS+4aruOhzyO/0F7bgvOQlmrqP1kQvvdMSvbmPW8wlr4CQZbJ
         143a7nxcEWz50OxhJc/tJyHzQU+cQRg1zmobxv5rR79T3TUQ/ZFiWIcY2Wo0vqFQkQ
         rbtBbKDXLKms+ilT1Mf6FjfB3ZIB+j7nPA+uhWMY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2D7843523039; Tue, 21 Apr 2020 17:42:08 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:42:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 07/10] docs: RCU: RTFP: fix bibtex entries
Message-ID: <20200422004208.GI17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
 <3cc10823634f12c3d3c44ee03f73b7aaa347df63.1587488137.git.mchehab+huawei@kernel.org>
 <20200421174329.GR17661@paulmck-ThinkPad-P72>
 <20200421175225.GA32083@paulmck-ThinkPad-P72>
 <20200421212850.616db8b0@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421212850.616db8b0@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 21, 2020 at 09:29:06PM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 21 Apr 2020 10:52:25 -0700
> "Paul E. McKenney" <paulmck@kernel.org> escreveu:
> 
> > On Tue, Apr 21, 2020 at 10:43:29AM -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 21, 2020 at 07:04:08PM +0200, Mauro Carvalho Chehab wrote:  
> > > > There are several troubles at the bibtex entries with
> > > > prevent them to be processed by LaTeX:
> > > > 
> > > > - On LaTeX, comment lines start with '%', but here, comments
> > > >   are starting with "#";
> > > > - Underlines should be escaped.
> > > > - While the best would be to use \url{} for all URL entries,
> > > >   let's do it at least for a couple that would otherwise
> > > >   produce errors on LaTeX.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > > 
> > > Another approach might be just to link to a public repo containing
> > > cleaned-up versions of these bibliography entries:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git/tree/bib/RCU.bib
> > > 
> > > That would have the advantage of keeping this information in only one
> > > place, and reducing the number of updates required.
> 
> Yeah. I didn't know you had it somewhere else.
> 
> > > 
> > > Thoughts?  
> > 
> > OK, I should have read the next patch in the series, where you convert
> > into a Sphinx-compatible bibliography.  Except that you had to convert
> > the bibtex entries by hand to produce the Sphinx-compatible entries?
> 
> No, but it still required a lot of manual work.
> 
> I manually converted the file to ReST. That was the easiest part.
> 
> Then, I used sphinx-build to convert it into a LaTeX file and changed
> the produced .tex for it to use the .bib file. 
> 
> The last step was the hardest one. I'm not familiar with LaTeX. I did
> several attempts to produce an output with the same kind of captions
> as the original file, but I was unable to generate it.
> 
> So, I ended doing the final step the hard way: I used XeLaTeX to produce
> a PDF file. Then, I manually copied the entries from the output back into 
> the ReST file, carefully adjusting the captions, in order for them to
> point to the right places. 
> 
> Before that, I tried to use a few Sphinx BibTeX extensions, but they
> are not complete: they were unable to parse some types of entries.
> If I'm not mistaken (I did it some time ago, on another computer),
> the ones I tested crashed when trying to parse some entries, like 
> '@Conference'.

OK, that sounds decidedly non-trivial.  :-(

> > That will get a bit ugly when it comes time to add more entries.
> > 
> > Or was the conversion of bibliography entries automated?
> 
> I suspect it should be possible to automate it, but, as I said,
> I'm not too familiar with LaTeX. 

In the meantime, would it work to just reference the RCU.bib URL above?

						Thanx, Paul
