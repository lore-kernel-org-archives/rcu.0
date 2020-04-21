Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B1EC54FC9
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 12:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3871206D4
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 12:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlUJRnWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDUMEI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726691AbgDUMEI (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 21 Apr 2020 08:04:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1F6C061A10;
        Tue, 21 Apr 2020 05:04:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n6so10327417ljg.12;
        Tue, 21 Apr 2020 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJsRBBfwvyySoCiHEGj9Gv9Mk2bvYvkWIPinytPXa3Y=;
        b=WlUJRnWbR+q2LFhRFuyhK7j7dqEZmdCCYRe5yPYPArU2SeYgB0nu6FICi3B0IjbHTE
         im5NS4z2Y5neElktEpaeT48d6SxzUt5AswpZh3XuNLp4Pv61t1vzRL1KBKBO4cWPihH/
         OtI/66WFxpXnjI4FQTxZwBkT20H8Yz5ijGhLbETmKlyOZATyLeJeL/nzY0t1ZYQiNYpu
         UBrsa0sTT4EX+Xy57Ni6N2iqyYmiTRJpIvddyolCnkqfLLyjyGp2/oTfEGhp+zzPLAgB
         rEamVAOkomUW8mGLi4jzAg/vLIo5i2lNPP1pAH99n9fXGBSN27la6WCfOZqi2/M+GqlC
         +fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJsRBBfwvyySoCiHEGj9Gv9Mk2bvYvkWIPinytPXa3Y=;
        b=UWt5rVTppbGQ5CHDxHOMgTU/0aGtjNOPoqnVkI9llbiBpDG8q80S0hoXWpKqQKmB9G
         164QEY6QtcKxA6KND5aArbFn/rHXaBrvvTgcaSTGBbzQR1kBZtsf0XNq0fVLTmJC3FOG
         fCzmdTyuzMYzzfPNvJrRitN94jhTIDzGlKkw1mSAuaZZTNe+hA1j5cmGQ5aHVBrrTCFO
         95YAVOz54PKKLSBpPNsNHJDA50v2c2PuOC1y1JL1KCCaU5ac4vxREdRFyZP9BfTphrbo
         BISsZRN32La1RpL9SUTgF9hk/0ojXUKY9JxW90jwOjXY/sERSXBnQqrTq6rm3WQJUOtH
         JwZA==
X-Gm-Message-State: AGi0Pub6OppEPZzPU+QNWgq4F0jTDl7MQammC3wsMfOuHshjzKK4yGUT
        uM2xSlq1RQ6fimDUXUkhaGk=
X-Google-Smtp-Source: APiQypIl6ZzqFTYuqcgjHoyu2LEXlTRD8H2bBnEdjaLWMTBnQbOVFWNLlY49ht8BNLsYC1wSyNOmMQ==
X-Received: by 2002:a05:651c:2011:: with SMTP id s17mr11097051ljo.242.1587470646215;
        Tue, 21 Apr 2020 05:04:06 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m13sm2006576lfk.12.2020.04.21.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:04:05 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Apr 2020 14:03:58 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 5/6] rcu: rename kfree_call_rcu()/__kfree_rcu()
Message-ID: <20200421120358.GA5117@pc636>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-6-urezki@gmail.com>
 <20200316152541.GD190951@google.com>
 <20200316190144.GB10577@pc636>
 <20200420201527.679247f6fa76cba4331f3cd3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420201527.679247f6fa76cba4331f3cd3@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Andrew.

> > > I based the kfree_rcu shrinker patches on an 'rcu/kfree' branch in my git
> > > tree: https://github.com/joelagnel/linux-kernel/tree/rcu/kfree
> > > 
> > > For now I manually applied 5/6. All others applied cleanly.
> > > 
> > > Updated the tree as I continue to review your patches.
> > >
> 
> I'm not sure what's happening here - these patches aren't yet in
> linux-next.
> 
Please have a look here, i explained in detail in my cover latter
what we would like to achieve: https://lkml.org/lkml/2020/3/23/242

> A couple of thoughts:
> 
> - Please cc linux-mm@kvack.org on this patchset and anything else
>   which impacts MM.
> 
OK. I thought that is related to RCU, therefore i did not want to
spam, but i included you :) Next time we will keep linux-mm@kvack.org
in a loop. Sorry for that.

>
> - It's a bit strange to create new infrastructure which has but a
>   single call site.  Please tell us much more about "there was also
>   request/interest so there will be new comers" to set minds at ease. 
> 
>   Who/where are these possible new callsites and when can we expect to
>   see that code?
> 
https://lkml.org/lkml/2020/3/23/242 here i wrote motivation. Please
check it. If you have some questions please ask.

--
Vlad Rezki
