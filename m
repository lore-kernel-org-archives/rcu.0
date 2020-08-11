Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A71C433E0
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 11:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F1E206B2
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 11:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqcyJCpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgHKLK3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgHKLK3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 07:10:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C4C06174A;
        Tue, 11 Aug 2020 04:10:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so13052577ljd.0;
        Tue, 11 Aug 2020 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2nNPNm4tYKrvoUdNlKVXxkf9XuHNQ7X8ruGTZJkTmKI=;
        b=rqcyJCpYWkgePj6wCghY2mm2R68DDv1IQPZ5xxBRV//iwhNZgnMSiCOSogCoHZ6W5v
         zNBmo+A0lsapXmVFinLB2wQMktPxNwqCbWzyUBWw+hj34soNXsZcJU9BQvA6OlGeQsd5
         EuiJIciJCtDRw1b0z4/f9OobXUuHSzC9nmwI4HgtHgFu7NPubGR4skaDViYXByqUxBO/
         +drZRnnEvsYnDTpAMTeQLbV75ABoNgSa7CI5hMJoiGUxcN84xfTXpWPNtwjfF23FHLV/
         w+ing8OcBJgAGzXX25rZgb4xBILmmdcwkJr8/vLepPMw7IbNJOQGJDp5e/MEAhh8tGkH
         SBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nNPNm4tYKrvoUdNlKVXxkf9XuHNQ7X8ruGTZJkTmKI=;
        b=LAQI45NiQ+X2j3G6nnuieoGukwvVKyqvJ53uNHUwpm8zjXEuLs+Q7bv7ZF9eGld/Lm
         9Q48ujM4KFjZ57agTWEa9fuGbBRsvJ9I62GPLu+L0KadtC8nbuwzbVAs1TEo12ARSleb
         QeJcEhYixnrHkKsgwSARprMDrxmH8zSpSp5kPFx0sn2BmhathxPs7G00uFIjI4zKhj+A
         ZhZRuD+SMzUPTXVVT0vPSAyijFgunRtUeaepVSJabsujCSVS8IvdDqAxrvJ/8WKIo585
         jjZL5JzYA7jrqJYWKtDM6DRdHxnci1IVa4NrvBYHC2r2gq/MqSCcZXID1QbTIkCG5eWP
         CS3Q==
X-Gm-Message-State: AOAM530BFaysyz+8zXQkdQnbWjun4OYVxWzGNuZ1fButkCPcM0JsgrKX
        nN7bnHgv5E5C9646Mn7f+0g=
X-Google-Smtp-Source: ABdhPJxQo4vZpVOoGhJK8aSvayeavCZybEoN+zL4WQVg+ujAkkJDfT0bBaWH22ZkcN8Xh24gVu3eiQ==
X-Received: by 2002:a2e:8456:: with SMTP id u22mr2772006ljh.243.1597144226957;
        Tue, 11 Aug 2020 04:10:26 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id p13sm12672000lfc.63.2020.08.11.04.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:10:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 11 Aug 2020 13:10:23 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811111023.GA5544@pc636>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <20200811091807.GA2634@pc636>
 <20200811102124.GH4793@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811102124.GH4793@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 11, 2020 at 12:21:24PM +0200, Michal Hocko wrote:
> On Tue 11-08-20 11:18:07, Uladzislau Rezki wrote:
> > On Mon, Aug 10, 2020 at 09:25:25PM +0200, Michal Hocko wrote:
> > > On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
> > > > > On Sun 09-08-20 22:43:53, Uladzislau Rezki (Sony) wrote:
> [...]
> > > > As i described before, calling the __get_free_page(0) with 0 as argument
> > > > will solve the (a). How correctly is it? From my point of view the logic
> > > > that bypass the wakeup path should be explicitly defined.
> > > 
> > > gfp_mask == 0 is GFP_NOWAIT (aka an atomic allocation request) which
> > > doesn't wake up kswapd. So if the wakeup is a problem then this would be
> > > a way to go.
> > > 
> > What do you mean Michal? gfp_mask 0 != GFP_NOWAIT:
> > 
> > #define GFP_NOWAIT (__GFP_KSWAPD_RECLAIM)
> > 
> > it does wakeup of the kswapd. Or am i missing something? Please comment.
> > If we are about to avoid the kswapd, should we define something special?
> > 
> > #define GFP_NOWWAKE_KSWAPD 0
> 
> Sorry, I was more cryptic than necessary. What I meant is that
> GFP_NOWAIT is the basic non-sleepable allocation. It does wake up
> kswapd but a lack of it can be expressed GFP_NOWAIT & ~__GFP_KSWAPD_RECLAIM
> which is 0, now. The mouthfull variant is better for future
> maintainability.
>
OK. I got it anyway. Just decided to clarify.

--
Vlad Rezki
