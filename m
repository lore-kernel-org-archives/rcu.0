Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F8C2D0A8
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 11:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A6B2145D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 11:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPbMa256"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIWL10 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWL1Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 07:27:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6990CC0613CE;
        Wed, 23 Sep 2020 04:27:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w3so16903457ljo.5;
        Wed, 23 Sep 2020 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PF60as8MpIwsxJIqqAOINxwtnO5aupgejkBPp4saGRI=;
        b=kPbMa256EDIOx6B5ZH/I6P8OuhTR0akW/H9eJ7j4yFwMH9vATN3TGA9nPT1oLbicn9
         9wZ8Kzh23ymfDthKlHUqKejeXwDhmzBUiCJrfrk/ONnzdvxqFP+W2a91PTP+GVw9hkbK
         pAGvI0PTupNyEXsPZWhK8OAX8B3gGR2gy7Qs+O1Io+Y6gKDu2OZPsMpmIPdSmt1aU8hW
         wVAGSylLZ396/vgp60qJzCH5WFXiC2PtAG+SOtZrRFUTLqtbXayZDv3Jl7wVig5Gp526
         dSqbZi1V9DxjWfM2Z5oDfrbgpILRRCb2+RoXIvBYYIZKG3ctB7+n3LN/MzE5WqklTMnn
         uiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PF60as8MpIwsxJIqqAOINxwtnO5aupgejkBPp4saGRI=;
        b=KWp+foSDBtDzLx8nM3zDJ40vWLSstKjNXwW3NJ9J6Uii8GOkcbcc+lEIRE+ZD6Efzw
         3UHt0ptAQXP+PkIDscWbe+/edxvzXX2Ss2PPu0U8D1i7dl3Anr2baLFkyvFWlh7Ey1pJ
         dCmnv1PtqPX2V1J0mp+C14x0uWuIfp0QBNzd5uJaW5A+gB+a3oW/mj8JdHZCXaDUiRlm
         NloG8FYNFSSw9p900KSjx/lvE/5DrOblW8hEKznXQRC4pKfbx+iC/XHbJ24EQfKKBsrm
         prJAm/b/utKJAEu0K8PPyTvsOaUlQ/G9U6ZC2Gt3Y35SCpmrBamU12lTRtaXXIdFY67E
         6dJA==
X-Gm-Message-State: AOAM531DWoSsB1JCdYnphA26ebsc/WYzUESrT95BmD3S9m/70JkpX7iG
        HuW/JdvVV6FxBSEvaHNCdsw=
X-Google-Smtp-Source: ABdhPJyjJ7gCM2EyR1iq96O3NkMTgpN2WZZdCb3tyuAX//K2341e1123fZlk9VT2Gj64jWc3o5ySnA==
X-Received: by 2002:a2e:99c4:: with SMTP id l4mr3211132ljj.428.1600860443667;
        Wed, 23 Sep 2020 04:27:23 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id g26sm371781ljl.116.2020.09.23.04.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 04:27:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 23 Sep 2020 13:27:19 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200923112719.GA6796@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200922033553.GU29330@paulmck-ThinkPad-P72>
 <20200922080306.GV12990@dhcp22.suse.cz>
 <20200922154621.GW29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922154621.GW29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > Other approaches under consideration include making CONFIG_PREEMPT_COUNT
> > > unconditional and thus allowing call_rcu() and kvfree_rcu() to determine
> > > whether direct calls to the allocator are safe (some guy named Linus
> > > doesn't like this one),
> > 
> > I assume that the primary argument is the overhead, right? Do you happen
> > to have any reference?
> 
> Jon Corbet wrote a very nice article summarizing the current situation:
> https://lwn.net/Articles/831678/.  Thomas's measurements show no visible
> system-level performance impact.  I will let Uladzislau present his more
> microbenchmarky performance work.
> 
I have done some analysis of the !PREEMPT kernel with and without PREEMPT_COUNT
configuration. The aim is to show a performance impact if the PREEMPT_COUNT is
unconditionally enabled.

As for the test i used the refscale kernel module, that does:

<snip>
static void ref_rcu_read_section(const int nloops)
{
 int i;

 for (i = nloops; i >= 0; i--) {
  rcu_read_lock();
  rcu_read_unlock();
 }
}
<snip>

How to run the microbenchmark:

<snip>
urezki@pc638:~$ sudo modprobe refscale
<snip>

The below is an average duration per loop (nanoseconds):

  !PREEMPT_COUNT            PREEMPT_COUNT
 Runs     Time(ns)         Runc     Time(ns)
 1        109.640          1        99.915
 2        102.303          2        111.106
 3        90.520           3        98.713
 4        106.347          4        111.239
 5        108.374          5        111.797
 6        108.012          6        111.558
 7        103.989          7        113.122
 8        106.194          8        111.515
 9        107.330          9        107.559
 10       105.877          10       105.965
 11       104.860          11       104.835
 12       104.299          12       106.342
 13       104.794          13       106.664
 14       104.916          14       104.914
 15       105.485          15       104.280
 16       104.610          16       105.642
 17       104.981          17       105.646
 18       103.089          18       106.370
 19       105.251          19       105.284
 20       104.133          20       105.973
 21       105.589          21       105.271
 22       104.154          22       106.063
 23       104.963          23       106.248
 24       102.431          24       105.568
 25       102.610          25       105.556
 26       103.474          26       105.655
 27       100.194          27       102.887
 28       102.340          28       104.347
 29       102.075          29       102.389
 30       102.808          30       103.123

The difference is ~1.8% in average. The maximum value is 109.640 vs 113.122
The minimum value is 90.520 vs 98.713.

Tested on:
    processor       : 63
    vendor_id       : AuthenticAMD
    cpu family      : 6
    model           : 6
    model name      : QEMU Virtual CPU version 2.5+
    cpu MHz         : 3700.204

I also can do more detailed testing using "perf" tool.

--
Vlad Rezki
