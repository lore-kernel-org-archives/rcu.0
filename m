Return-Path: <SRS0=BSCp=DM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E35C4363A
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAA5207F7
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 13:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq/1EENg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJEN7B (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJEN7A (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Oct 2020 09:59:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F80C0613CE;
        Mon,  5 Oct 2020 06:58:58 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so11005792lff.1;
        Mon, 05 Oct 2020 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FSG++GcuwtXfFL0pAmi9VIOsmecZ/zHiEFdMrjrBjZ0=;
        b=jq/1EENgpJztVgUbiHOlFewQRt85vb2x9X/5tTn6DHbAXnHybLY6oqIexnupDz1gaJ
         g01snaS7Uhn1mfY8YL/GyEKAzRhvch6cPp40maquni4o2dzDk3P/hujBXIaRX6JJHrPN
         8ZDsJ3+FMC5pzRwMwEEG01DpEMz/WZAUzIDhKncN6ABVuHaBLZRhm2HtXiJ2DjqmIa7H
         TSXu7U6+QCA4ODIwvsYJ5rLRxpDOlVzQWxLhGVBO0jUOY3sz4l1YYq9CrfvmzDz9Dcie
         MH06I13mMMKVJfgK7/mUvGtAIIiPKIMSygNxwwmoj42ss8rElH/8kNE4/GvPVDglSPZ0
         S6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FSG++GcuwtXfFL0pAmi9VIOsmecZ/zHiEFdMrjrBjZ0=;
        b=R61wspwn6vdLk3aQKtfm3Am/l7xEartIbzZShNVB/1P7KdTPf+6P1m0Q9OWBk4VCtj
         usM83le4MNTOFVKIQgVnRrbNW4z/XvR3CwPbmuZNjXqDgf8WbngoiJS8H+2f/v3ALiWY
         I34E5rxNGI8kTwb3Wg++AgSYmF20v7qHty04OjOh39r3CScvgM6XNspXvBMD4TLgQSlQ
         DQR7VZ/tacwZTN+yQYKiAoTRTKOxEYUH8gILFCCByOtSmcl6ddFu9G7e3LllJ/YsX7W+
         VXEh80DSRbpCOrKFgpRpz9NwI1SG79QfOKmQG3y5eTl62JWQMHxhYFOmoMK9ltYss/wI
         7H9A==
X-Gm-Message-State: AOAM5338zF/2zTpKMW0XJgftwIMM6bRyNSjefY5bmYcJp+ryN+GlxM2/
        ymIUCX5l6J9lSWs4Q8X2DRo=
X-Google-Smtp-Source: ABdhPJzX0Fq/hCeOCOFzQbhoFtQMbR7mUVdrmKjW8qHxJYKGuZza5OAMcXuLhDWlTnVDkaa6CE/WWA==
X-Received: by 2002:a19:2302:: with SMTP id j2mr3422194lfj.78.1601906337230;
        Mon, 05 Oct 2020 06:58:57 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n2sm2653504lji.97.2020.10.05.06.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:58:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 5 Oct 2020 15:58:54 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201005135854.GA17959@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002071123.GB20872@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 02, 2020 at 09:11:23AM +0200, Michal Hocko wrote:
> On Thu 01-10-20 21:26:26, Uladzislau Rezki wrote:
> > > 
> > > No, I meant going back to idea of new gfp flag, but adjust the implementation in
> > > the allocator (different from what you posted in previous version) so that it
> > > only looks at the flag after it tries to allocate from pcplist and finds out
> > > it's empty. So, no inventing of new page allocator entry points or checks such
> > > as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> > > affect existing fast paths.
> > >
> > OK. Now i see. Please have a look below at the patch, so we fully understand
> > each other. If that is something that is close to your view or not:
> > 
> > <snip>
> > t a/include/linux/gfp.h b/include/linux/gfp.h
> > index c603237e006c..7e613560a502 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -39,8 +39,9 @@ struct vm_area_struct;
> >  #define ___GFP_HARDWALL                0x100000u
> >  #define ___GFP_THISNODE                0x200000u
> >  #define ___GFP_ACCOUNT         0x400000u
> > +#define ___GFP_NO_LOCKS                0x800000u
> 
> Even if a new gfp flag gains a sufficient traction and support I am
> _strongly_ opposed against consuming another flag for that. Bit space is
> limited.
>
That is a valid point.

>
> Besides that we certainly do not want to allow craziness like
> __GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?
>
Obviously not. And it seems that the way of implementing of the
NO_LOCK logic would be easier(less code changes) and better if
it was defined like below(what you proposed later in this thread):

-#define __GFP_NO_LOCKS ((__force gfp_t)___GFP_NO_LOCKS)
+#define __GFP_NO_LOCKS ((__force gfp_t) 0)

That could imply that calling the page allocator with zero
argument would apply a further limitation - that is lock free.

--
Vlad Rezki
