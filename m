Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE85FC433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813FC64E5C
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBSL3Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 06:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhBSL2g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 06:28:36 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5682DC061788;
        Fri, 19 Feb 2021 03:27:55 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a17so18421837ljq.2;
        Fri, 19 Feb 2021 03:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HAm3b1BxNMJwHYQdwhTOSEndOZP55AielTvmaxsP3Gw=;
        b=XhiG+o4gJ+xpYPbUoUkovutIBMeiHZNB9MjcBaqA57JnlygJYMb/rP6zisqfaa5eyX
         RdhAX54klI4VK/lFW798lySdYyVKriy2E3x4FtrJBvL7Dk7ml0g2f8uogSbKTCveIVjN
         uXJH9nrwm0/dQXEQjw1EkGKP2P0ZJfNKSqcQjxpqkFISpwld7RL3DrTOGy/eX0vLWgsK
         9u69AXSxxbV1mDQv4/yHXp2IphXJRyxxOwsTLXYdO6bjAmCH48NlOwcQCbiS9YfhSiaQ
         3E5wKT7pQVPD89SAVmksgN4b3FM9lVXTaNldD+hs+rH7Yuj89k9KEt1yR9ypZ+Yk/fao
         8nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HAm3b1BxNMJwHYQdwhTOSEndOZP55AielTvmaxsP3Gw=;
        b=PMYmwDUOpoOErvMMups4W66VkVRrDtWS7mODeZuOPU2qqvVjZUzyi0OWFMvVVWBnyR
         q0eOGXR4Jv8ZgNN/UVQpSubizrm2OgVgsq0ECmZuvyYejpyojpwthefqiwCue0X7QxPV
         Cp3VM7VnaB4enUjY5EUZji479ac8SIz4xI3J31Kuz6FJzw0SLTa6ANkH6+tMDADWAlWz
         bdOcLliRvhijtq2aW9yRle4pnLc///Xfv4q6kd2bJ2++Gvus+O7QtcCKrVO81Wvfr2T3
         1yzVUCzu92UyIV+Dx8vycmBZCtE5UytVlTI7hW9MTsxQ6LAcZ1LeR0eMpUgBV2/i+6Dw
         1jzQ==
X-Gm-Message-State: AOAM532LR6xQj1mVozkWIlbCgpqTyy+hlm5DiZgdQfuuqLOCld+k/ypf
        gcr3ic7A4tQvTcj/YRiu3vo=
X-Google-Smtp-Source: ABdhPJy749jfYojCrXQSs3otKCtA1NfcEr6dxV27xpZu8c6qGTOK0tNFWdEWgA6qW7+gzo5Jx8vicw==
X-Received: by 2002:a05:6512:10c9:: with SMTP id k9mr5703622lfg.532.1613734073813;
        Fri, 19 Feb 2021 03:27:53 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c18sm329583lfr.140.2021.02.19.03.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 03:27:53 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 19 Feb 2021 12:27:51 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20210219112751.GA34528@pc638.lan>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219112357.GA34462@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 19, 2021 at 12:23:57PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 19, 2021 at 12:17:38PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-02-19 12:13:01 [+0100], Uladzislau Rezki wrote:
> > > I or Paul will ask for a test once it is settled down :) Looks like
> > > it is, so we should fix for v5.12.
> > 
> > Okay. Since Paul asked for powerpc test on v5.11-rc I wanted check if
> > parts of it are also -stable material.
> > 
> OK, i see. It will be broken starting from v5.12-rc unless we fix it.
> 
Sorry it is broken since 5.11 kernel already, i messed it up.

--
Vlad Rezki
