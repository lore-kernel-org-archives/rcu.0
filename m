Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45598C4320E
	for <rcu@archiver.kernel.org>; Tue, 31 Aug 2021 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8E160724
	for <rcu@archiver.kernel.org>; Tue, 31 Aug 2021 15:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhHaPWn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Aug 2021 11:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbhHaPWn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Aug 2021 11:22:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC7CC061575
        for <rcu@vger.kernel.org>; Tue, 31 Aug 2021 08:21:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q14so28357499wrp.3
        for <rcu@vger.kernel.org>; Tue, 31 Aug 2021 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PdWzVy+KCoOf7GLLv9OU4SNDxgUfYq96U+qVTICtiis=;
        b=WLscQd4jv2T8IKORw/Q19+nCUf+1IeY0MMDPzeNldNC4lvj+bVjXog7NqdBnVceHW3
         QAdxCJby391pRCJgXVvvoPRzJ8xt1195Cqylf5Z6+mfHnRuqrRczpEr11zv/HqmQqxHZ
         L47g3ZhPA0E/qbOaR+3rVCWIyVOm0R5TIsA8vc97NuDxQMIkyCET9CkAfqMFZaIJFg4t
         681nqNs3uXsYiKguPtzmq/kqnfZl50mVbgmp/EY1hflI1zY5jPEDmADnpmc3LVoU/eZJ
         flL/OoQBc7+4CJvIO/CFFCihWY5HKYejtbu5063YLxXun0bMhxSdNGRgPD05c4Er6J/a
         Hurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PdWzVy+KCoOf7GLLv9OU4SNDxgUfYq96U+qVTICtiis=;
        b=pnO3ujgShVNZryUfu/9XqgAJiQWyjt1BwDvCUSn6QVJgBPwErFxVv+GIGtXDA3yORs
         9vApUQckwd6M1xQ5aZO5a5LCxbRFTN8RTeN9I6b8DMGxicryy1A49hB6+N/+z2rh0QKD
         u6Lb8JwPL3S6mb63sPGmpOJ8BR67Et1QWDZJzrPeqJtkiOdyMAIts3NKlrBp4ZNMgzsW
         qdD8b9ydR+wp/CUhqXqEldEhhu4FmCEJ6FgZt136oTMHb0yVGlEY6hsxoCm+g2soGR6u
         VlqsT5rXpz4ggrvs42md3IsOit/dBVtJlqPWxBXiIwj1b/t4l+6YaI2a7woj5usZ1jV/
         VIOQ==
X-Gm-Message-State: AOAM5301R4cYvT5NeJRFeQh35CiE30LicrSxC4g8SusONt70M8VPGbTt
        uft/UgkYk6HCMhz1gVn0CMj53Q==
X-Google-Smtp-Source: ABdhPJzCgW0b2yP2tbW046Yx26EYiNa5/xe/k5Pl/qfv9dFJIcFZg8y6wcEXodMiOlGWKxi+3c7zlw==
X-Received: by 2002:a05:6000:34a:: with SMTP id e10mr13836206wre.421.1630423306313;
        Tue, 31 Aug 2021 08:21:46 -0700 (PDT)
Received: from trex (162.red-79-154-201.dynamicip.rima-tde.net. [79.154.201.162])
        by smtp.gmail.com with ESMTPSA id u27sm19342861wru.2.2021.08.31.08.21.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Aug 2021 08:21:45 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Tue, 31 Aug 2021 17:21:44 +0200
To:     paulmck@kernel.org
List-Id: <soc.lore.kernel.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: rcu_preempt detected stalls
Message-ID: <20210831152144.GA28128@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi

When enabling CONFIG_PREEMPT and running the stress-ng scheduler class
tests on arm64 (xilinx zynqmp and imx imx8mm SoCs) we are observing the following.

[   62.578917] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:                                                              
[   62.585015]  (detected by 0, t=5253 jiffies, g=3017, q=2972)                                                                   
[   62.590663] rcu: All QSes seen, last rcu_preempt kthread activity 5254 (4294907943-4294902689), jiffies_till_next_fqs=1, root  
+->qsmask 0x0                                                                                                                     
[   62.603086] rcu: rcu_preempt kthread starved for 5258 jiffies! g3017 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1               
[   62.613246] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.                        
[   62.622359] rcu: RCU grace-period kthread stack dump:                                                                          
[   62.627395] task:rcu_preempt     state:R  running task     stack:    0 pid:   14 ppid:     2 flags:0x00000028                  
[   62.637308] Call trace:                                                                                                        
[   62.639748]  __switch_to+0x11c/0x190                                                                                           
[   62.643319]  __schedule+0x3b8/0x8d8                                                                                            
[   62.646796]  schedule+0x4c/0x108                                                                                               
[   62.650018]  schedule_timeout+0x1ac/0x358                                                                                      
[   62.654021]  rcu_gp_kthread+0x6a8/0x12b8                                                                                       
[   62.657933]  kthread+0x14c/0x158                                                                                               
[   62.661153]  ret_from_fork+0x10/0x18                                                                                           
[   62.682919] BUG: scheduling while atomic: stress-ng-hrtim/831/0x00000002                                                       
[   62.689604] Preemption disabled at:                                                                                            
[   62.689614] [<ffffffc010059418>] irq_enter_rcu+0x30/0x58                                                                       
[   62.698393] CPU: 0 PID: 831 Comm: stress-ng-hrtim Not tainted 5.10.42+ #5                                         
[   62.706296] Hardware name: Zynqmp new (DT)                                                                                        
[   62.710115] Call trace:                                                                                                        
[   62.712548]  dump_backtrace+0x0/0x240                                                                                          
[   62.716202]  show_stack+0x2c/0x38                                                                                              
[   62.719510]  dump_stack+0xcc/0x104                                                                                             
[   62.722904]  __schedule_bug+0x78/0xc8                                                                                          
[   62.726556]  __schedule+0x70c/0x8d8                                                                                            
[   62.730037]  schedule+0x4c/0x108                                                                                               
[   62.733259]  do_notify_resume+0x224/0x5d8                                                                                      
[   62.737259]  work_pending+0xc/0x2a4

The error results in OOM eventually.

RCU priority boosting does work around this issue but it seems to me
a workaround more than a fix (otherwise boosting would be enabled
by CONFIG_PREEMPT for arm64 I guess?).

The question is: is this an arm64 bug that should be investigated? or
is this some known corner case of running stress-ng that is already
understood?

thanks
Jorge



