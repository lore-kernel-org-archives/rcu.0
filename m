Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11121C4361B
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 13:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C432C23D39
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 13:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbgLJNFc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 08:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbgLJNFX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 08:05:23 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6DBC0613CF;
        Thu, 10 Dec 2020 05:04:43 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id m25so8060936lfc.11;
        Thu, 10 Dec 2020 05:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=edwMuXvWjFR+A9x6xevAZ7MMKuEj255nvCx/HiHssnU=;
        b=utmvGq3waWEkeFYCjtru982P+/BJ67a5BVoeHkVJwLe5Zvz1FAtE8u2/1lWReXQzr0
         fMgl8i4rex4z5jRRt7TIgIjQMD3eHqX0hHkivv6vuRRhMVbLz8RJS1cuqOVrtr+hTBWU
         BhMqedG7TPIGbaav4yVcXdokhqX+CxDd53pD5719voeADfdGBK3p0Ukqykr6XhK8JKVW
         jgoBzsDgHFDKBYCHotSIo0tId7IAYCcyLk+OYCsTdIoqvuuwKH4LIoNC2Ol+Gykh7CXb
         Y2SNTcq+0O3fP+Eoz0tt13dB13rLpriWETLXOX7yU2BUVuRWdi67m6eFitq32t9G2Kbv
         +CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=edwMuXvWjFR+A9x6xevAZ7MMKuEj255nvCx/HiHssnU=;
        b=Ab4EA5SwHO9nKusx5cAvf3EYxXEz4iOfH3mEfeX5QkGoefD66MzETWXd9FmGyO6fyL
         6LPuiis7m1tcH20KVL0Ttdk8EWvxqSjQN57vDy8HWZT35OkyUfaBPSxd6ntGOb0pNFE/
         +t/1IzKFI67mRFkWN20FvYP6nbRpWJ6LMTO5Z2iyRovC1tYGYosL/Oh9qZj9xX7X/l3K
         5AwB3ssyl/kRyn6u6yOP9DusIoefp1XRF9D7S8Oo2tniDoqsWHonF5wxUMda1BFY9hzI
         I3gOm+0lydVT1QFPh7Lhb0djIOX6cKTevIRPN8/vEpYlOAT/hqQ/V0uU6Z4MTUVuU9vq
         KFRg==
X-Gm-Message-State: AOAM530eeBgYSFQYbrLZ6j1H0S6DWy2Uw0IOZp85CYJRzy9yFb5NXeCS
        w+bbP2orWQF0voN+7EzXuZUGlUjxOzvopw==
X-Google-Smtp-Source: ABdhPJxIO0D3RjVCncNMjWR9qNQ4fnH0e6eY9D3/Zs9oEnvQsSp/jyJ4XBfsR8lsLkq2yI2pf2oFkg==
X-Received: by 2002:a19:6e4c:: with SMTP id q12mr2787021lfk.162.1607605481666;
        Thu, 10 Dec 2020 05:04:41 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id e26sm512373lfj.21.2020.12.10.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 05:04:40 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 10 Dec 2020 14:04:39 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcu-tasks: move RCU-tasks initialization out of
 core_initcall()
Message-ID: <20201210130439.GA1883@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201210032613.GS2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210032613.GS2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 07:26:13PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 09, 2020 at 09:27:31PM +0100, Uladzislau Rezki (Sony) wrote:
> > Initialize the RCU-tasks earlier, before *_initcall() callbacks are
> > invoked. Do it after the workqueue subsytem is up and running. That
> > gives us a possibility to make use of synchronize_rcu_tasks*() wait
> > API in early_initcall() callbacks.
> > 
> > Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Thank you!  I have queued both with the usual editing, so please
> check and let me know if I messed something up.
> 
Thanks! 

Will have a look at editing.

--
Vlad Rezki
