Return-Path: <SRS0=1n6r=WY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2EBC3A5A1
	for <rcu@archiver.kernel.org>; Wed, 28 Aug 2019 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE7222CF8
	for <rcu@archiver.kernel.org>; Wed, 28 Aug 2019 20:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j0BmqqfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfH1UfB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:35:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34441 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfH1UfB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Aug 2019 16:35:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so506700plr.1
        for <rcu@vger.kernel.org>; Wed, 28 Aug 2019 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=upwaiJ61BH1IpIswTLq+2j1brd6YlJwq3xhLh2FJl/Q=;
        b=j0BmqqfF2dUwzXmcTIDGocquJMKbOF2wEU+8SAdj+xEVuSMZZt2jvoMBCH9qUDV+W4
         uhp73qjEXaaGHfOJZyoJqtVlxC+xLcYkpu4P4xSXiVYog59x/FImui1wixg9OrquFFcn
         gpjMbjgO+WQ7poBwG4DFhCjIajmLZEDP1B0ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upwaiJ61BH1IpIswTLq+2j1brd6YlJwq3xhLh2FJl/Q=;
        b=qnyQK5CYGPUh0Co3VfGFybImEPTWtNUg27nU9j3mnO8ODHXTyQAFKGHZ+p3TjQAWBw
         co4gBeOosgr6m0/BDcv1VbdSq/+uVfo3BIn4m8Ldu8Dg8kcrc8cJErcQn7etX0nt6YXX
         imZhNtoAH7+ucGAh5MIcUtcOgG4s/EBu8MIbtlbVEKtICLXw2HpDozhNVaGZEN6ZR7o2
         wOAmNxtOcDnUbIerOMvVNVOJ4Vy13cnRoLI0GoER13DaNlvnLvXuN+R3Ta9VJmolmY/i
         0gZ5/5PRKn1bEBAzZIWg/ISxEBuYEdawRF6hCiu5XxxMd+jxl2Cp5qWb5NZL2iwLU4ZA
         rI7w==
X-Gm-Message-State: APjAAAUzngE+mfEDp4Ivn80Yg+m2X/zdmil9gVY5DQfXbyuQpwY5/34q
        m7WJnf3+79SdxGeAIy+3pySHEQ==
X-Google-Smtp-Source: APXvYqwnZzm4cK0z1wLUekxhHBcwsIiezmmxCb7nn4XUc+uSnyrmAgKCD6uVOWydivR5Imi9QmdyUw==
X-Received: by 2002:a17:902:a410:: with SMTP id p16mr6220611plq.150.1567024500119;
        Wed, 28 Aug 2019 13:35:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y14sm62881pge.7.2019.08.28.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:34:59 -0700 (PDT)
Date:   Wed, 28 Aug 2019 16:34:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 0/5] kfree_rcu() additions for -rcu
Message-ID: <20190828203458.GA75931@google.com>
References: <5d657e30.1c69fb81.54250.01dc@mx.google.com>
 <20190828202808.GT26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828202808.GT26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 28, 2019 at 01:28:08PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 27, 2019 at 03:01:54PM -0400, Joel Fernandes (Google) wrote:
> > Hi,
> > 
> > This is a series on top of the patch "rcu/tree: Add basic support for kfree_rcu() batching".
> > 
> > Link: http://lore.kernel.org/r/20190814160411.58591-1-joel@joelfernandes.org
> > 
> > It adds performance tests, some clean ups and removal of "lazy" RCU callbacks.
> > 
> > Now that kfree_rcu() is handled separately from call_rcu(), we also get rid of
> > kfree "lazy" handling from tree RCU as suggested by Paul which will be unused.
> > This also results in a nice negative delta as well.
> > 
> > Joel Fernandes (Google) (5):
> > rcu/rcuperf: Add kfree_rcu() performance Tests
> > rcu/tree: Add multiple in-flight batches of kfree_rcu work
> > rcu/tree: Add support for debug_objects debugging for kfree_rcu()
> > rcu: Remove kfree_rcu() special casing and lazy handling
> > rcu: Remove kfree_call_rcu_nobatch()
> > 
> > Documentation/RCU/stallwarn.txt               |  13 +-
> > .../admin-guide/kernel-parameters.txt         |  13 ++
> > include/linux/rcu_segcblist.h                 |   2 -
> > include/linux/rcutiny.h                       |   5 -
> > include/linux/rcutree.h                       |   1 -
> > include/trace/events/rcu.h                    |  32 ++--
> > kernel/rcu/rcu.h                              |  27 ---
> > kernel/rcu/rcu_segcblist.c                    |  25 +--
> > kernel/rcu/rcu_segcblist.h                    |  25 +--
> > kernel/rcu/rcuperf.c                          | 173 +++++++++++++++++-
> > kernel/rcu/srcutree.c                         |   4 +-
> > kernel/rcu/tiny.c                             |  29 ++-
> > kernel/rcu/tree.c                             | 145 ++++++++++-----
> > kernel/rcu/tree.h                             |   1 -
> > kernel/rcu/tree_plugin.h                      |  42 +----
> > kernel/rcu/tree_stall.h                       |   6 +-
> > 16 files changed, 337 insertions(+), 206 deletions(-)
> 
> Looks like a 131-line positive delta to me.  ;-)

Not if you overlook the rcuperf changes which is just test code. :-D ;-)

thanks,

 - Joel

