Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A45C47258
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F0A20735
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vpgZTmS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEDAYl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgEDAYl (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 3 May 2020 20:24:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F8C061A0E
        for <rcu@vger.kernel.org>; Sun,  3 May 2020 17:24:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 23so15112804qkf.0
        for <rcu@vger.kernel.org>; Sun, 03 May 2020 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xI7Qm85+J9yYa3BECz1PpAq35SrAJXBLbUl+ywDnfIo=;
        b=vpgZTmS7D85XFaWuubB35aigMgPfNH5vS1YnNRzviB7wv/20FlsbirhRkjg9zOgEEA
         7iLGF4H8xJvd1bNUd0FCIkaDFGVwxN3nHI38lr3P/K/eOgye89BTBZzGIz5jaXEjes/a
         NIGFyOoAYZFX4lZRDVkIolGMfeBq08naC9rLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xI7Qm85+J9yYa3BECz1PpAq35SrAJXBLbUl+ywDnfIo=;
        b=fFsAEU7QQyvW7BWkYbqprB26wNvA08Lvm7ZA5MwLNDbMJ+pSY57Gmn0B2/g4oCZ3OO
         LUKwmveYtvrX+2nHdSgtwMC933/DDaSeDi9wLvuEIstagNqyXJQ16rnQgTOT+hQUvLX7
         4BfuPYX+saBayx9oVvHr00Zy00tntShVegxtgsi2fL+d4tVRtzgRFE6jt8py/fhofYTy
         IFSSA5N0Lzn9pXxCVfRzp12RIYvApobpgn6idRXQxeHiMXiaWuSFVazzTjKDSLWfi2mH
         aGW8SxzdLZBq9yohlr0WtOWHcpIepIWwaAeIO23yOUHaqENBwKjgIFdHMG3pZlf5FNEr
         U+eA==
X-Gm-Message-State: AGi0PuaejmUR9j/BPsfJqFPPMQHHCIYZAbBEzlJ0E/ChM2MCQ6X4wvJd
        p7yUafKQ3xcLA9KIZtawvMu7eg==
X-Google-Smtp-Source: APiQypLzxAGctzs8HcSpHXiYBWEZS0iGP3Ge6vZbGNZgWlf7z6MAH+MfKEicRMukpaZPrAXHEY5pGg==
X-Received: by 2002:a05:620a:89c:: with SMTP id b28mr1490696qka.380.1588551878821;
        Sun, 03 May 2020 17:24:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d69sm7491203qkc.106.2020.05.03.17.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 17:24:38 -0700 (PDT)
Date:   Sun, 3 May 2020 20:24:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 20/24] rcu/tree: Make kvfree_rcu() tolerate any alignment
Message-ID: <20200504002437.GA212435@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-21-urezki@gmail.com>
 <20200501230052.GG7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501230052.GG7560@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 01, 2020 at 04:00:52PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:58:59PM +0200, Uladzislau Rezki (Sony) wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Handle cases where the the object being kvfree_rcu()'d is not aligned by
> > 2-byte boundaries.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 501cac02146d..649bad7ad0f0 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2877,6 +2877,9 @@ struct kvfree_rcu_bulk_data {
> >  #define KVFREE_BULK_MAX_ENTR \
> >  	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
> >  
> > +/* Encoding the offset of a fake rcu_head to indicate the head is a wrapper. */
> > +#define RCU_HEADLESS_KFREE BIT(31)
> 
> Did I miss the check for freeing something larger than 2GB?  Or is this
> impossible, even on systems with many terabytes of physical memory?
> Even if it is currently impossible, what prevents it from suddenly
> becoming all too possible at some random point in the future?  If you
> think that this will never happen, please keep in mind that the first
> time I heard "640K ought to be enough for anybody", it sounded eminently
> reasonable to me.
> 
> Besides...
> 
> Isn't the offset in question the offset of an rcu_head struct within
> the enclosing structure? If so, why not keep the current requirement
> that this be at least 16-bit aligned, especially given that some work
> is required to make that alignment less than pointer sized?  Then you
> can continue using bit 0.
> 
> This alignment requirement is included in the RCU requirements
> documentation and is enforced within the __call_rcu() function.
> 
> So let's leave this at bit 0.

This patch is needed only if we are growing the fake rcu_head. Since you
mentioned in a previous patch in this series that you don't want to do that,
and just rely on availability of the array of pointers or synchronize_rcu(),
we can drop this patch. If we are not dropping that earlier patch, let us
discuss more.

thanks,

 - Joel

