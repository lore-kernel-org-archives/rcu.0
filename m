Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D23C433E1
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8E8208E4
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 12:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pW09kmDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgHNMPu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgHNMPt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 08:15:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77393C061384;
        Fri, 14 Aug 2020 05:15:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so9703509ljk.6;
        Fri, 14 Aug 2020 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PgYt5IIzJArLnCvs1n8uTpEleBnGmJTMqA1M8YX4wEU=;
        b=pW09kmDoa4gKDugL6xl+TVMKGaf7wLNlIKtlhhUsi/4ioWA8XoGrmj4Kk+fdwgq0Qi
         GVJ9GhvIpIg1EON4lybae3+l5zysAnKnJSN2lyyaQGmYpqkmTKoJe7dXK9D/ZNT77sP2
         FUBf3xgg0E58CZk6iz4kLInaZHnN/6R6LDszBeEczLflS+Du3W2yBT2YpcSUe5veDmx3
         dnA6NwWHrN32xmxiQkgRdcLIrx3uZwRRngZHmGwF8Qs/nJ8mk4bFAiKVJM4clB+MHG4Q
         udN4nBAcTtC97GZv/HADvl3g5p+W127Y594a5FxQsUBVfyQ1696P7BPCrKFM73PHBzVj
         khfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PgYt5IIzJArLnCvs1n8uTpEleBnGmJTMqA1M8YX4wEU=;
        b=TywOWb8aYJNur/AvtQO51j3cCMj5/nj/LpZjtabXWvXCDWtzWo0Dol641o4T2oYbHU
         Uj+zYfdTE94ovzj0G6VqX22deKD7FByayQ5tD7LGYp6jsB4myv/XIPNyZtZt3CKtB+FA
         ogqGR1kQ/eCQHKLjpUeOS+6gR0bj/6jpExpV6v9rL5w38Mh7P7xSG8gUSIhsNAeXYc+F
         3F8w2ES0tpGQWRnyZBSC8HS6GQurY/PBbL+Wgo5PSRcbRy34jVBhSAfhwZQ69lMFzpbA
         gUl/xuXzP27WAIUUrNFJwXjuDDehmidtx4jknntJ0X59h9NYsInNaJ6uH7eQz48HdfZI
         xeYA==
X-Gm-Message-State: AOAM532XkM+9T1m53xSnfJk0NbxWKkaeopYqvFwdUPUe7XEpyUD93Hsr
        6dKrIGstEL+4SxImPJDv/8s=
X-Google-Smtp-Source: ABdhPJwE/bPWMvgjVP9ZxlbqmeOPZEiQ5IhiGO0gRA8dm9/zjFVxWrS71UHXu39G/zIWhzfaElHxwQ==
X-Received: by 2002:a2e:80c9:: with SMTP id r9mr1069440ljg.95.1597407347365;
        Fri, 14 Aug 2020 05:15:47 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id n29sm1896654lfi.9.2020.08.14.05.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:15:46 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 14 Aug 2020 14:15:44 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814121544.GA32598@pc636>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <87lfiitquu.fsf@nanos.tec.linutronix.de>
 <20200814071750.GZ9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814071750.GZ9477@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Thu 13-08-20 19:09:29, Thomas Gleixner wrote:
> > Michal Hocko <mhocko@suse.com> writes:
> [...]
> > > Why should we limit the functionality of the allocator for something
> > > that is not a real problem?
> > 
> > We'd limit the allocator for exactly ONE new user which was aware of
> > this problem _before_ the code hit mainline. And that ONE user is
> > prepared to handle the fail.
> 
> If we are to limit the functionality to this one particular user then
> I would consider a dedicated gfp flag a huge overkill. It would be much
> more easier to have a preallocated pool of pages and use those and
> completely avoid the core allocator. That would certainly only shift the
> complexity to the caller but if it is expected there would be only that
> single user then it would be probably better than opening a can of worms
> like allocator usable from raw spin locks.
> 
Vlastimil raised same question earlier, i answered, but let me answer again:

It is hard to achieve because the logic does not stick to certain static test
case, i.e. it depends on how heavily kfree_rcu(single/double) are used. Based
on that, "how heavily" - number of pages are formed, until the drain/reclaimer
thread frees them.

Preloading pages and keeping them for internal use, IMHO, seems not optimal
from the point of resources wasting. It is better to have a fast mechanism to
request a page and release it back for needs of others. As described about
we do not know how much we will need.

--
Vlad Rezki
