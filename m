Return-Path: <SRS0=gxlL=AZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FCEC433E1
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 18:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6600225AB
	for <rcu@archiver.kernel.org>; Tue, 14 Jul 2020 18:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRmQHph7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NbtGskQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgGNSOa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgGNSOa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jul 2020 14:14:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D180DC061755;
        Tue, 14 Jul 2020 11:14:29 -0700 (PDT)
Date:   Tue, 14 Jul 2020 20:14:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594750468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLqhjwaPuRWZY/A2fjDIxG8lv9sgoZU+shmKdScd9m4=;
        b=rRmQHph7I2tlr8erfDn67DA7O8oGFZgHWOZxl9deLA9pIdtvOJiUbXBVX0VjFXTMC1x40y
        um123HFcuLasqmjp1w4FZQGQkHWEZGEornRm6RoY40/o9Crp9oNHCuN1EhE79tasGbTSUE
        ti5WMPILnknkcGr23QUFiVMS33R5Cjb38GbYNl2hKVyJ9Ne4zfIhpIvh1iCNsIN0yNs6Dz
        kPR3PtLyvlgriMmaAhtt4CfknxTxqOBtNKoerr24u61H0IMM6qste2V5F4ImJXPj0QYPOj
        osBbtnqYy6WHTJe34FFUbRZ9l9vM1sEy4r32+jPR2IvmBpXRHVV+rcWf5KLd1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594750468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLqhjwaPuRWZY/A2fjDIxG8lv9sgoZU+shmKdScd9m4=;
        b=NbtGskQvuAsubnAZcEwcdSt2/LWcW6h45OAmF8cNPnj1EruUGOK+k4gcwrylg6f30RvWni
        ude4OJ+Itbf7iWCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, arnd@arndb.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200714181426.hhguqzrcqdubyvae@linutronix.de>
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714172701.GA31369@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-07-14 10:27:01 [-0700], Paul E. McKenney wrote:
> Joel Fernandes (Google) (5):
>       rcu/tree: Skip entry into the page allocator for PREEMPT_RT

If it is too late to drop this then I am going send a revert okay?

Sebastian
