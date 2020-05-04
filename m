Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7FC28CBC
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6057F206F0
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgEDAeg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:34:36 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:51966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgEDAef (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 3 May 2020 20:34:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id ECBCE100F0724;
        Mon,  4 May 2020 00:34:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crowd42_44dd700fc7262
X-Filterd-Recvd-Size: 2793
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 00:34:33 +0000 (UTC)
Message-ID: <86d49281dfa7c28b7079af84b5b5e9d70a454f8e.camel@perches.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Date:   Sun, 03 May 2020 17:34:31 -0700
In-Reply-To: <20200504002309.GD2869@paulmck-ThinkPad-P72>
References: <20200428205903.61704-1-urezki@gmail.com>
         <20200428205903.61704-4-urezki@gmail.com>
         <20200501190555.GB7560@paulmck-ThinkPad-P72>
         <93f764ad743082f2bbab4595eb892c2004e61b44.camel@perches.com>
         <20200503234400.GB197097@google.com>
         <20200504002309.GD2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 2020-05-03 at 17:23 -0700, Paul E. McKenney wrote:
> On Sun, May 03, 2020 at 07:44:00PM -0400, Joel Fernandes wrote:
> > On Fri, May 01, 2020 at 01:52:46PM -0700, Joe Perches wrote:
[]
> > > Perhaps a change to coding-style.rst
> > > ---
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
[]
> > > @@ -565,6 +565,11 @@ comments is a little different.
> > >  	 * but there is no initial almost-blank line.
> > >  	 */
> > >  
> > > +.. code-block:: c
> > > +
> > > +	// Single line and inline comments may also use the c99 // style
> > > +	// Block comments as well
> > > +
> > >  It's also important to comment data, whether they are basic types or derived
> > >  types.  To this end, use just one data declaration per line (no commas for
> > >  multiple data declarations).  This leaves you room for a small comment on each
> > 
> > Yeah that's fine with me. This patch just tries to keep it consistent. I am
> > Ok with either style.
> 
> My approach has been gradual change.  Big-bang changes of this sort
> cause quite a bit of trouble.  So I use "//" in new code and (sometimes)
> convert nearby ones when making a change.

I think that's good too.

Mixing styles in the same compilation unit is not
generally the right thing to do.

But right now, c99 comments are not specified as
allowed in coding-style so it's likely appropriate
to add something like this there.


