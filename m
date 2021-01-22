Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64017C433E0
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 18:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B1723AAC
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 18:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbhAVSoW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbhAVOV5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Jan 2021 09:21:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F059C061786;
        Fri, 22 Jan 2021 06:21:17 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a8so7741447lfi.8;
        Fri, 22 Jan 2021 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DRuoE5BoHJqfSn/CuRyT9sBVsoEYMteCMLatsDG8GRg=;
        b=hmcwK4U+8IJhIFHxPEN0f1oPn56dF/9BlpFzezML4fX3kcphxhYf2wrGGMoMcitVE/
         n/ZIb51ScH6oi8qRZG8VES9j/utF4LkBbkD9ArYhbBWGfmm6m6mNNqwyVW1WBtTXb5eT
         +QlXA7DVDPOqr1sguiUhMsSrM4q0hbtY5Ot8VCuQCCyWU5ORMC3vz4fjigAOIVbXOYha
         Y/tXKohUZ2TAM/LNG8YH6Jg95iIAqHRCS3JRcLE2NbbbUYfleFl2Wyzq+vwoKgDTXHxg
         4fYFykfNMEV4+17jm7ICDtgGz0NYlfbt7/+a/t6Uota5JktZKC68B5FUV3yD5FG0qReB
         O1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DRuoE5BoHJqfSn/CuRyT9sBVsoEYMteCMLatsDG8GRg=;
        b=qLZ23jIzcJTsWiS6qAgsJeaxNZIS37A8dBsJJVu5ZX9LnSto5pKTwYlKdCOBLHKR2G
         X/u/oyLZBdEcuaQw6XBv6WdWzDaAVBW1NyTIOz+4xNkyZUCLUO1WOWK3nl3kNxKkLDxT
         /HO5t3Dz42d8DJyYuYtmTG0c8s9gnp8ZBYRAZZCkWaeCV05j8c+Rg/RiIjzN8/uU28nc
         9ik8TNiJH+yL2QtY+oPKPO/utpNxC+bhwiJYHsblShgWyu57QyHIxpbOxHua6WmWO/Ag
         YzpMk4rRKce44nvBZwlkJohs46saeicy9G3BtJ34iBjVg06FCpj+eklAgoI2XyotB5+U
         UTFg==
X-Gm-Message-State: AOAM533HMrtLtH0f2t73hu7xfJHLnjf+2HAAUogDlo/+aTCNAGBjvZqC
        +iSN58EXa1b8Gs+Rbg2K3dw=
X-Google-Smtp-Source: ABdhPJziVUotrZv1JHvUCsUK21iR9fnvFePlUaXqgbh0VrMpneXNfWBFix3ajFZB+t9OFnwdaixkNw==
X-Received: by 2002:ac2:5f58:: with SMTP id 24mr887475lfz.302.1611325275649;
        Fri, 22 Jan 2021 06:21:15 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y3sm778446ljy.98.2021.01.22.06.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:21:15 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 22 Jan 2021 15:21:13 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210122142113.GA1873@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
 <20210121123834.GA1872@pc638.lan>
 <20210122113409.w55kul5bpjxhkgm4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122113409.w55kul5bpjxhkgm4@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On 2021-01-21 13:38:34 [+0100], Uladzislau Rezki wrote:
> > __get_free_page() returns "unsigned long" whereas a bnode is a pointer
> > to kvfree_rcu_bulk_data struct, without a casting the compiler will
> > emit a warning.
> 
> Yes, learned about it, sorry.
> 
> > >> You think that a CPU migration is a bad thing. But why?
> > >>
> > It is not a bad thing. But if it happens we might queue a new bnode
> > to a drain list of another CPU where a previous element of a new
> > bnode may be just underutilized. So that is why i use migrate_disable()/enable()
> > to prevent it.
> 
> If you allocate a node for queueing and then you realize that you
> already have one then you either free it or queue it for later.
> Given that all this is a slower-path and that this is used on every-CPU,
> sooner or later that page will be used avoids a later allocation, right?
> 
To free it right away is a bit problematic, because we need at least one more
time to drop the lock what would introduce more complexity. Adding to the cache 
for later reuse is possible but would require an extra decay cache logic.

I think, since it is a corner case and i do not consider it as a big issue,
we can just queue it to the drain list so the previous node can be half filled
due to migration.

> > If there are some hidden issues with migrate_disable()/enable() or you
> > think it is a bad idea to use it, it would be appreciated if you could
> > describe your view in more detail.
> 
> Just what I mentioned in my previous email:
> - the whole operation isn't cheap but it is more efficient in tree
>   compared to what we used to have in RT.
> - the task can no be freely placed while it could run. So if the task
>   gets preempted, it will have to wait until it can run on the CPU
>   again.
> 
Yep, that is obvious. From scheduling point of view the task can wait more
time because the migration is prohibited. From the other hand, the page is
obtained in the path that is not considered as a hot one. One page can serve 
~500 pointers.

I do not say that we should keep: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()

without it, a migration can occur, what is really rare according to my tests
therefore i do not have a strong opinion about keeping it. If you or someone
else has some concern we can drop it.

--
Vlad Rezki
