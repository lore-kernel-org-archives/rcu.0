Return-Path: <SRS0=1ltc=DC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A65C4741F
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 10:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B61206C9
	for <rcu@archiver.kernel.org>; Fri, 25 Sep 2020 10:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms1CpZOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgIYKZh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 25 Sep 2020 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYKZg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 25 Sep 2020 06:25:36 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24E6C0613CE;
        Fri, 25 Sep 2020 03:25:35 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m5so2210651lfp.7;
        Fri, 25 Sep 2020 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EDTrxzVhPvirc6DaIwHmGU5btp2o0zUWFlr+hQsger8=;
        b=ms1CpZOJ8k6K5gNyl/8fgGKNeCIOwIQ6pwiWpuxuT4FKuzH19HH+sFPkj62fuhN6S8
         1bYjfeiG+yABwHGPcSDZZcQTE/Hs/Ej+mdRY8mycu/fY5klH5FgWIjrbM80ENpCLbraC
         Vedu0Mi8Mxy2Dx5boaxsWDr0xpC8f24hu06JcS510dXmjVtUf4QajWz5bJt9qCrXEv/Y
         OnbNgPM5fTU/MMX8XsageCxcOINyk9fkC0cnqBEYKMvosHVqYpss0pIPOewyhP313C7g
         E/FNsmffN6gHhumCx/fQtrHeNfxxvOldTJALDAeOKKUfMEkQFGGS2hSuXr4o1tquOx6m
         We+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EDTrxzVhPvirc6DaIwHmGU5btp2o0zUWFlr+hQsger8=;
        b=oNf4ZKDO3ppb9YceftjOU/JSyHW5iEVZ/+4ibfg0RYr8jEZRClftt2IMRBzqmfYkB/
         hjBekd+XYtCEABDxeGzqoLq1YVVYtut5x7Tg+YoxuhZaIW+dOYT3FGYIaYb6HH6/bPI9
         gMoJkgogJK1pb5ecN33cM5wMWetT9BCffUnjGTVTfHMsFVAO/GsLW5Efs9KfDVxTq7eX
         XmSNpbyUMUxiAYCJAXfxOk7tk3m1QClP2/NhYN2DEQrFVdvQr2s5k72GPypae9LSivLe
         DnOXiU85sed/jaJiKnH6VR8lol1LWXF1z1t5nELaEsSUSLVLNDK8dR3mwPiPrx1ci11T
         KwyQ==
X-Gm-Message-State: AOAM532bUM5wfKjyfRTxkM8jGrfS3BLgPlTX7pziVc0kNsN6M2ZyCMoC
        YNXwhvpZFC2KCq29ceALJbUv3Lg9VXgP5Ayc
X-Google-Smtp-Source: ABdhPJzc9jnAUHPreS882WLX0Hodi6O0tyUX+gJK+AO2qpK1Qn4CqGyCxv/4MCfXJNOEbGTn6T0crg==
X-Received: by 2002:a19:8542:: with SMTP id h63mr1022902lfd.177.1601029534021;
        Fri, 25 Sep 2020 03:25:34 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 73sm1909342lff.118.2020.09.25.03.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 03:25:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 25 Sep 2020 12:25:31 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200925102531.GA25350@pc636>
References: <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200924111907.GE2628@hirez.programming.kicks-ass.net>
 <20200924152112.GB19013@pc636>
 <20200925081552.GS2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925081552.GS2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 25, 2020 at 10:15:52AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 05:21:12PM +0200, Uladzislau Rezki wrote:
> > On Thu, Sep 24, 2020 at 01:19:07PM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 24, 2020 at 10:16:14AM +0200, Uladzislau Rezki wrote:
> > > > The key point is "enough". We need pages to make a) fast progress b) support
> > > > single argument of kvfree_rcu(one_arg). Not vice versa. That "enough" depends
> > > > on scheduler latency and vague pre-allocated number of pages, it might
> > > > be not enough what would require to refill it more and more or we can overshoot
> > > > that would lead to memory overhead. So we have here timing issues and
> > > > not accurate model. IMHO.
> > > 
> > > I'm firmly opposed to the single argument kvfree_rcu() idea, that's
> > > requiring memory to free memory.
> > > 
> > Hmm.. The problem is there is a demand in it:
> 
> People demand ponies all the time, the usual answer is: No.
>
I see your view. From the other hand it is clear, there is still
demand in it:

<snip>
void ext4_kvfree_array_rcu(void *to_free)
{
 struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);

 if (ptr) {
  ptr->ptr = to_free;
  call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
  return;
 }
 synchronize_rcu();
 kvfree(ptr);
}
<snip>

--
Vlad Rezki
