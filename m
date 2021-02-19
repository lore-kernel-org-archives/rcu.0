Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D0C433DB
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 11:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E12764E77
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 11:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBSLNs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 06:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBSLNq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 06:13:46 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420FFC061574;
        Fri, 19 Feb 2021 03:13:06 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a22so18160608ljp.10;
        Fri, 19 Feb 2021 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P0byXqzM+Zc4/Gl9DjXiSfs91CO2J92qhMxAg8TAMLI=;
        b=uV/y8yzjoZTboINvZT8E7qZLEZUobVSAll67AKd91yz2ML/e4ZwydlTFn9mneO8NQ5
         siWcaZwLcz+9tw42crghN8kHYG1KLBp6KS11uDZmQWcE6XXBr7Zh5PsR+jQyqflEUdjS
         OOqwGyVrkV4qFnjcyyRgcyEGjcaYAIjm5PNqPfweytQSma4uMAm6jetqIFqNrNBmxLn6
         SHDpmG1oWpK2wqnonsmw2Vlj7IPIg2VrVFpSP6EKEFvsbUKfWKsH7h/mLNef7EF8Ykt9
         D53iiGcgYPYN4U3htKIsKdnIB2WYTV/UXovYki4vXnSRToG8ZFfO/mIFxNaVCWPVBUo3
         +u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0byXqzM+Zc4/Gl9DjXiSfs91CO2J92qhMxAg8TAMLI=;
        b=WrqyqEyhyHaN7t8VIHTsdfhRVRD4KQR2coBSz5aEWOzQK8aisOWJCqplNf4tVykgvz
         vLkp6HM7IQiPtXv/+GzXpatkfcDBKabalX4mJSd+yeV+dxEsqfje+1bjfFpCfhL2uogH
         Iy3noEj2fJsaoHOXJ2xknWqvGfAo/Gl56iiRtoFtoESUnYpEO13BqXvJlubsnssSvpkJ
         INaev+JBcN9hKDHpptvWWH32figXWbT0NdtutaqIS2DQzL89ZgwOr+MGTbKSPiZJ1HFr
         9HoLT7T/Sy0FObUyv0TqTqLI4JuixNY1MwO7tlFFR7SQ5Vf8NLfkgWPDRaGLwHYlDuA/
         LCMA==
X-Gm-Message-State: AOAM5338dr4RUQ9CHQk/SyfoY6Qecyq/gxKuSCJC2VejTl3GFal0DBsF
        kKoALeYlCGljS1FZePB63WI=
X-Google-Smtp-Source: ABdhPJzYnQcFySx46h87XYSBUvdZCQ+CSAtC312TKOXS8RGFBMgZgxfILJF7iZFJHJQtTLRkSg9Zyw==
X-Received: by 2002:a2e:9795:: with SMTP id y21mr2994420lji.226.1613733184642;
        Fri, 19 Feb 2021 03:13:04 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id g3sm925135ljj.43.2021.02.19.03.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 03:13:04 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 19 Feb 2021 12:13:01 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20210219111301.GA34441@pc638.lan>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219105710.d626zexj6vzt6k6y@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 19, 2021 at 11:57:10AM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-19 11:49:58 [+0100], Uladzislau Rezki wrote:
> > If above fix works, we can initialize rcu_init_tasks_generic() from the
> > core_initcall() including selftst. It means that such initialization can
> > be done later:
> 
> Good. Please let me know once there is something for me to test.
> Do I assume correctly that the self-test, I stumbled upon, is v5.12
> material?
> 
I or Paul will ask for a test once it is settled down :) Looks like
it is, so we should fix for v5.12.

--
Vlad Rezki
