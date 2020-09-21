Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2E9C4363C
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 19:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744792223E
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 19:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPLTUfFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgIUTsZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgIUTsY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 15:48:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C4C061755;
        Mon, 21 Sep 2020 12:48:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y17so15399502lfa.8;
        Mon, 21 Sep 2020 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XrwtFZlkzC4xnkOODRwGMeyZ0KnSDnPL+eEdoGaN3l8=;
        b=GPLTUfFNY19G5YRYzVy+fyWXW3qEBOUJaQ76dfVJYpHeLXOHau+uFYJOldDsPR+2up
         dGNjTyH1QDsgtUie4o1X/OuBP1GFn1BX1lJx/OqME2M1NFbCnqrLqJWZCOE70sBoPF0m
         gg09I9JfZh/Cmq5//7vFWggExa/C2CDBiayyuF5oxcU6qtZ+4N2vYI2EPf5HSEewrL6J
         qH1LTTQhOcJDNbJDJL1OpcxjRF8TCaA6N3Fp+nYZZP5eCWIjpxFiXzkyOhoZ6Qncz7cX
         E8JOpiZkBwfpHHLsO/WNKapXpvB0AUZ+OZxFQrs7k+F2l/QW46p2yq0y6FL+GIIQEL8U
         MN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XrwtFZlkzC4xnkOODRwGMeyZ0KnSDnPL+eEdoGaN3l8=;
        b=VYGPA0hCD+tilkRVYfbfTba8kFM3AD5PGW3KSZK6eIbxAZjhYlEdU2F9vOVnMOEK4I
         5fan+l+mbWu7BFJ9bvQYfcuBCAA+4LNB2AsWS5jO0/gWBZrFzxekUjieF3Mq3Mq69bWi
         BLNb3N6EEhYMgQIbpHYeC1MBfycwTefogHacLoVe76bAoWSEpp3dnL9RWxGLTEEsJdxQ
         x928Z2eyTT7SVvMgJvgbwDn1j7hksBajhS653vAnFNPJd4ZveHgTBfKYJNYwIgjb1e+o
         FcDyHKknPQ9dbod3NZC97YlY8+h6xSn6iZKFFfsEN+JxBrnDUVafc1xX3Z9G8R8Dtvft
         1lDw==
X-Gm-Message-State: AOAM532Bj1s1qYRSPMPjJ+mgrzEF2bH+Ul2F1KLpz6Z/6F+m/Iv27m7T
        TL/WepQZjlfPDsttcrEDQDw=
X-Google-Smtp-Source: ABdhPJzxBsvJLiIKiIhV8rG2fL2QGs8ROc27J2i7iokxWGUUCL4uk54QartYVw8qx1YDYJcTkdsZxg==
X-Received: by 2002:a19:b8a:: with SMTP id 132mr431662lfl.249.1600717702539;
        Mon, 21 Sep 2020 12:48:22 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y26sm2818159lfy.163.2020.09.21.12.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 12:48:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 21 Sep 2020 21:48:19 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200921194819.GA24236@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921160318.GO12990@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Michal.

> >
> > Yes, I do well remember that you are unhappy with this approach.
> > Unfortunately, thus far, there is no solution that makes all developers
> > happy.  You might be glad to hear that we are also looking into other
> > solutions, each of which makes some other developers unhappy.  So we
> > are at least not picking on you alone.  :-/
> 
> No worries I do not feel like a whipping boy here. But do expect me to
> argue against the approach. I would also appreciate it if there was some
> more information on other attempts, why they have failed. E.g. why
> pre-allocation is not an option that works well enough in most
> reasonable workloads.
Pre-allocating has some drawbacks:

a) It is impossible to predict how many pages will be required to
   cover a demand that is controlled by different workloads on
   various systems.

b) Memory overhead since we do not know how much pages should be
   preloaded: 100, 200 or 300

As for memory overhead, it is important to reduce it because of
embedded devices like phones, where a low memory condition is a
big issue. In that sense pre-allocating is something that we strongly
would like to avoid.

>
> I would also appreciate some more thoughts why we
> need to optimize for heavy abusers of RCU (like close(open) extremes).
> 
I think here is a small misunderstanding. Please note, that is not only
about performance and corner cases. There is a single argument support
of the kvfree_rcu(ptr), where maintaining an array in time is needed.
The fallback of the single argument case is extrimely slow.

Single-argument details is here: https://lkml.org/lkml/2020/4/28/1626

> > > I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
> > > that this optimization is not aiming at reasonable workloads. Really, go
> > > with pre-allocated buffer and fallback to whatever slow path you have
> > > already. Exposing more internals of the allocator is not going to do any
> > > good for long term maintainability.
> > 
> > I suggest that you carefully re-read the thread following that email.
> 
> I clearly remember Thomas not being particularly happy that you optimize
> for a corner case. I do not remember there being a consensus that this
> is the right approach. There was some consensus that this is better than
> a gfp flag. Still quite bad though if you ask me.
> 
> > Given a choice between making users unhappy and making developers
> > unhappy, I will side with the users each and every time.
> 
> Well, let me rephrase. It is not only about me (as a developer) being
> unhappy but also all the side effects this would have for users when
> performance of their favorite workload declines for no apparent reason
> just because pcp caches are depleted by an unrelated process.
>
If depleted, we have a special worker that charge it. From the other hand,
the pcplist can be depleted by its nature, what _is_ not wrong. But just
in case we secure it since you had a concern about it.

Could you please specify a real test case or workload you are talking about?

Thank you for your comments and help.

--
Vlad Rezki
