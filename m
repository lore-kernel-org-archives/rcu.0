Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97847C433E0
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 20:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9DE23A54
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 20:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbhAUU23 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbhAUU1V (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Jan 2021 15:27:21 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675ABC0613D6;
        Thu, 21 Jan 2021 12:26:39 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e7so3978299ljg.10;
        Thu, 21 Jan 2021 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CK9v4fJZez9oq+66O9lv/sWkyc4mUCFz9PdtPkQoRmA=;
        b=iFMSbE7wyUyKwmY2E7RnbbmjaygiXMHTQQ60cn4WAfXxZ8g0S0fer14cKskE48ekxP
         VdTpmX6UWmnlXXqAcib4ycO4wahuzrG9NoO0GuriWV2m/NSObN0GP3NNwxT1OWwIAjH7
         Xv/hdEbRHiZRNicELlf5XS6XIOnoBITZt9QSQ5GoSjR2T708N6Gb6/3UfzfjKbDOi/NK
         SPdmED8emmi2l5EEXEJTKP5e1E7U6ZfjH2P69UHseqkzRoXByI7Ej6KoylCe6OfPXB0s
         jdV9fNRfzcjQyQi8ng1p4Ly99KDjHumsWxXDdsW15nyMEuJ3qrx56TB5fd8SZxAGhQCk
         yWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CK9v4fJZez9oq+66O9lv/sWkyc4mUCFz9PdtPkQoRmA=;
        b=FzeH4U0PjG6Zi6uu+GISkrMm6OzMZBOJSfFYvSNBL3i/7UNx8JeB4NFUnLOZGMSclL
         EAsGF7LErseBbkEPsbzm/XzHW0lOpBffULPwsh7ldNIOM9qVXJmkAN4YokTwAwMqm+16
         bJzGY4tqfG1UAmTb0GyAU97BVes1UxTA0OaNYY0n94rqlZ5gWkVjSdJ2FxR1Pyrp73KM
         CRG/E1S4zy03aAXw2+rIopvUTOlHA6jxLfcYvmaNbH5FnRUgaF35atlFVopPEM7R/suX
         aPnFBDe5zPBI83zoB4e2f+/f0DdvFcV1lew7TFoBUs50+oE5iRuDgfAMl5Fei+qI2u1x
         zktA==
X-Gm-Message-State: AOAM532h1boLg76aWcTOXxLlsFUrVhUVKUjPXzzLtLIRXfLZf669PCZm
        IsWed9qrTrSlujc+SFVsm28=
X-Google-Smtp-Source: ABdhPJxqMS/xwXTHH3tlcom34rpxkP3S4uIPtEX0oIY58eN8T8BaeYIQel2RiI8MzWIM1Ib2ob0HPA==
X-Received: by 2002:a2e:585:: with SMTP id 127mr522636ljf.131.1611260797957;
        Thu, 21 Jan 2021 12:26:37 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id b3sm646370lff.190.2021.01.21.12.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:26:37 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 21 Jan 2021 21:26:35 +0100
To:     qiang.zhang@windriver.com
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcu: Release per-cpu krcp page cache when CPU going
 offline
Message-ID: <20210121202635.GB2454@pc638.lan>
References: <20210121064949.16164-1-qiang.zhang@windriver.com>
 <20210121185615.GR2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121185615.GR2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Qiang,

> On Thu, Jan 21, 2021 at 02:49:49PM +0800, qiang.zhang@windriver.com wrote:
> > From: Zqiang <qiang.zhang@windriver.com>
> > 
> > If CPUs go offline, the corresponding krcp's page cache can
> > not be use util the CPU come back online, or maybe the CPU
> > will never go online again, this commit therefore free krcp's
> > page cache when CPUs go offline.
> > 
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> 
Do you consider it as an issue? We have 5 pages per CPU, that is 20480 bytes. 

--
Vlad Rezki
