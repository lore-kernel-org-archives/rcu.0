Return-Path: <SRS0=CVHC=DG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A713C4741F
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AF421734
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItqoUv/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgI2QZV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgI2QZV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 12:25:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3BC061755;
        Tue, 29 Sep 2020 09:25:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y11so6247720lfl.5;
        Tue, 29 Sep 2020 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3h7n0kDoWxJUkwhkiM6hwjpaSHbo+Kpn1WLzHzipkyI=;
        b=ItqoUv/YfW+YGoIsABPqwUCJ3aW66rxag+E/tYt/pr3c9vgOZqoboOPd/5+G+Jta4u
         VmOds2eutD86AJOuEwpqr14g03ny82jaLNumOm3y12CtvgwLXNhV37zkqa22rhb0QZz8
         P58mF/7/sH35NzmpmvuCopz4osPHpHhsA9vTUQiEbr8bljBXd1wkEN5v4ZLd4L2E9etw
         yl7C2uiqwLjlnYJK8BgFU96NiYrXR74S961ym6CsMYjjHSwIENjqoA+DFtW5aGp1b46U
         F/CvJksW5nwaNXbW++dT4UPtQzVTtIfSlXUiwrZQd/wJfDYk+dKv0j93mDj+OsjuYmPx
         yLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3h7n0kDoWxJUkwhkiM6hwjpaSHbo+Kpn1WLzHzipkyI=;
        b=iGtQaSxXlW2Cmn5GtU+US9cW3yWS8+ZeI/2GpMWOfBpKWF+9m5wx5xAcmcBnOBMw5d
         qeHTZa9gkxLpZth1yvpbKLEbkt4Rp5AhjA6gJoDkDRckKSuEdffm0xk1I7zXSsdoCC6o
         xaVG+1/ErwJ4MmRu8egLxmzvTk1dYQfbpbNHagN3SAsTueCJC7Ch0QSmy3mqHhszvDlV
         vntbdB8SzvsMZRoYFyiNeMf3/I/QjREa4XxFoL7cM0Zgo2ZlhpuzxTMS5kY77HKzPxCd
         XSYVTQNZtq2uXJuDTa+Cyz79LxfDcrKNdMQ48uDVINhvAwkjRhXy0hChdNVjAIJfsKxu
         9Tvw==
X-Gm-Message-State: AOAM533BSj+iwnyYMv08ApiQr6Es+bUkBLu5uabG5RvmyJrpHRG/s1VH
        eqnNYw/VdJqGhosl8FXJMFg=
X-Google-Smtp-Source: ABdhPJypuHLpBjSrh4x5SAP5mpaT+K/3JmAlFT4O+cw8Pet4vn4FOFS90XV3mVEaMASa+nEvO2elOg==
X-Received: by 2002:a19:a93:: with SMTP id 141mr1439631lfk.292.1601396717818;
        Tue, 29 Sep 2020 09:25:17 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id q24sm3289429lfo.149.2020.09.29.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 09:25:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 29 Sep 2020 18:25:14 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200929162514.GA8768@pc636>
References: <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net>
 <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz>
 <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925154741.GI3389@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > I look at it in scope of GFP_ATOMIC/GFP_NOWAIT issues, i.e. inability
> > to provide a memory service for contexts which are not allowed to
> > sleep, RCU is part of them. Both flags used to provide such ability
> > before but not anymore.
> > 
> > Do you agree with it?
> 
> Yes this sucks. But this is something that we likely really want to live
> with. We have to explicitly _document_ that really atomic contexts in RT
> cannot use the allocator. From the past discussions we've had this is
> likely the most reasonable way forward because we do not really want to
> encourage anybody to do something like that and there should be ways
> around that. The same is btw. true also for !RT. The allocator is not
> NMI safe and while we should be able to make it compatible I am not
> convinced we really want to.
> 
> Would something like this be helpful wrt documentation?
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 67a0774e080b..9fcd47606493 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -238,7 +238,9 @@ struct vm_area_struct;
>   * %__GFP_FOO flags as necessary.
>   *
>   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> - * watermark is applied to allow access to "atomic reserves"
> + * watermark is applied to allow access to "atomic reserves".
> + * The current implementation doesn't support NMI and other non-preemptive context
> + * (e.g. raw_spin_lock).
>   *
>   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
>   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
> 
To me it is clear. But also above conflicting statement:

<snip>
%GFP_ATOMIC users can not sleep and need the allocation to succeed. A %lower
<snip>

should be rephrased, IMHO.

--
Vlad Rezki
