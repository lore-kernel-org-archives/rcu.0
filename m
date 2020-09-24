Return-Path: <SRS0=Gqt/=DB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD6EC2D0E2
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FA921D24
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 15:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1cp87nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgIXPVR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Sep 2020 11:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgIXPVR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Sep 2020 11:21:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1495CC0613CE;
        Thu, 24 Sep 2020 08:21:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so3078440lja.7;
        Thu, 24 Sep 2020 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/mZAambhFcl0S7KGEMSUJjg0a7gPmj28sRt8xsxUs0=;
        b=B1cp87nPpk6fcWkz7WopVAUa9cH5zagTJ8w6MstgYFm2N8S6/lERSognJMXCMS0C+9
         mToxWz1aWOpujhsqR9EYGB9aw2XcIxz9xCDxeb2nb8zspvfNQZkW8Tp2I9cXqtzox+81
         Lr4UL51TmMNrEX23ZWzFpDZgumqj8CIWk4F5y8ZygycgvfeL1OmX+TCmn3hA776svmx/
         04MwvEJGpkbZB+9hzLOATT6IWG9TzXVRVORodjxckIKf+WBADQ/6rwdW1rUFGzVsKLfy
         TIPf9pJcCBWthYpY4V4YL/Krj1doPvm+fSIvLsBzX4IyRdAb/7q3mafoL3d77UlWomb4
         eRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/mZAambhFcl0S7KGEMSUJjg0a7gPmj28sRt8xsxUs0=;
        b=l59+wlLPMtzF7L73hcur+Q//UBglKDl4eV6Kf4Eyj4+MHJooUUNiHqzEuDzRMBtpsI
         3s9qFspbJN7AKY/ZGBAuNCLkvLd/9NJrqhOopVbie+NSly5dSmGsWi9Y/YGwrbL/Lvbu
         TLemxxPtnllvDgYslZz5tbakkYTlGBwPMdq54SMMtuPfO4JspUeJ2e1u8ikOPoLWJI1u
         ENY89ptPLKSmjzK/SLuhg2a5JcLCyiwMRyUt6H3Nl+UTNyql7pIX/4G3K424QV4dsyRA
         WtWeU8jW0PwUr7vvMmZDDnYg+4bS4g8iQgaBgVM+/70L8i5AIlGuuFp1092MZ8VrH9Kl
         mtyg==
X-Gm-Message-State: AOAM533M6HTNiqytfCzEuNNe1o5IhlRVx0bG2DVJ1sIDfiRKaZDp1DdE
        YEKiDzz9h8UnzrFG4Icev7g=
X-Google-Smtp-Source: ABdhPJyLv1TmIc/5WfunO6vMcDPwSFsYmXi2nRV7bxMy6gP3CGLrG7hHCdMN/ZXmksdMyAPKbuKlzw==
X-Received: by 2002:a2e:3008:: with SMTP id w8mr99644ljw.63.1600960875417;
        Thu, 24 Sep 2020 08:21:15 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o128sm2313144lfa.110.2020.09.24.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:21:14 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 24 Sep 2020 17:21:12 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200924152112.GB19013@pc636>
References: <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200924111907.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924111907.GE2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 24, 2020 at 01:19:07PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 10:16:14AM +0200, Uladzislau Rezki wrote:
> > The key point is "enough". We need pages to make a) fast progress b) support
> > single argument of kvfree_rcu(one_arg). Not vice versa. That "enough" depends
> > on scheduler latency and vague pre-allocated number of pages, it might
> > be not enough what would require to refill it more and more or we can overshoot
> > that would lead to memory overhead. So we have here timing issues and
> > not accurate model. IMHO.
> 
> I'm firmly opposed to the single argument kvfree_rcu() idea, that's
> requiring memory to free memory.
> 
Hmm.. The problem is there is a demand in it:

Please have a look at places in the kernel where people do not
embed the rcu_head into their stuctures and do like:

<snip>
    synchronize_rcu();
    kfree(p);
<snip>

<snip>
urezki@pc638:~/data/coding/linux-rcu.git$ find ./ -name "*.c" | xargs grep -C 1 -rn "synchronize_rcu" | grep kfree
./fs/nfs/sysfs.c-113-           kfree(old);
./fs/ext4/super.c-1708- kfree(old_qname);
./kernel/trace/ftrace.c-5079-                   kfree(direct);
./kernel/trace/ftrace.c-5156-                   kfree(direct);
./kernel/trace/trace_probe.c-1087-      kfree(link);
./kernel/module.c-3910- kfree(mod->args);
./net/core/sysctl_net_core.c-143-                               kfree(cur);
./arch/x86/mm/mmio-mod.c-314-           kfree(found_trace);
./drivers/mfd/dln2.c-183-               kfree(i);
./drivers/block/drbd/drbd_state.c-2074-         kfree(old_conf);
./drivers/block/drbd/drbd_nl.c-1689-    kfree(old_disk_conf);
./drivers/block/drbd/drbd_nl.c-2522-    kfree(old_net_conf);
./drivers/block/drbd/drbd_nl.c-2935-            kfree(old_disk_conf);
./drivers/block/drbd/drbd_receiver.c-3805-      kfree(old_net_conf);
./drivers/block/drbd/drbd_receiver.c-4177-                      kfree(old_disk_conf);
./drivers/ipack/carriers/tpci200.c-189- kfree(slot_irq);
./drivers/crypto/nx/nx-842-pseries.c-1010-      kfree(old_devdata);
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c-3583-        kfree(mgp->ss);
./drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c:286:       synchronize_rcu(); /* before kfree(flow) */
./drivers/net/ethernet/mellanox/mlxsw/core.c-1574-      kfree(rxl_item);
./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6642- kfree(adapter->mbox_log);
./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6644- kfree(adapter);
./drivers/infiniband/hw/hfi1/sdma.c-1337-       kfree(dd->per_sdma);
./drivers/infiniband/core/device.c:2164:                         * synchronize_rcu before the netdev is kfreed, so we
./drivers/misc/vmw_vmci/vmci_context.c-692-             kfree(notifier);
./drivers/misc/vmw_vmci/vmci_event.c-213-       kfree(s);
./drivers/staging/fwserial/fwserial.c-2122-     kfree(peer);
urezki@pc638:~/data/coding/linux-rcu.git$
<snip>

--
Vlad Rezki
