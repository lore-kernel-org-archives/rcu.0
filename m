Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E68C43217
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 14:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiK1OB1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiK1OBS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 09:01:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A973E62E0
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 06:01:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mv18so9583710pjb.0
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amV6jMD2wzSg3Bi29Zsva56Y6oqfokCVnbY9ZVPgtB4=;
        b=grz9mQMYEWedHnh+phNOW2tPpOxlLj077CHZlU805AzuC2j3RLenWHCY0qyNf2sUZ2
         NHt0fDopaRj3jsx4nbzLMH+nzGFSylOZ/RpHDQixU2pWo3dUMaaQup+OU35GSRuN4wqZ
         2I86R7g/7oEGT5nls6oZ2IvyP786w+BQ4F2ZNyOxvadOO7pgugn7F8P6OXZnz9PFpKbQ
         lispx2HDKGrpWErma1B15PSMS4yuIbkq7ZCjbBKx48EqyGsCC1Iw0TQ4mlgJC6oxnyZJ
         lzQW6VBoeikUER+ETSsBaL5Uw5Sp6sBZtQVw/UpWE2FDyZzfYRDJuJnqe3bSP8xWfLSl
         nhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amV6jMD2wzSg3Bi29Zsva56Y6oqfokCVnbY9ZVPgtB4=;
        b=nfDeyIZaa73ZA4jcdLA2zqCVD8rIaxy9zN42V2L8STzHgvQerXjTeONue7r2X8rD2R
         gDfkCpBFWyiCZKj/N9610vgLSDCHy0uIT8OfTml8hbsKvLpqDdJE+Hiu3BkssNCllH1s
         06//556Ik2cQxJw1yyGE+udxcdPLVJJ4fu0Spa+9PKGh+jb8eHX1+bTujpnvy91hAnOw
         HQzhYOPCHDb8QjLs4t+9Pewp6QVwPcgWbi7Uxrp28z7/kqHWTY3Tq01Iw3dQRJwGqTd5
         zni0PMmJR5+96o7VtE/5tYtEzdHah7wLJACGsOm/wQsv3jdob8LLF1z+kPSvrkVxAAx5
         PBKQ==
X-Gm-Message-State: ANoB5pnpudCMjx+VzKxtxZ2Dv63PIdZ6hHQ35CNRbNC1YBbJCCkRknp5
        iwDD/UC5IoXwKTWyJ+uHFQ==
X-Google-Smtp-Source: AA0mqf5R+ROIdc0OfemUpsU/DQsM1L2pkbmKk/B526XMfLV16DaAdgw0XcMRNaf0jAq4SsB0IOp0Zw==
X-Received: by 2002:a17:90b:4b42:b0:20a:e38c:8c5f with SMTP id mi2-20020a17090b4b4200b0020ae38c8c5fmr60554711pjb.217.1669644077131;
        Mon, 28 Nov 2022 06:01:17 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z4-20020a63c044000000b004639c772878sm6888265pgi.48.2022.11.28.06.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:01:16 -0800 (PST)
Date:   Mon, 28 Nov 2022 22:01:08 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/3] srcu: Eliminate the requirement of
 SRCU_SIZE_WAIT_CALL
Message-ID: <Y4S/JLoILJZMCj9N@piliu.users.ipa.redhat.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
 <20221128082816.28518-2-kernelfans@gmail.com>
 <PH0PR11MB5880CEEA5D2CD0F7AF21E954DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880CEEA5D2CD0F7AF21E954DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 28, 2022 at 08:40:22AM +0000, Zhang, Qiang1 wrote:
> >The state SRCU_SIZE_WAIT_CALL is only used in srcu_gp_start_if_needed().
> >And it is not needed. Because counter_wrap_check has guarantee that both
> >srcu_gp_seq_needed and srcu_gp_seq_needed_exp are not far behind
> >srcu_gp_seq and no false alarm will be raised by the statement in
> >srcu_gp_start_if_needed()
> >
> >  ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)
> >
> >As a result, once if SRCU_SIZE_WAIT_BARRIER is seen, the tree snp can be
> >used immediately, not need to wait for another srcu_gp_end() to update
> >the srcu_gp_seq_needed and srcu_gp_seq_needed_exp to avoid false alarm.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >Cc: Frederic Weisbecker <frederic@kernel.org>
> >Cc: Josh Triplett <josh@joshtriplett.org>
> >Cc: Steven Rostedt <rostedt@goodmis.org>
> >Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> >To: rcu@vger.kernel.org
> >---
> > kernel/rcu/srcutree.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >index 1c304fec89c0..fe0759d89c2d 100644
> >--- a/kernel/rcu/srcutree.c
> >+++ b/kernel/rcu/srcutree.c
> >@@ -1092,7 +1092,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > 	check_init_srcu_struct(ssp);
> > 	idx = srcu_read_lock(ssp);
> > 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
> >-	if (ss_state < SRCU_SIZE_WAIT_CALL)
> >+	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
> > 		sdp = per_cpu_ptr(ssp->sda, 0);
> 
> Hi Pingfan
> 
> should it be used get_boot_cpu_id() ?
> 

I am not sure which branch to work on.

Thanks,

	Pingfan

> Thanks
> Zqiang
> 
> > 	else
> > 		sdp = raw_cpu_ptr(ssp->sda);
> >-- 
> >2.31.1
> >
