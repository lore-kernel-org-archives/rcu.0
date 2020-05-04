Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A0AC28CBC
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554BC206F0
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eiIirED3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgEDAli (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbgEDAlh (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 3 May 2020 20:41:37 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB87C061A0F
        for <rcu@vger.kernel.org>; Sun,  3 May 2020 17:41:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so12711505qts.9
        for <rcu@vger.kernel.org>; Sun, 03 May 2020 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PhoRsdVUpxSefTN3nA18NxBE6Bc3GIrO3qESKoaBeLw=;
        b=eiIirED3qHhOWipGjeDdkfgS6x9vBM5QEEOf5fRffYbj9YWUhCyermSfNDb9pxgsaL
         RIsNfefUqTcEkuOc2GNAnhFoEyZOcoLG8zd6vtNEyf3FvwpXOyxGMNGw9P3XhM3utgRr
         nOGkEiElDA/CQ+ecaVClVdNWF9en8Q5WFMcZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PhoRsdVUpxSefTN3nA18NxBE6Bc3GIrO3qESKoaBeLw=;
        b=ACNtOZOenLknr6/p9O5/V+N5QGH8IqH9DSwWfXVKUm6Ocqq/KM44QHJjJ2B8dVnmN3
         yMFSf7FioW1HqnimRARx2v5HCtp+EfIM1EXEr5XLereDgXFV529i6fO/NrSvuepf7sfY
         Gb8q65S4ap40wTqanFMje0syY+J/Nre5ui0pnBr3o2KSj8iCJToVkDujbiy4Dr0p4Oi4
         xhsOxNN+0ITXyZlUmm0RtLR+uBvqSFIpRlREYPbh7E0ruLKZ8Ou+v5mI0xoYdg0xZS2/
         vFPRXCVb4NrPmUJfgU2juzxtBYVUKzWcReuTFtuk2Lx5ke6yehwEaIHsWqEzBuniy7oV
         X9XA==
X-Gm-Message-State: AGi0PuYJJbQ2Zkietqyaj8rJkLz0T98cy/6Xgha6ztkNQpoNGYkTAw1/
        C2KrbBkFFwGq5LU4YZbaIHZ2YQ==
X-Google-Smtp-Source: APiQypLm9DWQtztLxl8yVs7UxAPvJPkNvWCOEKzw7QaqkrVjpn0b8WccC6XYYNBsMVi9l03kwIDEVw==
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr15083681qto.230.1588552896694;
        Sun, 03 May 2020 17:41:36 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t14sm9407295qtj.71.2020.05.03.17.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 17:41:36 -0700 (PDT)
Date:   Sun, 3 May 2020 20:41:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
Message-ID: <20200504004135.GF212435@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-4-urezki@gmail.com>
 <20200501190555.GB7560@paulmck-ThinkPad-P72>
 <93f764ad743082f2bbab4595eb892c2004e61b44.camel@perches.com>
 <20200503234400.GB197097@google.com>
 <20200504002309.GD2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504002309.GD2869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 03, 2020 at 05:23:09PM -0700, Paul E. McKenney wrote:
> On Sun, May 03, 2020 at 07:44:00PM -0400, Joel Fernandes wrote:
> > On Fri, May 01, 2020 at 01:52:46PM -0700, Joe Perches wrote:
> > > On Fri, 2020-05-01 at 12:05 -0700, Paul E. McKenney wrote:
> > > > On Tue, Apr 28, 2020 at 10:58:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > > Simple clean up of comments in kfree_rcu() code to keep it consistent
> > > > > with majority of commenting styles.
> > > []
> > > > on /* */ style?
> > > > 
> > > > I am (slowly) moving RCU to "//" for those reasons.  ;-)
> > > 
> > > I hope c99 comment styles are more commonly used soon too.
> > > checkpatch doesn't care.
> > > 
> > > Perhaps a change to coding-style.rst
> > > ---
> > >  Documentation/process/coding-style.rst | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > > index acb2f1b..fee647 100644
> > > --- a/Documentation/process/coding-style.rst
> > > +++ b/Documentation/process/coding-style.rst
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

Ok thanks for the guidance on that, will follow similar conversion strategy
as well.

thanks,

 - Joel

