Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE6C4361B
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 19:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881612067C
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 19:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393371AbgLJTYz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393240AbgLJTYn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 14:24:43 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A1C0613D6;
        Thu, 10 Dec 2020 11:24:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f11so8039921ljn.2;
        Thu, 10 Dec 2020 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCrNR3n9GJNoXa6hYaaSjB4xbjhQGCznNDRIPsdaBgI=;
        b=QCR5wTC0ofAq8RJNsX2W1rg6lNBCuGM/kJN3qyqlq2cGRvdmNRX7i9ydiVK9k2lu3J
         a7HsND38YxMH1QQHajQo8DViLOuSjSXdaR3lJdaYafD5ABB3fCRkV4lwDUClCZOzLvY6
         BlGMedO5FU22D2HLqkNpwTvaWtXoOraH5KDEra911zjFAaCPNlkph3BSN7DLjIKXwEkr
         AYgAwoERJMj8reQUL860FAJtcHYBqobuy1oV7t7wiffTrwJFBHhuntNn1F4qA1cdRMuG
         EsJIwTEJ1QP/KV00mStp6iFeyi3lUEXYltIOOdruRO2QChRJ9TAcKgG2/yqI8ArxjNq5
         d++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCrNR3n9GJNoXa6hYaaSjB4xbjhQGCznNDRIPsdaBgI=;
        b=lrElSWrQ8404u81E81+N7SaPUZKX3K3EgZRJbpraapaO3kscua/5FUbkJnG78zio3r
         VhZvTV0xicDA6xPJHfVi5XWmbxQSTn1O7Mf+QS4IbiK3cIEGiVTs+bzXZxblHDj0LgsT
         Qa6JHo/GAhIP4Yggm2jmqoKwnmbyLpZpV+LYzWXyAz0pLhvsdayGJHx9I4f1Deze+IFc
         NjWrG8eYbvMC2hupMRLp/ZhhTQgwZ5e+jxB3d6qzQbqvi9K85sSVhwPUxuOp0d3Ty+TM
         Kb53RBlVidT0dYukNEFI/VhAmW0wo0a83yBdvQ67qoQF+FTOHQq/N6jlKRbL78hHHwb+
         ZY7A==
X-Gm-Message-State: AOAM5327WfSb2LMZbG4ZwlUDall/kEO+oCXscjY5Zgh/VzSHpJwPqFV0
        qMH2ZUaMccxKI12Rz+7lz5o=
X-Google-Smtp-Source: ABdhPJyt3Mpg1xnO5a8M5FUwtqQQBf79CikKdM4ytgc0dMYe5Bby2JPefgTVSyEjLR0kMpaqC+uwaQ==
X-Received: by 2002:a2e:914c:: with SMTP id q12mr3670350ljg.102.1607628241935;
        Thu, 10 Dec 2020 11:24:01 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v9sm615235lfd.287.2020.12.10.11.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 11:24:01 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 10 Dec 2020 20:23:58 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Energy-efficiency options within RCU
Message-ID: <20201210192358.GA2365@pc638.lan>
References: <20201210183737.GA12900@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210183737.GA12900@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Paul.

[Dropping CC]

> Hello, Joel,
> 
> In case you are -seriously- interested...  ;-)
> 
> 						Thanx, Paul
> 
> rcu_nocbs=
> 
> 	Adding a CPU to this list offloads RCU callback invocation from
> 	that CPU's softirq handler to a kthread.  In big.LITTLE systems,
> 	this kthread can be placed on a LITTLE CPU, which has been
> 	demonstrated to save significant energy in benchmarks.
> 	http://www.rdrop.com/users/paulmck/realtime/paper/AMPenergy.2013.04.19a.pdf
> 
I have checked our config. We do use rcu_nocbs=0-7 as kthreads but what
i see those threads are not bound to 0-3 CPUs. In our case it is little
cluster. I think i should check and run some test cases regarding power 
savings if i pin all threads to little cluster.

> rcutree.rcu_idle_gp_delay=  (Only CONFIG_RCU_FAST_NO_HZ=y kernels.)
> 
> 	This defaults to four jiffies on the theory that grace periods
> 	tend to last about that long.  If grace periods tend to take
> 	longer, then it makes a lot of sense to increase this.	And maybe
> 	battery-powered devices would rather have it be about 2x or 3x
> 	the expected grace-period duration, who knows?
> 
> 	I would keep it to a power of two, but the code should work with
> 	other numbers.  Except that I don't know that this has ever been
> 	tested.  ;-)
> 
Same here. We do use it.

--
Vlad Rezki
