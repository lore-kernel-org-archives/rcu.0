Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D93C2D0E4
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F25221F9
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 01:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQzp4w6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKPBZ3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Nov 2020 20:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKPBZ3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Nov 2020 20:25:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E8C0613CF
        for <rcu@vger.kernel.org>; Sun, 15 Nov 2020 17:25:28 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id f93so11745149qtb.10
        for <rcu@vger.kernel.org>; Sun, 15 Nov 2020 17:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y6DAnutuJvE4ekTkdJf/xkVLXwBr2OVNfGsibVSH1+c=;
        b=nQzp4w6DO4rRMmKmzZ8IwwibAVUxXQ+ZYCGjd7Le7KLWEJ0lnmrZbiy5+LVtkurccV
         Kf3Y2VAPs3QbZEs+z3wmkXkecL08v9u1gy0rPM0C4+s+lQOb5SxWQgwmZFD+0CYSp5x2
         udTZjqrYHyQyFIs+yCGr/Fsledcz43mbwpzmR1k77E4n57WwZgo55tIfyFLlO8mcq3yC
         86Y6hVO3Y7/J/jgqYAG/oHgC8gIEhTtS5lLwZ7pvZqb4F/xY65YUzePlL05a9LJUDBfE
         LsY6JLukoFKGLX0qdeg7ljCyohQhugBbrJYYSzMv35Foaxwd8yf6oqwJRhbnAy6wVYRN
         xtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y6DAnutuJvE4ekTkdJf/xkVLXwBr2OVNfGsibVSH1+c=;
        b=tR+GOLHPab2OaR4eLfR0dIOMH5hhX4ReqCAI/gOuxgoX1dkTOZxTxH0S9q8KKQwkKC
         cnfRDsfIN5ZtHFwfe5LF41pEwV0YHB5c/qHfnaw1yOAwHXbZhfANlzBf5Q2a+zDuvRTr
         qSCo4Y5NQwT8oWfJEU/4swsRbItBcBJ4DUO5P1B+xGOoxD7r3mOUq8obgULboGW8Ekwj
         bDKYcvAIV9DP8qWcA68fZmSwJTRpAShP3GTGmaCJka1zYhQYHitUnEdwA3NwtMk731gd
         QgNmgxd7ZQ9nvu/e0Syidl2ivOE1wfXC7iakvLboHTD+4Wk50C92mZzXWvpDJhutLUZ1
         ntEQ==
X-Gm-Message-State: AOAM5317DyblWFeYqZ14FfXrvgdIN44PwqfELuf1crdSTWBCa7x7i+Rd
        ACyBwKZkE5wLaL2fOxg0fJ2szkfEfgyi
X-Google-Smtp-Source: ABdhPJz6HbWUBWS38cFUEDwnZUdLdEaeOAioisWE+Q4oqu3PaoGyc68/AzS4Wn631uiqgTVwodxGUw==
X-Received: by 2002:ac8:57c2:: with SMTP id w2mr11676609qta.213.1605489927879;
        Sun, 15 Nov 2020 17:25:27 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id i15sm10665542qke.16.2020.11.15.17.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 17:25:27 -0800 (PST)
Date:   Sun, 15 Nov 2020 20:25:25 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: SRCU question
Message-ID: <20201116012525.GB3655723@moria.home.lan>
References: <20201112201547.GF3365678@moria.home.lan>
 <20201115201124.GL3249@paulmck-ThinkPad-P72>
 <20201115202017.GA8197@paulmck-ThinkPad-P72>
 <20201115203551.GA3655723@moria.home.lan>
 <20201115205339.GN3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115205339.GN3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 15, 2020 at 12:53:39PM -0800, Paul E. McKenney wrote:
> On Sun, Nov 15, 2020 at 03:35:51PM -0500, Kent Overstreet wrote:
> > Yeah. My one quibble is, instead of having to call poll_state_synchronize_srcu()
> > on every cookie - would it be possible to get function that returns a cookie we
> > can compare against (i.e. with time_after())? I'm going to be use this in the
> > shrinker where we have to walk and check potentially tens of thousands of
> > objects.
> 
> If the cookies compare equal, poll_state_synchronize_srcu() will treat
> them the same.  If that does not help, could you please show me a code
> snippet illustrating what you would like to do?
> 
> (Yes, even if equality comparison works, I probably need to give you
> an API member just in case the nature of grace-period sequence numbers
> changes in the future.)

Having just looked at your code - I think it's fine as is. I wouldn't complain
if it was a static inline, though.

> 
> > > Oh, and due to historical inertia, Tiny SRCU's grace-period sequence
> > > number is only 16 bits.  I can change this easily, but I need to know
> > > that it is a real problem for you before I can do so.
> > > 
> > > The potential problem for you is that if you let a given cookie lie
> > > dormant for 16384 grace periods, it will take another 16385 grace
> > > periods for get_state_synchronize_srcu() to say that a grace period
> > > has elapsed.
> > > 
> > > In contrast, Tree SRCU's grace-period sequence number is either 32 bits
> > > or 64 bits, depending on the size of unsized long.
> > 
> > It's not something I'd lose sleep over, but I think it could be. If there isn't
> > memory pressure, then the shrinker won't be running and we won't be freeing the
> > objects with the oldest cookies, but freeing them internally will be creating
> > new grace periods - but if I make sure we're reusing objects in LIFO order would
> > also work against the shrinker actually being able to free any objects, so not
> > sure I want to do that...
> 
> OK, I will leave it, at least until you tell me otherwise.
> 
> I probably need to add a warning to the header comment, though...
> 
> 							Thanx, Paul

Thanks! 
