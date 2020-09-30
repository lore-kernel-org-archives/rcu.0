Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CE3C4727C
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 20:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B3B2064E
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 20:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRjjZ074"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgI3UgS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UgR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 16:36:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11ECC061755;
        Wed, 30 Sep 2020 13:36:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z17so3760698lfi.12;
        Wed, 30 Sep 2020 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FvVU3w+wKNrGmSSrpD1fuhyo1DsqW+d7YWGQnG2VgIU=;
        b=pRjjZ074ybsg1YxE4qraHShSd8LDsjv4ETsECqDd/VFayRIW+63mGICoDt8RqUP4I4
         2akClrjBlw2sGnVdOdYd7l3hG/Vq8ya+Nnhuh9jsOOQLLEssR2yk6Zi3ueP/Jqf0l1LM
         eh3boBbCXJJNuaTppIteQb4dCgNnKvDw55HdlkO0ZpeyOuwx/HEccdYmXWpylriTf0o2
         R3u7qsuODlXbwWGnr87mJP47ab/qGHaEeWG4D8nwKI00sokjiJtLtVdMFuZpxVsriXuw
         CuVSqAhPF6wTWYec85Yke1Usd5oU0E1fXGF0ZrHJlpNWhWApCb+pkB4cDAupEOx+0s52
         caHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FvVU3w+wKNrGmSSrpD1fuhyo1DsqW+d7YWGQnG2VgIU=;
        b=hRH/YBOwfVscl+K1Z9/rlRttW9urtd7IpGl9Vxx83CN/hRba7CDg+XoX08JZoBDaCD
         OxcgzWpM++rAhNfObM7U2jixhO7Wnr0zemWMUXwalK94s6EdsdjqZRhUWoeZDIBHD/Tg
         KJYaC2rs7AIG2OK3cBlsE9yv5QoN5UFKi9orvFYfcWA/4MxOmAM0W4VaqXFHqIaNMAUG
         sfNZ6GCCWx2RuPdoMG006YsELRFymADeb9vMThHqeBpJfI8r9CF9ZbL38hAToIPkCiFC
         q/+RZs3WHs1ZsnDoXKNCeZEvpnVO/4sC8lbHmbfZMLcU7OEcJtoNoZbgRshNFkFsCP8K
         0NJA==
X-Gm-Message-State: AOAM532F27V8k9Iz5xYScGzPPHpg3vZySNsteAqkcT/cn/xa/ji6Ym6k
        BCmCBkxYyS3e/0mqwHFNS/hcEU5DFUf0/PW+
X-Google-Smtp-Source: ABdhPJyO/xuwQDU03jhAhiML4MgJebyzTY0GvISjG9zVY9mj+iTPJS7F1V10Ii/DUNNERq3e5z9gcw==
X-Received: by 2002:a05:6512:3692:: with SMTP id d18mr1331274lfs.62.1601498175210;
        Wed, 30 Sep 2020 13:36:15 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id b197sm304632lfd.251.2020.09.30.13.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:36:14 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 30 Sep 2020 22:36:12 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200930203612.GA22035@pc636>
References: <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz>
 <20200929162514.GA8768@pc636>
 <20200930092732.GP2277@dhcp22.suse.cz>
 <20200930123535.GB18005@pc636>
 <20200930124413.GU2277@dhcp22.suse.cz>
 <20200930133954.GA19235@pc636>
 <20200930164600.GW2277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930164600.GW2277@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 30, 2020 at 06:46:00PM +0200, Michal Hocko wrote:
> On Wed 30-09-20 15:39:54, Uladzislau Rezki wrote:
> > On Wed, Sep 30, 2020 at 02:44:13PM +0200, Michal Hocko wrote:
> > > On Wed 30-09-20 14:35:35, Uladzislau Rezki wrote:
> > > > On Wed, Sep 30, 2020 at 11:27:32AM +0200, Michal Hocko wrote:
> > > > > On Tue 29-09-20 18:25:14, Uladzislau Rezki wrote:
> > > > > > > > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > > > > > > > to provide a memory service for contexts which are not allowed to
> > > > > > > > sleep, RCU is part of them. Both flags used to provide such ability
> > > > > > > > before but not anymore.
> > > > > > > > 
> > > > > > > > Do you agree with it?
> > > > > > > 
> > > > > > > Yes this sucks. But this is something that we likely really want to live
> > > > > > > with. We have to explicitly _document_ that really atomic contexts in RT
> > > > > > > cannot use the allocator. From the past discussions we've had this is
> > > > > > > likely the most reasonable way forward because we do not really want to
> > > > > > > encourage anybody to do something like that and there should be ways
> > > > > > > around that. The same is btw. true also for !RT. The allocator is not
> > > > > > > NMI safe and while we should be able to make it compatible I am not
> > > > > > > convinced we really want to.
> > > > > > > 
> > > > > > > Would something like this be helpful wrt documentation?
> > > > > > > 
> > > > > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > > > index 67a0774e080b..9fcd47606493 100644
> > > > > > > --- a/include/linux/gfp.h
> > > > > > > +++ b/include/linux/gfp.h
> > > > > > > @@ -238,7 +238,9 @@ struct vm_area_struct;
> > > > > > >   * %__GFP_FOO flags as necessary.
> > > > > > >   *
> > > > > > >   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> > > > > > > - * watermark is applied to allow access to "atomic reserves"
> > > > > > > + * watermark is applied to allow access to "atomic reserves".
> > > > > > > + * The current implementation doesn't support NMI and other non-preemptive context
> > > > > > > + * (e.g. raw_spin_lock).
> > > > > > >   *
> > > > > > >   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
> > > > > > >   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
> > > > > > > 
> > > > > > To me it is clear. But also above conflicting statement:
> > > > > > 
> > > > > > <snip>
> > > > > > %GFP_ATOMIC users can not sleep and need the allocation to succeed. A %lower
> > > > > > <snip>
> > > > > > 
> > > > > > should be rephrased, IMHO.
> > > > > 
> > > > > Any suggestions? Or more specifics about which part is conflicting? It
> > > > > tries to say that there is a higher demand to succeed even though the
> > > > > context cannot sleep to take active measures to achieve that. So the
> > > > > only way to achieve that is to break the watermakrs to a certain degree
> > > > > which is making them more "higher class" than other allocations.
> > > > > 
> > > > Michal, i had only one concern about it. It says that %GFP_ATOMIC users
> > > > can not sleep, i.e. callers know that they are in atomic, thus no any
> > > > sleeping, but the chose they make will force them to sleep.
> > > 
> > > I am not sure I follow you here. Do you mean they will be forced to
> > > sleep with PREEMPT_RT?
> > > 
> > Exactly :)
> 
> We can make that more specific once RT patchset is merged. As of now
> this is not the thing in the Linus tree. I believe there will be more to
> clarify about atomic contexts in the RT tree as it means something else
> than people are used to think.
> 
Fair enough. Currently we have only the Kconfig CONFIG_PREEMPT_RT
symbol, so RT patches are still not in place.

--
Vlad Rezki
