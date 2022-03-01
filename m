Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D65C433F5
	for <rcu@archiver.kernel.org>; Tue,  1 Mar 2022 17:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiCARtR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCARtP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 1 Mar 2022 12:49:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E1AFC3
        for <rcu@vger.kernel.org>; Tue,  1 Mar 2022 09:48:31 -0800 (PST)
Date:   Tue, 1 Mar 2022 18:48:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646156909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ErbLcNEM/OAH5Vz00kO3RrxwytLjoBVvp+rHkZ/0lfU=;
        b=NnBJe+5aNewyhHbntoRcz9UHcNvT3VBkycFe43ZQXnBUKp52WGKQRbk0fmDfv73XABmPBh
        vihEJxsYOswHy+Gc8VGkwQohN++XXwMaoZ39gNzM7yLaNnvnGVD9jI9mazMprLLi2DosG7
        hfUUqWO12d4xjeMBKkfGKC3BRRQRZFOE/W+yI/Ik6hBRaypU1y5Uo3zqweAiiDXyCM8zsY
        9Iotx2NEz+QdlNMXvoZdC8EFHaMcDGMvIbCzB3jcfLDzmhoqFBp5TXlPusjX9h1kH4JKbd
        78JTmyxEn7U3jRyVgt/HzuDWaqHcEEYr2vLltP1/057ihk+kyzfYBCEcA8CzQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646156909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ErbLcNEM/OAH5Vz00kO3RrxwytLjoBVvp+rHkZ/0lfU=;
        b=e/1Jmcght4vwneFkh9JrA2XujR6A/GzC1SQhcW9v94Zu/zH0vMtUkTUc1FGom/AcMj9VUt
        D5lt9oBrcqyApvBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <Yh5cbJ4boPS2MMDm@linutronix.de>
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yh5bJZmAXXGtgTIl@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-03-01 18:43:02 [+0100], To rcu@vger.kernel.org wrote:
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1659,9 +1659,10 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
>  	pr_info("Callback from %s invoked.\n", rttd->name);
>  
>  	rttd->notrun = true;
> +	WARN_ON(1);

Please ignore this piece, it sneaked in during testing.

>  }
>  

Sebastian
