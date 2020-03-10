Return-Path: <SRS0=CUdJ=43=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC2FC10DCE
	for <rcu@archiver.kernel.org>; Tue, 10 Mar 2020 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB1821927
	for <rcu@archiver.kernel.org>; Tue, 10 Mar 2020 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583877377;
	bh=diRYLqa+LDmZkK6ZOXfzyYKp5+riDKhmWi81858cb1o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gEyYBMvcdFPJ5EXdmIFlk5XmUMHUFuETeIY6x21/7Bpf7zFslj0idJokDtjR0hf6h
	 GyONCFMq6HdUxAH+gvuSn4gDwfyUc4NAp4/D2hr/VKmV+nsMIAal+kES+Dx/YGVQqZ
	 D0C1GJSX/zDVsiP9HVIM6b/O/D2ZpsGToV3Soao4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCJV4R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJV4R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Mar 2020 17:56:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C37DE215A4;
        Tue, 10 Mar 2020 21:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583877376;
        bh=diRYLqa+LDmZkK6ZOXfzyYKp5+riDKhmWi81858cb1o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pid4zjnbSmqk4NraTzRY0EbVQzebSj+Or38YKGO0pcO/usFjzOPSH3r1ECTbfiYqn
         vbGNnQjCvaqbQQXrAMUTiU7kuG0jt26gUDe+k9Qb8bVP11lepcdKPF29svi4v3RkS9
         x65bufODrf8XuNOT9ES9YppUsNbkR9eRZoz/F1Ow=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 936DD35229CC; Tue, 10 Mar 2020 14:56:16 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:56:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     rcu@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: Clang warning in kernel/rcu/tasks.h
Message-ID: <20200310215616.GI2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200310204941.GA53917@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310204941.GA53917@ubuntu-m2-xlarge-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 10, 2020 at 01:49:41PM -0700, Nathan Chancellor wrote:
> Hi Paul,
> 
> It appears that the commits 37564025a3d7 ("rcu-tasks: Refactor RCU-tasks
> to allow variants to be added") and cbd703932774 ("rcu-tasks: Add an
> RCU-tasks rude variant") both add a forward declaration to rcu_tasks and
> the rcu_tasks_gp_func_t typedef, resulting in the following clang
> warning:
> 
> In file included from kernel/rcu/update.c:563:
> kernel/rcu/tasks.h:24:16: warning: redefinition of typedef 'rcu_tasks_gp_func_t' is a C11 feature [-Wtypedef-redefinition]
> typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
>                ^
> kernel/rcu/tasks.h:17:16: note: previous definition is here
> typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
>                ^
> 1 warning generated.
> 
> Maybe a rebase or merge gone wrong? Would you mind taking a look and
> fixing it up if possible?

Will do, good catch, thank you!

							Thanx, Paul
