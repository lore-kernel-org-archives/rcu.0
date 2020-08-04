Return-Path: <SRS0=f/Ck=BO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ABAC433E0
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 19:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF9D205CB
	for <rcu@archiver.kernel.org>; Tue,  4 Aug 2020 19:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P99m3Cql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHDTrn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHDTrm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Aug 2020 15:47:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CBC06174A;
        Tue,  4 Aug 2020 12:47:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 140so23014893lfi.5;
        Tue, 04 Aug 2020 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SmsOusmdMYGELZ8p3XEi4L+aw3GtlflT7uJDqWYvIR0=;
        b=P99m3CqlBQHqWsurOdOpqLE7SpK1WwWjG5aK6G0TbQDzNYhKE8F0pEVn41CXJM2kkl
         t3jIFTNa5UOP+HqkJv4XlwGJAEEdl/VsEkPFDDBTrzB+xEMbvXFNRu/SLXmdIRPgMTU9
         rAaDAinoLoZFLiukf+O0DzDUDIlHG3t+gQpW8lyNdAm23zV2R4N1kHwV29aSqs5lGwRY
         Af3Octoe0lDH/THOH60d8D/eyvJnB823MJaVn0+UfFxh/NZHH2y4MatNaoQ4g1/sFRMU
         qjF12eGp5qzqMzyv0QQ0Bfl3vSrYoLBbq7IoSU7AKAgxhFnCoJjyKVlBM+XRTGJS/j49
         FrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SmsOusmdMYGELZ8p3XEi4L+aw3GtlflT7uJDqWYvIR0=;
        b=fokV+RyMGSYiObgl4qItkWXPRkTmVih/CA/tc0H4FH2qUkxBwxm/61Qd73A7P6oKcy
         ZKPlkd5mTCQXlsoeN8djnvmw+3gMfUQi5Mi1bOJfBYfrMSu2W6y7dDfyBHb62AD0gGtK
         a4nuHhWsIeSIFHVjiuiS6m1v3NNrVvmaEPhex7tgI8P00rcTGwVy7cHyrQlYqvwrsX16
         jL0ElJisREwnxwb+f7nHFpuL7p3d3yAhgCasbJFGo7ftwRy4wQjb/nx/+WTsLhWAC28f
         UlKl1lhEiS8/B5x+Ia7slxJeWeg0Tn281ws1Y6yeujajXOvtl488XUi0gEHLBtkB0Cqe
         8GZw==
X-Gm-Message-State: AOAM533ZqAIUt4Rt6K0nhI+iB7khMf4zHjhXH2sZpsKORBmvSzshm0Sr
        vKTUxo//ZdwWPKUmweO5Ukw=
X-Google-Smtp-Source: ABdhPJw6PA92m2lWJFvuiDUsp9KOwmOSTk91RwnIMXSG1Dx93Z5QfRrNMOqJ/vwo08ifR+tHmF5Bmw==
X-Received: by 2002:a19:c752:: with SMTP id x79mr11265187lff.197.1596570461002;
        Tue, 04 Aug 2020 12:47:41 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n3sm5865720ljj.39.2020.08.04.12.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 12:47:40 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 4 Aug 2020 21:47:38 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PROTOTYPE 1/1] mm: Add __GFP_FAST_TRY flag
Message-ID: <20200804194738.GB29837@pc636>
References: <20200803163029.1997-1-urezki@gmail.com>
 <1d50a46a-b97f-96b2-8a5c-21075f022f01@suse.cz>
 <20200804171203.GH23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804171203.GH23808@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 04, 2020 at 06:12:03PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 04, 2020 at 07:02:14PM +0200, Vlastimil Babka wrote:
> > > 2) There was a proposal from Matthew Wilcox: https://lkml.org/lkml/2020/7/31/1015
> > > 
> > > <snip>
> > > On non-RT, we could make that lock a raw spinlock.  On RT, we could
> > > decline to take the lock.  We'd need to abstract the spin_lock() away
> > > behind zone_lock(zone), but that should be OK.
> > > <snip>
> > > 
> > > It would be great to use any existing flag, say GFP_NOWAIT. Suppose we
> > > decline to take the lock across the page allocator for RT. But there is
> > > at least one path that does it outside of the page allocator. GFP_NOWAIT
> > > can wakeup the kswapd, whereas a "wake-up path" uses sleepable lock:
> > > 
> > > wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
> > > 
> > > Probably it can be fixed by the excluding of waking of the kswapd process
> > > defining something like below:
> > 
> > Is something missing here?
> > 
> > > what is equal to zero and i am not sure if __get_free_page(0) handles
> > > all that correctly, though it allocates and seems working on my test
> > > machine! Please note it is related to "if we can reuse existing flags".
> > > 
> > > In the meantime, please see below for a patch that adds a __GFP_FAST_TRY,
> > > which can at least serve as a baseline against which other proposals can
> > > be compared. The patch is based on the 5.8.0-rc3.
> > > 
> > > Please RFC.
> > 
> > At first glance __GFP_FAST_TRY (more descriptive name? __GFP_NO_LOCKS?) seems
> > better than doing weird things with GFP_NOWAIT, but depends on the real benefits
> > (hence my first questions).
> 
> I think what Vlad is trying to say is that even GFP_NOWAIT will wake
> kswapd, which involves taking a spinlock.  If you specify 0 in your GFP
> flags, then we won't wake kswapd.  So a simple:
> 
> #define GFP_NOLOCKS	0
> 
> should do the trick (modulo various casting, blah blah blah)
>
Yep, i meant that.

Thank you Matthew!

--
Vlad Rezki
