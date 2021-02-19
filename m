Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66764C433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 11:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C3864E5C
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 11:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBSL0r (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 06:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhBSLYm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 06:24:42 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B7C061574;
        Fri, 19 Feb 2021 03:24:01 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e17so18330518ljl.8;
        Fri, 19 Feb 2021 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RFA5bf1h8EQA7SRcg6dIjyB28rNd3wzpvWShfnUUMhI=;
        b=vRRLT+H16oJx9Yd1pVNwh54SLDLDwhsVDjZiYhkQc7HjQrqrwLhEC8p3Sul4rsmFuT
         9vkEwf6/Gu4G/X+VWgvCOcg2Gk7gjkghSpj8U2h9nLnIghHUVRNFcht5OKO8kttd7Uwb
         rwiAqjl0+bPGnpV/IA0piPrTghfzMA2e0RN/ZDdQn/rgrx9Op8BEbDEF9srZnh0x02KH
         9NmS9gSEKwXaWcywLff7rIJ5JkytczmVMbRTlfJ7vYFwzEC25cVl6/RJmkqHp9IfPd/H
         hGLW5dQIXUysqJHpDoNDuE27M6RySOmr7GamBwahVCDjuG5R2tw6q6Htc78FGO4o+qG5
         3DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RFA5bf1h8EQA7SRcg6dIjyB28rNd3wzpvWShfnUUMhI=;
        b=lAo7FWU9zC6KeqyPdRa5QYLU+32i0ifxvdy+PuaxyPKRo1BkBuf/E1bAv7Xln63dCu
         1ppLok1VZBTVSOSmLv4G8EhYiA6EbNb5HcLuCo72ICkj2IMOpAlnXaU1zgIwhd+v9dAN
         rKkOwWwOoqTx7gZIq5zR8S5FuTvEAqZBEZW2TbRAoo6mqq7uZ+SlnyAiBSAmkOPUG+Bc
         j59fF6wUL8dqx2DwqXWeKPhZsq/3yL9w/JYsxEylZyVaq56FOQJk0ci5UqQr/sFNcv/H
         APQRv2FVH23wT0kcFdSlA26i9WZajjGosIumkq8xnzOQAAma0aweUbLm49y5FmeALJpy
         GX6Q==
X-Gm-Message-State: AOAM532L64Gjrrb34BEBm55xRBxQ1FN3pEoYvu1bAPonEifHVVvRgxSp
        8AU3P2smrJsniTGEcaM8eQU=
X-Google-Smtp-Source: ABdhPJxP2OMw7jgbXy9Tqse8W7medU+/E6iZh4OhyZbfm21RUPNUhlqDJAJ5wTNWLZI5IS3rSciutw==
X-Received: by 2002:a2e:7811:: with SMTP id t17mr5551509ljc.86.1613733839962;
        Fri, 19 Feb 2021 03:23:59 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f1sm939184ljj.124.2021.02.19.03.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 03:23:59 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 19 Feb 2021 12:23:57 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210219112357.GA34462@pc638.lan>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219111738.go6i2fdzvavpotxd@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 19, 2021 at 12:17:38PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-19 12:13:01 [+0100], Uladzislau Rezki wrote:
> > I or Paul will ask for a test once it is settled down :) Looks like
> > it is, so we should fix for v5.12.
> 
> Okay. Since Paul asked for powerpc test on v5.11-rc I wanted check if
> parts of it are also -stable material.
> 
OK, i see. It will be broken starting from v5.12-rc unless we fix it.

--
Vlad Rezki
