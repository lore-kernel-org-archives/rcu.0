Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D708FC54FCC
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 19:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEDF206D9
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587497508;
	bh=BE4IFnhZXL+QecB5RHlSvGSBQfuvKjcw+a+56tvjuPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Z3w/eSNDLdGXNgZYBNwP62wtQf3OMvPGvboau499rowntwlFvcjbK2OGh8kZOJnXi
	 UCBniw+pylqKqcBizbJacFftkTfz03ADc9v3By9A/ad1DmKEKSsJBYVRWy2zqSD5uI
	 rX9qCe5PF8QBA0VqJmJtqX43C7DU7T0TtyCjtKsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDUTbs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUTbs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 15:31:48 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8555F206D5;
        Tue, 21 Apr 2020 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587497351;
        bh=BE4IFnhZXL+QecB5RHlSvGSBQfuvKjcw+a+56tvjuPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tSARBWUP64gzQ5NLyeeC4TZ3buBZeIwn+Y3/W/QIGKUcqRbg74UFh/abweOaGS7S8
         GFaDTsqncX4r1WL5lWFb6SHDZIRr4dlvswFtzmck/3ho/rWCKv5rLGegjNGrHBv+tb
         /+uf2y3ydxg5X7aUSSvAuI8sOW6M8cgoH0wKnsm4=
Date:   Tue, 21 Apr 2020 21:29:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 07/10] docs: RCU: RTFP: fix bibtex entries
Message-ID: <20200421212850.616db8b0@coco.lan>
In-Reply-To: <20200421175225.GA32083@paulmck-ThinkPad-P72>
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
        <3cc10823634f12c3d3c44ee03f73b7aaa347df63.1587488137.git.mchehab+huawei@kernel.org>
        <20200421174329.GR17661@paulmck-ThinkPad-P72>
        <20200421175225.GA32083@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Em Tue, 21 Apr 2020 10:52:25 -0700
"Paul E. McKenney" <paulmck@kernel.org> escreveu:

> On Tue, Apr 21, 2020 at 10:43:29AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 21, 2020 at 07:04:08PM +0200, Mauro Carvalho Chehab wrote:  
> > > There are several troubles at the bibtex entries with
> > > prevent them to be processed by LaTeX:
> > > 
> > > - On LaTeX, comment lines start with '%', but here, comments
> > >   are starting with "#";
> > > - Underlines should be escaped.
> > > - While the best would be to use \url{} for all URL entries,
> > >   let's do it at least for a couple that would otherwise
> > >   produce errors on LaTeX.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > Another approach might be just to link to a public repo containing
> > cleaned-up versions of these bibliography entries:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git/tree/bib/RCU.bib
> > 
> > That would have the advantage of keeping this information in only one
> > place, and reducing the number of updates required.

Yeah. I didn't know you had it somewhere else.

> > 
> > Thoughts?  
> 
> OK, I should have read the next patch in the series, where you convert
> into a Sphinx-compatible bibliography.  Except that you had to convert
> the bibtex entries by hand to produce the Sphinx-compatible entries?

No, but it still required a lot of manual work.

I manually converted the file to ReST. That was the easiest part.

Then, I used sphinx-build to convert it into a LaTeX file and changed
the produced .tex for it to use the .bib file. 

The last step was the hardest one. I'm not familiar with LaTeX. I did
several attempts to produce an output with the same kind of captions
as the original file, but I was unable to generate it.

So, I ended doing the final step the hard way: I used XeLaTeX to produce
a PDF file. Then, I manually copied the entries from the output back into 
the ReST file, carefully adjusting the captions, in order for them to
point to the right places. 

Before that, I tried to use a few Sphinx BibTeX extensions, but they
are not complete: they were unable to parse some types of entries.
If I'm not mistaken (I did it some time ago, on another computer),
the ones I tested crashed when trying to parse some entries, like 
'@Conference'.

> That will get a bit ugly when it comes time to add more entries.
> 
> Or was the conversion of bibliography entries automated?

I suspect it should be possible to automate it, but, as I said,
I'm not too familiar with LaTeX. 

Thanks,
Mauro
