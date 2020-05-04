Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B52C47258
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474502075E
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd9xAZ5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgEDM43 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728581AbgEDM43 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:56:29 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B1C061A0E;
        Mon,  4 May 2020 05:56:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g10so9576889lfj.13;
        Mon, 04 May 2020 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0rfcpBiYm/vdP/rPS5pY3UI91lwRcLM+QDCxN+kdQvY=;
        b=Bd9xAZ5SIXkT0ZkOcJgezg3gnaGoXdfRdPVFqkgU8njcxtbwGYCSHDeaGgVUdNmFCx
         QOhaXRnw60DcFVXUjqk45+32UTIQgigAnGK3VYXkiA0prS8vGF33JL6OvuoMg+eXQJ5R
         U2sOS+RfCAleP3ScXPsVIQUohRncJWpmUC8YSmSM0hP+AGCd+AsNQl+dielXQ5r0NBQf
         hi0zfWw/DFzP0sngTOMAushEwFLKkgAZpKUyoK8BmAIFr5PQ/LqtzO7nJae4qnP4mETm
         /bq9qPVOmu54yIrvZPJRkrMm8c9n8Wvs/1JMAoWad/55pWa2P0YM3VdHGW9OyjiTde9F
         o97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rfcpBiYm/vdP/rPS5pY3UI91lwRcLM+QDCxN+kdQvY=;
        b=otd/eitiogdi4Ihq4lDAkipEUm/6vKU9t2ECYaBUkSIRJXceuZ95vgED4qFXZLFAAm
         nOLqOg9hwGfVVquv2ukSK8J7IoSXpEI/Q1kIe8bFjpo9e+RCYUKh+YaCfF+t0G/8purQ
         D/7FYESCjolt+NOmsSktJdvKCvo19oVnKl415f6TdHDL7C08dsTv0Tt/Kx/2uG5xFXJz
         Rm15OwdnHqvOmDi/giQotrPNy4FLDnINttnkeqfA15k1JX+wOP3LfT/jHSXwAc8KCes5
         H6/ijz1tlNnE6JUJTyDsU0Rcgh5gcAkOVyffyVDfbB/qCky8O7rblu0Ohyl1qZWPiZ5z
         k+KA==
X-Gm-Message-State: AGi0PuawAyya264jgz0ZTbspkWdV4sGFbDwjLgBTHEZVkwiMDzOuI9KS
        ipujo38HMxuHxVWxkBNaC/s=
X-Google-Smtp-Source: APiQypLO9djVLG2CsQneTPf5oC5sJ9jspCYKIozsOYyltKghcNVpfvflx82y1owDAuzrIpT9jBAg5Q==
X-Received: by 2002:a19:c349:: with SMTP id t70mr11310784lff.139.1588596986865;
        Mon, 04 May 2020 05:56:26 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id w29sm9705366lfq.35.2020.05.04.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:56:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 14:56:23 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 20/24] rcu/tree: Make kvfree_rcu() tolerate any alignment
Message-ID: <20200504125623.GE17577@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-21-urezki@gmail.com>
 <20200501230052.GG7560@paulmck-ThinkPad-P72>
 <20200504002437.GA212435@google.com>
 <20200504002947.GG2869@paulmck-ThinkPad-P72>
 <20200504003106.GC212435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504003106.GC212435@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 03, 2020 at 08:31:06PM -0400, Joel Fernandes wrote:
> On Sun, May 03, 2020 at 05:29:47PM -0700, Paul E. McKenney wrote:
> > On Sun, May 03, 2020 at 08:24:37PM -0400, Joel Fernandes wrote:
> > > On Fri, May 01, 2020 at 04:00:52PM -0700, Paul E. McKenney wrote:
> > > > On Tue, Apr 28, 2020 at 10:58:59PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > > 
> > > > > Handle cases where the the object being kvfree_rcu()'d is not aligned by
> > > > > 2-byte boundaries.
> > > > > 
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 9 ++++++---
> > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 501cac02146d..649bad7ad0f0 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2877,6 +2877,9 @@ struct kvfree_rcu_bulk_data {
> > > > >  #define KVFREE_BULK_MAX_ENTR \
> > > > >  	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
> > > > >  
> > > > > +/* Encoding the offset of a fake rcu_head to indicate the head is a wrapper. */
> > > > > +#define RCU_HEADLESS_KFREE BIT(31)
> > > > 
> > > > Did I miss the check for freeing something larger than 2GB?  Or is this
> > > > impossible, even on systems with many terabytes of physical memory?
> > > > Even if it is currently impossible, what prevents it from suddenly
> > > > becoming all too possible at some random point in the future?  If you
> > > > think that this will never happen, please keep in mind that the first
> > > > time I heard "640K ought to be enough for anybody", it sounded eminently
> > > > reasonable to me.
> > > > 
> > > > Besides...
> > > > 
> > > > Isn't the offset in question the offset of an rcu_head struct within
> > > > the enclosing structure? If so, why not keep the current requirement
> > > > that this be at least 16-bit aligned, especially given that some work
> > > > is required to make that alignment less than pointer sized?  Then you
> > > > can continue using bit 0.
> > > > 
> > > > This alignment requirement is included in the RCU requirements
> > > > documentation and is enforced within the __call_rcu() function.
> > > > 
> > > > So let's leave this at bit 0.
> > > 
> > > This patch is needed only if we are growing the fake rcu_head. Since you
> > > mentioned in a previous patch in this series that you don't want to do that,
> > > and just rely on availability of the array of pointers or synchronize_rcu(),
> > > we can drop this patch. If we are not dropping that earlier patch, let us
> > > discuss more.
> > 
> > Dropping it sounds very good to me!
> 
> Cool ;-) Thanks,
> 
OK. Then we drop this patch and all dynamic rcu_head attaching logic
what will make the code size smaller.

Thanks!

--
Vlad Rezki
