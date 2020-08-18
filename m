Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC06DC433E1
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 16:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B4420639
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 16:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqxwybX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHRQAW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHRPpN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 11:45:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3934C061389;
        Tue, 18 Aug 2020 08:45:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so21953056ljc.10;
        Tue, 18 Aug 2020 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DhzM7vDeu30fKWxKCWsmI+9HmQeO+RMonyIvtC+hDwA=;
        b=SqxwybX42CIGvNAoGhhjU+9JlLP/BC7Mga9LqZvCW/UUWMQ6DQSFFa1MIbfeTOax4O
         4gX/tWloNniS8fMgJSpgVre6Pz+rR4IvOSIJ+3hTy0a4yWfh/rDbOa+c7oLqKdGAwPP/
         pXR2kOlWGuh9QgyoaZFEbT4Y9pRSWJbjLj18QlhAVxnZiK3nOKx+Uq+D+XWgaFGTLv5i
         F+hwCGQ4sGgDITHAujFewbSoP1xC0Am1kMysavPQ+Y3b4cgFXVcRVMHGm3QWJreTCaFF
         lFlyZ6Ahc65JNW0TcoEK5pafoZxs1wyQIpACb5OIo59grcOhxh5w6eqnkBphPe3kbc9P
         7sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhzM7vDeu30fKWxKCWsmI+9HmQeO+RMonyIvtC+hDwA=;
        b=hM2gTyc3gEt78h/fLw8dUMEl/BF7yRWQoN2d7Wi2ZxUNAMUdI3PIP2Oj9qCgYWRsgt
         SB8QSxA+GNfJZFD3/Qpqkh5HXNQ+0gpO3zwFaYkYFwW/rjIsoNh5K9XFnwYRQMdfXWId
         Y++Vwq1hohoXPR/BuvsGdMlPSqz4QbQrKqeDWqrXy/Xb92TV6j5N9FL14OPARjv+A10+
         y/UzU4znq0JF9KO6i7mQ8r246riXZVh5cepJTQR7jcqZR5yz5knaGdD2Z4MRRKhY4UVY
         uURv2Y09zw4Zj3/7Bhf9PMyt4NL3BE63/8fBAEKLZDVv6e9vKAU7Vb1kArq8xCdLOaRn
         mc1A==
X-Gm-Message-State: AOAM530iLigdHR+EWFgKf+8waxispOrkQ+xZqxZ9GrJflDaX6xXNQPJN
        3RDm02gcXgnxsLbk9PwJfI4=
X-Google-Smtp-Source: ABdhPJxJ1cguy3j9aaGW5J2byMGBQhOG8Nq7ELvlaUyvvEcVjRM7knWKdu3qF9HJwcbWT83xOhyEAg==
X-Received: by 2002:a2e:7006:: with SMTP id l6mr8585166ljc.107.1597765506138;
        Tue, 18 Aug 2020 08:45:06 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id d13sm6624392lfl.89.2020.08.18.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:45:05 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 18 Aug 2020 17:45:02 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200818154502.GA32169@pc636>
References: <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
 <20200816225655.GA17869@pc636>
 <20200817082849.GA28270@dhcp22.suse.cz>
 <20200817222803.GE23602@paulmck-ThinkPad-P72>
 <20200818074344.GL28270@dhcp22.suse.cz>
 <20200818135327.GF23602@paulmck-ThinkPad-P72>
 <20200818150232.GQ28270@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818150232.GQ28270@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Michal.

You mentioned somewhere in the thread to show figures regarding hitting
a fast path and "fallback one". We follow fallback when a page allocation fails.

Please see below the plot. I hope it is easy to understand:

wget ftp://vps418301.ovh.net/incoming/1000000_kfree_rcu_fast_hit_vs_fallback_hit.png

to summarize. When i tight loop is applied, i.e. flood simulation the fallback hit
is negligible. It is a noise, out of 1 000 000 we have 1% or %2 of fallback hitting.

Thanks!

--
Vlad Rezki
